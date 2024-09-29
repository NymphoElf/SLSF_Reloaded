Scriptname PW_HoldQuestScript extends PW_Quest

Int property locIndex Auto
ReferenceAlias property ThaneAlias Auto

PW_QuotaManagerScript QuotaMgr
PW_TrackerScript Tracker

GlobalVariable PW_QuotaPeriod
GlobalVariable PW_QuotaTimeLeft
GlobalVariable PW_ReportedGold
GlobalVariable PW_ReportedClients
GlobalVariable PW_ObjectiveGold
GlobalVariable PW_ObjectiveClients
GlobalVariable PW_RecentClients

function setup()
{Designed to be called by me right after I start the quest.
Serves as an OnInit that gets called specifically when I want it to}

	;These are defined using getformfromfile because I dont want to have to fill them out manually on each city's quest
	QuotaMgr = Quest.GetQuest("PW_QuotaManagement") as PW_QuotaManagerScript
	Tracker = Quest.GetQuest("PW_Tracker") as PW_TrackerScript
	PW_QuotaPeriod = Game.GetFormFromFile(0x04018790, "Public Whore.esp") as GlobalVariable
	PW_QuotaTimeLeft = Game.GetFormFromFile(0x0404783E, "Public Whore.esp") as GlobalVariable
	PW_ReportedGold = Game.GetFormFromFile(0x0404370F, "Public Whore.esp") as GlobalVariable
	PW_ReportedClients = Game.GetFormFromFile(0x0404370E, "Public Whore.esp") as GlobalVariable
	PW_ObjectiveGold = Game.GetFormFromFile(0x04043711, "Public Whore.esp") as GlobalVariable
	PW_ObjectiveClients = Game.GetFormFromFile(0x04043710, "Public Whore.esp") as GlobalVariable
	PW_RecentClients = Game.GetFormFromFile(0x04069A1F, "Public Whore.esp") as GlobalVariable

	ThaneAlias.ForceRefTo(Tracker.pwThanes[locIndex])

	PW_QuotaPeriod.SetValue(QuotaMgr.reportingPeriod)
	PW_QuotaTimeLeft.SetValue(Math.Ceiling(QuotaMgr.getQuotaTimeRemaining(locIndex)))
	PW_ReportedClients.SetValue(0)
	PW_ObjectiveClients.SetValue(QuotaMgr.clientQuotas[locIndex])
	PW_ReportedGold.SetValue(0)
	PW_ObjectiveGold.SetValue(QuotaMgr.goldQuotas[locIndex])

	UpdateCurrentInstanceGlobal(PW_QuotaPeriod)
	UpdateCurrentInstanceGlobal(PW_QuotaTimeLeft)
	UpdateCurrentInstanceGlobal(PW_ReportedGold)
	UpdateCurrentInstanceGlobal(PW_ReportedClients)
	UpdateCurrentInstanceGlobal(PW_ObjectiveGold)
	UpdateCurrentInstanceGlobal(PW_ObjectiveClients)

	if(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_CLIENTS)
		SetObjectiveDisplayed(1)
		SetObjectiveDisplayed(4)
		SetObjectiveDisplayed(5)
		RegisterForModEvent("PW_UpdateClientObjective", "updateClientObjective")
	elseIf(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_GOLD)
		SetObjectiveDisplayed(2)
		SetObjectiveDisplayed(4)
		RegisterForModEvent("PW_UpdateGoldObjective", "updateGoldObjective")
	elseIf(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_ENDLESS)
		SetObjectiveDisplayed(3)
	endIf
	
	RegisterEvents()
	return
endFunction

event onClearStatus(int aLocIndex)
	if (aLocIndex == locIndex)
		unregisterEvents()
		SetStage(100)
	endIf
endEvent

function RegisterEvents()
	RegisterForModEvent("PW_UpdateLocationGlobal", "UpdateLocationGlobal")
	RegisterForModEvent("PW_DailyUpdate", "updateTimeObjectives")
	RegisterForModEvent("PW_StatusCleared", "onClearStatus")
	RegisterForModEvent("PW_RefreshObjectives", "RefreshObjectives")
	RegisterForModEvent("PW_RecentClientsChange", "OnRecentClientsChange")
