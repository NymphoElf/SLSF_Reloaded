ScriptName SLSF_Reloaded_LocationManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto

Location Property CurrentLocation Auto
String[] Property DefaultLocation Auto ;Size 21
String[] Property CustomLocation Auto ;Size 20 | "-EMPTY-" by Default

Bool Property CustomLocationsFull Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

;/
Locations:

--Holds--
Whiterun
Winterhold
Windhelm
Solitude
Riften
Markarth
Morthal
Dawnstar
Falkreath
Raven Rock

--Minor Locations--
Riverwood
Rorikstead
Ivarstead
Shor's Stone
Dragon Bridge
Karthwasten
Skaal Village

--Orc Encampments--
Largashbur
Dushnikh Yal
Mor Khazgur
Narzulbur
/;

Bool Function IsLocationValid(String CheckedLocation)
	Int LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
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
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() == 20
		CustomLocationsFull = True
	Else
		CustomLocationsFull = False
	EndIf
EndFunction

String Function FetchLocationName(Location LocationRef)
	return LocationRef.GetName()
EndFunction

String Function CurrentLocationName()
	return CurrentLocation.GetName()
EndFunction

Function RegisterCustomLocation()
	Debug.Notification("Attempting to register location. Please wait...")
	Int LocationIndex = 0
	Bool EmptyIndexFound = False
	String LocationToRegister = CurrentLocationName()
	
	If CustomLocationsFull == True
		Debug.MessageBox("SLSF Reloaded - Cannot Register Custom Location. Custom Location List is Full.")
		return
	EndIf
	
	If LocationCanBeRegistered(LocationToRegister) == False
		return
	EndWhile
	
	While EmptyIndexFound == False && CustomLocationsFull == False
		If CustomLocation[LocationIndex] == "-EMPTY-"
			EmptyIndexFound == True
			CustomLocation[LocationIndex] = LocationToRegister
		Else
			LocationIndex += 1
		EndIf
	EndWhile
	
	Debug.Notification("Location " + LocationToRegister + " registered!")
	
	UpdateCustomLocationCount()
EndFunction

Function UnregisterCustomLocation(Int LocationIndexToUnregister)
	String UnregisteredLocation = CustomLocation[LocationIndexToUnregister]
	
	Debug.Notification("Unregistering " + UnregisteredLocation + ". Please wait...")
	
	FameManager.ClearFame(CustomLocation[LocationIndexToUnregister])
	
	CustomLocation[LocationIndexToUnregister] = "-EMPTY-"
	
	;Compact Custom Location Indexes - Required to keep other functions functional
	Int LocationIndex = 0
	While LocationIndex < 19 ;Stop at 19 instead of 20 because we'd check beyond the Array length otherwise
		If CustomLocation[LocationIndex] == "-EMPTY-" && CustomLocation[LocationIndex + 1] != "-EMPTY-"
			CustomLocation[LocationIndex] = CustomLocation[LocationIndex + 1]
			CustomLocation[LocationIndex + 1] = "-EMPTY-"
		EndIf
		LocationIndex += 1
	EndWhile
	
	UpdateCustomLocationCount()
	
	Debug.Notification("Location " + UnregisteredLocation + " Unregistered.")
EndFunction

Function RegisterCustomLocationExternal(String LocationToRegister)
	Debug.Notification("Attempting to register " + LocationToRegister + ". Please wait...")
	Int LocationIndex = 0
	Bool EmptyIndexFound = False
	
	If CustomLocationsFull == True
		Debug.MessageBox("SLSF Reloaded (External Mod Event) - Cannot Register Custom Location. Custom Location List is Full.")
		return
	EndIf
	
	While EmptyIndexFound == False && CustomLocationsFull == False
		If CustomLocation[LocationIndex] == "-EMPTY-"
			EmptyIndexFound == True
			CustomLocation[LocationIndex] = LocationToRegister
		Else
			LocationIndex += 1
		EndIf
	EndWhile
	
	Debug.Notification("Location " + LocationToRegister + " registered!")
	
	UpdateCustomLocationCount()
EndFunction

Function UnregisterCustomLocationExternal(String LocationToUnregister)
	Bool LocationFound = False
	Int LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue()
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