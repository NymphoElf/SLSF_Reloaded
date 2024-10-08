ScriptName SLSF_Reloaded_ModEventListener extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Event OnInit()
	RegisterExternalEvents()
EndEvent

Function RegisterExternalEvents()
	;AUTOMATED FAME INCREASE LISTENERS
	RegisterForModEvent("SLSF_Reloaded_SendFameGainRoll", "OnExternalFameGainRoll")
	RegisterForModEvent("SLSF_Reloaded_SendFameGain", "OnExternalFameGain")
	
	;MANUAL FAME INCREASE LISTENERS
	RegisterForModEvent("SLSF_Reloaded_SendManualFameGain", "OnExternalManualFameGain")
	RegisterForModEvent("SLSF_Reloaded_SendManualFameGainAllInLocation", "OnExternalManualFameGainAllInLocation")
	RegisterForModEvent("SLSF_Reloaded_SendManualFameGainAll", "OnExternalManualFameGainAll")
	
	;FAME DECAY LISTENERS
	RegisterForModEvent("SLSF_Reloaded_SendFameDecay", "OnExternalFameDecay")
	RegisterForModEvent("SLSF_Reloaded_SendManualFameDecay", "OnExternalManualFameDecay")
	RegisterForModEvent("SLSF_Reloaded_SendManualFameDecayAllInLocation", "OnExternalManualFameDecayAllInLocation")
	RegisterForModEvent("SLSF_Reloaded_SendManualFameDecayAll", "OnExternalManualFameDecayAll")
	
	;FAME SPREAD LISTENERS
	RegisterForModEvent("SLSF_Reloaded_SendFameSpreadRoll", "OnExternalFameSpreadRoll")
	RegisterForModEvent("SLSF_Reloaded_SendFameSpread", "OnExternalFameSpread")
	RegisterForModEvent("SLSF_Reloaded_SendFameSpreadByName", "OnExternalFameSpreadByName")
	RegisterForModEvent("SLSF_Reloaded_SendManualFameSpread", "OnExternalManualFameSpread")
	
	;LOCATION REGISTRATION LISTENERS
	RegisterForModEvent("SLSF_Reloaded_SendLocationRegister", "OnExternalLocationRegister")
	RegisterForModEvent("SLSF_Reloaded_SendLocationUnregister", "OnExternalLocationUnregister")
	
	;FLAG LISTENERS
	RegisterForModEvent("SLSF_Reloaded_SetSlutFlag", "OnExternalSlutFlag")
	RegisterForModEvent("SLSF_Reloaded_SetWhoreFlag", "OnExternalWhoreFlag")
	RegisterForModEvent("SLSF_Reloaded_SetExhibitionistFlag", "OnExternalExhibitionistFlag")
	RegisterForModEvent("SLSF_Reloaded_SetOralFlag", "OnExternalOralFlag")
	RegisterForModEvent("SLSF_Reloaded_SetAnalFlag", "OnExternalAnalFlag")
	RegisterForModEvent("SLSF_Reloaded_SetNastyFlag", "OnExternalNastyFlag")
	RegisterForModEvent("SLSF_Reloaded_SetPregnantFlag", "OnExternalPregnantFlag")
	RegisterForModEvent("SLSF_Reloaded_SetDominantFlag", "OnExternalDominantFlag")
	RegisterForModEvent("SLSF_Reloaded_SetSubmissiveFlag", "OnExternalSubmissiveFlag")
	RegisterForModEvent("SLSF_Reloaded_SetSadistFlag", "OnExternalSadistFlag")
	RegisterForModEvent("SLSF_Reloaded_SetMasochistFlag", "OnExternalMasochistFlag")
	RegisterForModEvent("SLSF_Reloaded_SetGentleFlag", "OnExternalGentleFlag")
	RegisterForModEvent("SLSF_Reloaded_SetLikesMenFlag", "OnExternalLikesMenFlag")
	RegisterForModEvent("SLSF_Reloaded_SetLikesWomenFlag", "OnExternalLikesWomenFlag")
	RegisterForModEvent("SLSF_Reloaded_SetLikesOrcFlag", "OnExternalLikesOrcFlag")
	RegisterForModEvent("SLSF_Reloaded_SetLikesKhajiitFlag", "OnExternalLikesKhajiitFlag")
	RegisterForModEvent("SLSF_Reloaded_SetLikesArgonianFlag", "OnExternalLikesArgonianFlag")
	RegisterForModEvent("SLSF_Reloaded_SetBestialityFlag", "OnExternalBestialityFlag")
	RegisterForModEvent("SLSF_Reloaded_SetGroupFlag", "OnExternalGroupFlag")
	RegisterForModEvent("SLSF_Reloaded_SetBoundFlag", "OnExternalBoundFlag")
	RegisterForModEvent("SLSF_Reloaded_SetTattooFlag", "OnExternalTattooFlag")
	RegisterForModEvent("SLSF_Reloaded_SetCumDumpFlag", "OnExternalCumDumpFlag")
	RegisterForModEvent("SLSF_Reloaded_SetUnfaithfulFlag", "OnExternalUnfaithfulFlag")
	RegisterForModEvent("SLSF_Reloaded_SetCuckFlag", "OnExternalCuckFlag")
	RegisterForModEvent("SLSF_Reloaded_SetAirheadFlag", "OnExternalAirheadFlag")
	RegisterForModEvent("SLSF_Reloaded_SetWhoreEventFlag", "OnExternalWhoreEventFlag") ;Used specifically for checking if a Sexlab Event should give Whore fame
	
	;DATA LISTENERS
	RegisterForModEvent("SLSF_Reloaded_RequestLocation", "OnRequestLocation")
	RegisterForModEvent("SLSF_Reloaded_RequestFame", "OnRequestFame")
	RegisterForModEvent("SLSF_Reloaded_RequestCumVisibility", "OnRequestCumVisibility")
