Scriptname PW_QuotaManagerScript extends PW_ScriptComponent Conditional
{Responsible for the creation and tracking of quotas}

import PW_Utility


function Initialize()
	quotaActive = new bool[9]

	clientQuotas = new int[9]
	goldQuotas = new int[9]
	periodStarts = new float[9]
	
	cumulativeGold = new int[9]
	cumulativeClients = new int[9]
	recentClients = new int[9]
	overtimeClients = new int[9]
	
	
	nghActualClients = new int[9]
	nghActualGold = new int[9]
	nghExpectedClients = new int[9]
	nghExpectedGold = new int[9]
	
	currentRecentClients = 0
	currentOvertimeClients = 0
	
	earlyBuyouts = new int[9]
	quotaFailed = new bool[9]
	
	PW_QuotaPeriod.SetValue(reportingPeriod)
	
	pwDebug(self, 1, "quota manager initialized")
	
endFunction

function Startup()
	RegisterForModEvent("PW_EnterCity", "onEnterCity")
	RegisterForModEvent("PW_LeaveCity", "onLeaveCity")
	RegisterForModEvent("PW_CheckTimeComponents", "checkTimeComponents")
	RegisterForModEvent("PW_TurnInGold", "turnInGold")
	RegisterForModEvent("PW_CitizenReport", "citizenReport")
	RegisterForModEvent("PW_AssignQuota", "AssignQuota")
	RegisterForModEvent("PW_AssignSpecificQuota", "AssignSpecificQuota")
	RegisterForModEvent("PW_ClearQuota", "clearQuota")
	RegisterForModEvent("PW_SetEnforcedMode", "consolidateQuotas")
	RegisterForModEvent("PW_PrintQuota", "printCurrentQuota")
	RegisterForModEvent("PW_SideQuestCompleted", "OnSideQuestCompleted")
	RegisterForModEvent("PW_SideQuestFailed", "OnSideQuestFailed")
	RegisterForModEvent("PW_UpdateLocInfo", "UpdateLocationInfo")
endFunction

event onEnterCity(int newLocIndex)
	if(newLocIndex < 0 || newLocIndex > 8)
		return
	endIf
	
	lastLocIndex = newLocIndex
	
	UpdateLocationInfo()
endEvent

event onLeaveCity(int oldLocIndex)
	if(lastLocIndex < 0 || lastLocIndex > 8)
		pwDebug(self, 4, "left city, but lastLocIndex is invalid")
	else
		if(quotaActive[oldLocIndex] && quotaMode == QUOTA_MODE_ENDLESS && recentClients[oldLocIndex] > 0 && playerHandlesGold)
			ConvertQuotaToBounty(lastLocIndex)
		endIf
	endIf
endEvent

event UpdateLocationInfo()
	currentRecentClients = recentClients[lastLocIndex]
	currentOvertimeClients = overtimeClients[lastLocIndex]
	nghCurrentExpectedClients = nghExpectedClients[lastLocIndex]
	nghCurrentExpectedGold = nghExpectedGold[lastLocIndex]
	nghHasExpectedProgress = ((nghCurrentExpectedClients > 0) || (nghCurrentExpectedGold > 0))
	currentQuotaFailed = quotaFailed[lastLocIndex]
endEvent

event checkTimeComponents()
	;Check for quota failure in applicable modes
	if(quotaMode == QUOTA_MODE_CLIENTS || quotaMode == QUOTA_MODE_GOLD)
		int index = 0
		while index <= 8
			if(quotaActive[index] \
				&& (Utility.GetCurrentGameTime() - periodStarts[index]) >= reportingPeriod \
				&& !quotaFailed[index] \
				&& quotaMode != QUOTA_MODE_ENDLESS)
				
				quotaFailed[index] = true
				int handle = ModEvent.create("PW_FloorAlertLevel")
				ModEvent.pushInt(handle, index)
				ModEvent.pushInt(handle, 1)
			endIf
			index += 1
		endWhile
	endIf
	currentQuotaFailed = quotaFailed[lastLocIndex]
