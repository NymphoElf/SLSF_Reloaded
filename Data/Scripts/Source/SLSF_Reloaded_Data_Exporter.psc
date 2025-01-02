ScriptName SLSF_Reloaded_Data_Exporter extends Quest

Import JsonUtil

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_DataManager Property DataManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_MCM Property Config Auto

GlobalVariable Property CustomLocations Auto

String[] Property ModFlags Auto

Int RegisteredModCount = 0

Function RunExport(String FileName)
	Debug.Notification("$DataExportMSG")
	
	;Wipe Previous Export Data before storing new data to prevent bad data from old exports causing problems with Import
	If JsonExists("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data")
		ClearAll("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data")
	EndIf
	
	;Start Exporting new data
	RegisteredModCount = DataManager.CountExternalMods()
	
	ExportData(FileName)
	
	Debug.Notification("$DataExportCompleteMSG")
EndFunction

Function ExportData(String FileName)
	Int FameIndex = 0
	Int DefaultLocationIndex = 0
	Int CustomLocationIndex = 0
	Int ExportedFameValue = 0
	
	Int RegisteredModIndex = 0
	
	Int FlagIndex = 0
	Int ModIndex = 0
	Int FlagValue = 0 ;Cannot store BOOL in JsonUtil functions, so we must convert to INT (1 = TRUE, 0 = FALSE)
	
	Int LocationIndex = 0
	
	;EXPORT FAME DATA
	While FameIndex < FameManager.FameType.Length
		While DefaultLocationIndex < LocationManager.DefaultLocation.Length
			ExportedFameValue = DataManager.GetFameValue(LocationManager.DefaultLocation[DefaultLocationIndex], FameManager.FameType[FameIndex])
			
			SetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", LocationManager.DefaultLocation[DefaultLocationIndex] + "." + FameManager.FameType[FameIndex], ExportedFameValue)
			
			DefaultLocationIndex += 1
		EndWhile
		
		While CustomLocationIndex < (CustomLocations.GetValue() as Int)
			ExportedFameValue = DataManager.GetFameValue(LocationManager.CustomLocation[CustomLocationIndex], FameManager.FameType[FameIndex])
			
			SetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", LocationManager.CustomLocation[CustomLocationIndex] + "." + FameManager.FameType[FameIndex], ExportedFameValue)
			
			CustomLocationIndex += 1
		EndWhile
		
		DefaultLocationIndex = 0
		CustomLocationIndex = 0
		FameIndex += 1
	EndWhile
	
	;EXPORT FAME SPREAD CHANCES
	While DefaultLocationIndex < LocationManager.DefaultLocation.Length
		SetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", LocationManager.DefaultLocation[DefaultLocationIndex] + ".famespreadchance", Config.DefaultLocationSpreadChance[DefaultLocationIndex])
		DefaultLocationIndex += 1
	EndWhile
	
	While CustomLocationIndex < (CustomLocations.GetValue() as Int)
		SetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", LocationManager.CustomLocation[CustomLocationIndex] + ".famespreadchance", Config.CustomLocationSpreadChance[CustomLocationIndex])
		CustomLocationIndex += 1
	EndWhile
	
	;EXPORT MOD DATA
	While RegisteredModIndex < RegisteredModCount
		SetStringValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "ModIndex[" + RegisteredModIndex + "]", DataManager.ExternalMods[RegisteredModIndex])
		
		RegisteredModIndex += 1
	EndWhile
	
	SetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "ModTotal", RegisteredModCount)
	
	;EXPORT FLAG DATA
	While ModIndex < RegisteredModCount
		While FlagIndex < ModFlags.Length
			FlagValue = DataManager.GetModFlagState(DataManager.ExternalMods[ModIndex], ModFlags[FlagIndex]) as Int
			
			SetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", DataManager.ExternalMods[ModIndex] + "." + ModFlags[FlagIndex], FlagValue)
			
			FlagIndex += 1
		EndWhile
		
		FlagIndex = 0
		ModIndex += 1
	EndWhile
	
	;EXPORT LOCATION DATA
	While LocationIndex < (CustomLocations.GetValue() as Int)
		SetStringValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "Location_String_" + LocationIndex, LocationManager.CustomLocation[LocationIndex])
		SetFormValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "Location_Form_" + LocationIndex, LocationManager.CustomLocationRef[LocationIndex] as Form)
		
		LocationIndex += 1
	EndWhile
	
	SetIntValue("SLSF_Reloaded/LocationData", "LocationTotal", CustomLocations.GetValue() as Int)
	
	Save("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data")
EndFunction