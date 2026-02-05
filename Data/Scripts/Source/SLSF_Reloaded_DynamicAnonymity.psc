ScriptName SLSF_Reloaded_DynamicAnonymity extends Quest

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property DataManager Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_Logger Property Logger Auto

FavorJarlsMakeFriendsScript Property ThaneScript Auto

Quest Property DLC2StoneCleanse Auto

Faction Property OrcFriends Auto

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
Bool[] Property DefaultLocationLocalAnonymityStartedAsTrue Auto
Bool[] Property CustomLocationLocalAnonymityStartedAsTrue Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Event OnInit()
	RegisterForUpdateGameTime(1.0)
	SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [OnInit] - Dynamic Anonymity Script Initialized", Logger.CRITICAL)
EndEvent

Event OnUpdateGameTime()
	If Config.DynamicAnonymity == False
		SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [OnUpdateGameTime] - Dynamic Anonymity is disabled")
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
	
	SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CompareLocations] - Comparing Locations. Old Location: " + OldFameLocation + ". New Location: " + NewFameLocation)
	
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
		SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [SetLastExitTime] - Last Exit Time for " + FameLocation + " set to " + GameTime)
		return
	EndIf
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			CustomLocationLastExitTime[LocationIndex] = GameTime
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [SetLastExitTime] - Last Exit Time for " + FameLocation + " set to " + GameTime)
			return
		EndIf
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity SetLastExitTime Fame Location ERROR. Could not find Fame Location: " + FameLocation)
	SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [SetLastExitTime] ERROR - Could not find Fame Location: " + FameLocation)
EndFunction

Function SetLastEnterTime(String FameLocation, Float GameTime)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	
	If LocationIndex >= 0
		DefaultLocationLastEnterTime[LocationIndex] = GameTime
		SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [SetLastEnterTime] - Last Enter Time for " + FameLocation + " set to " + GameTime)
		return
	EndIf
	
	If SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			CustomLocationLastEnterTime[LocationIndex] = GameTime
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [SetLastEnterTime] - Last Enter Time for " + FameLocation + " set to " + GameTime)
			return
		EndIf
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity SetLastEnterTime Fame Location ERROR. Could not find Fame Location: " + FameLocation)
	SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [SetLastEnterTime] ERROR - Could not find Fame Location: " + FameLocation)
EndFunction

;NOTE - Check Recognition Time Increase when player EXITS a location
Function CheckRecognitionTimeIncrease(String FameLocation)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	Float TimeSpentInLocation = 0
	
	If LocationIndex >= 0
		TimeSpentInLocation = DefaultLocationLastExitTime[LocationIndex] - DefaultLocationLastEnterTime[LocationIndex]
		If TimeSpentInLocation < 0.125 && DefaultLocationLocalAnonymityFlag[LocationIndex] == True
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Time Spent in " + FameLocation + " is too short. No Recognition Increase.")
			return
		Else
			If DefaultLocationLocalAnonymityFlag[LocationIndex] == True || DefaultLocationLocalAnonymityStartedAsTrue[LocationIndex] == True
				DefaultLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
				DefaultLocationLocalAnonymityStartedAsTrue[LocationIndex] = False
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Anonymity for " + LocationManager.DefaultLocation[LocationIndex] + " has been lost.")
				
				DefaultLocationRecognitionTime[LocationIndex] = DefaultLocationRecognitionTime[LocationIndex] + (TimeSpentInLocation - 0.125)
				If DefaultLocationRecognitionTime[LocationIndex] > 365
					DefaultLocationRecognitionTime[LocationIndex] = 365
				EndIf
				
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Recognition time INCREASED! Recognition Time for " + FameLocation + " is now " + DefaultLocationRecognitionTime[LocationIndex])
			Else
				DefaultLocationRecognitionTime[LocationIndex] = DefaultLocationRecognitionTime[LocationIndex] + TimeSpentInLocation
				If DefaultLocationRecognitionTime[LocationIndex] > 365
					DefaultLocationRecognitionTime[LocationIndex] = 365
				EndIf
				
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Recognition time INCREASED! Recognition Time for " + FameLocation + " is now " + DefaultLocationRecognitionTime[LocationIndex])
			EndIf
		EndIf
		return
	ElseIf SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			TimeSpentInLocation = CustomLocationLastExitTime[LocationIndex] - CustomLocationLastEnterTime[LocationIndex]
			If TimeSpentInLocation < 0.125 && CustomLocationLocalAnonymityFlag[LocationIndex] == True
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Time Spent in " + FameLocation + " is too short. No Recognition Increase.")
				return
			Else
				If CustomLocationLocalAnonymityFlag[LocationIndex] == True || CustomLocationLocalAnonymityStartedAsTrue[LocationIndex] == True
					CustomLocationLocalAnonymityFlag[LocationIndex] = False
					CustomLocationLocalAnonymityStartedAsTrue[LocationIndex] = False
					SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Anonymity for " + LocationManager.CustomLocation[LocationIndex] + " has been lost.")
					
					CustomLocationRecognitionTime[LocationIndex] = CustomLocationRecognitionTime[LocationIndex] + (TimeSpentInLocation - 0.125)
					If CustomLocationRecognitionTime[LocationIndex] > 365
						CustomLocationRecognitionTime[LocationIndex] = 365
					EndIf
					
					SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Recognition time INCREASED! Recognition Time for " + FameLocation + " is now " + CustomLocationRecognitionTime[LocationIndex])
				Else
					CustomLocationRecognitionTime[LocationIndex] = CustomLocationRecognitionTime[LocationIndex] + TimeSpentInLocation
					If CustomLocationRecognitionTime[LocationIndex] > 365
						CustomLocationRecognitionTime[LocationIndex] = 365
					EndIf
					
					SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] - Recognition time INCREASED! Recognition Time for " + FameLocation + " is now " + CustomLocationRecognitionTime[LocationIndex])
				EndIf
			EndIf
			return
		EndIf
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity CheckRecognitionTimeIncrease Fame Location ERROR. Could not find Fame Location: " + FameLocation)
	SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeIncrease] ERROR - Could not find Fame Location: " + FameLocation)