endEvent

event turnInGold(int amount)
	Game.GetPlayer().RemoveItem(gold, amount)
	
	int regularPay = (amount * (standardCut / 100.0)) as int
	int overtimePay = 0
	
	;Think this is deprecated but I don't want to break anything
	playersCut = regularPay
	
	if(quotaMode == QUOTA_MODE_CLIENTS)
		dgConds.overtimeReported = overtimeClients[lastLocIndex] > 0
		if(dgConds.overtimeReported && dgConds.hasEnough)
			overtimePay = (overtimeClients[lastLocIndex] * calculatePay() * (overTimeCut / 100.0)) as int
		endIf

		cumulativeClients[lastLocIndex] = cumulativeClients[lastLocIndex] + recentClients[lastLocIndex]
		dgConds.IsFinished = cumulativeClients[lastLocIndex] >= clientQuotas[lastLocIndex]
		
		updateEarlyBuyout(lastLocIndex)
		
		recentClients[lastLocIndex] = 0
		
		sendEvent("PW_UpdateLocInfo")
		
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		
		sendIntEvent("PW_UpdateGoldObjecive", lastLocIndex)
	
		cumulativeGold[lastLocIndex] = cumulativeGold[lastLocIndex] + amount
		dgConds.IsFinished = cumulativeGold[lastLocIndex] >= goldQuotas[lastLocIndex]
		
		updateEarlyBuyout(lastLocIndex)
		sendEvent("PW_UpdateLocInfo")
		
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
		cumulativeClients[lastLocIndex] = cumulativeClients[lastLocIndex] + recentClients[lastLocIndex]
		recentClients[lastLocIndex] = 0
		sendEvent("PW_UpdateLocInfo")
	endIf
	
	
	if(quotaMode != QUOTA_MODE_GOLD || !playerHandlesGold) ;Player should not receive a cut in gold mode, unless she never had gold on hand anyway
		if(regularPay > 0)
			Game.GetPlayer().AddItem(gold, regularPay)
		endIf
		
		if(overtimePay > 0 && dgConds.overtimeReported && quotaMode == QUOTA_MODE_CLIENTS) ;Only mode where overtime is a valid concept
			Game.GetPlayer().AddItem(gold, overtimePay)
		endIf
	endIf
	
	PW_Utility.SendIntEvent("PW_RefreshObjectives", lastLocIndex)
	
endEvent

function ConvertQuotaToBounty(int locIndex)
	if(locIndex < 0 || locIndex > 8)
		pwDebug(self, 4, "could not convert quota to bounty, index out of bounds")
	endIf
	
	;Only place we use this right now
	if(quotaMode == QUOTA_MODE_ENDLESS)
		Debug.Notification("PW: " + recentClients[locIndex] * calculatePay() + " bounty added for leaving before reporting.")
		crimeFactions[locIndex].ModCrimeGold(recentClients[locIndex] * calculatePay())
		recentClients[lastLocIndex] = 0
		PW_Utility.SendEvent("PW_RefreshObjectives")
	endIf
endFunction