EndFunction

;/
=================================================
========AUTOMATED FAME INCREASE LISTENERS========
=================================================

USE THESE TO PERFORM ONE-TIME FAME INCREASES VIA THE INTERNAL FUNCTIONS. USE THESE CAREFULLY SO FAME DOESN'T SPIRAL OUT OF CONTROL

==PARAMETERS/ARGUMENTS==
EventLocation = YOU MUST MANUALLY DEFINE A LOCATION NAME. THE LOCATION MUST BE VALID OTHERWISE THE EVENT WILL FAIL

MinFame       = YOU MUST MANUALLY DEFINE A MINIMUM FAME VALUE THAT YOUR EVENT NEEDS BEFORE IT STARTS AFFECTING FAME.

MaxFame       = YOU MUST MANUALLY DEFINE A MAXIMUM FAME VALUE THAT YOUR EVENT CAN REACH BEFORE IT STOPS AFFECTING FAME.

==HOW TO WRITE YOUR MOD EVENT PROPERLY==
Example:

Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendSlutFameGain") ;This should ALWAYS be the first line for each event
ModEvent.PushString(EventHandle, "Whiterun") ;Our Location Name
ModEvent.PushString(EventHandle, "Slut") ;Our Category - If applicable
ModEvent.PushInt(EventHandle, 0) ;The minimum fame the player should have
ModEvent.PushInt(EventHandle, 100) ;The maximum fame the player is allowed from this event
ModEvent.Send(EventHandle) ;Sends the data from our "ModEvent.Push" lines. This should ALWAYS be the last line for each event

If you send multiple mod events in one function, just remove "Int" from the first line of your next mod event:

EventHandle = ModEvent.Create("WhateverModEventYouWant")

NOTE: You MUST send the variables in the correct order in the 'ModEvent.Push' lines:
Parameter 1 (left-most parameter)
Parameter 2 (First parameter right of Parameter 1)
[and so on...]
/;

