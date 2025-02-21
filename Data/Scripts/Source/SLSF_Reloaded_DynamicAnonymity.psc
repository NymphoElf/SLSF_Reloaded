ScriptName SLSF_Reloaded_DynamicAnonymity extends Quest

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property DataManager Auto

Bool Property IsAnonymous Auto

Float[] Property DefaultLocationLastEnterTime Auto
Float[] Property CustomLocationLastEnterTime Auto
Float[] Property DefaultLocationLastExitTime Auto
Float[] Property CustomLocationLastExitTime Auto
Float[] Property DefaultLocationVisitTime Auto
Float[] Property CustomLocationVisitTime Auto

Float[] Property DefaultLocationRecognitionTime Auto
Float[] Property CustomLocationRecognitionTime Auto

Bool[] Property DefaultLocationLocalAnonymityFlag Auto
Bool[] Property CustomLocationLocalAnonymityFlag Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Event OnInit()
	RegisterForUpdateGameTime(1.0)
	Debug.Trace("SLSF Reloaded - Dynamic Anonymity Script Initialized")
EndEvent

Event OnUpdateGameTime()
	If Config.DynamicAnonymity == False
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Dynamic Anonymity is disabled")
		EndIf
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
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Dynamic Anonymity: Comparing Locations. Old Location: " + OldFameLocation + ". New Location: " + NewFameLocation)
	EndIf
	
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
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Last Exit Time for " + FameLocation + " set to " + GameTime)
		EndIf
		return
	EndIf
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			CustomLocationLastExitTime[LocationIndex] = GameTime
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Last Exit Time for " + FameLocation + " set to " + GameTime)
			EndIf
			return
		EndIf
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity SetLastExitTime Fame Location ERROR. Could not find Fame Location: " + FameLocation)
EndFunction

Function SetLastEnterTime(String FameLocation, Float GameTime)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	
	If LocationIndex >= 0
		DefaultLocationLastEnterTime[LocationIndex] = GameTime
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Last Enter Time for " + FameLocation + " set to " + GameTime)
		EndIf
		return
	EndIf
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			CustomLocationLastEnterTime[LocationIndex] = GameTime
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Last Enter Time for " + FameLocation + " set to " + GameTime)
			EndIf
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
		If TimeSpentInLocation < 0.125 && DefaultLocationLocalAnonymityFlag[LocationIndex] == True
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Time Spent in " + FameLocation + " is too short. No Recognition Increase.")
			EndIf
			return
		Else
			If DefaultLocationLocalAnonymityFlag[LocationIndex] == True
				DefaultLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - Anonymity for " + LocationManager.DefaultLocation[LocationIndex] + " has been lost.")
				EndIf
			EndIf
			
			DefaultLocationRecognitionTime[LocationIndex] = DefaultLocationRecognitionTime[LocationIndex] + TimeSpentInLocation
			If DefaultLocationRecognitionTime[LocationIndex] > 365
				DefaultLocationRecognitionTime[LocationIndex] = 365
			EndIf
			
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Recognition time INCREASED! Recognition Time for " + FameLocation + " is now " + DefaultLocationRecognitionTime[LocationIndex])
			EndIf
		EndIf
		return
	ElseIf SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			TimeSpentInLocation = CustomLocationLastExitTime[LocationIndex] - CustomLocationLastEnterTime[LocationIndex]
			If TimeSpentInLocation < 0.125 && CustomLocationLocalAnonymityFlag[LocationIndex] == True
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - Time Spent in " + FameLocation + " is too short. No Recognition Increase.")
				EndIf
				return
			Else
				If CustomLocationLocalAnonymityFlag[LocationIndex] == True
					CustomLocationLocalAnonymityFlag[LocationIndex] = False
					If Config.EnableTracing == True
						Debug.Trace("SLSF Reloaded - Anonymity for " + LocationManager.CustomLocation[LocationIndex] + " has been lost.")
					EndIf
				EndIf
				
				CustomLocationRecognitionTime[LocationIndex] = CustomLocationRecognitionTime[LocationIndex] + TimeSpentInLocation
				If CustomLocationRecognitionTime[LocationIndex] > 365
					CustomLocationRecognitionTime[LocationIndex] = 365
				EndIf
				
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - Recognition time INCREASED! Recognition Time for " + FameLocation + " is now " + CustomLocationRecognitionTime[LocationIndex])
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
			
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Recognition time DECAY! Recognition Time for " + FameLocation + " is now " + DefaultLocationRecognitionTime[LocationIndex])
				Debug.Trace("SLSF Reloaded - Anonymity for " + FameLocation + " is now possible if their fame is low enough.")
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
				
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - Recognition time DECAY! Recognition Time for " + FameLocation + " is now " + CustomLocationRecognitionTime[LocationIndex])
					Debug.Trace("SLSF Reloaded - Anonymity for " + FameLocation + " is now possible if their fame is low enough.")
				EndIf
			EndIf
		EndIf
		return
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity CheckRecognitionTimeDecay Fame Location ERROR. Could not find Fame Location: " + FameLocation)
EndFunction

Function UpdateCurrentLocationAnonymity(Int LocationIndex, Float GameTime, Bool IsDefaultLocation)
	If IsDefaultLocation == True
		If GameTime - DefaultLocationLastEnterTime[LocationIndex] >= 0.125
			DefaultLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Anonymity for " + LocationManager.DefaultLocation[LocationIndex] + " has been lost.")
			EndIf
		EndIf
	Else
		If GameTime - CustomLocationLastEnterTime[LocationIndex] >= 0.125
			CustomLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Anonymity for " + LocationManager.CustomLocation[LocationIndex] + " has been lost.")
			EndIf
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