event citizenReport()
{For NGH mode. Reports a single instance of a citizen fucking the player}

	nghDoesntMatch = false
	if(quotaMode == QUOTA_MODE_CLIENTS || quotaMode == QUOTA_MODE_ENDLESS) ;Endless shares client mode functionality here
		nghExpectedClients[lastLocIndex] = nghExpectedClients[lastLocIndex] + 1		;Always increment expected clients
		nghCurrentExpectedClients += 1
		Debug.Notification("You've now taken  " + nghExpectedClients[lastLocIndex] + " clients since reporting")
		if(utility.RandomInt(1, 100) > missingReportChance)		;if base chance for a report is met...
			if(!dgConds.IsRape || (Utility.RandomInt(0, 1) > 0))		;Perform another check (rapists less likely to report, parallels the half-payments in gold-handling mode)
				nghActualClients[lastLocIndex] = nghActualClients[lastLocIndex] + 1						;increment actual clients
			endIf
			
		endIf
		
		nghDoesntMatch = nghActualClients[lastLocIndex] < nghExpectedClients[lastLocIndex]
		
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		nghExpectedGold[lastLocIndex] = nghExpectedGold[lastLocIndex] + PW_StandardPay.GetValue() as int
		nghCurrentExpectedGold += 1
		Debug.Notification("You have now earned " + nghExpectedGold[lastLocIndex] + " since reporting")
		if(Utility.RandomInt(1, 100) > missingReportChance)
			if(!dgConds.IsRape || (Utility.RandomInt(0, 1) > 0))	;In gold mode
				nghActualGold[lastLocIndex] = nghActualGold[lastLocIndex] + PW_StandardPay.GetValue() as int
			endIf
			
		endIf
		
		nghDoesntMatch = nghActualGold[lastLocIndex] < nghExpectedGold[lastLocIndex]
		
	endIf

	nghHasExpectedProgress = true
	return
endEvent


event nghPlayerReport()
{No-gold-handling player progress report. Assumes reporting for local}

	if(quotaMode == QUOTA_MODE_CLIENTS)
		playersCut = (calculatePay() * nghActualClients[lastLocIndex] * (standardCut / 100.0)) as int
		cumulativeClients[lastLocIndex] = cumulativeClients[lastLocIndex] + nghActualClients[lastLocIndex]
		nghActualClients[lastLocIndex] = 0
		nghExpectedClients[lastLocIndex] = 0
		dgConds.IsFinished = cumulativeClients[lastLocIndex] >= clientQuotas[lastLocIndex]
		dgConds.overtimeReported = cumulativeClients[lastLocIndex] > clientQuotas[lastLocIndex]
		
		if dgConds.overtimeReported
			Game.GetPlayer().AddItem(Gold, (cumulativeClients[lastLocIndex] - clientQuotas[lastLocIndex]) * calculatePay())
		endIf
		
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		playersCut = (nghActualGold[lastLocIndex] * (standardCut / 100.0)) as int
		cumulativeGold[lastLocIndex] = cumulativeGold[lastLocIndex] + nghActualGold[lastLocIndex]
		nghActualGold[lastLocIndex] = 0
		nghExpectedGold[lastLocIndex] = 0
		dgConds.IsFinished = cumulativeGold[lastLocIndex] >= goldQuotas[lastLocIndex]
		dgConds.overtimeReported = cumulativeGold[lastLocIndex] > goldQuotas[lastLocIndex]
		
		if dgConds.overtimeReported
			Game.GetPlayer().AddItem(Gold, cumulativeGold[lastLocIndex] - goldQuotas[lastLocIndex])
		endIf
		
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
		playersCut = (calculatePay() * nghActualClients[lastLocIndex] * (standardCut / 100)) as int
		cumulativeClients[lastLocIndex] = cumulativeClients[lastLocIndex] + nghActualClients[lastLocIndex]
		nghActualClients[lastLocIndex] = 0
		nghExpectedClients[lastLocIndex] = 0
		
	endIf
	
	if playersCut > 0
		Game.GetPlayer().AddItem(Gold, playersCut)
	endIf
	
	PW_Utility.SendIntEvent("PW_RefreshObjectives", lastLocIndex)
	
	dgConds.OvertimeReported = false
	
	return
endEvent