Event OnExternalFameGainRoll(String EventLocation)
	FameManager.FameGainRoll(EventLocation, True)
EndEvent

Event OnExternalFameGain(String Category, String EventLocation, Int MinFame, Int MaxFame)
	If EventLocation == "Current"
		EventLocation = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("External Fame Gain Event Location is Invalid")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int CategoryIndex = FameManager.FameType.Find(Category)
	If CategoryIndex >= 0 && CategoryIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameGain - Fame Category " + Category + " is Invalid.")
		return
	EndIf
	
	Int CurrentFame = Data.GetFameValue(EventLocation, Category)
	
	If CurrentFame >= MinFame && CurrentFame < MaxFame
		FameManager.GainFame(Category, EventLocation, False)
	EndIf
EndEvent

;/
==============================================
========MANUAL FAME INCREASE LISTENERS========
==============================================

USE THESE TO PERFORM MANUAL ONE-TIME FAME INCREASES
/;

;/
This event requires specifying the location and category of fame to increase, as well as the minimum amount to increase and the maximum.
Use "Current" for the EventLocation if you want to get the player's current location. 
If the location is invalid, the event fails. If using "Current", event failure is not necessarily bad.
If the category is not specified, or is not a valid category, the event will fail.
If the Minimum is higher than the Maximum, it will apply the Minimum.
If either are below 0, they will set to 0. If either are above 150, they will set to 150. If increase is not possible, event fails.
If the Minimum and Maximums are different, it will randomly pick a number between those values to increase (inclusive).
/;

Event OnExternalManualFameGain(String Category, String EventLocation, Int MinIncrease, Int MaxIncrease)
	If EventLocation == "Current"
		EventLocation = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameGain - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int CategoryIndex = FameManager.FameType.Find(Category)
	If CategoryIndex >= 0 && CategoryIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameGain - Fame Category " + Category + " is Invalid.")
		return
	EndIf
	
	If MinIncrease < 0
		MinIncrease = 0
	ElseIf MinIncrease > 150
		MinIncrease = 150
	EndIf
	
	If MaxIncrease < 0
		MaxIncrease = 0
	ElseIf MaxIncrease > 150
		MaxIncrease = 150
	EndIf
	
	If MinIncrease == 0 && MaxIncrease == 0
		Debug.Trace("SLSF Reloaded - ExternalManualFameGain - Gain is only 0")
		return
	EndIf
	
	Int PreviousFame = Data.GetFameValue(EventLocation, Category)
	Int IncreaseValue = 0
	If MinIncrease >= MaxIncrease
		IncreaseValue = MinIncrease
	Else
		IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
	EndIf
	
	Int NewFame = PreviousFame + IncreaseValue
	If NewFame < 150
		Data.SetFameValue(EventLocation, Category, NewFame)
	Else
		Data.SetFameValue(EventLocation, Category, 150)
	EndIf
EndEvent

;/
This event will increase all fame categories in a specific location. Functions similarly to the above event.
/;

