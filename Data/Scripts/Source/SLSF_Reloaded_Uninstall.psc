ScriptName SLSF_Reloaded_Uninstall extends Quest

SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_CommentManager Property CommentManager Auto

Quest Property MainQuest Auto
Quest Property ManagerQuest Auto
Quest Property ConfigQuest Auto

Function RunUninstall()
	Debug.Notification("$UninstallMSG")
	
	PlayerScript.UnregisterForUpdate()
	PlayerScript.UnregisterForMenu("Sleep/Wait Menu")
	
	Mods.FHU = None
	Mods.PW_Tracker = None
	Mods.LegacyConfig = None
	
	CommentManager.UnregisterForUpdate()
	
	MainQuest.Stop()
	ManagerQuest.Stop()
	ConfigQuest.Stop()
	
	Utility.Wait(15.0)
	
	Debug.Messagebox("$UninstallCompleteMSG")
EndFunction