ScriptName SLSF_Reloaded_DynamicAnonymity extends Quest

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property DataManager Auto

Bool Property IsAnonymous Auto

Float[] Property DefaultLocationLastEnterTime Auto Hidden
Float[] Property CustomLocationLastEnterTime Auto Hidden
Float[] Property DefaultLocationLastExitTime Auto Hidden
Float[] Property CustomLocationLastExitTime Auto Hidden
Float[] Property DefaultLocationVisitTime Auto Hidden
Float[] Property CustomLocationVisitTime Auto Hidden

Int[] Property DefaultLocationRecognitionTime Auto Hidden
Int[] Property CustomLocationRecognitionTime Auto Hidden

Bool[] Property DefaultLocationLocalAnonymityFlag Auto Hidden
Bool[] Property CustomLocationLocalAnonymityFlag Auto Hidden

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Event OnInit()
	RegisterForUpdateGameTime(1.0)
	Startup()
	Debug.Trace("SLSF Reloaded - Dynamic Anonymity Script Initialized")
EndEvent

Function Startup()
	IsAnonymous = True
	DefaultLocationLastEnterTime = New Float[21]
	CustomLocationLastEnterTime = New Float[21]
	DefaultLocationLastExitTime = New Float[21]
	CustomLocationLastExitTime = New Float[21]
	DefaultLocationVisitTime = New Float[21]
	CustomLocationVisitTime = New Float[21]
	
	DefaultLocationRecognitionTime = New Int[21]
	CustomLocationRecognitionTime = New Int[21]
	
	DefaultLocationLocalAnonymityFlag = New Bool[21]
	CustomLocationLocalAnonymityFlag = New Bool[21]
	
	Int Index = 0
	While Index < 21
		DefaultLocationLastEnterTime[Index] = 0
		CustomLocationLastEnterTime[Index] = 0
		DefaultLocationLastExitTime[Index] = -10
		CustomLocationLastExitTime[Index] = -10
		DefaultLocationVisitTime[Index] = 0
		CustomLocationVisitTime[Index] = 0
		
		DefaultLocationRecognitionTime[Index] = 7
		CustomLocationRecognitionTime[Index] = 7
		
		DefaultLocationLocalAnonymityFlag[Index] = True
		CustomLocationLocalAnonymityFlag[Index] = True
		Index += 1
	EndWhile
EndFunction

Event OnUpdateGameTime()
	If Config.DynamicAnonymity == False
		Debug.Trace("SLSF Reloaded - Dynamic Anonymity is disabled")
		return
	EndIf
	
	Float CurrentTime = Utility.GetCurrentGameTime()
	String CurrentLocation = LocationManager.CurrentLocationName()
	Int LocationIndex = LocationManager.DefaultLocation.Find(CurrentLocation)
	
	If LocationIndex >= 0
		If DefaultLocationLocalAnonymityFlag[LocationIndex] == True
			UpdateCurrentLocationAnonymity(LocationIndex, CurrentTime, True)
		EndIf
		CheckAnonymityStatus(LocationIndex, True)
	Else
		LocationIndex = LocationManager.CustomLocation.Find(CurrentLocation)
		If LocationIndex >= 0
			If CustomLocationLocalAnonymityFlag[LocationIndex] == True
				UpdateCurrentLocationAnonymity(LocationIndex, CurrentTime, False)
			EndIf
			CheckAnonymityStatus(LocationIndex, False)
		EndIf
	EndIf
EndEvent

Function CompareLocations(Location OldLocation, Location NewLocation)
	String OldFameLocation = LocationManager.GetFameLocation(OldLocation)
	String NewFameLocation = LocationManager.GetFameLocation(NewLocation)
	Float CurrentGameTime = Utility.GetCurrentGameTime()
	
	If OldFameLocation != "Null" && OldFameLocation != NewFameLocation
		SetLastExitTime(OldFameLocation, CurrentGameTime)
		CheckRecognitionTimeIncrease(OldFameLocation)
	EndIf
	
	If NewFameLocation != "Null" && NewFameLocation != OldFameLocation
		SetLastEnterTime(NewFameLocation, CurrentGameTime)
		CheckRecognitionTimeDecay(NewFameLocation)
	EndIf
EndFunction

Function SetLastExitTime(String FameLocation, Float GameTime)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	
	If LocationIndex >= 0
		DefaultLocationLastExitTime[LocationIndex] = GameTime
		return
	EndIf
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			CustomLocationLastExitTime[LocationIndex] = GameTime
			return
		EndIf
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity SetLastExitTime Fame Location ERROR. Could not find Fame Location: " + FameLocation)
EndFunction

Function SetLastEnterTime(String FameLocation, Float GameTime)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	
	If LocationIndex >= 0
		DefaultLocationLastEnterTime[LocationIndex] = GameTime
		return
	EndIf
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			CustomLocationLastEnterTime[LocationIndex] = GameTime
			return
		EndIf
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity SetLastEnterTime Fame Location ERROR. Could not find Fame Location: " + FameLocation)
EndFunction

