Scriptname PW_TrackerScript extends PW_ScriptComponent Conditional
{This script, attached to PW_Tracker, is the focal point of location tracking.
It does the legwork of determining location details, so that the other scripts
can just copy its data}

import PW_Utility

bool property startInEnforcedMode = false auto

PW_ModIntegrationsScript property Mods Auto
PW_DialogueConds property dgConds Auto

Location[] property pwCities Auto

;References to the Thanes added by Public Whore
Actor[] property pwThanes Auto

Faction Property PW_ThaneFaction  Auto  

ReferenceAlias property LocalPWThane Auto		;Who the Thane is in the player's current or last location
ReferenceAlias property LocalJarl Auto
ObjectReference[] property CityCenterMarkers Auto

int[] property cityStatuses Auto

Quest[] Property IntroQuests  Auto  

Location property currentLoc Auto		;The location the player is currently in
int property currentLocIndex Auto Conditional	;The index of the player's current location in the cities array. Much easier and cheaper to use than the location, this gets used A LOT
int property lastLocIndex Auto	;Displays the last valid locIndex the player was in - often the same as currentLocIndex, less volatile than currentLocIndex

bool property currentPunishmentDue Auto Conditional

bool property isWhoreAnywhere = false Auto Conditional		;Whether the player is currently the whore anywhere. Useful for various things.

MiscObject property Gold Auto

ImageSpaceModifier property FadeToBlack Auto

MagicEffect property cantLeaveEffect Auto

Spell property CantLeaveSpell Auto
;int property cantLeaveIndex = -1 Auto
Bool property cantLeave = false Auto Conditional		;If the player can leave before quota is met

;INTERNAL CONTROL
int property extensiveUpdateThreshold = 10 Auto
int property extensiveUpdateCounter = 0 Auto


;MISC TRACKING
bool[] property hasBeenWhore Auto		;Whether, in each hold, the player has ever been the PW
bool property hasBeenWhoreHere = false Auto Conditional	;Whether the player has ever been PW in current location

ReferenceAlias[] Property jarlAliasScripts Auto

Keyword property pwHoldStatusKeyword Auto

bool[] property ssCityEnabled Auto

Faction[] Property CrimeFactions  Auto  

ReferenceAlias Property PlayerFollower Auto ;todo why the fuck is this here, and its handling in main

int property LOC_NONE = -1 Auto
int property LOC_DAWNSTAR = 0 Auto
int property LOC_FALKREATH = 1 Auto
int property LOC_MARKARTH = 2 Auto
int property LOC_MORTHAL = 3 Auto
int property LOC_RIFTEN = 4 Auto
int property LOC_SOLITUDE = 5 Auto
int property LOC_WHITERUN = 6 Auto
int property LOC_WINDHELM = 7 Auto
int property LOC_WINTERHOLD = 8 Auto

function Initialize()
	
	int index = 0
	while index < 8
		pwThanes[index].addToFaction(PW_ThaneFaction)
		index += 1
	endWhile
	
	RegisterForUpdateGameTime(24.0)	;Register our daily update

	cityStatuses = new int[9]
	
	ssCityEnabled = new bool[9]
	ssCityEnabled[LOC_MARKARTH] = true ;Enable Markarth SS by default
	ssCityEnabled[LOC_RIFTEN] = true ;Enable Riften SS by default
	ssCityEnabled[LOC_SOLITUDE] = true ;Enable Solitude SS by default
	ssCityEnabled[LOC_WHITERUN] = true ;Enable Whiterun SS by default
	ssCityEnabled[LOC_WINDHELM] = true ;Enable Windhelm SS by default

	currentLoc = none
	currentLocIndex = LOC_NONE
	
	lastLocIndex = 6

	hasBeenWhore = new bool[9]

	pwDebug(self, 2, "tracker initialized")
	
	return
endFunction

function Startup()
	RegisterForModEvent("PW_CheckTimeComponents", "checkTimeComponents")
	
	RegisterForModEvent("PW_UpdateLocInfo", "updateLocInfoEvent")
	RegisterForModEvent("PW_MakeEligible", "makeEligible")
	RegisterForModEvent("PW_MakeEligibleLocal", "MakeEligibleLocal")
	RegisterForModEvent("PW_MakeEligibleHeroFame", "makeEligible")	;this script does the same thing no matter how eligibility is achieved
	RegisterForModEvent("PW_MakePublicWhore", "makePublicWhore")
	RegisterForModEvent("PW_MakePublicWhoreLocal", "MakePublicWhoreLocal")
	RegisterForModEvent("PW_MakePublicWhoreAdvanced", "makePublicWhoreAdvanced")
	RegisterForModEvent("PW_ssStart", "PW_ssStart")
	RegisterForModEvent("PW_ClearStatus", "clearStatus")
	RegisterForModEvent("PW_ClearStatusLocal", "ClearStatusLocal")
	RegisterForModEvent("PW_ClearAllStatuses", "ClearAllStatuses")
	RegisterForModEvent("PW_MakePublicWhoreSelfCont", "MakePublicWhoreSelfContained")
	
	sendEvent("PW_UpdateLocInfo")