Event OnExternalManualFameGainAllInLocation(String EventLocation, Int MinIncrease, Int MaxIncrease)
	If EventLocation == "Current"
		EventLocation = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("SLSF Reloaded - OnExternalManualFameGainAllInLocation - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	If MinIncrease < 0
		MinIncrease = 0
	ElseIf MinIncrease > 150
		MinIncrease = 150
	EndIf
	
	If MaxIncrease < 0
		MaxIncrease = 0
	ElseIf MaxIncrease > 150
		MaxIncrease = 150
	EndIf
	
	Int IncreaseValue = 0
	Bool RandomizeIncreaseValue = True
	If MinIncrease > MaxIncrease || MinIncrease == MaxIncrease
		IncreaseValue = MinIncrease
		RandomizeIncreaseValue = False
	EndIf
	
	If MinIncrease == 0 && MaxIncrease == 0
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Decay Value is 0")
		return
	EndIf
	
	Int PreviousFame = 0
	Int NewFame = 0
	Int FameIndex = 0
	While FameIndex < FameManager.FameType.Length
		PreviousFame = Data.GetFameValue(EventLocation, FameManager.FameType[FameIndex])
		If RandomizeIncreaseValue == True
			IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
		EndIf
		
		NewFame = PreviousFame + IncreaseValue
		
		If NewFame < 150
			Data.SetFameValue(EventLocation, FameManager.FameType[FameIndex], NewFame)
		Else
			Data.SetFameValue(EventLocation, FameManager.FameType[FameIndex], 150)
		EndIf
		
		FameIndex += 1
	EndWhile
EndEvent

;/
This event will increase all fame categories in ALL registered locations. Functions similarly to the above event.
MAKE SURE YOU KNOW WHAT YOU'RE DOING HERE! THIS COULD SKYROCKET A CHARACTER'S FAME AND MAKE IT HARD TO DECREASE!
/;

Event OnExternalManualFameGainAll(Int MinIncrease, Int MaxIncrease)
	If MinIncrease < 0
		MinIncrease = 0
	ElseIf MinIncrease > 150
		MinIncrease = 150
	EndIf
	
	If MaxIncrease < 0
		MaxIncrease = 0
	ElseIf MaxIncrease > 150
		MaxIncrease = 150
	EndIf
	
	Int IncreaseValue = 0
	Bool RandomizeIncreaseValue = True
	If MinIncrease > MaxIncrease || MinIncrease == MaxIncrease
		IncreaseValue = MinIncrease
		RandomizeIncreaseValue = False
	EndIf
	
	If MinIncrease == 0 && MaxIncrease == 0
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Decay Value is 0")
		return
	EndIf
	
	Int PreviousFame = 0
	Int NewFame = 0
	Int FameIndex = 0
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		While FameIndex < FameManager.FameType.Length
			PreviousFame = Data.GetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[FameIndex])
			If RandomizeIncreaseValue == True
				IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
			EndIf
			
			NewFame = PreviousFame + IncreaseValue
			
			If NewFame < 150
				Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[FameIndex], NewFame)
			Else
				Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[FameIndex], 150)
			EndIf
			
			FameIndex += 1
		EndWhile
		FameIndex = 0
		LocationIndex += 1
	EndWhile
	
	FameIndex = 0
	LocationIndex = 0
	
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	While LocationIndex < CustomLocations
		While FameIndex < FameManager.FameType.Length
			PreviousFame = Data.GetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[FameIndex])
			If RandomizeIncreaseValue == True
				IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
			EndIf
			
			NewFame = PreviousFame + IncreaseValue
			
			If NewFame < 150
				Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[FameIndex], NewFame)
			Else
				Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[FameIndex], 150)
			EndIf
			
			FameIndex += 1
		EndWhile
		FameIndex = 0
		LocationIndex += 1 
	EndWhile
EndEvent

;/
====================================
========FAME DECAY LISTENERS========
====================================
/;

;/
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!THIS EVENT TRIGGERS THE INTERNAL FAME DECAY FUNCTION, AND WILL AFFECT ALL LOCATIONS!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
IF DECAY IS PAUSED FOR A LOCATION, IT WILL NOT DECAY
IF A LOCATION'S DECAY IS NOT PAUSED, IT WILL DECAY, BUT THE DECAY PAUSE TIMER WILL START.
IF YOU WANT TO MANUALLY DECAY A SPECIFIC LOCATION'S FAME, USE THE MANUAL DECAY FUNCTIONS INSTEAD.
/;

Event OnExternalFameDecay()
	FameManager.DecayFame()
EndEvent