event OnSideQuestCompleted(string eventName, string strArg, float numArg, Form sender)

	int locIndex = numArg as int

	if(locIndex < 0 || locIndex > 8)
		locIndex = lastLocIndex
	endIf
	
	if(strArg == "bandits")
		if(quotaMode == QUOTA_MODE_CLIENTS)
		
			Debug.MessageBox("You get credit for " + SQBanditClientReward + " clients towards your quota")

			cumulativeClients[locIndex] = cumulativeClients[locIndex] + SQBanditClientReward
			dgConds.IsFinished = cumulativeClients[locIndex] >= clientQuotas[locIndex]
			
			updateEarlyBuyout(locIndex)
			sendEvent("PW_UpdateLocInfo")
			
		elseIf(quotaMode == QUOTA_MODE_GOLD)
		
			Debug.MessageBox("You get credit for " + SQBanditGoldReward + " gold towards your quota")
			
			sendIntIntEvent("PW_UpdateGoldObjecive", locIndex, SQBanditGoldReward)
		
			cumulativeGold[locIndex] = cumulativeGold[locIndex] + SQBanditGoldReward
			dgConds.IsFinished = cumulativeGold[locIndex] >= goldQuotas[locIndex]
			
			updateEarlyBuyout(locIndex)
			sendEvent("PW_UpdateLocInfo")
			
		elseIf(quotaMode == QUOTA_MODE_ENDLESS)
			Game.GetPlayer().AddItem(Gold, SQBanditGoldReward)
			
		endIf
	endIf
	
	PW_Utility.SendIntEvent("PW_RefreshObjectives", locIndex)
endEvent

event OnSideQuestFailed(string eventName, string strArg, float numArg, Form sender)
	; Nothing implemented yet
endEvent

event AssignQuota(int locIndex)
	
	locIndex = scrubLocIndex(locIndex)
	
	;Clear any existing quota to start clean before proceeding
	clearQuota(locIndex)
	
	dgConds.isFinished = false
	
	if(quotaMode == QUOTA_MODE_CLIENTS)
		clientQuotas[locIndex] = Utility.RandomInt(minClientQuota, maxClientQuota)
		
		periodStarts[locIndex] = Utility.GetCurrentGameTime()
		updateEarlyBuyout(locIndex)

	elseIf(quotaMode == QUOTA_MODE_GOLD)
		goldQuotas[locIndex] = Utility.RandomInt(minGoldQuota, maxGoldQuota)

		periodStarts[locIndex] = Utility.GetCurrentGameTime()
		updateEarlyBuyout(locIndex)
	
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
	;ENDLESS is quota-less, it does nothing here
		
	endIf
	
	sendEvent("PW_UpdateLocInfo")
	
	quotaActive[locIndex] = true
endEvent

event AssignSpecificQuota(int locIndex, int specificQuota)
;Initializes the player's quota. Optional args: specify location, specify quota to be set

	if(quotaMode == QUOTA_MODE_ENDLESS)
		pwDebug(self, 4, "attempted to assign a quota while in endless mode")
		return
	endIf

	locIndex = scrubLocIndex(locIndex)
	
	;Clear any existing quota to start clean before proceeding
	clearQuota(locIndex)
	
	dgConds.isFinished = false
	
	if(quotaMode == QUOTA_MODE_CLIENTS)
		;If a (valid) specific quota was passed as an argument then we want to use that. Otherwise use a random one between min and max
		if(specificQuota > 0)
			clientQuotas[locIndex] = specificQuota
		else
			clientQuotas[locIndex] = Utility.RandomInt(minClientQuota, maxClientQuota)
		endIf

		periodStarts[locIndex] = Utility.GetCurrentGameTime()
		updateEarlyBuyout(locIndex)
		sendEvent("PW_UpdateLocInfo")

	elseIf(quotaMode == QUOTA_MODE_GOLD)		;GOLD
		if(specificQuota > 0)
			goldQuotas[locIndex] = specificQuota
		else
			goldQuotas[locIndex] = Utility.RandomInt(minGoldQuota, maxGoldQuota)
		endIf

		periodStarts[locIndex] = Utility.GetCurrentGameTime()
		updateEarlyBuyout(locIndex)
		sendEvent("PW_UpdateLocInfo")

	endIf
	
	quotaActive[locIndex] = true
	
	return
endEvent