EndFunction

;NOTE - Check Recognition Time Decay when player ENTERS a location
Function CheckRecognitionTimeDecay(String FameLocation)
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	Float TimeSinceLastVisit = 0
	
	If LocationIndex >= 0
		TimeSinceLastVisit = DefaultLocationLastEnterTime[LocationIndex] - DefaultLocationLastExitTime[LocationIndex]
		If TimeSinceLastVisit > DefaultLocationRecognitionTime[LocationIndex] && DefaultLocationLocalAnonymityFlag[LocationIndex] == False
			DefaultLocationLocalAnonymityFlag[LocationIndex] = True ;Can be Anonymous
			DefaultLocationLocalAnonymityStartedAsTrue[LocationIndex] = True
			;Decay Recognition
			DefaultLocationRecognitionTime[LocationIndex] = DefaultLocationRecognitionTime[LocationIndex] - (TimeSinceLastVisit - DefaultLocationRecognitionTime[LocationIndex])
			If DefaultLocationRecognitionTime[LocationIndex] < 7
				DefaultLocationRecognitionTime[LocationIndex] = 7
			EndIf
			
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Recognition time DECAY! Recognition Time for " + FameLocation + " is now " + DefaultLocationRecognitionTime[LocationIndex])
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Anonymity for " + FameLocation + " is now possible if their fame is low enough.")
		ElseIf DefaultLocationLocalAnonymityFlag[LocationIndex] == True
			DefaultLocationRecognitionTime[LocationIndex] = DefaultLocationRecognitionTime[LocationIndex] - (TimeSinceLastVisit - DefaultLocationRecognitionTime[LocationIndex])
			If DefaultLocationRecognitionTime[LocationIndex] < 7
				DefaultLocationRecognitionTime[LocationIndex] = 7
			EndIf
			
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Recognition time DECAY! Recognition Time for " + FameLocation + " is now " + DefaultLocationRecognitionTime[LocationIndex])
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Anonymity for " + FameLocation + " was already possible.")
		EndIf
		return
	ElseIf SLSF_Reloaded_CustomLocationCount.GetValue() as Int > 0
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		
		If LocationIndex >= 0
			TimeSinceLastVisit = CustomLocationLastEnterTime[LocationIndex] - CustomLocationLastExitTime[LocationIndex]
			If TimeSinceLastVisit > CustomLocationRecognitionTime[LocationIndex] && CustomLocationLocalAnonymityFlag[LocationIndex] == False
				CustomLocationLocalAnonymityFlag[LocationIndex] = True ;Can be Anonymous
				CustomLocationLocalAnonymityStartedAsTrue[LocationIndex] = True
				;Decay Recognition
				CustomLocationRecognitionTime[LocationIndex] = CustomLocationRecognitionTime[LocationIndex] - (TimeSinceLastVisit - CustomLocationRecognitionTime[LocationIndex])
				If CustomLocationRecognitionTime[LocationIndex] < 7
					CustomLocationRecognitionTime[LocationIndex] = 7
				EndIf
				
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Recognition time DECAY! Recognition Time for " + FameLocation + " is now " + CustomLocationRecognitionTime[LocationIndex])
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Anonymity for " + FameLocation + " is now possible if their fame is low enough.")
			ElseIf CustomLocationLocalAnonymityFlag[LocationIndex] == True
				CustomLocationRecognitionTime[LocationIndex] = CustomLocationRecognitionTime[LocationIndex] - (TimeSinceLastVisit - CustomLocationRecognitionTime[LocationIndex])
				If CustomLocationRecognitionTime[LocationIndex] < 7
					CustomLocationRecognitionTime[LocationIndex] = 7
				EndIf
				
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Recognition time DECAY! Recognition Time for " + FameLocation + " is now " + CustomLocationRecognitionTime[LocationIndex])
				SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] - Anonymity for " + FameLocation + " was already possible.")
			EndIf
		EndIf
		return
	EndIf
	
	Debug.Messagebox("SLSF Reloaded - Dynamic Anonymity CheckRecognitionTimeDecay Fame Location ERROR. Could not find Fame Location: " + FameLocation)
	SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [CheckRecognitionTimeDecay] ERROR - Could not find Fame Location: " + FameLocation)