;/
This event requires specifying the location and category of fame to decay, as well as the minimum amount to decay and the maximum.
The location will default to the player's current location if not specified. If location is invalid, the event fails.
If the category is not specified, or is not a valid category, the event will fail.
If the Minimum is higher than the Maximum, it will apply the Minimum.
If either are below 0, they will set to 0. If either are above 150, they will set to 150. If decay is not possible, event fails.
If the Minimum and Maximums are different, it will randomly pick a number between those values to decay (inclusive).
/;

Event OnExternalManualFameDecay(String EventLocation, String Category, Int MinDecay, Int MaxDecay)
	If EventLocation == "Current"
		EventLocation = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int CategoryIndex = FameManager.FameType.Find(Category)
	If CategoryIndex >= 0 && CategoryIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Fame Category " + Category + " is Invalid.")
		return
	EndIf
	
	If MinDecay < 0
		MinDecay = 0
	ElseIf MinDecay > 150
		MinDecay = 150
	EndIf
	
	If MaxDecay < 0
		MaxDecay = 0
	ElseIf MaxDecay > 150
		MaxDecay = 150
	EndIf
	
	If MinDecay == 0 && MaxDecay == 0
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Decay Value is 0")
		return
	EndIf
	
	Int DecayValue = 0
	If MinDecay > MaxDecay || MinDecay == MaxDecay
		DecayValue = MinDecay
	Else
		DecayValue = Utility.RandomInt(MinDecay, MaxDecay)
	EndIf
	
	Int PreviousFame = Data.GetFameValue(EventLocation, Category)
	Int NewFame = PreviousFame - DecayValue
	
	If NewFame > 0
		Data.SetFameValue(EventLocation, Category, NewFame)
	Else
		Data.SetFameValue(EventLocation, Category, 0)
	EndIf
EndEvent

;/
This event will decay all fame categories in a specific location. Functions similarly to the above event.
/;

Event OnExternalManualFameDecayAllInLocation(String EventLocation, Int MinDecay, Int MaxDecay)
	If EventLocation == "Current"
		EventLocation = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecayAllInLocation - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	If MinDecay < 0
		MinDecay = 0
	ElseIf MinDecay > 150
		MinDecay = 150
	EndIf
	
	If MaxDecay < 0
		MaxDecay = 0
	ElseIf MaxDecay > 150
		MaxDecay = 150
	EndIf
	
	Int DecayValue = 0
	Bool RandomizeDecayValue = True
	If MinDecay > MaxDecay || MinDecay == MaxDecay
		DecayValue = MinDecay
		RandomizeDecayValue = False
	EndIf
	
	If MinDecay == 0 && MaxDecay == 0
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecayAllInLocation - Decay Value is 0")
		return
	EndIf
	
	Int PreviousFame = 0
	Int NewFame = 0
	Int FameIndex = 0
	While FameIndex < FameManager.FameType.Length
		PreviousFame = Data.GetFameValue(EventLocation, FameManager.FameType[FameIndex])
		If RandomizeDecayValue == True
			DecayValue = Utility.RandomInt(MinDecay, MaxDecay)
		EndIf
		
		NewFame = PreviousFame - DecayValue
		
		If NewFame > 0
			Data.SetFameValue(EventLocation, FameManager.FameType[FameIndex], NewFame)
		Else
			Data.SetFameValue(EventLocation, FameManager.FameType[FameIndex], 0)
		EndIf
		
		FameIndex += 1
	EndWhile
EndEvent

;/
This event will decay all fame categories in ALL registered locations. Functions similarly to the above event.
MAKE SURE YOU KNOW WHAT YOU'RE DOING HERE! THIS COULD EFFECTIVELY WIPE ALL FAME FOR A CHARACTER!
/;