function clearQuota(int locIndex = -2)
;Clears all variables associated with quota tracking

	locIndex = scrubLocIndex(locIndex)
	
	quotaActive[locIndex] = false

	clientQuotas[locIndex] = 0
	cumulativeClients[locIndex] = 0
	cumulativeGold[locIndex] = 0
	recentClients[locIndex] = 0
	overtimeClients[locIndex] = 0
	
	if locIndex == lastLocIndex
		PW_RecentClients.SetValue(0)
		SendIntEvent("PW_RecentClientsChange", lastLocIndex)
	endIf

	goldQuotas[locIndex] = 0

	earlyBuyouts[locIndex] = 0
	
	
	sendEvent("PW_UpdateLocInfo")
endFunction

function changeQuotaMode(int value)
	if(value < 0 || value > 2)
		return
	endIf
	
	int i = 0 
	while i <= 8 
		if quotaActive[i]
			Debug.MessageBox("PW: Quota mode cannot be changed while you are the public whore somewhere")
			return
		endIf
		i += 1
	endWhile

	quotaMode = value

	return
endFunction


;Moves all quotas into one hold. namely for enforced mode
event consolidateQuotas(int into)
	into = scrubLocIndex(into)

	if(quotaMode == QUOTA_MODE_CLIENTS)
		int totalClients = 0
		int index = 0
		while(index <= 8)
			if(clientQuotas[index] > 0)
				totalClients += clientQuotas[index]
			endIf
			index += 1
		endWhile
		
		assignSpecificQuota(into, (enforcedModeQuotaMult * totalClients) as int)
		PW_Utility.SendIntEvent("PW_RefreshObjectives", into)
		
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		int totalGold = 0
		int index = 0
		
		while(index <= 8)
			if(goldQuotas[into] > 0)
				totalGold += goldQuotas[index]
			endIf
			index += 1
		endWhile

		assignSpecificQuota(into, (enforcedModeQuotaMult * totalGold) as int)
		PW_Utility.SendIntEvent("PW_RefreshObjectives", into)
		
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
		;Nothing yet
	endIf
	
endEvent

function appendQuota(int locIndex = -2, int specificQuota = 0)
	locIndex = scrubLocIndex(locIndex)
	
	if(quotaMode == QUOTA_MODE_CLIENTS)
		int previousQuota = clientQuotas[locIndex]		;Save the amount of quota currently remaining

		AssignSpecificQuota(locIndex, specificQuota)		;Make a new quota
		clientQuotas[locIndex] =  clientQuotas[locIndex] + previousQuota	;Append the previous one

	elseIf(quotaMode == QUOTA_MODE_GOLD)
		int previousQuota = goldQuotas[locIndex]
		
		AssignSpecificQuota(locIndex, specificQuota)
		goldQuotas[locIndex] = goldQuotas[locIndex] + previousQuota
	
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
		;Probably shouldn't be happening
		pwDebug(self, 4, "tried to append a quota in endless mode")
		return

	endIf
	
	SendEvent("PW_UpdateLocInfo")
	
	SendIntEvent("PW_RefreshObjectives", locIndex)

	return
endfunction

function MultiplyLocalQuota(float multiplier)
	MultiplyQuota(lastLocIndex, multiplier)
endFunction

function MultiplyQuota(int locIndex, float multiplier)
	if(quotaMode == QUOTA_MODE_CLIENTS)
		int previousQuota = clientQuotas[locIndex]		;Save the amount of quota currently remaining
		clientQuotas[locIndex] = (previousQuota * multiplier) as int

	elseIf(quotaMode == QUOTA_MODE_GOLD)
		int previousQuota = goldQuotas[locIndex]
		goldQuotas[locIndex] = (previousQuota * multiplier) as int
	
	endIf
	
	SendIntEvent("PW_RefreshObjectives", locIndex)
endFunction


