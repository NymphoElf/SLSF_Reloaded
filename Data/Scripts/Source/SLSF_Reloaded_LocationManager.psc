ScriptName SLSF_Reloaded_LocationManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_DataManager Property DataManager Auto
SLSF_Reloaded_DynamicAnonymity Property DynamicAnonymityScript Auto

Location Property CurrentLocation Auto Hidden
Location[] Property MajorLocations Auto
Location[] Property MinorLocations Auto
Location[] Property CustomLocationRef Auto

String[] Property DefaultLocation Auto ;Size 21
String[] Property CustomLocation Auto ;Size 21 | "---" by Default

Keyword[] Property ExcludedLocations Auto ;NordicRuin, FalmerHive, HagravenNest, Cave, AnimalDen, DwarvenRuin, ForswornCamp
Keyword[] Property OverrideExcludedLocation Auto ;BanditCamp, VampireLiar, WarlockLair, MilitaryFort, MilitaryCamp

Bool Property CustomLocationsFull Auto Hidden

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Bool Function IsLocationValid(String CheckedLocation)
	If CheckedLocation == "$NoneText"
		return False
	EndIf
	
	Int LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	If CheckedLocation == "Eastmarch"
		CheckedLocation = "Windhelm"
	ElseIf CheckedLocation == "Haafingar"
		CheckedLocation = "Solitude"
	ElseIf CheckedLocation == "Hjaalmarch"
		CheckedLocation = "Morthal"
	ElseIf CheckedLocation == "the Reach"
		CheckedLocation = "Markarth"
	ElseIf CheckedLocation == "the Pale"
		CheckedLocation = "Dawnstar"
	ElseIf CheckedLocation == "the Rift"
		CheckedLocation = "Riften"
	EndIf
	
	;Check Location
	While LocationIndex < DefaultLocation.Length
		If CheckedLocation == DefaultLocation[LocationIndex]
			return True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < CustomLocations
		If CheckedLocation == CustomLocation[LocationIndex]
			return True
		EndIf
		LocationIndex += 1
	EndWhile
	
	return False
EndFunction

Bool Function LocationCanBeRegistered(String LocationToRegister, Bool ExternalRegister = False)
	If ExternalRegister == False
		If CustomLocationsFull == True
			Debug.MessageBox("SLSF Reloaded - Cannot Register Custom Location. Custom Location List is Full.")
			return False
		EndIf
		
		If LocationToRegister != "" && LocationToRegister != "Wilderness" && CurrentLocation != None
			If IsLocationExcluded(CurrentLocation) == True
				Debug.MessageBox("SLSF Reloaded - Location is marked as EXCLUDED. Location not registered.")
				return False
			EndIf
			
			If IsLocationValid(LocationToRegister) == False
				return True
			Else
				Debug.MessageBox("SLSF Reloaded - Location is already registered.")
				return False
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - Cannot register " + LocationToRegister + ". Location is invalid.")
			return False
		EndIf
	Else
		If CustomLocationsFull == True
			Debug.Trace("SLSF Reloaded (External Mod Event) - Cannot Register " + LocationToRegister + ". Custom Location List is Full.")
			return False
		EndIf
		
		If LocationToRegister != "" && LocationToRegister != "Wilderness"
			If IsLocationValid(LocationToRegister) == False
				return True
			Else
				Debug.Trace("SLSF Reloaded (External Mod Event) - Location is already registered.")
				return False
			EndIf
		Else
			Debug.Trace("SLSF Reloaded (External Mod Event) - Cannot register " + LocationToRegister + ". Location is invalid.")
			return False
		EndIf
	EndIf
EndFunction

Function UpdateCustomLocationCount()
	Int LocationIndex = 0
	Int LocationCount = 0
	
	While LocationIndex < CustomLocation.Length
		If CustomLocation[LocationIndex] != "---" && CustomLocation[LocationIndex] != "-EMPTY-"
			LocationCount += 1
		EndIf
		LocationIndex += 1
	EndWhile
	
	SLSF_Reloaded_CustomLocationCount.SetValue(LocationCount)
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() == CustomLocation.Length
		CustomLocationsFull = True
	Else
		CustomLocationsFull = False
	EndIf
EndFunction

String Function FetchLocationName(Location LocationRef)
	If LocationRef == None || LocationRef.GetName() == ""
		return "$NoneText"
	EndIf
	return LocationRef.GetName()
EndFunction