Event OnExternalManualFameDecayAll(Int MinDecay, Int MaxDecay)
	If MinDecay < 0
		MinDecay = 0
	ElseIf MinDecay > 150
		MinDecay = 150
	EndIf
	
	If MaxDecay < 0
		MaxDecay = 0
	ElseIf MaxDecay > 150
		MaxDecay = 150
	EndIf
	
	Int DecayValue = 0
	Bool RandomizeDecayValue = True
	If MinDecay > MaxDecay || MinDecay == MaxDecay
		DecayValue = MinDecay
		RandomizeDecayValue = False
	EndIf
	
	If MinDecay == 0 && MaxDecay == 0
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecayAll - Decay Value is 0")
		return
	EndIf
	
	Int PreviousFame = 0
	Int NewFame = 0
	Int FameIndex = 0
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		While FameIndex < FameManager.FameType.Length
			PreviousFame = Data.GetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[FameIndex])
			If RandomizeDecayValue == True
				DecayValue = Utility.RandomInt(MinDecay, MaxDecay)
			EndIf
			
			NewFame = PreviousFame - DecayValue
			
			If NewFame > 0
				Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[FameIndex], NewFame)
			Else
				Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[FameIndex], 0)
			EndIf
			
			FameIndex += 1
		EndWhile
		FameIndex = 0
		LocationIndex += 1
	EndWhile
	
	FameIndex = 0
	LocationIndex = 0
	
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	While LocationIndex < CustomLocations
		While FameIndex < FameManager.FameType.Length
			PreviousFame = Data.GetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[FameIndex])
			If RandomizeDecayValue == True
				DecayValue = Utility.RandomInt(MinDecay, MaxDecay)
			EndIf
			
			NewFame = PreviousFame - DecayValue
			
			If NewFame > 0
				Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[FameIndex], NewFame)
			Else
				Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[FameIndex], 0)
			EndIf
			
			FameIndex += 1
		EndWhile
		FameIndex = 0
		LocationIndex += 1
	EndWhile
EndEvent

;/
=====================================
========FAME SPREAD LISTENERS========
=====================================
THESE EVENTS WILL TRIGGER FAME SPREAD EITHER VIA THE INTERNAL SPREAD FUNCTION
OR BY MANUAL SPREAD TO AND FROM THE SPECIFIED LOCATIONS.
/;

;This event triggers the internal FameSpreadRoll. This will cause fame spreads to Pause if successfull.
Event OnExternalFameSpreadRoll()
	FameManager.SpreadFameRoll()
EndEvent

;This event forces a fame spread from the defined location, as long as the location is valid
Event OnExternalFameSpread(Location SpreadFromLocation)
	If SpreadFromLocation == None
		Debug.Trace("SLSF Reloaded - ExternalFameSpread - Location is None.")
		return
	EndIf
	
	String LocationName = LocationManager.FetchLocationName(SpreadFromLocation)
	If LocationManager.IsLocationValid(LocationName) == True
		FameManager.SpreadFame(LocationName)
	Else
		Debug.Trace("SLSF Reloaded - ExternalFameSpread - Location is Invalid.")
	EndIf
EndEvent

Event OnExternalFameSpreadByName(String SpreadFromLocation)
	If SpreadFromLocation == "NULL" || SpreadFromLocation == "-EMPTY-" || SpreadFromLocation == ""
		Debug.Trace("SLSF Reloaded - ExternalFameSpread - Location is None.")
		return
	EndIf
	
	If LocationManager.IsLocationValid(SpreadFromLocation) == True
		FameManager.SpreadFame(SpreadFromLocation)
	Else
		Debug.Trace("SLSF Reloaded - ExternalFameSpread - Location is Invalid.")
	EndIf
EndEvent

;/
You MUST define all aspects of this event. There are not reasonable defaults.
PercentToSpread minimum is 10. If it is lower than 10, it will be set to 10. Maximum PercentToSpread is 100.
Please do not change these minimums and maximums.
/;