EndFunction

Function UpdateCurrentLocationAnonymity(Int LocationIndex, Float GameTime, Bool IsDefaultLocation)
	If IsDefaultLocation == True
		If GameTime - DefaultLocationLastEnterTime[LocationIndex] >= 0.125
			DefaultLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [UpdateCurrentLocationAnonymity] - Anonymity for " + LocationManager.DefaultLocation[LocationIndex] + " has been lost.")
		EndIf
	Else
		If GameTime - CustomLocationLastEnterTime[LocationIndex] >= 0.125
			CustomLocationLocalAnonymityFlag[LocationIndex] = False ;Can't be Anonymous
			SLSF_Reloaded_Logger.Log("<Dynamic Anonymity> [UpdateCurrentLocationAnonymity] - Anonymity for " + LocationManager.CustomLocation[LocationIndex] + " has been lost.")
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
		If Config.ThanesCantBeAnonymous == True && ThaneStatus(LocationManager.DefaultLocation[LocationIndex]) == True
			IsAnonymous = False
		ElseIf DefaultLocationLocalAnonymityFlag[LocationIndex] == True && DataManager.DefaultLocationDynamicAnonymityFlag[LocationIndex] == True
			IsAnonymous = True
		Else
			IsAnonymous = False
		EndIf
	Else
		If Config.ThanesCantBeAnonymous == True && ThaneStatus(LocationManager.CustomLocation[LocationIndex]) == True
			IsAnonymous = False
		ElseIf CustomLocationLocalAnonymityFlag[LocationIndex] == True && DataManager.CustomLocationDynamicAnonymityFlag[LocationIndex] == True
			IsAnonymous = True
		Else
			IsAnonymous = False
		EndIf
	EndIf
EndFunction

Bool Function ThaneStatus(String FameLocation)
	If FameLocation == "Whiterun" || FameLocation == "Riverwood" || FameLocation == "Rorikstead" || LocationManager.WhiterunLocationList.Find(FameLocation) >= 0
		If ThaneScript.WhiterunImpGetOutofJail > 0 || ThaneScript.WhiterunSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Winterhold" || LocationManager.WinterholdLocationList.Find(FameLocation) >= 0
		If ThaneScript.WinterholdImpGetOutofJail > 0 || ThaneScript.WinterholdSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Windhelm" || LocationManager.EastmarchLocationList.Find(FameLocation) >= 0
		If ThaneScript.EastmarchImpGetOutofJail > 0 || ThaneScript.EastmarchSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Solitdue" || FameLocation == "Dragon Bridge" || LocationManager.HaafingarLocationList.Find(FameLocation) >= 0
		If ThaneScript.HaafingarImpGetOutofJail > 0 || ThaneScript.HaafingarSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Morthal" || LocationManager.HjaalmarchLocationList.Find(FameLocation) >= 0
		If ThaneScript.HjaalmarchImpGetOutofJail > 0 || ThaneScript.HjaalmarchSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Dawnstar" || LocationManager.PaleLocationList.Find(FameLocation) >= 0
		If ThaneScript.PaleImpGetOutofJail > 0 || ThaneScript.PaleSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Riften" || FameLocation == "Ivarstead" || FameLocation == "Shor's Stone" || LocationManager.RiftLocationList.Find(FameLocation) >= 0
		If ThaneScript.RiftImpGetOutofJail > 0 || ThaneScript.RiftSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Markarth" || FameLocation == "Karthwasten" || LocationManager.ReachLocationList.Find(FameLocation) >= 0
		If ThaneScript.ReachImpGetOutofJail > 0 || ThaneScript.ReachSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Falkreath" || LocationManager.FalkreathLocationList.Find(FameLocation) >= 0
		If ThaneScript.FalkreathImpGetOutofJail > 0 || ThaneScript.FalkreathSonsGetOutofJail > 0
			return True
		EndIf
	ElseIf FameLocation == "Raven Rock" || FameLocation == "Skaal Village" || LocationManager.SolstheimLocationList.Find(FameLocation) >= 0
		If DLC2StoneCleanse.IsCompleted()
			return True
		EndIf
	ElseIf FameLocation == "Narzulbur" || FameLocation == "Mor Khazgur" || FameLocation == "Largashbur" || FameLocation == "Dushnikh Yal"
		If PlayerScript.PlayerRef.IsInFaction(OrcFriends)
			return True
		EndIf
	EndIf
	return False
EndFunction