function incrementClients(int locIndex)

	if(!playerHandlesGold)
		pwDebug(self, 1, "not incrementing clients normally because player is not handling gold")
		return
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		pwDebug(self, 1, "not incrementing clients normally because quota mode is gold")
		return
	endIf

	recentClients[locIndex] = recentClients[locIndex] + 1
	
	if(locIndex == lastLocIndex)
		currentRecentClients += 1
		PW_RecentClients.SetValue(currentRecentClients)
		SendIntEvent("PW_RecentClientsChange", lastLocIndex)
	endIf
	
	pwDebug(self, 2, "incremented clients to " + recentClients[locIndex])

	; Handle OT clients in client mode
	if(quotaMode == QUOTA_MODE_CLIENTS)
		int clientsLeft = clientQuotas[locIndex] - (recentClients[locIndex] + cumulativeClients[locIndex])
		if(clientsLeft == 0)
			Debug.Notification("You have reached your quota here - any further clients are overtime.")
			dgConds.voluntary = true
		elseIf(clientsLeft < 0)
			overtimeClients[locIndex] = overtimeClients[locIndex] + 1
			currentOvertimeClients += 1
			Debug.Notification("You have taken " + currentOvertimeClients + " overtime clients here.")
		else
			Debug.Notification("You have " + clientsLeft + " clients remaining here.")
		endIf
	endIf
	
	;In endless mode, quest wants to keep client count in journal
	if(quotaMode == QUOTA_MODE_ENDLESS)
		PW_Utility.SendIntEvent("PW_RefreshObjectives", locIndex)
	endIf

	return
endFunction

float function getQuotaTimeRemaining(int locIndex)
	return ((reportingPeriod - (Utility.GetCurrentGameTime() - periodStarts[locIndex])) as float)
endfunction


;What the actual fuck is this
function updateGlobals(int quotaClients = 0, int earlyBuyout = 0)
	setGlobal(PW_QuotaClients, quotaClients)
	setGlobal(PW_EarlyBuyout, earlyBuyout)
endFunction


function nghShowQuota(int locIndex)
{Messagebox display the number of people that have reported in}
	if(quotaMode == QUOTA_MODE_CLIENTS || quotaMode == QUOTA_MODE_ENDLESS)
		Debug.MessageBox(nghActualClients[locIndex] + " people paid for fucking you.")
		setGlobal(PW_nghExpected, nghExpectedClients[locIndex])
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		Debug.MessageBox("I received " + nghActualGold[locIndex] + " gold.")
		setGlobal(PW_nghExpected, nghExpectedGold[locIndex])
	endIf

	return
endFunction

bool function HasUnreportedProgress(int locIndex)
	if(locIndex < 0 || locIndex > 8)
		pwDebug(self, 3, "HasUnreportedProgress() called with invalid location index")
	endIf

	if(playerHandlesGold)	;If not handling gold, no progress is "unreported"
		if(quotaMode == QUOTA_MODE_CLIENTS)
			return recentClients[locIndex] > 0
		elseIf(quotaMode == QUOTA_MODE_GOLD)
			return false ;Gold mode doesn't track interim progress
		elseIf(quotaMode == QUOTA_MODE_ENDLESS)
			return recentClients[locIndex] > 0
		endIf
	endIf
	
	return false
endFunction

function ForceReport(int locIndex)
{Does everything playerReport() does but doesn't handle any gold. Primarily used when sending into
Service Extension with a client quota - we don't care whether she turns all the gold in, or gets overtime back, continuing with
punishment scenes is a bigger priority so we tally up the progress to continue.}

	if(quotaMode == QUOTA_MODE_CLIENTS)	;CLIENTS
		overtimeClients[locIndex] = 0
		cumulativeClients[locIndex] = cumulativeClients[locIndex] + recentClients[locIndex]
		recentClients[locIndex] = 0
	elseIf(quotaMode == QUOTA_MODE_GOLD) ;GOLD
		;TODO implement
	endIf
	
	PW_Utility.SendIntEvent("PW_RefreshObjectives", lastLocIndex)

	return
endFunction