Event OnExternalManualFameSpread(String SpreadFromLocation, String SpreadToLocation, String Category, Int PercentToSpread)
	If LocationManager.IsLocationValid(SpreadFromLocation) == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameSpread - SpreadFromLocation is Invalid.")
		return
	EndIf
	
	If LocationManager.IsLocationValid(SpreadToLocation) == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameSpread - SpreadToLocation is Invalid.")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int FameIndex = FameManager.FameType.Find(Category)
	If FameIndex >= 0 && FameIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameSpread - Fame Category " + Category + " is Invalid.")
		return
	EndIf
	
	If Data.GetFameValue(SpreadFromLocation, Category) < 10
		Debug.Trace("SLSF Reloaded - ExternalManualFameSpread - Fame Value is too low. Cannot Spread Fame.")
		return
	EndIf
	
	If PercentToSpread < 10
		PercentToSpread = 10
	EndIf
	
	If PercentToSpread > 100
		PercentToSpread = 100
	EndIf
	
	Int PreviousFame = Data.GetFameValue(SpreadToLocation, Category)
	Int FameSpreadValue = (Data.GetFameValue(SpreadFromLocation, Category) * (PercentToSpread / 100)) as Int
	Int NewFame = PreviousFame + FameSpreadValue
	
	If NewFame < 150
		Data.SetFameValue(SpreadToLocation, Category, NewFame)
	Else
		Data.SetFameValue(SpreadToLocation, Category, 150)
	EndIf
EndEvent

;/
===============================================
========LOCATION REGISTRATION LISTENERS========
===============================================
THESE EVENTS ALLOW YOU TO MANUALLY REGISTER OR UNREGISTER LOCATIONS VIA MOD EVENT
PLEASE DO NOT TRY TO INCREASE THE CUSTOM LOCATION ARRAY SIZE!
TOO MANY LOCATIONS WILL BOG DOWN THE SCRIPT!
21 CUSTOM LOCATIONS SHOULD BE PLENTY!
/;

;Pass a Location Form value to this event
Event OnExternalLocationRegister(Form LocationToRegister)
	Location LocationForm = LocationToRegister as Location
	If LocationForm == None
		Debug.Trace("SLSF Reloaded - ExternalLocationRegister - Location is NONE.")
		return
	Else
		String LocationName = LocationManager.FetchLocationName(LocationForm)
		If LocationManager.LocationCanBeRegistered(LocationName, True) == True
			LocationManager.RegisterCustomLocationExternal(LocationName, LocationForm)
		EndIf
	EndIf
EndEvent

;The following events are similar to above, but remove the location instead
Event OnExternalLocationUnregister(Form LocationToUnregister)
	Location LocationForm = LocationToUnregister as Location
	If LocationForm == None
		Debug.Trace("SLSF Reloaded - ExternalLocationUnregister - Location is NONE.")
		return
	Else
		String LocationName = LocationManager.FetchLocationName(LocationForm)
		LocationManager.UnregisterCustomLocationExternal(LocationName)
	EndIf
EndEvent

;/
==============================
========FLAG LISTENERS========
==============================
These listeners allow you to manually set Fame flags, which will enable the periodic check
to increase fame based on your mod's internal state.
In order to prevent conflicts, these flags are filtered by mod name.
Therefore, you must send the NAME of your mod in a string and the BOOLEAN for that category.

TRUE means that you want to enable fame gains for that category from your mod

