ScriptName SLSF_Reloaded_LocationManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto

Location Property CurrentLocation Auto Hidden
Location[] Property MajorLocations Auto
Location[] Property MinorLocations Auto
Location[] Property CustomLocationRef Auto
String[] Property DefaultLocation Auto ;Size 21
String[] Property CustomLocation Auto ;Size 21 | "-EMPTY-" by Default

Bool Property CustomLocationsFull Auto Hidden

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Bool Function IsLocationValid(String CheckedLocation)
	If CheckedLocation == "-NONE-"
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
			Debug.MessageBox("SLSF Reloaded - Cannot Register Custom Location: " + LocationToRegister + ". Custom Location List is Full.")
			return False
		EndIf
		
		If LocationToRegister != "" && LocationToRegister != "Wilderness" && CurrentLocation != None
			If IsLocationValid(LocationToRegister) == False
				return True
			Else
				Debug.MessageBox("SLSF Reloaded - Location is already registered.")
				return False
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - Cannot register Custom Location. Location is invalid.")
			return False
		EndIf
	Else
		If CustomLocationsFull == True
			Debug.MessageBox("SLSF Reloaded (External Mod Event) - Cannot Register Custom Location: " + LocationToRegister + ". Custom Location List is Full.")
			return False
		EndIf
		
		If LocationToRegister != "" && LocationToRegister != "Wilderness"
			If IsLocationValid(LocationToRegister) == False
				return True
			Else
				Debug.MessageBox("SLSF Reloaded (External Mod Event) - Location is already registered.")
				return False
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded (External Mod Event) - Cannot register Custom Location. Location is invalid.")
			return False
		EndIf
	EndIf
EndFunction

Function UpdateCustomLocationCount()
	Int LocationIndex = 0
	Int LocationCount = 0
	
	While LocationIndex < CustomLocation.Length
		If CustomLocation[LocationIndex] != "-EMPTY-"
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
	If LocationRef == None
		return "-NONE-"
	EndIf
	return LocationRef.GetName()
EndFunction

String Function CurrentLocationName()
	If CurrentLocation == None
		return "-NONE-"
	EndIf
	
	String LocationParent = CurrentLocationParent(CurrentLocation)
	
	If LocationParent != "Null"
		return LocationParent
	EndIf
	
	return CurrentLocation.GetName()
EndFunction

String Function CurrentLocationParent(Location LocationRef)
	Int CustomLocationCount = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	Int LocationIndex = 0
	
	;Check Custom Locations First. Minor and Major locations may have a Custom Location as a Child Location as well.
	While LocationIndex < CustomLocationCount
		If CustomLocationRef[LocationIndex].IsChild(LocationRef)
			return CustomLocation[LocationIndex]
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	;Check Minor Locations next, because Major Locations have some Minor Locations as a Child Location as well.
	While LocationIndex < MinorLocations.Length
		If MinorLocations[LocationIndex].IsChild(LocationRef)
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
	return "Null"
EndFunction

Function RegisterCustomLocation()
	String LocationToRegister = FetchLocationName(CurrentLocation)
	
	Debug.Notification("Attempting to register " + LocationToRegister + ". Please wait...")
	
	If LocationToRegister == "-NONE-"
		Debug.MessageBox("SLSF Reloaded - Cannot Register Custom Location. Location invalid.")
		return
	EndIf
	
	If LocationCanBeRegistered(LocationToRegister, False) == False
		return
	EndIf
	
	Int EmptyIndex = CustomLocation.Find("-EMPTY-")
	
	If EmptyIndex >= 0 && EmptyIndex < CustomLocation.Length
		CustomLocation[EmptyIndex] = LocationToRegister
		CustomLocationRef[EmptyIndex] = CurrentLocation
	Else
		Debug.MessageBox("SLSF Reloaded ERROR: Empty Location Index not found despite other checks allowing registration. Location Registration Failed.")
		return
	EndIf
	
	Debug.Notification("Location " + LocationToRegister + " registered!")
	
	UpdateCustomLocationCount()
EndFunction

Function UnregisterCustomLocation(Int LocationIndexToUnregister)
	String UnregisteredLocation = CustomLocation[LocationIndexToUnregister]
	
	Debug.Notification("Unregistering " + UnregisteredLocation + ". Please wait...")
	
	FameManager.ClearFame(CustomLocation[LocationIndexToUnregister])
	
	CustomLocation[LocationIndexToUnregister] = "-EMPTY-"
	CustomLocationRef[LocationIndexToUnregister] = None
	
	;Compact Custom Location Indexes - Required to keep other functions functional
	Int LocationIndex = 0
	Int IndexLimit = (CustomLocation.Length) - 1 ;Stop 1 index below length because we'd check beyond the Array length otherwise
	
	While LocationIndex < IndexLimit 
		If CustomLocation[LocationIndex] == "-EMPTY-" && CustomLocation[LocationIndex + 1] != "-EMPTY-"
			CustomLocation[LocationIndex] = CustomLocation[LocationIndex + 1]
			CustomLocationRef[LocationIndex] = CustomLocationRef[LocationIndex + 1]
			
			CustomLocation[LocationIndex + 1] = "-EMPTY-"
			CustomLocationRef[LocationIndex + 1] = None
		EndIf
		LocationIndex += 1
	EndWhile
	
	UpdateCustomLocationCount()
	
	Debug.Notification("Location " + UnregisteredLocation + " Unregistered.")
EndFunction

Function RegisterCustomLocationExternal(String LocationToRegister, Location LocationRefToRegister)
	Debug.Notification("Attempting to register " + LocationToRegister + ". Please wait...")
	Int LocationIndex = 0
	Bool EmptyIndexFound = False
	
	If CustomLocationsFull == True
		Debug.MessageBox("SLSF Reloaded (External Mod Event) - Cannot Register Custom Location. Custom Location List is Full.")
		return
	EndIf
	
	Int EmptyIndex = CustomLocation.Find("-EMPTY-")
	
	If EmptyIndex >= 0 && EmptyIndex < CustomLocation.Length
		CustomLocation[EmptyIndex] = LocationToRegister
		CustomLocationRef[EmptyIndex] = LocationRefToRegister
	Else
		Debug.MessageBox("SLSF Reloaded (External Mod Event) ERROR: Empty Location Index not found despite other checks allowing registration. Location Registration Failed.")
		return
	EndIf
	
	Debug.Notification("Location " + LocationToRegister + " registered!")
	
	UpdateCustomLocationCount()
EndFunction

Function UnregisterCustomLocationExternal(String LocationToUnregister)
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
		Debug.MessageBox("SLSF Reloaded - UnregisterCustomLocationExternal - Could not find " + LocationToUnregister + " to Unregister.")
	Else
		Debug.Notification("Location " + LocationToUnregister + " Unregistered.")
	EndIf
	
	UpdateCustomLocationCount()
EndFunction