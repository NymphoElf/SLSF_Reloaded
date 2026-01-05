ScriptName SLSF_Reloaded_PlayerScript extends ReferenceAlias

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_TimeManager Property TimeManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_ModEventListener Property Listener Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_LegacyOverwrite Property LegacyOverwrite Auto
SLSF_Reloaded_DynamicAnonymity Property DynamicAnonymityScript Auto
SLSF_Reloaded_SexAnimationAnalyzer Property AnimationAnalyzer Auto
SLSF_Reloaded_Logger Property Logger Auto

Actor Property PlayerRef Auto

Bool Property WaitingOnVisibilityManager = False Auto Hidden

Spell Property NPCScanSpell Auto

GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto

GlobalVariable Property SLSF_Reloaded_Skooma Auto

Event OnInit()
	Startup()
EndEvent

Function Startup()
	RegisterForUpdateGameTime(0.5)
	
	Mods.CheckInstalledMods()
	
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
	RegisterForModEvent("HookAnimationEnd", "OnSexlabAnimationEnd")
	RegisterForMenu("Sleep/Wait Menu")
	RegisterForMenu("RaceSex Menu")
	
	Logger.Log("SLSF Reloaded - Player Script Initialized", True)
EndFunction

Event OnPlayerLoadGame()
	ActorBase PlayerBase = PlayerRef.GetActorBase()
	String PlayerName = PlayerBase.GetName()
	
	If Logger.LogName == "" || Logger.LogName == "?"
		Logger.LogName = PlayerName
		Logger.DuplicateCheck()
	EndIf
	Logger.Log("===LOAD GAME===")
	
	Mods.CheckInstalledMods()
	Listener.RegisterExternalEvents()
	Data.CleanExternalModList()
	VisibilityManager.UpdateTattooSlots()
	
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
	RegisterForModEvent("HookAnimationEnd", "OnSexlabAnimationEnd")
	
	If Mods.IsANDInstalled == True
		RegisterForModEvent("AdvancedNudityDetectionUpdate", "OnANDUpdate")
	EndIf
	
	Logger.Log("SLSF Reloaded - Player Script: Load Game Complete", True)
EndEvent

Event OnANDUpdate()
	If VisibilityManager.UpdateRunning == False && VisibilityManager.CountingBodyTats == False
		VisibilityManager.CountBodyTattoos()
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "RaceSex Menu"
		ActorBase PlayerBase = PlayerRef.GetActorBase()
		String PlayerName = PlayerBase.GetName()
		
		Logger.LogName = PlayerName
		Logger.DuplicateCheck()
		Logger.Log("===MAMMAERIES AND LACTATION LOG START===")
		Logger.Log("===PLAYER NAME: " + PlayerName + " ===")
	EndIf
	
	If MenuName == "Sleep/Wait Menu"
		Float TimeDifference = Utility.GetCurrentGameTime() - TimeManager.LastCheckedTime
		Logger.Log("SLSF Reloaded - Sleep/Wait Menu Closed")
		Logger.Log("SLSF Reloaded - Sleep/Wait Menu Time Check. Curent Game Time is: " + Utility.GetCurrentGameTime())
		Logger.Log("SLSF Reloaded - Sleep/Wait Menu Time Check. TimeManager Last Checked Time is: " + TimeManager.LastCheckedTime)
		Logger.Log("SLSF Reloaded - Sleep/Wait Menu Time Check. Difference is: " + TimeDifference)
		If TimeDifference >= 0.0199 ;~0.0199 is the time amount for an in-game half-hour
			If TimeManager.TimeManagerRunning == False ;Prevent double-up of Periodic Fame Update
				Logger.Log("SLSF Reloaded - Sleep/Wait Menu tiggers TimeManager")
				TimeManager.PeriodicFameTimer()
			EndIf
		EndIf
	EndIf
EndEvent