FALSE means you want to disable fame gains for that category from your mod
(this will NOT overrule this mod's internal conditions, and if another mod is still enabling fame gains for that category it will remain enabled)
/;

Event OnExternalSlutFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Slut", Flag)
EndEvent

Event OnExternalWhoreFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Whore", Flag)
EndEvent

Event OnExternalExhibitionistFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Exhibitionist", Flag)
EndEvent

Event OnExternalOralFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Oral", Flag)
EndEvent

Event OnExternalAnalFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Anal", Flag)
EndEvent

Event OnExternalNastyFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Nasty", Flag)
EndEvent

Event OnExternalPregnantFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Pregnant", Flag)
EndEvent

Event OnExternalDominantFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Dominant", Flag)
EndEvent

Event OnExternalSubmissiveFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Submissive", Flag)
EndEvent

Event OnExternalSadistFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Sadist", Flag)
EndEvent

Event OnExternalMasochistFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Masochist", Flag)
EndEvent

Event OnExternalGentleFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Gentle", Flag)
EndEvent

Event OnExternalLikesMenFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Likes Men", Flag)
EndEvent

Event OnExternalLikesWomenFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Likes Women", Flag)
EndEvent

Event OnExternalLikesOrcFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Likes Orc", Flag)
EndEvent

Event OnExternalLikesKhajiitFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Likes Khajiit", Flag)
EndEvent

Event OnExternalLikesArgonianFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Likes Argonian", Flag)
EndEvent

Event OnExternalBestialityFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Bestiality", Flag)
EndEvent

Event OnExternalGroupFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Group", Flag)
EndEvent

Event OnExternalBoundFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Bound", Flag)
EndEvent

Event OnExternalTattooFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Tattoo", Flag)
EndEvent

Event OnExternalCumDumpFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Cum Dump", Flag)
EndEvent

Event OnExternalUnfaithfulFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Unfaithful", Flag)
EndEvent

Event OnExternalCuckFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Cuck", Flag)
EndEvent

Event OnExternalAirheadFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Airhead", Flag)
EndEvent

Event OnExternalWhoreEventFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Whore Event", Flag)
EndEvent

;/
==============================
========DATA LISTENERS========
==============================

You can use these events to pull data from SLSF Reloaded without making it a Hard dependency
/;

;You must specify if you want the STRICT location (the current cell) or not. If Strict = False, then it will return the first valid Fame Location, if any.
;In either case, you may get a return of "None" if the location is unknown or invalid for fame.
Event OnRequestLocation(Bool Strict)
	String LocationToReturn = ""
	
	If Strict == False
		LocationToReturn = LocationManager.CurrentLocationName()
		;returns None if the location is not valid for fame
	Else
		LocationToReturn = LocationManager.FetchLocationName(LocationManager.CurrentLocation)
		;returns None if there is no location value specified in the current cell
	EndIf
	
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_ReturnRequestedLocation")
	ModEvent.PushString(EventHandle, LocationToReturn)
	ModEvent.Send(EventHandle)
EndEvent

Event OnRequestFame(String LocationName, String Category)
	If LocationName == "Current"
		LocationName = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(LocationName) == False
		Debug.Trace("SLSF Reloaded - External Fame Request Location Invalid")
		return
	EndIf
	
	If FameManager.FameType.Find(Category) < 0 || FameManager.FameType.Find(Category) > FameManager.FameType.Length
		Debug.Trace("SLSF Reloaded - External Fame Request Category Invalid")
		return
	EndIf
	
	Int RequestedFame = Data.GetFameValue(LocationName, Category)
	
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_ReturnRequestedFame")
	ModEvent.PushString(EventHandle, LocationName)
	ModEvent.PushString(EventHandle, Category)
	ModEvent.PushInt(EventHandle, RequestedFame)
	ModEvent.Send(EventHandle)
EndEvent

Event OnRequestCumVisibility(String CumLocation)
	Bool OralVisible = VisibilityManager.IsOralCumVisible()
	Bool AnalVisible = VisibilityManager.IsAssCumVisible()
	Bool VaginalVisible = VisibilityManager.IsVaginalCumVisible()
	
	Bool Result = False
	
	If CumLocation == "Oral"
		Result = OralVisible
	ElseIf CumLocation == "Anal"
		Result = AnalVisible
	ElseIf CumLocation == "Vaginal"
		Result = VaginalVisible
	ElseIf CumLocation == "Any"
		If OralVisible == True || AnalVisible == True || VaginalVisible == True
			Result = True
		EndIf
	EndIf
	
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_ReturnRequestedCum")
	ModEvent.PushBool(EventHandle, Result)
	ModEvent.Send(EventHandle)
EndEvent