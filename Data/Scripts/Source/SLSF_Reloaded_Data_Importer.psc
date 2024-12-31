ScriptName SLSF_Reloaded_Data_Importer extends Quest

Import JsonUtil

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_DataManager Property DataManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_LegacyOverwrite Property LegacyOverwrite Auto
SLSF_Reloaded_Data_Exporter Property DataExporter Auto

GlobalVariable Property CustomLocations Auto

Function RunImport(String FileName)
	Debug.Notification("$DataImportMSG")
	Bool ImportSucceeded = False
	
	If JsonExists("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data")
		ImportData(FileName)
		ImportSucceeded = True
	Else
		Debug.MessageBox("$DataImportFileMissingERRORMSG")
		return
	EndIf
	
	DataManager.FameOverviewCheck()
	
	If ImportSucceeded == True && Config.AllowLegacyOverwrite == True
		LegacyOverwrite.OverwriteLegacyFame()
	EndIf
	
	Debug.Notification("$DataImportCompleteMSG")
EndFunction

Function ImportData(String FileName)
	
	Int LocationsToImport = GetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "LocationTotal")
	Int LocationIndex = 0
	
	Int ModsToImport = GetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "ModTotal")
	Int ModIndex = 0
	Bool ModFlagsCanBeImported = False
	
	Int FameIndex = 0
	Int DefaultLocationIndex = 0
	Int CustomLocationIndex = 0
	Int ImportedFameValue = 0
	
	;IMPORT LOCATION DATA
	While LocationIndex < LocationsToImport
		String LocationString = GetStringValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "Location_String_" + LocationIndex)
		Location LocationReference = GetFormValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "Location_Form_" + LocationIndex) as Location
		
		If LocationManager.CustomLocation.Find(LocationString) >= 0
			Debug.Trace("Location " + LocationString + " is already registered. Skipping registration.")
		ElseIf LocationManager.CustomLocationRef.Find(LocationReference) >= 0
			Debug.Trace("Location Reference for " + LocationString + " is already registered.  Skipping registration.")
		Else
			LocationManager.RegisterCustomLocationExternal(LocationString, LocationReference)
			
			Utility.WaitMenuMode(3.0)
		EndIf
		
		LocationIndex += 1
	EndWhile
	
	;IMPORT MOD & FLAG DATA
	While ModIndex < ModsToImport
		String ModString = GetStringValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", "ModIndex[" + ModIndex + "]")
		
		If DataManager.IsModRegistered(ModString)
			Debug.Trace("Mod " + ModString + " is already registered. Skipping registration.")
		Else
			If Game.GetModByName(ModString) != 255
				DataManager.RegisterExternalMod(ModString)
				ModFlagsCanBeImported = True
			Else
				Debug.Trace("Mod " + ModString + " does not exist or is not loaded! " + ModString + " not Imported!")
			EndIf
		EndIf
		
		If ModFlagsCanBeImported == True
			Int FlagIndex = 0
	
			While FlagIndex < 26
				String FlagString = DataExporter.ModFlags[FlagIndex]
				
				;Retrieve our INT value stored by the exporter and convert it back into a BOOL in order to store it in the Data Manger script properly
				Bool FlagState = GetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", ModString + "." + FlagString) as Bool
				
				DataManager.SetExternalFlags(ModString, FlagString, FlagState)
				
				FlagIndex += 1
			EndWhile
		EndIf
		
		ModFlagsCanBeImported = False
		ModIndex += 1
	EndWhile
	
	;IMPORT FAME DATA
	While FameIndex < FameManager.FameType.Length
		While DefaultLocationIndex < LocationManager.DefaultLocation.Length
			ImportedFameValue = GetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", LocationManager.DefaultLocation[DefaultLocationIndex] + "." + FameManager.FameType[FameIndex])
			
			DataManager.SetFameValue(LocationManager.DefaultLocation[DefaultLocationIndex], FameManager.FameType[FameIndex], ImportedFameValue)
			
			DefaultLocationIndex += 1
		EndWhile
		
		While CustomLocationIndex < (CustomLocations.GetValue() as Int)
			ImportedFameValue = GetIntValue("SLSF_Reloaded/" + FileName + " SLSF Reloaded Data", LocationManager.CustomLocation[CustomLocationIndex] + "." + FameManager.FameType[FameIndex])
			
			DataManager.SetFameValue(LocationManager.CustomLocation[CustomLocationIndex], FameManager.FameType[FameIndex], ImportedFameValue)
			
			CustomLocationIndex += 1
		EndWhile
		
		DefaultLocationIndex = 0
		CustomLocationIndex = 0
		FameIndex += 1
	EndWhile
EndFunction