string function getQuotaPeriodString(int locIndex)
	if(locIndex < 0 || locIndex > 8)
		return "NO QUOTA"
	endIf
	
	return ((reportingPeriod - (Utility.GetCurrentGameTime() - periodStarts[locIndex])) + "D")
endFunction

int function getOvertimeGold()
	return (overtimeClients[lastLocIndex] * calculatePay() * ((overtimeCut) / 100)) as int 
endFunction

function payOverTimeGold()
	Game.GetPlayer().AddItem(Gold, getOvertimeGold() + playersCut)
	overtimeClients[lastLocIndex] = 0
	currentOvertimeClients = 0
	return
endFunction

int function calculatePay(bool deduction = false)
;Updates the StandardPay global and returns the standard pay, or a deducted amount if we need that.
;It also should be negligibly expensive to call it without assigning any values, just to update the PW_StandardPay global

	float pay = basePay + (payPerLevel * Game.GetPlayer().GetLevel())
	PW_StandardPay.SetValue(pay)
	updateCurrentInstanceGlobal(PW_StandardPay)
	if(deduction) 
		pay *= 0.5
	endIf
	return pay as int
endFunction

function updateEarlyBuyout(int locIndex)
;Updates the earlyBuyouts value for the hold associated with the index.

	calculatePay()

	if(quotaMode == QUOTA_MODE_CLIENTS)
		earlyBuyouts[locIndex] = ((clientQuotas[locIndex] - cumulativeClients[locIndex]) * PW_StandardPay.GetValue() * buyoutMultiplier) as int
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		earlyBuyouts[locIndex] = ((goldQuotas[locIndex] * buyoutMultiplier) as int)
	endIf

	if(locIndex == lastLocIndex)
		updateGlobals(clientQuotas[locIndex], earlyBuyouts[locIndex])
	endIf
	
	return
endFunction

function updateAllEarlyBuyouts()
;Calls updateEarlyBuyout on all locIndices. Rarely if ever should we need this function.

	calculatePay()
	
	int locIndex = 0
	while (locIndex <= 8)
		updateEarlyBuyout(locIndex)
		locIndex += 1
	endWhile
	return
endFunction

int function scrubLocIndex(int locIndex)
{defaults a location index to something usable}
	if(locIndex > 8 || locIndex < 0)
		locIndex = lastLocIndex
	endIf
	
	return locIndex
endFunction

function SimulateClientTaken()
	if(!playerHandlesGold)
		CitizenReport()

	elseIf(quotaMode == QUOTA_MODE_CLIENTS)
		recentClients[lastLocIndex] = recentClients[lastLocIndex] + 1
		currentRecentClients += 1
		Game.GetPlayer().AddItem(Gold, calculatePay())
		
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		Game.GetPlayer().AddItem(Gold, calculatePay())
		
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
		recentClients[lastLocIndex] = recentClients[lastLocIndex] + 1
		currentRecentClients += 1
		SendIntEvent("PW_RefreshObjectives", lastLocIndex)
		Game.GetPlayer().AddItem(Gold, calculatePay())
		
	endIf
	
endFunction

function SimulateClientTakenUnpaid()
	if(!playerHandlesGold)
		;Copy actual, increment, then revert actual
		int prevGold = nghActualGold[lastLocIndex]
		int prevClients = nghActualClients[lastLocIndex]
		CitizenReport()
		nghActualGold[lastLocIndex] = prevGold
		nghActualClients[lastLocIndex] = prevClients
		
		;Now expected will have incremented, actual will be the same. Always conflict now.
		nghDoesntMatch = true

	elseIf(quotaMode == QUOTA_MODE_CLIENTS)
		recentClients[lastLocIndex] = recentClients[lastLocIndex] + 1
		currentRecentClients += 1
		
	elseIf(quotaMode == QUOTA_MODE_GOLD)
		;Does nothing
		
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
		recentClients[lastLocIndex] = recentClients[lastLocIndex] + 1
		currentRecentClients += 1
		SendIntEvent("PW_RefreshObjectives", lastLocIndex)
	endIf