endFunction

event OnUpdateGameTime()
	;Tracker acts as the timekeeper for these daily updates
	sendEvent("PW_DailyUpdate")
endEvent


event updateLocInfoEvent()
{An event wrapper for updateLocInfo}
	updateLocInfo()
endEvent

function updateLocInfo(string calledFrom = "undef")

	pwDebug(self, 2, "tracker location info updating")

	;We need to do a loop through all of the cities here because as of now we don't necessarily know where the player is.
	;Once we find it, we set currentLocIndex to the pwCities index of that city, so that other scripts can simply refer to
	;whateverVariable[currentLocIndex]

	bool locationFound = false
	int index = 0
	while (index <= 8)
		if(Game.GetPlayer().IsInLocation(pwCities[index]))
		
			(jarlAliasScripts[index] as SwapJobAliasScript).RegisterForSingleUpdate(1.0)

			;STUFF WE DO EVERY TIME THIS IS CALLED (track quotas, monitor the local Thane)
			;Update our information about the current hold
			currentLoc = pwCities[index]

			hasBeenWhoreHere = hasBeenWhore[index]
			
			if (index != currentLocIndex)
				PW_Utility.sendIntEvent("PW_EnterCity", index)
				
				if(GetStatus(currentLocIndex) != GetStatus(index))
					PW_Utility.sendIntEvent("PW_CurrentStatusChange", cityStatuses[index])
				endIf
			endIf
			
			currentLocIndex = index
			lastLocIndex = index
			
			locationFound = true
		endIf
		index += 1
	endWhile

	;If no location found and we aren't already nowhere, make us nowhere.
	if(!locationFound && currentLocIndex != LOC_NONE)
		currentLocIndex = LOC_NONE
		currentLoc = none
		
		if(GetStatus(lastLocIndex) != 0)
			PW_Utility.sendIntEvent("PW_CurrentStatusChange", 0)
		endIf
		
		PW_Utility.SendIntEvent("PW_LeaveCity", lastLocIndex)
		
	endIf
	
	; Anything below this wait serves as a kind of post-update,
	; where we're fairly sure other components will have updated their
	; information by now
	Utility.Wait(2.0)
	
	if(lastLocIndex >= 0 && lastLocIndex <= 8)
		Actor jarl = jarlAliasScripts[lastLocIndex].GetActorReference()
		if jarl != None
			LocalJarl.ForceRefTo(jarl)
		else
			pwDebug(self, 5, "no jarl found for location index " + lastLocIndex)
		endIf
		
		Actor thane = pwThanes[lastLocIndex]
		if thane != None
			LocalPWThane.ForceRefTo(thane)
		else
			pwDebug(self, 5, "no thane found for location index " + lastLocIndex)
		endIf
	endIf
	
endFunction

int function GetLocIndexFromLocation(Location locArg)
	int index = pwCities.Find(locArg)
	
	if(index < 0)
		pwDebug(self, 4, "PW was asked to find a location index for a location it is not tracking.")
		return -1
	endIf
	
	return index
endFunction


