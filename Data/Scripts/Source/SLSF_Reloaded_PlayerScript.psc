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
SLSF_Reloaded_UpdateManager Property UpdateManager Auto

Actor Property PlayerRef Auto

Bool Property WaitingOnVisibilityManager Auto Hidden

Float Property LastModVersion Auto Hidden

Spell Property NPCScanSpell Auto

GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto

GlobalVariable Property SLSF_Reloaded_Skooma Auto

Event OnInit()
	RegisterForUpdateGameTime(0.5)
	Mods.CheckInstalledMods()
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
	RegisterForModEvent("HookAnimationEnd", "OnSexlabAnimationEnd")
	RegisterForMenu("Sleep/Wait Menu")
	WaitingOnVisibilityManager = False
	
	Debug.Trace("SLSF Reloaded - Player Script Initialized")
EndEvent

Event OnPlayerLoadGame()
	Mods.CheckInstalledMods()
	Listener.RegisterExternalEvents()
	Data.CleanExternalModList()
	VisibilityManager.UpdateTattooSlots()
	
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
	RegisterForModEvent("HookAnimationEnd", "OnSexlabAnimationEnd")
	RegisterForMenu("Sleep/Wait Menu")
	
	UpdateManager.CheckModUpdate(LastModVersion)
	
	Debug.Trace("SLSF Reloaded - Player Script: Load Game Complete")
EndEvent

Event OnMenuClose(String MenuName) ;We only registered the Sleep/Wait Menu, so that's the only one we'll capture with this event
	Float TimeDifference = Utility.GetCurrentGameTime() - TimeManager.LastCheckedTime
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Sleep/Wait Menu Closed")
		Debug.Trace("SLSF Reloaded - Sleep/Wait Menu Time Check. Curent Game Time is: " + Utility.GetCurrentGameTime())
		Debug.Trace("SLSF Reloaded - Sleep/Wait Menu Time Check. TimeManager Last Checked Time is: " + TimeManager.LastCheckedTime)
		Debug.Trace("SLSF Reloaded - Sleep/Wait Menu Time Check. Difference is: " + TimeDifference)
	EndIf
	If TimeDifference >= 0.0199 ;~0.0199 is the time amount for an in-game half-hour
		If TimeManager.TimeManagerRunning == False ;Prevent double-up of Periodic Fame Update
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Sleep/Wait Menu tiggers TimeManager")
			EndIf
			TimeManager.PeriodicFameTimer()
		EndIf
	EndIf
EndEvent

Event OnSexlabAnimationStart(Int threadID, Bool hasPlayer)
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Sexlab Animation started")
	EndIf
	If hasPlayer == True
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Sexlab Animation has player")
		EndIf
		AnimationAnalyzer.SexSceneEnded = False
		AnimationAnalyzer.AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabForeplayEnd(Int threadID, Bool hasPlayer)
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Foreplay Animation ended")
	EndIf
	If hasPlayer == True
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Foreplay Animation has player")
		EndIf
		AnimationAnalyzer.SexSceneEnded = False
		AnimationAnalyzer.AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabAnimationEnd(Int threadID, Bool hasPlayer)
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Sexlab Animation ended")
	EndIf
	If hasPlayer == True
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Sexlab Animation has player")
		EndIf
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
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - PlayerScript UpdateGameTime started.")
	EndIf
	If TimeManager.TimeManagerRunning == False ;Prevent double-up of Periodic Fame Update
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - PlayerScript UpdateGameTime: TimeManager is not already running. Calling TimeManager.")
		EndIf
		TimeManager.PeriodicFameTimer()
	Else
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - PlayerScript UpdateGameTime: TimeManager is already running. Skipped TimeManager call.")
		EndIf
	EndIf
	
	Int OldSkoomaValue = SLSF_Reloaded_Skooma.GetValue() as Int
	Int NewSkoomaValue = OldSkoomaValue - 2
	
	If NewSkoomaValue < 0
		NewSkoomaValue = 0
	EndIf
	
	SLSF_Reloaded_Skooma.SetValue(NewSkoomaValue)
	
	If Config.AllowLegacyOverwrite == True
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - PlayerScript UpdateGameTime: AllowLegacyOverwrite is TRUE")
		EndIf
		LegacyOverwrite.OverwriteLegacyFame()
	Else
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - PlayerScript UpdateGameTime: AllowLegacyOverwrite is FALSE")
		EndIf
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	String ObjectName = ""
	
	If akBaseObject != none
		ObjectName = akBaseObject.GetName()
	EndIf
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - PlayerScript OnObjectEquipped: ObjectName is: " + ObjectName)
	EndIf
	
	If (akBaseObject == none || ObjectName == "")
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - PlayerScript OnObjectEquipped: Object is Null or has blank name. Event terminated.")
		EndIf
		return
	ElseIf (ObjectName == "Skooma" || ObjectName == "Kordir's Skooma" || ObjectName == "Redwater Skooma" || ObjectName == "Double-Distilled Skooma")
		Int OldSkoomaValue = SLSF_Reloaded_Skooma.GetValue() as Int
		Int NewSkoomaValue = OldSkoomaValue + 1
		
		If NewSkoomaValue > 150
			NewSkoomaValue = 150
		EndIf
		
		SLSF_Reloaded_Skooma.SetValue(NewSkoomaValue)
	EndIf
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - PlayerScript OnObjectEquipped: Register VisibilityManager for Single Update")
	EndIf
	
	If VisibilityManager.UpdateRunning == False
		WaitingOnVisibilityManager = False
		VisibilityManager.RegisterForSingleUpdate(0.1)
	Else
		If WaitingOnVisibilityManager == False
			While VisibilityManager.UpdateRunning == True
				WaitingOnVisibilityManager = True
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - OnObjectEquipped: Waiting on previous VisibilityManager Update to finish")
				EndIf
				Utility.Wait(5.0) ;Wait 5 seconds to let the VisibilityManager Update Finish before starting a new one
			EndWhile
			
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - OnObjectEquipped: Previous VisibilityManager Update finished. Register VisibilityManager for Single Update")
			EndIf
			
			VisibilityManager.RegisterForSingleUpdate(0.1)
			WaitingOnVisibilityManager = False
		EndIf
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	String ObjectName = ""
	
	If akBaseObject != none
		ObjectName = akBaseObject.GetName()
	EndIf
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - PlayerScript OnObjectUnequipped: Object name is: " + ObjectName)
	EndIf
	
	If (akBaseObject == none || akBaseObject.GetName() == "")
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - PlayerScript OnObjectUnequipped: Object is Null or has blank name. Event terminated.")
		EndIf
		return
	EndIf
	
	If VisibilityManager.UpdateRunning == False
		WaitingOnVisibilityManager = False
		VisibilityManager.RegisterForSingleUpdate(0.1)
	Else
		If WaitingOnVisibilityManager == False
			While VisibilityManager.UpdateRunning == True
				WaitingOnVisibilityManager = True
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - OnObjectUnequipped: Waiting on previous VisibilityManager Update to finish")
				EndIf
				Utility.Wait(5.0) ;Wait 5 seconds to let the VisibilityManager Update Finish before starting a new one
			EndWhile
			
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - OnObjectUnequipped: Previous VisibilityManager Update finished. Register VisibilityManager for Single Update")
			EndIf
			
			VisibilityManager.RegisterForSingleUpdate(0.1)
			WaitingOnVisibilityManager = False
		EndIf
	EndIf
EndEvent

Function RunNPCDetect()
	SLSF_Reloaded_NPCScanSucess.SetValue(0)
	NPCScanSpell.Cast(PlayerRef)
EndFunction