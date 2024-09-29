Scriptname PW_ComponentManagerPlayerScript extends ReferenceAlias


Event OnPlayerLoadGame()
	PW_Utility.pwDebug(none, 2, "playerscript: game loaded")
	(GetOwningQuest() as PW_ComponentManagerScript).MarkForMaintenance()
endEvent