;NOTE - Check Recognition Time Increase when player EXITS a location
Function CheckRecognitionTimeIncrease(String FameLocation)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	Float TimeSpentInLocation = 0
	
	If LocationIndex >= 0
		TimeSpentInLocation = DefaultLocationLastExitTime[LocationIndex] - DefaultLocationLastEnterTime[LocationIndex]
		If TimeSpentInLocation < 1
			Debug.Trace("SLSF Reloaded - Time Spent in " + FameLocation + " is too short. No Recognition Increase.")
			return
		Else
			DefaultLocationRecognitionTime[LocationIndex] = DefaultLocationRecognitionTime[LocationIndex] + (TimeSpentInLocation as Int)
			If DefaultLocationRecognitionTime[LocationIndex] > 365
				DefaultLocationRecognitionTime[LocationIndex] = 365
			EndIf
		EndIf
		return
	ElseIf SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			TimeSpentInLocation = CustomLocationLastExitTime[LocationIndex] - CustomLocationLastEnterTime[LocationIndex]
			If TimeSpentInLocation < 1
				Debug.Trace("SLSF Reloaded - Time Spent in " + FameLocation + " is too short. No Recognition Increase.")
				return
			Else
				CustomLocationRecognitionTime[LocationIndex] = CustomLocationRecognitionTime[LocationIndex] + (TimeSpentInLocation as Int)
				If CustomLocationRecognitionTime[LocationIndex] > 365
					CustomLocationRecognitionTime[LocationIndex] = 365
				EndIf
			EndIf
			return
		EndIf
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity CheckRecognitionTimeIncrease Fame Location ERROR. Could not find Fame Location: " + FameLocation)
EndFunction

;NOTE - Check Recognition Time Decay when player ENTERS a location
Function CheckRecognitionTimeDecay(String FameLocation)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	Float TimeSinceLastVisit = 0
	
	If LocationIndex >= 0
		TimeSinceLastVisit = DefaultLocationLastEnterTime[LocationIndex] - DefaultLocationLastExitTime[LocationIndex]
		If TimeSinceLastVisit > DefaultLocationRecognitionTime[LocationIndex]
			DefaultLocationLocalAnonymityFlag[LocationIndex] = True ;Can be Anonymous
			;Decay Recognition
			DefaultLocationRecognitionTime[LocationIndex] = DefaultLocationRecognitionTime[LocationIndex] - (TimeSinceLastVisit - DefaultLocationRecognitionTime[LocationIndex]) as Int
			If DefaultLocationRecognitionTime[LocationIndex] < 7
				DefaultLocationRecognitionTime[LocationIndex] = 7
			EndIf
		EndIf
		return
	ElseIf SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			TimeSinceLastVisit = CustomLocationLastEnterTime[LocationIndex] - CustomLocationLastExitTime[LocationIndex]
			If TimeSinceLastVisit > CustomLocationRecognitionTime[LocationIndex]
				CustomLocationLocalAnonymityFlag[LocationIndex] = True ;Can be Anonymous
				;Decay Recognition
				CustomLocationRecognitionTime[LocationIndex] = CustomLocationRecognitionTime[LocationIndex] - (TimeSinceLastVisit - CustomLocationRecognitionTime[LocationIndex]) as Int
				If CustomLocationRecognitionTime[LocationIndex] < 7
					CustomLocationRecognitionTime[LocationIndex] = 7
				EndIf
			EndIf
		EndIf
		return
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity CheckRecognitionTimeDecay Fame Location ERROR. Could not find Fame Location: " + FameLocation)
EndFunction

Function UpdateCurrentLocationAnonymity(Int LocationIndex, Float GameTime, Bool IsDefaultLocation)
	If IsDefaultLocation == True
		If GameTime - DefaultLocationLastEnterTime[LocationIndex] >= 1
			DefaultLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
		EndIf
	Else
		If GameTime - CustomLocationLastEnterTime[LocationIndex] >= 1
			CustomLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
		EndIf
	EndIf
EndFunction

Function GetAnonymity(Location LocationRef)
	String FameLocation = LocationManager.GetFameLocation(LocationRef)
	Int LocationIndex = 0
	
	If FameLocation != "Null"
		LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
		If LocationIndex >= 0
			CheckAnonymityStatus(LocationIndex, True)
		ElseIf SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
			LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
			
			If LocationIndex >= 0
				CheckAnonymityStatus(LocationIndex, False)
			EndIf
		EndIf
	EndIf
EndFunction

Function CheckAnonymityStatus(Int LocationIndex, Bool IsDefaultLocation)
	If IsDefaultLocation == True
		If DefaultLocationLocalAnonymityFlag[LocationIndex] == True && DataManager.DefaultLocationDynamicAnonymityFlag[LocationIndex] == True
			IsAnonymous = True
		Else
			IsAnonymous = False
		EndIf
	Else
		If CustomLocationLocalAnonymityFlag[LocationIndex] == True && DataManager.CustomLocationDynamicAnonymityFlag[LocationIndex] == True
			IsAnonymous = True
		Else
			IsAnonymous = False
		EndIf
	EndIf
EndFunction