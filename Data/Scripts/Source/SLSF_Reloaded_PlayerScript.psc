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

GlobalVariable Property SLSF_AllowComment Auto
GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto
GlobalVariable Property SLSF_Reloaded_Skooma Auto

Event OnInit()
	Startup()
EndEvent

Function Startup()
	Mods.CheckInstalledMods()
	
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
	RegisterForModEvent("HookAnimationEnd", "OnSexlabAnimationEnd")
	
	If Mods.IsANDInstalled == True
		RegisterForModEvent("AdvancedNudityDetectionUpdate", "OnANDUpdate")
	EndIf
	
	SLSF_Reloaded_Logger.Log("<Player Script> [Startup] - Player Script Initialized", Logger.CRITICAL)
EndFunction

Event OnPlayerLoadGame()
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
	
	SLSF_Reloaded_Logger.Log("<Player Script> [OnPlayerLoadGame] - Load Game Complete", Logger.CRITICAL)
EndEvent

Event OnANDUpdate()
	If VisibilityManager.UpdateRunning == False && VisibilityManager.CountingBodyTats == False
		VisibilityManager.CountBodyTattoos()
	EndIf
EndEvent

Event OnCombatStateChanged(Actor CombatTarget, Int CombatState)
	If CombatTarget == PlayerRef && CombatState != 0
		SLSF_AllowComment.SetValue(0)
	EndIf
EndEvent

Event OnSexlabAnimationStart(Int threadID, Bool hasPlayer)
	SLSF_Reloaded_Logger.Log("<Player Script> [OnSexlabAnimationStart] - Sexlab Animation started")
	If hasPlayer == True
		SLSF_Reloaded_Logger.Log("<Player Script> [OnSexlabAnimationStart] - Sexlab Animation has player")
		AnimationAnalyzer.SexSceneEnded = False
		AnimationAnalyzer.AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabForeplayEnd(Int threadID, Bool hasPlayer)
	SLSF_Reloaded_Logger.Log("<Player Script> [OnSexlabForeplayEnd] - Foreplay Animation ended")
	If hasPlayer == True
		SLSF_Reloaded_Logger.Log("<Player Script> [OnSexlabForeplayEnd] - Foreplay Animation has player")
		AnimationAnalyzer.SexSceneEnded = False
		AnimationAnalyzer.AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabAnimationEnd(Int threadID, Bool hasPlayer)
	SLSF_Reloaded_Logger.Log("<Player Script> [OnSexlabAnimationEnd] - Sexlab Animation ended")
	If hasPlayer == True
		SLSF_Reloaded_Logger.Log("<Player Script> [OnSexlabAnimationEnd] - Sexlab Animation has player")
		AnimationAnalyzer.SexSceneEnded = True
	EndIf
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	LocationManager.CurrentLocation = akNewLoc
	SLSF_Reloaded_Logger.Log("<Player Script> [OnLocationChange] - Player changed locations! Old Location = " + akOldLoc + " | New Location = " + akNewLoc)
	If Config.DynamicAnonymity == True
		DynamicAnonymityScript.CompareLocations(akOldLoc, akNewLoc)
		DynamicAnonymityScript.GetAnonymity(akNewLoc)
	EndIf
	FameManager.UpdateGlobals()
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	String ObjectName = ""
	
	If akBaseObject != none
		ObjectName = akBaseObject.GetName()
	EndIf
	
	SLSF_Reloaded_Logger.Log("<Player Script> [OnObjectEquipped] - ObjectName is: " + ObjectName)
	
	If (akBaseObject == none || ObjectName == "")
		SLSF_Reloaded_Logger.Log("<Player Script> [OnObjectEquipped] - Object is Null or has blank name. Event terminated.")
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
	
	SLSF_Reloaded_Logger.Log("<Player Script> [OnObjectUnequipped] - Object name is: " + ObjectName)
	
	If (akBaseObject == none || akBaseObject.GetName() == "")
		SLSF_Reloaded_Logger.Log("<Player Script> [OnObjectUnequipped] - Object is Null or has blank name. Event terminated.")
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