event checkTimeComponents()
{Tracker currently isn't doing anything with this}
endEvent



function updateIsWhoreAnywhere()
	int index = 0
	while index <= 8
		if(GetStatus(currentLocIndex) == 2)
			isWhoreAnywhere = true
			return
		endIf
		index += 1
	endWhile
	
	isWhoreAnywhere = false
	
	return
endFunction

event makeEligible(int locIndex)
{If a valid location index is passed, this marks the player as eligible in the corresponding city.
If no index is passed/locIndex == -2, this marks the player as eligible in their current city (if in one).
Does nothing if an invalid index is passed.}

	if(locIndex < 0 || locIndex > 8)
		locIndex = lastLocIndex
	endIf


	if(IntroQuests[locIndex] != none)
		if(IntroQuests[locIndex]).GetStage() > 0
			return			;we don't want the player becoming eligible mid-quest
		endIf
	endIf

	if(locIndex >= 0 && locIndex <= 8)
		SetStatus(locIndex, 1)
	else
		return
	endIf

	PW_Utility.SendEvent("PW_UpdateLocInfo")
	
	sendIntEvent("PW_BecameEligible", locIndex)

	return
endEvent

event MakeEligibleLocal()
	if(currentLocIndex < 0 || currentLocIndex > 8)
		return
	endIf
	
	MakeEligible(currentLocIndex)
endEvent

int function GetCurrentStatus()
	if (currentLocIndex < 0 || currentLocIndex > 8)
		pwDebug(self, 3, "tried to get current status while not registered as in a city")
		return 0
	endIf
	
	return GetStatus(currentLocIndex)
endFunction

int function GetStatus(int locIndex)
	if(locIndex < 0 || locIndex > 8)
		return 0
	endIf
	
	return pwCities[locIndex].GetKeywordData(pwHoldStatusKeyword) as int
endFunction

function SetStatus(int locIndex, int status)
	if(locIndex < 0 || locIndex > 8)
		return
	endIf

	if(GetStatus(locIndex) != status && locIndex == currentLocIndex)
		PW_Utility.sendIntEvent("PW_CurrentStatusChange", status)
	endIf
	
	cityStatuses[locIndex] = status
	pwCities[locIndex].SetKeywordData(pwHoldStatusKeyword, status)
	
endFunction


event MakePublicWhoreLocal()
	if(currentLocIndex >= 0 && currentLocIndex <= 8)
		MakePublicWhore(currentLocIndex)
	endIf
endEvent


event makePublicWhore(int locIndex)

	if(locIndex < 0 || locIndex > 8)
		locIndex = lastLocIndex
	endIf

	SetStatus(locIndex, 2)

	sendIntEvent("PW_AssignQuota", locIndex)

	isWhoreAnywhere = true
	hasBeenWhore[locIndex] = true
	
	sendEvent("PW_StripPlayer")
	
	Mods.collarPlayer()

	if(startInEnforcedMode)
		SetEnforcedMode(locIndex)
	elseIf(cantLeave && !Game.GetPlayer().HasMagicEffect(cantLeaveEffect))
		Debug.MessageBox("An incantation is cast upon you. If you attempt to leave the city, you will begin to suffocate.")
		Game.GetPlayer().AddSpell(CantLeaveSpell)

	endIf

	if IntroQuests[locIndex] != None
		if(IntroQuests[locIndex].IsRunning())
			IntroQuests[locIndex].CompleteQuest()
		endIf
	endIf

	PW_Utility.sendIntEvent("PW_QuestInternalsReady", locIndex)
	
	sendEvent("PW_UpdateLocInfo")
	
	sendIntEvent("PW_BecamePublicWhore", locIndex)
	return
endEvent

event makePublicWhoreAdvanced(int locIndex, int specificQuota, bool enforcedMode)

	if(locIndex < 0 || locIndex > 8)
		locIndex = lastLocIndex
	endIf

	SetStatus(locIndex, 2)
	
	sendIntIntEvent("PW_AssignSpecificQuota", locIndex, specificQuota)

	isWhoreAnywhere = true
	hasBeenWhore[locIndex] = true
	
	sendEvent("PW_StripPlayer")
	Mods.collarPlayer()

	updateLocInfo()		;This seems necessary

	if(startInEnforcedMode || enforcedMode)
		SetEnforcedMode(locIndex)
	elseIf(cantLeave && !Game.GetPlayer().HasMagicEffect(cantLeaveEffect))
		Debug.MessageBox("An incantation is cast upon you. If you attempt to leave the city, you will begin to suffocate.")
		Game.GetPlayer().AddSpell(CantLeaveSpell)
	endIf

	if(IntroQuests[locIndex].IsRunning())
		IntroQuests[locIndex].CompleteQuest()
	endIf

	
	PW_Utility.sendIntEvent("PW_QuestInternalsReady", locIndex)
	
	sendIntEvent("PW_BecamePublicWhore", locIndex)
	
	sendEvent("PW_UpdateLocInfo")
	return
endEvent

event MakePublicWhoreSelfContained(int locIndex, bool ssStart)
{The full package - an introduction, the setting of the statuses, all in one}
	if(locIndex < 0 || locIndex > 8)
		return
	endIf
	
	;Prevent stuff happening while screen is black
	SendModEvent("dhlp-Suspend")
	Game.DisablePlayerControls()
	
	SetStatus(locIndex, 2)

	string holdName = PW_Constants.getCityName(locIndex)

	FadeToBlack.ApplyCrossfade(1.0)
	Utility.Wait(1.0)
	if(ssStart)
		Debug.MessageBox("Your buyer tells you that they have purchased you on behalf of " + holdName + ", where they take you now.")
		Utility.Wait(1.0)
	endIf

	Debug.MessageBox("You are arrested by guards, who strip you, collar you, and mark you as property of " + holdName + ". By decree of the Jarl, you have been made Public Whore of " + holdName + ". You are now legally obligated to sell yourself to the citizens of " + holdName + " and turn  in your profits to " +  pwThanes[locIndex].GetLeveledActorBase().GetName() + ".")
	
	Game.GetPlayer().MoveTo(CityCenterMarkers[locIndex])
	
	Utility.Wait(3.0)
	
	Mods.addSlaveTat(locIndex)

	MakePublicWhoreAdvanced(locIndex, 0, ssStart)

	sendEvent("PW_PrintQuota")
	
	FadeToBlack.Remove()
	
	Game.EnablePlayerControls()
	SendModEvent("dhlp-Resume")

endEvent

event clearStatus(int locIndex)
	pwDebug(self, 2, "ClearStatus() ENTER, locIndex = " + locIndex)
	
	if(locIndex < 0 || locIndex > 8)
		locIndex = currentLocIndex
		pwDebug(self, 2, "ClearStatus() defaulting locIndex to currentLocIndex")
	endIf
	
	ClearEnforcedMode(locIndex)

	SetStatus(locIndex, 0)

	sendIntEvent("PW_ClearQuota", locIndex)
	
	updateIsWhoreAnywhere()
	
	sendEvent("PW_UpdateLocInfo")
	
	sendIntEvent("PW_StatusCleared", locIndex)

	;cantLeaveIndex = -1
	Game.GetPlayer().DispelSpell(cantLeaveSpell)

	return
endEvent


event SetEnforcedMode(int locIndex)

	;There can be only one whore-status hold now, clear the rest
	int i = 0
	while i <= 8
		if(GetStatus(i) == 2 && i != locIndex)
			ClearStatus(i)
		endIf
		i += 1
	endWhile
	
	;Tell the other components what's up
	PW_Utility.sendIntEvent("PW_SetEnforcedMode", locIndex)
	
	
endEvent

event ClearEnforcedMode(int locIndex)
	SendIntEvent("PW_ClearEnforcedMode", locIndex)
endEvent

event PW_ssStart(string eventName, string strArg, float numArg, Form sender)
	MakePublicWhoreSelfContained(GetValidSSIndex(), true)
endEvent

int function GetValidSSIndex()
	int validCities = 0
	int index = 0
	
	; Get array of valid location indices
	int[] validCityMap = new int[9]	; key: n | value: locIndex of nth valid city
	while (index <= 8)
		if(ssCityEnabled[index])
			validCityMap[validCities] = index
			validCities += 1
		endIf
		index += 1
	endWhile
	
	if(validCities < 1) ;No valid cities? SS++ sent the player here, we need to return something.
		return Utility.RandomInt(0, 8)
	endIf
	
	return validCityMap[Utility.RandomInt(0, validCities - 1)]
	
endFunction

event ClearStatusLocal()
	pwDebug(self, 2, "ClearStatusLocal() ENTER")
	if(currentLocIndex >= 0 && currentLocIndex <= 8)
		clearStatus(currentLocIndex)
	else
		pwDebug(self, 2, "ClearStatusLocal() EXIT, invalid currentLocIndex: " + currentLocIndex)
	endIf
endEvent

event ClearAllStatuses()
	int i = 0
	while i <= 8
		if GetStatus(i) != 0
			ClearStatus(i)
		endIf
		i += 1
	endWhile
endEvent


int function scrubLocIndex(int locIndex)
{defaults a location index to something usable}
	if(locIndex > 8 || locIndex < 0)
		locIndex = lastLocIndex
	endIf
	
	return locIndex
endFunction

Actor function GetJarl(int locIndex)
	return jarlAliasScripts[locIndex].GetActorReference()
endFunction

function PrintJarls()
	string output = ""
	int i = 0
	while i <= 8
		if jarlAliasScripts[i].GetActorReference() != none
			output += i + ": " + jarlAliasScripts[i].GetActorReference().GetLeveledActorBase().GetName() + "\n"
		else
			output += i + ": Empty\n"
		endIf
		i += 1
	endWhile
	
	Debug.MessageBox(output)
endFunction


Function AddBountyLocal(int bounty, bool violent)
	AddBounty(lastLocIndex, bounty, violent)
endFunction

Function AddBounty(int locIndex, int bounty, bool violent)
	if locIndex < 0 || locIndex > 8
		pwDebug(self, 5, "tried to add bounty to invalid hold index: " + locIndex)
		return
	endIf
	
	Debug.Notification(bounty + " bounty added to " + PW_Constants.getHoldName(locIndex))
	
	CrimeFactions[locIndex].ModCrimeGold(bounty, violent)
	
endFunction

function trackerDebugFunc()
endFunction