String Function CurrentLocationName()
	If CurrentLocation == None
		return "$NoneText"
	EndIf
	
	String FameLocation = GetFameLocation(CurrentLocation)
	
	If FameLocation != "Null"
		return FameLocation
	EndIf
	
	return CurrentLocation.GetName()
EndFunction

String Function GetLocalizedFameLocation(Location LocationRef)
	If LocationRef == None || IsLocationExcluded(LocationRef) == True
		return "$NoneText"
	EndIf
	
	Int CustomLocationCount = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	Int LocationIndex = 0
	
	;Check Custom Locations First. Minor and Major locations may have a Custom Location as a Child Location as well.
	While LocationIndex < CustomLocationCount
		If CustomLocationRef[LocationIndex].IsChild(LocationRef) || CustomLocationRef[LocationIndex].GetName() == LocationRef.GetName()
			return CustomLocation[LocationIndex]
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	;Check Minor Locations next, because Major Locations have some Minor Locations as a Child Location as well.
	While LocationIndex < MinorLocations.Length
		If MinorLocations[LocationIndex].IsChild(LocationRef) || MinorLocations[LocationIndex].GetName() == LocationRef.GetName()
			return MinorLocations[LocationIndex].GetName()
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < MajorLocations.Length
		If MajorLocations[LocationIndex].IsChild(LocationRef)
			return MajorLocations[LocationIndex].GetName()
		EndIf
		LocationIndex += 1
	EndWhile
	return "$NoneText"
EndFunction

String Function GetFameLocation(Location LocationRef)
	If LocationRef == None || IsLocationExcluded(LocationRef) == True
		return "Null"
	EndIf
	
	Int CustomLocationCount = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	Int LocationIndex = 0
	
	;Check Custom Locations First. Minor and Major locations may have a Custom Location as a Child Location as well.
	While LocationIndex < CustomLocationCount
		If CustomLocationRef[LocationIndex].IsChild(LocationRef) || CustomLocationRef[LocationIndex].GetName() == LocationRef.GetName()
			return CustomLocation[LocationIndex]
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	;Check Minor Locations next, because Major Locations have some Minor Locations as a Child Location as well.
	While LocationIndex < MinorLocations.Length
		If MinorLocations[LocationIndex].IsChild(LocationRef) || MinorLocations[LocationIndex].GetName() == LocationRef.GetName()
			return DefaultLocation[LocationIndex + 10]
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < MajorLocations.Length
		If MajorLocations[LocationIndex].IsChild(LocationRef)
			return DefaultLocation[LocationIndex]
		EndIf
		LocationIndex += 1
	EndWhile
	return "Null"
EndFunction

;Filter Dungeons by Keywords - Dungeons should not be valid Fame locations
Bool Function IsLocationExcluded(Location LocationRef)
	Int ExcludedKeywordIndex = 0
	Int OverrideKeywordIndex = 0
	Bool ValidExclusion = False
	Bool ExclusionOverridden = False
	
	While ExcludedKeywordIndex < ExcludedLocations.Length && ValidExclusion == False && ExclusionOverridden == False
		If LocationRef.HasKeyword(ExcludedLocations[ExcludedKeywordIndex])
			While OverrideKeywordIndex < OverrideExcludedLocation.Length && ExclusionOverridden == False
				If LocationRef.HasKeyword(OverrideExcludedLocation[OverrideKeywordIndex])
					ValidExclusion = False
					ExclusionOverridden = True
				Else
					ValidExclusion = True
				EndIf
				OverrideKeywordIndex += 1
			EndWhile
		EndIf
		ExcludedKeywordIndex += 1
	EndWhile
	
	return ValidExclusion
EndFunction

Function RegisterCustomLocation()
	String LocationToRegister = FetchLocationName(CurrentLocation)
	
	Debug.Notification("$CustomLocationRegisterStartMSG")
	
	If LocationToRegister == "$NoneText"
		Debug.MessageBox("SLSF Reloaded - Cannot register " + LocationToRegister + ". Location is invalid.")
		return
	EndIf
	
	If LocationCanBeRegistered(LocationToRegister, False) == False
		return
	EndIf
	
	Int EmptyIndex = CustomLocation.Find("---")
	
	If EmptyIndex >= 0 && EmptyIndex < CustomLocation.Length
		CustomLocation[EmptyIndex] = LocationToRegister
		CustomLocationRef[EmptyIndex] = CurrentLocation
	Else
		EmptyIndex = CustomLocation.Find("-EMPTY-")
		If EmptyIndex >= 0 && EmptyIndex < CustomLocation.Length
			CustomLocation[EmptyIndex] = LocationToRegister
			CustomLocationRef[EmptyIndex] = CurrentLocation
		Else
			Debug.MessageBox("SLSF Reloaded ERROR - Empty Location Index not found despite other checks allowing registration. Location Registration Failed.")
			return
		EndIf
	EndIf
	
	Debug.Notification("$CustomLocationRegisterCompleteMSG")
	
	UpdateCustomLocationCount()