endFunction

function UnregisterEvents()
	UnregisterForModEvent("PW_DailyUpdate")
	UnregisterForModEvent("PW_RefreshObjectives")
	UnregisterForModEvent("PW_StatusCleared")
	UnregisterForModEvent("PW_UpdateLocationGlobal")
	UnregisterForModEvent("PW_RecentClientsChange")
endFunction


event UpdateLocationGlobal(Form glob, int locIndex)
	if (!glob as GlobalVariable)
		return
	endIf

	GlobalVariable globVar = glob as GlobalVariable

	UpdateCurrentInstanceGlobal(globVar)
endEvent


event updateGoldObjective(int aLocIndex, int amount)
	if(aLocIndex != locIndex)
		return
	endIf
	
	PW_ReportedGold.SetValue(QuotaMgr.cumulativeGold[locIndex])
	PW_ObjectiveGold.SetValue(QuotaMgr.goldQuotas[locIndex])	
	UpdateCurrentInstanceGlobal(PW_ReportedGold)
	UpdateCurrentInstanceGlobal(PW_ObjectiveGold)

	SetObjectiveDisplayed(2, abForce = true)
endEvent

event updateClientObjective(int aLocIndex, int amount)
	if(aLocIndex != locIndex)
		return
	endIf
	
	PW_ReportedClients.SetValue(QuotaMgr.cumulativeClients[locIndex])
	PW_ObjectiveClients.SetValue(QuotaMgr.clientQuotas[locIndex])
	UpdateCurrentInstanceGlobal(PW_ReportedClients)
	UpdateCurrentInstanceGlobal(PW_ObjectiveClients)

	SetObjectiveDisplayed(1, abForce = true)
endEvent

event RefreshObjectives(int aLocIndex)
	if(aLocIndex != locIndex)
		return
	endIf

	if(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_CLIENTS)
		PW_ReportedClients.SetValue(QuotaMgr.cumulativeClients[locIndex])
		PW_ObjectiveClients.SetValue(QuotaMgr.clientQuotas[locIndex])
		UpdateCurrentInstanceGlobal(PW_ReportedClients)
		UpdateCurrentInstanceGlobal(PW_ObjectiveClients)

		SetObjectiveDisplayed(1, abForce = true)

	elseIf(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_GOLD)
		PW_ReportedGold.SetValue(QuotaMgr.cumulativeGold[locIndex])
		PW_ObjectiveGold.SetValue(QuotaMgr.goldQuotas[locIndex])	
		UpdateCurrentInstanceGlobal(PW_ReportedGold)
		UpdateCurrentInstanceGlobal(PW_ObjectiveGold)

		SetObjectiveDisplayed(2, abForce = true)
	endIf
endEvent

Event OnRecentClientsChange(int locIndex)
	if(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_CLIENTS || QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_ENDLESS)
		if(quotaMgr.playerHandlesGold && QuotaMgr.recentClients[locIndex] > 0)
			UpdateCurrentInstanceGlobal(PW_RecentClients)
			SetObjectiveDisplayed(5, abForce = true)
		elseIf(!quotaMgr.playerHandlesGold && QuotaMgr.nghExpectedClients[locIndex] > 0)
			UpdateCurrentInstanceGlobal(PW_RecentClients)
			SetObjectiveDisplayed(5, abForce = true)
		elseIf(QuotaMgr.recentClients[locIndex] == 0)
			SetObjectiveDisplayed(5, false)
		endIf
	endIf
endEvent

function updateTimeObjectives()
{Called from Tracker once every 24 hours}

	PW_QuotaTimeLeft.SetValue(Math.Ceiling(QuotaMgr.getQuotaTimeRemaining(locIndex)))
	UpdateCurrentInstanceGlobal(PW_QuotaTimeLeft)
	ModObjectiveGlobal(0, PW_QuotaTimeLeft, 4, 0, abCountingUp = false)

	return
endFunction