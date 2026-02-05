ScriptName SLSF_Reloaded_LocationManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_DataManager Property DataManager Auto
SLSF_Reloaded_DynamicAnonymity Property DynamicAnonymityScript Auto
SLSF_Reloaded_Logger Property Logger Auto

Location Property CurrentLocation Auto Hidden
Location[] Property MajorLocations Auto
Location[] Property MinorLocations Auto
Location[] Property CustomLocationRef Auto

Location Property SolstheimLocation Auto

String[] Property DefaultLocation Auto ;Size 21
String[] Property CustomLocation Auto ;Size 21 | "---" by Default

String[] Property WhiterunLocationList Auto
String[] Property WinterholdLocationList Auto
String[] Property EastmarchLocationList Auto
String[] Property RiftLocationList Auto
String[] Property ReachLocationList Auto
String[] Property FalkreathLocationList Auto
String[] Property PaleLocationList Auto
String[] Property HaafingarLocationList Auto
String[] Property HjaalmarchLocationList Auto
String[] Property SolstheimLocationList Auto
String[] Property UndefinedLocationList Auto

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
			SLSF_Reloaded_Logger.Log("SLSF Reloaded (External Mod Event) - Cannot Register " + LocationToRegister + ". Custom Location List is Full.", Logger.CRITICAL)
			return False
		EndIf
		
		If LocationToRegister != "" && LocationToRegister != "Wilderness"
			If IsLocationValid(LocationToRegister) == False
				return True
			Else
				SLSF_Reloaded_Logger.Log("SLSF Reloaded (External Mod Event) - Location is already registered.", Logger.CRITICAL)
				return False
			EndIf
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded (External Mod Event) - Cannot register " + LocationToRegister + ". Location is invalid.", Logger.CRITICAL)
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
	Int KeywordIndex = 0
	Bool PotentialExclusion = False
	Bool ValidExclusion = False
	Bool ExclusionOverridden = False
	
	While KeywordIndex < ExcludedLocations.Length && PotentialExclusion == False
		If LocationRef.HasKeyword(ExcludedLocations[KeywordIndex])
			PotentialExclusion = True
		EndIf
		KeywordIndex += 1
	EndWhile
	
	KeywordIndex = 0
	If PotentialExclusion == True
		While KeywordIndex < OverrideExcludedLocation.Length && ExclusionOverridden == False
			If LocationRef.HasKeyword(OverrideExcludedLocation[KeywordIndex])
				ExclusionOverridden = True
			EndIf
			KeywordIndex += 1
		EndWhile
	EndIf
	
	If PotentialExclusion == True && ExclusionOverridden == False
		ValidExclusion = True
	EndIf
	
	return ValidExclusion
EndFunction

Function RegisterCustomLocation()
	Location LocationRef = CurrentLocation
	String LocationToRegister = FetchLocationName(LocationRef)
	
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
		CustomLocationRef[EmptyIndex] = LocationRef
	Else
		EmptyIndex = CustomLocation.Find("-EMPTY-")
		If EmptyIndex >= 0 && EmptyIndex < CustomLocation.Length
			CustomLocation[EmptyIndex] = LocationToRegister
			CustomLocationRef[EmptyIndex] = LocationRef
		Else
			Debug.MessageBox("SLSF Reloaded ERROR - Empty Location Index not found despite other checks allowing registration. Location Registration Failed.")
			return
		EndIf
	EndIf
	
	AddToLocationList(LocationRef)
	
	Debug.Notification("$CustomLocationRegisterCompleteMSG")
	
	UpdateCustomLocationCount()
EndFunction