Event OnSexlabAnimationStart(Int threadID, Bool hasPlayer)
	Logger.Log("SLSF Reloaded - Sexlab Animation started")
	If hasPlayer == True
		Logger.Log("SLSF Reloaded - Sexlab Animation has player")
		AnimationAnalyzer.SexSceneEnded = False
		AnimationAnalyzer.AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabForeplayEnd(Int threadID, Bool hasPlayer)
	Logger.Log("SLSF Reloaded - Foreplay Animation ended")
	If hasPlayer == True
		Logger.Log("SLSF Reloaded - Foreplay Animation has player")
		AnimationAnalyzer.SexSceneEnded = False
		AnimationAnalyzer.AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabAnimationEnd(Int threadID, Bool hasPlayer)
	Logger.Log("SLSF Reloaded - Sexlab Animation ended")
	If hasPlayer == True
		Logger.Log("SLSF Reloaded - Sexlab Animation has player")
		AnimationAnalyzer.SexSceneEnded = True
	EndIf
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	LocationManager.CurrentLocation = akNewLoc
	If Config.DynamicAnonymity == True
		DynamicAnonymityScript.CompareLocations(akOldLoc, akNewLoc)
		DynamicAnonymityScript.GetAnonymity(akNewLoc)
	EndIf
	FameManager.UpdateGlobals()
EndEvent

Event OnUpdateGameTime()
	Logger.Log("SLSF Reloaded - PlayerScript UpdateGameTime started.")
	If TimeManager.TimeManagerRunning == False ;Prevent double-up of Periodic Fame Update
		Logger.Log("SLSF Reloaded - PlayerScript UpdateGameTime: TimeManager is not already running. Calling TimeManager.")
		TimeManager.PeriodicFameTimer()
	Else
		Logger.Log("SLSF Reloaded - PlayerScript UpdateGameTime: TimeManager is already running. Skipped TimeManager call.")
	EndIf
	
	Int OldSkoomaValue = SLSF_Reloaded_Skooma.GetValue() as Int
	Int NewSkoomaValue = OldSkoomaValue - 2
	
	If NewSkoomaValue < 0
		NewSkoomaValue = 0
	EndIf
	
	SLSF_Reloaded_Skooma.SetValue(NewSkoomaValue)
	
	If Config.AllowLegacyOverwrite == True
		Logger.Log("SLSF Reloaded - PlayerScript UpdateGameTime: AllowLegacyOverwrite is TRUE")
		LegacyOverwrite.OverwriteLegacyFame()
	Else
		Logger.Log("SLSF Reloaded - PlayerScript UpdateGameTime: AllowLegacyOverwrite is FALSE")
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	String ObjectName = ""
	
	If akBaseObject != none
		ObjectName = akBaseObject.GetName()
	EndIf
	
	Logger.Log("SLSF Reloaded - PlayerScript OnObjectEquipped: ObjectName is: " + ObjectName)
	
	If (akBaseObject == none || ObjectName == "")
		Logger.Log("SLSF Reloaded - PlayerScript OnObjectEquipped: Object is Null or has blank name. Event terminated.")
		return
	ElseIf (ObjectName == "Skooma" || ObjectName == "Kordir's Skooma" || ObjectName == "Redwater Skooma" || ObjectName == "Double-Distilled Skooma")
		Int OldSkoomaValue = SLSF_Reloaded_Skooma.GetValue() as Int
		Int NewSkoomaValue = OldSkoomaValue + 1
		
		If NewSkoomaValue > 150
			NewSkoomaValue = 150
		EndIf
		
		SLSF_Reloaded_Skooma.SetValue(NewSkoomaValue)
	EndIf
	
	If VisibilityManager.UpdateRunning == False
		VisibilityManager.FullUpdate()
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	String ObjectName = ""
	
	If akBaseObject != none
		ObjectName = akBaseObject.GetName()
	EndIf
	
	Logger.Log("SLSF Reloaded - PlayerScript OnObjectUnequipped: Object name is: " + ObjectName)
	
	If (akBaseObject == none || akBaseObject.GetName() == "")
		Logger.Log("SLSF Reloaded - PlayerScript OnObjectUnequipped: Object is Null or has blank name. Event terminated.")
		return
	EndIf
	
	If VisibilityManager.UpdateRunning == False
		VisibilityManager.FullUpdate()
	EndIf
EndEvent

Function RunNPCDetect()
	SLSF_Reloaded_NPCScanSucess.SetValue(0)
	NPCScanSpell.Cast(PlayerRef)
EndFunction