EndFunction

Function UnregisterCustomLocation(Int LocationIndexToUnregister)
	String UnregisteredLocation = CustomLocation[LocationIndexToUnregister]
	
	Debug.Notification("$CustomLocationUnregisterStartMSG")
	
	If UnregisteredLocation == "---" || UnregisteredLocation == "-EMPTY-"
		Debug.Notification("$CustomLocationUnregisterInvalidMSG")
		return
	EndIf
	
	FameManager.ClearFame(CustomLocation[LocationIndexToUnregister])
	
	CustomLocation[LocationIndexToUnregister] = "---"
	CustomLocationRef[LocationIndexToUnregister] = None
	
	;Compact Custom Location Indexes - Required to keep other functions functional
	Int LocationIndex = 0
	Int IndexLimit = (CustomLocation.Length) - 1 ;Stop 1 index below length because we'd check beyond the Array length otherwise
	Int FameIndex = 0
	
	While LocationIndex < IndexLimit 
		If CustomLocation[LocationIndex] == "---" && CustomLocation[LocationIndex + 1] != "---"
			CustomLocation[LocationIndex] = CustomLocation[LocationIndex + 1]
			CustomLocationRef[LocationIndex] = CustomLocationRef[LocationIndex + 1]
			
			CustomLocation[LocationIndex + 1] = "---"
			CustomLocationRef[LocationIndex + 1] = None
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	;Shift Fame Data and Anonymity Data, then set last index to 0
	While LocationIndex < 21
		While FameIndex < FameManager.FameType.Length
			If LocationIndex == 0
				DataManager.CustomLocation1Fame[FameIndex] = DataManager.CustomLocation2Fame[FameIndex]
			ElseIf LocationIndex == 1
				DataManager.CustomLocation2Fame[FameIndex] = DataManager.CustomLocation3Fame[FameIndex]
			ElseIf LocationIndex == 2
				DataManager.CustomLocation3Fame[FameIndex] = DataManager.CustomLocation4Fame[FameIndex]
			ElseIf LocationIndex == 3
				DataManager.CustomLocation4Fame[FameIndex] = DataManager.CustomLocation5Fame[FameIndex]
			ElseIf LocationIndex == 4
				DataManager.CustomLocation5Fame[FameIndex] = DataManager.CustomLocation6Fame[FameIndex]
			ElseIf LocationIndex == 5
				DataManager.CustomLocation6Fame[FameIndex] = DataManager.CustomLocation7Fame[FameIndex]
			ElseIf LocationIndex == 6
				DataManager.CustomLocation7Fame[FameIndex] = DataManager.CustomLocation8Fame[FameIndex]
			ElseIf LocationIndex == 7
				DataManager.CustomLocation8Fame[FameIndex] = DataManager.CustomLocation9Fame[FameIndex]
			ElseIf LocationIndex == 8
				DataManager.CustomLocation9Fame[FameIndex] = DataManager.CustomLocation10Fame[FameIndex]
			ElseIf LocationIndex == 9
				DataManager.CustomLocation10Fame[FameIndex] = DataManager.CustomLocation11Fame[FameIndex]
			ElseIf LocationIndex == 10
				DataManager.CustomLocation11Fame[FameIndex] = DataManager.CustomLocation12Fame[FameIndex]
			ElseIf LocationIndex == 11
				DataManager.CustomLocation12Fame[FameIndex] = DataManager.CustomLocation13Fame[FameIndex]
			ElseIf LocationIndex == 12
				DataManager.CustomLocation13Fame[FameIndex] = DataManager.CustomLocation14Fame[FameIndex]
			ElseIf LocationIndex == 13
				DataManager.CustomLocation14Fame[FameIndex] = DataManager.CustomLocation15Fame[FameIndex]
			ElseIf LocationIndex == 14
				DataManager.CustomLocation15Fame[FameIndex] = DataManager.CustomLocation16Fame[FameIndex]
			ElseIf LocationIndex == 15
				DataManager.CustomLocation16Fame[FameIndex] = DataManager.CustomLocation17Fame[FameIndex]
			ElseIf LocationIndex == 16
				DataManager.CustomLocation17Fame[FameIndex] = DataManager.CustomLocation18Fame[FameIndex]
			ElseIf LocationIndex == 17
				DataManager.CustomLocation18Fame[FameIndex] = DataManager.CustomLocation19Fame[FameIndex]
			ElseIf LocationIndex == 18
				DataManager.CustomLocation19Fame[FameIndex] = DataManager.CustomLocation20Fame[FameIndex]
			ElseIf LocationIndex == 19
				DataManager.CustomLocation20Fame[FameIndex] = DataManager.CustomLocation21Fame[FameIndex]
			ElseIf LocationIndex == 20
				DataManager.CustomLocation21Fame[FameIndex] = 0
			EndIf
			FameIndex += 1
		EndWhile
		
		If LocationIndex < 20
			DynamicAnonymityScript.CustomLocationLastEnterTime[LocationIndex] = DynamicAnonymityScript.CustomLocationLastEnterTime[LocationIndex + 1]
			DynamicAnonymityScript.CustomLocationLastExitTime[LocationIndex] = DynamicAnonymityScript.CustomLocationLastExitTime[LocationIndex + 1]
			DynamicAnonymityScript.CustomLocationVisitTime[LocationIndex] = DynamicAnonymityScript.CustomLocationVisitTime[LocationIndex + 1]
			DynamicAnonymityScript.CustomLocationRecognitionTime[LocationIndex] = DynamicAnonymityScript.CustomLocationRecognitionTime[LocationIndex + 1]
			DynamicAnonymityScript.CustomLocationLocalAnonymityFlag[LocationIndex] = DynamicAnonymityScript.CustomLocationLocalAnonymityFlag[LocationIndex + 1]
			DataManager.CustomLocationDynamicAnonymityFlag[LocationIndex] = DataManager.CustomLocationDynamicAnonymityFlag[LocationIndex + 1]
		Else
			DynamicAnonymityScript.CustomLocationLastEnterTime[LocationIndex] = 0
			DynamicAnonymityScript.CustomLocationLastExitTime[LocationIndex] = 0
			DynamicAnonymityScript.CustomLocationVisitTime[LocationIndex] = 0
			DynamicAnonymityScript.CustomLocationRecognitionTime[LocationIndex] = 7
			DynamicAnonymityScript.CustomLocationLocalAnonymityFlag[LocationIndex] = True
			DataManager.CustomLocationDynamicAnonymityFlag[LocationIndex] = True
		EndIf
		
		LocationIndex += 1
	EndWhile
	
	UpdateCustomLocationCount()
	
	Debug.Notification("$CustomLocationUnregisterCompleteMSG")