endFunction

function Template()
	if(quotaMode == QUOTA_MODE_CLIENTS)
	
	elseIf(quotaMode == QUOTA_MODE_GOLD)
	
	elseIf(quotaMode == QUOTA_MODE_ENDLESS)
	
	endIf
	
endFunction


int lastLocIndex = 6	;equivalent to Tracker's lastLocIndex

; Quota Mode Constants
int property QUOTA_MODE_CLIENTS		= 0 	autoReadOnly;
int property QUOTA_MODE_GOLD 		= 1 	autoReadOnly;
int property QUOTA_MODE_ENDLESS		= 2 	autoReadOnly;

;Quota Configuration (MCM OPTIONS)
int property quotaMode = 0 Auto Conditional
		;0: X clients, 1: X gold, 2: duration trapped in city
int property minClientQuota = 15 Auto		;Minimum clients to assign per reporting period
int property maxClientQuota = 35 Auto		;Maximum clients to assign per reporting period
int property minGoldQuota = 3000 Auto		;Minimum gold to assign per reporting period
int property maxGoldQuota = 6000 Auto		;Maximum gold to assign per reporting period
int property reportingPeriod = 7 Auto				;Number of days the player has to meet quota

bool[] quotaActive

int[] property clientQuotas Auto
int[] property goldQuotas Auto
float[] property periodStarts Auto
int[] property cumulativeClients Auto
int[] property cumulativeGold Auto
int[] property recentClients Auto
int[] property overtimeClients Auto
int[] property earlyBuyouts Auto
float property buyoutMultiplier = 1.5 Auto

int property currentRecentClients Auto Conditional	;Number of recent clients in current location
int property currentOvertimeClients Auto Conditional	;Number of overtime clients in current location. 

;No-gold-handling mode
int property missingReportChance = 20 Auto	;Chance that a client will not turn in gold later
int[] property nghExpectedGold Auto		;The PC's expectation of how much should have been turned in
int[] property nghActualGold Auto			;The actual amount turned in
int[] property nghExpectedClients Auto
int[] property nghActualClients Auto

int property nghCurrentExpectedClients = 0 Auto Conditional	;Conditional variables for the current expected values, we don't need the actual values in this form
int property nghCurrentExpectedGold = 0 Auto Conditional
bool property nghHasExpectedProgress = false Auto Conditional
bool property nghDoesntMatch = false Auto Conditional


bool[] property quotaFailed Auto
bool property currentQuotaFailed Auto Conditional



Bool property playerHandlesGold = true Auto Conditional
int property standardCut = 0 Auto Conditional 	;what percent of pay will the player keep all the time?
int property overtimeCut = 30 Auto Conditional		;what percent of pay will the player keep when over quota?

;Global properties that we update here based on what they should be in the current location
GlobalVariable property PW_QuotaCount Auto
GlobalVariable property PW_QuotaClients Auto
GlobalVariable property PW_EarlyBuyout Auto
GlobalVariable property PW_StandardPay Auto
GlobalVariable property PW_nghExpected Auto
GlobalVariable property PW_QuotaPeriod Auto
GlobalVariable property PW_RecentClients Auto

PW_DialogueConds property dgConds Auto
PW_TrackerScript property Tracker Auto

int property basePay = 100 Auto	;The base amount of gold paid
int property payPerLevel = 0 Auto		;(This * Player) level will be added to the base gold for a subtotal
;Modifiers will then be applied to the subtotal

bool property hasProgress = false Auto
int property playersCut = 0 Auto Conditional ;REFACTOR THIS OUT

MiscObject property gold auto 

int[] alertLevel

int property SQBanditClientReward = 15 Auto
int property SQBanditGoldReward = 1500 Auto

Faction[] property crimeFactions Auto

float property enforcedModeQuotaMult = 1.5 Auto