Function AddToLocationList(Location LocationRef)
	String LocationName = FetchLocationName(LocationRef)
	Int ListIndex = 0
	
	If MajorLocations[0].IsChild(LocationRef) == True
		ListIndex = WhiterunLocationList.Find("---")
		If ListIndex >= 0
			WhiterunLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Whiterun Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Whiterun Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[1].IsChild(LocationRef)
		ListIndex = WinterholdLocationList.Find("---")
		If ListIndex >= 0
			WinterholdLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Winterhold Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Winterhold Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[2].IsChild(LocationRef)
		ListIndex = EastmarchLocationList.Find("---")
		If ListIndex >= 0
			EastmarchLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Eastmarch Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Eastmarch Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[3].IsChild(LocationRef)
		ListIndex = HaafingarLocationList.Find("---")
		If ListIndex >= 0
			HaafingarLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Haafingar Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Haafingar Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[4].IsChild(LocationRef)
		ListIndex = RiftLocationList.Find("---")
		If ListIndex >= 0
			RiftLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Rift Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Rift Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[5].IsChild(LocationRef)
		ListIndex = ReachLocationList.Find("---")
		If ListIndex >= 0
			ReachLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Reach Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Reach Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[6].IsChild(LocationRef)
		ListIndex = HjaalmarchLocationList.Find("---")
		If ListIndex >= 0
			HjaalmarchLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Hjaalmarch Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Hjaalmarch Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[7].IsChild(LocationRef)
		ListIndex = PaleLocationList.Find("---")
		If ListIndex >= 0
			PaleLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Pale Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Pale Location List is FULL. This should not be possible!")
		EndIf
	ElseIf MajorLocations[8].IsChild(LocationRef)
		ListIndex = FalkreathLocationList.Find("---")
		If ListIndex >= 0
			FalkreathLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Falkreath Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Falkreath Location List is FULL. This should not be possible!")
		EndIf
	ElseIf SolstheimLocation.IsChild(LocationRef)
		ListIndex = SolstheimLocationList.Find("---")
		If ListIndex >= 0
			SolstheimLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Solstheim Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Solstheim Location List is FULL. This should not be possible!")
		EndIf
	Else
		ListIndex = UndefinedLocationList.Find("---")
		If ListIndex >= 0
			UndefinedLocationList[ListIndex] = LocationName
		Else
			SLSF_Reloaded_Logger.Log("SLSF Reloaded CRITICAL ERROR: Undefined Location List is FULL. This should not be possible!", Logger.CRITICAL)
			Debug.MessageBox("SLSF Reloaded CRITICAL ERROR: Undefined Location List is FULL. This should not be possible!")
		EndIf
	EndIf
EndFunction

Function RemoveFromLocationList(String FameLocation)
	Int ListIndex = 0
	String EmptyString = "---"
	
	ListIndex = WhiterunLocationList.Find(FameLocation)
	If ListIndex >= 0
		WhiterunLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = WinterholdLocationList.Find(FameLocation)
	If ListIndex >= 0
		WinterholdLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = EastmarchLocationList.Find(FameLocation)
	If ListIndex >= 0
		EastmarchLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = HaafingarLocationList.Find(FameLocation)
	If ListIndex >= 0
		HaafingarLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = HjaalmarchLocationList.Find(FameLocation)
	If ListIndex >= 0
		HjaalmarchLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = PaleLocationList.Find(FameLocation)
	If ListIndex >= 0
		PaleLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = RiftLocationList.Find(FameLocation)
	If ListIndex >= 0
		RiftLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = ReachLocationList.Find(FameLocation)
	If ListIndex >= 0
		ReachLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = FalkreathLocationList.Find(FameLocation)
	If ListIndex >= 0
		FalkreathLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	ListIndex = UndefinedLocationList.Find(FameLocation)
	If ListIndex >= 0
		UndefinedLocationList[ListIndex] = EmptyString
		return
	EndIf
	
	Debug.MessageBox("SLSF Reloaded ERROR: Location " + FameLocation + " could not be found in any Location Lists.")
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
	
	RemoveFromLocationList(UnregisteredLocation)
	
	UpdateCustomLocationCount()
	
	Debug.Notification("$CustomLocationUnregisterCompleteMSG")
EndFunction

Function RegisterCustomLocationExternal(String LocationToRegister, Location LocationRefToRegister)
	Debug.Notification("$CustomLocationRegisterStartMSG")
	Int LocationIndex = 0
	Bool EmptyIndexFound = False
	
	If CustomLocationsFull == True
		SLSF_Reloaded_Logger.Log("<Location Manager> [RegisterCustomLocationExternal] - Cannot Register Custom Location. Custom Location List is Full.", Logger.CRITICAL)
		return
	EndIf
	
	If IsLocationExcluded(LocationRefToRegister) == True
		SLSF_Reloaded_Logger.Log("<Location Manager> [RegisterCustomLocationExternal] - Cannot Register Custom Location. Custom Location is EXCLUDED.", Logger.CRITICAL)
		return
	EndIf
	
	Int EmptyIndex = CustomLocation.Find("---")
	
	If EmptyIndex >= 0 && EmptyIndex < CustomLocation.Length
		CustomLocation[EmptyIndex] = LocationToRegister
		CustomLocationRef[EmptyIndex] = LocationRefToRegister
	Else
		SLSF_Reloaded_Logger.Log("<Location Manager> [RegisterCustomLocationExternal] ERROR - Empty Location Index not found despite other checks allowing registration. Location Registration Failed.", Logger.CRITICAL)
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
		SLSF_Reloaded_Logger.Log("<Location Manager> [UnregisterCustomLocationExternal] - UnregisterCustomLocationExternal - Could not find " + LocationToUnregister + " to Unregister.")
	Else
		Debug.Notification("$CustomLocationUnregisterCompleteMSG")
	EndIf
	
	UpdateCustomLocationCount()
EndFunction