EndFunction

Function RegisterCustomLocationExternal(String LocationToRegister, Location LocationRefToRegister)
	Debug.Notification("$CustomLocationRegisterStartMSG")
	Int LocationIndex = 0
	Bool EmptyIndexFound = False
	
	If CustomLocationsFull == True
		Debug.Trace("SLSF Reloaded (External Mod Event) - Cannot Register Custom Location. Custom Location List is Full.")
		return
	EndIf
	
	Int EmptyIndex = CustomLocation.Find("---")
	
	If EmptyIndex >= 0 && EmptyIndex < CustomLocation.Length
		CustomLocation[EmptyIndex] = LocationToRegister
		CustomLocationRef[EmptyIndex] = LocationRefToRegister
	Else
		Debug.Trace("SLSF Reloaded (External Mod Event) ERROR - Empty Location Index not found despite other checks allowing registration. Location Registration Failed.")
		return
	EndIf
	
	Debug.Notification("$CustomLocationRegisterCompleteMSG")
	
	UpdateCustomLocationCount()
EndFunction

Function UnregisterCustomLocationExternal(String LocationToUnregister)
	Debug.Notification("$CustomLocationUnregisterStartMSG")
	Bool LocationFound = False
	Int LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	While LocationIndex < CustomLocations && LocationFound == False
		If LocationToUnregister == CustomLocation[LocationIndex]
			LocationFound = True
			UnregisterCustomLocation(LocationIndex)
		EndIf
		LocationIndex += 1
	EndWhile
	
	If LocationFound == False
		Debug.Trace("SLSF Reloaded - UnregisterCustomLocationExternal - Could not find " + LocationToUnregister + " to Unregister.")
	Else
		Debug.Notification("$CustomLocationUnregisterCompleteMSG")
	EndIf
	
	UpdateCustomLocationCount()
EndFunction