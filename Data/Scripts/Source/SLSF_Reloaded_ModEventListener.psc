ScriptName SLSF_Reloaded_ModEventListener extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_DynamicAnonymity Property Anonymity Auto
SLSF_Reloaded_Logger Property Logger Auto

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
	
	;MOD REGISTRATION LISTENERS
	RegisterForModEvent("SLSF_Reloaded_RegisterMod", "OnExternalModRegister")
	RegisterForModEvent("SLSF_Reloaded_UnregisterMod", "OnExternalModUnregister")
	
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
	RegisterForModEvent("SLSF_Reloaded_SetWhoreEventFlag", "OnExternalWhoreEventFlag") ;DEPRECATED - Use Sex Woker flag instead
	RegisterForModEvent("SLSF_Reloaded_SetSexWorkerFlag", "OnExternalSexWorkerFlag") ;Used specifically for checking if a Sexlab Event should give Whore fame
	RegisterForModEvent("SLSF_Reloaded_EnableFameType", "OnEnableFameType")
	
	;DATA LISTENERS
	RegisterForModEvent("SLSF_Reloaded_RequestLocation", "OnRequestLocation")
	RegisterForModEvent("SLSF_Reloaded_RequestRecognitionTime", "OnRequestRecognitionTime")
	RegisterForModEvent("SLSF_Reloaded_RequestFame", "OnRequestFame")
	RegisterForModEvent("SLSF_Reloaded_RequestCumVisibility", "OnRequestCumVisibility")
	RegisterForModEvent("SLSF_Reloaded_RequestFlagState", "OnRequestFlagState")
	RegisterForModEvent("SLSF_Reloaded_RequestModFlagState", "OnRequestModFlagState")
	RegisterForModEvent("SLSF_Reloaded_RequestModRegisterState", "OnRequestModRegisterState")
EndFunction

;/
============================================
========VALID LOCATION LIST (STRING)========
============================================
[Default Locations - In no particular order]

[Major Locations]
Whiterun
Windhelm |or| Eastmarch
Winterhold
Markarth |or| the Reach
Riften |or| the Rift
Solitude |or| Haafingar
Morthal |or| Hjaalmarch
Dawnstar |or| the Pale
Falkreath

[Minor Locations]
Raven Rock
Riverwood
Rorikstead
Ivarstead
Shor's Stone
Dragon Bridge
Karthwasten
Skaal Village
Largashbur
Dushnikh Yal
Mor Khazgur
Narzulbur

[Custom Locations need to be specified by their location name string.]
[Use SLSF_Reloaded_RequestLocation to find and verify that information,
or manually register the location with SLSF_Reloaded_SendLocationRegister]
[Recommend extensive testing for custom locations.]

==============================================
========VALID FAME CATEGORIES (STRING)========
==============================================
[In no particular order]

Slut
Whore
Exhibitionist
Oral
Anal
Nasty
Pregnant
Group
Dominant
Submissive
Sadist
Masochist
Gentle
Likes Men
Likes Women
Likes Orc
Likes Khajiit
Likes Argonian
Bestiality
Bound - Requires Devious Devices
Tattoo - Requires Slave Tats
Cum Dump - Requires Fill Her Up Baka Edition
Unfaithful - Requires Fame Comments
Cuck - Requires Fame Comments
Airhead - Requires Bimbos of Skyrim
/;

;/
=================================================
========AUTOMATED FAME INCREASE LISTENERS========
=================================================

USE THESE TO PERFORM ONE-TIME FAME INCREASES VIA THE INTERNAL FUNCTIONS. USE THESE CAREFULLY SO FAME DOESN'T SPIRAL OUT OF CONTROL

==PARAMETERS/ARGUMENTS==
EventLocation = YOU MUST MANUALLY DEFINE A LOCATION NAME. THE LOCATION MUST BE VALID OTHERWISE THE EVENT WILL FAIL
[Use "Current" for the player's current location - will fail if the player's location is invalid. This is fine.]

MinFame       = YOU MUST MANUALLY DEFINE A MINIMUM FAME VALUE THAT YOUR EVENT NEEDS BEFORE IT STARTS AFFECTING FAME.

MaxFame       = YOU MUST MANUALLY DEFINE A MAXIMUM FAME VALUE THAT YOUR EVENT CAN REACH BEFORE IT STOPS AFFECTING FAME.

==HOW TO WRITE YOUR MOD EVENT PROPERLY==
Example:

Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendFameGain") ;ModEvent.Create should ALWAYS be the first line for each event
ModEvent.PushString(EventHandle, "Slut") ;Our Category
ModEvent.PushString(EventHandle, "Whiterun") ;Our Location Name (in English)
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


;This event manually triggers the internal Fame Gain Roll event (aka the same event from a Periodic increase)
Event OnExternalFameGainRoll(String EventLocation)
	If EventLocation == "Current"
		EventLocation = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(EventLocation) == False
		SLSF_Reloaded_Logger.Log("External Fame Gain Event Location is Invalid")
		return
	EndIf
	
	FameManager.FameGainRoll(EventLocation, True)
EndEvent

;This event manually triggers the internal Fame Gain function for a location and category
;MinFame means the player NEEDS AT LEAST that much fame or it will fail
;MaxFame means the player NEEDS LESS THAN that much fame or it will fail
Event OnExternalFameGain(String Category, String EventLocation, Int MinFame, Int MaxFame)
	If EventLocation == "Current"
		EventLocation = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(EventLocation) == False
		SLSF_Reloaded_Logger.Log("External Fame Gain Event Location is Invalid")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int CategoryIndex = FameManager.FameType.Find(Category)
	If CategoryIndex >= 0 && CategoryIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameGain - Fame Category " + Category + " is Invalid.")
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
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameGain - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int CategoryIndex = FameManager.FameType.Find(Category)
	If CategoryIndex >= 0 && CategoryIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameGain - Fame Category " + Category + " is Invalid.")
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
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameGain - Gain is only 0")
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
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - OnExternalManualFameGainAllInLocation - Fame Location " + EventLocation + " is Invalid.")
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
	If MinIncrease >= MaxIncrease
		IncreaseValue = MinIncrease
		RandomizeIncreaseValue = False
	EndIf
	
	If MinIncrease == 0 && MaxIncrease == 0
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecay - Decay Value is 0")
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
	If MinIncrease >= MaxIncrease
		IncreaseValue = MinIncrease
		RandomizeIncreaseValue = False
	EndIf
	
	If MinIncrease == 0 && MaxIncrease == 0
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecay - Decay Value is 0")
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
If location is invalid, the event fails. Use "Current" if you want to use the player's current location.

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
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecay - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int CategoryIndex = FameManager.FameType.Find(Category)
	If CategoryIndex >= 0 && CategoryIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecay - Fame Category " + Category + " is Invalid.")
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
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecay - Decay Value is 0")
		return
	EndIf
	
	Int DecayValue = 0
	If MinDecay >= MaxDecay
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
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecayAllInLocation - Fame Location " + EventLocation + " is Invalid.")
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
	If MinDecay >= MaxDecay
		DecayValue = MinDecay
		RandomizeDecayValue = False
	EndIf
	
	If MinDecay == 0 && MaxDecay == 0
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecayAllInLocation - Decay Value is 0")
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
	If MinDecay >= MaxDecay
		DecayValue = MinDecay
		RandomizeDecayValue = False
	EndIf
	
	If MinDecay == 0 && MaxDecay == 0
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameDecayAll - Decay Value is 0")
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
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalFameSpread - Location is None.")
		return
	EndIf
	
	String LocationName = LocationManager.FetchLocationName(SpreadFromLocation)
	If LocationManager.IsLocationValid(LocationName) == True
		FameManager.SpreadFame(LocationName)
	Else
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalFameSpread - Location is Invalid.")
	EndIf
EndEvent

Event OnExternalFameSpreadByName(String SpreadFromLocation)
	If SpreadFromLocation == "NULL" || SpreadFromLocation == "-EMPTY-" || SpreadFromLocation == ""
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalFameSpread - Location is None.")
		return
	EndIf
	
	If LocationManager.IsLocationValid(SpreadFromLocation) == True
		FameManager.SpreadFame(SpreadFromLocation)
	Else
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalFameSpread - Location is Invalid.")
	EndIf
EndEvent

;/
PercentToSpread minimum is 10. If it is lower than 10, it will be set to 10. Maximum PercentToSpread is 100.
Please do not change these minimums and maximums.
/;

Event OnExternalManualFameSpread(String SpreadFromLocation, String SpreadToLocation, String Category, Int PercentToSpread)
	If LocationManager.IsLocationValid(SpreadFromLocation) == False
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameSpread - SpreadFromLocation is Invalid.")
		return
	EndIf
	
	If LocationManager.IsLocationValid(SpreadToLocation) == False
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameSpread - SpreadToLocation is Invalid.")
		return
	EndIf
	
	Bool ValidCategoryFound = False
	Int FameIndex = FameManager.FameType.Find(Category)
	If FameIndex >= 0 && FameIndex < FameManager.FameType.Length
		ValidCategoryFound = True
	EndIf
	
	If ValidCategoryFound == False
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameSpread - Fame Category " + Category + " is Invalid.")
		return
	EndIf
	
	If Data.GetFameValue(SpreadFromLocation, Category) < 10
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalManualFameSpread - Fame Value is too low. Cannot Spread Fame.")
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
Event OnExternalLocationRegister(Location LocationToRegister)
	If LocationToRegister == None
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalLocationRegister - Location is NONE.")
		return
	Else
		String LocationName = LocationManager.FetchLocationName(LocationToRegister)
		If LocationManager.LocationCanBeRegistered(LocationName, True) == True
			LocationManager.RegisterCustomLocationExternal(LocationName, LocationToRegister)
		EndIf
	EndIf
EndEvent

;The following events are similar to above, but remove the location instead
Event OnExternalLocationUnregister(Location LocationToUnregister)
	If LocationToUnregister == None
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - ExternalLocationUnregister - Location is NONE.")
		return
	Else
		String LocationName = LocationManager.FetchLocationName(LocationToUnregister)
		LocationManager.UnregisterCustomLocationExternal(LocationName)
	EndIf
EndEvent

;/
==========================================
========MOD REGISTRATION LISTENERS========
==========================================

The register function allows your mod to send Flags to SLSF Reloaded for Periodic Fame gains

YOU MUST SEND THE NAME OF YOUR PLUGIN INCLUDING ".esp"/".esl"/".esm"

Example:

Int EventHandle = ModEvent.Create("SLSF_Reloaded_RegisterMod")
ModEvent.PushString("SLSF Reloaded.esp")
ModEvent.Send(EventHandle)

If your mod has an uninstall function, it is recommended to include the Unregistration function with your mod!

If your mod is otherwise uninstalled, it will still purge your mod from the registry.

Example:

Int EventHandle = ModEvent.Create("SLSF_Reloaded_UnregisterMod")
ModEvent.PushString("SLSF Reloaded.esp")
ModEvent.Send(EventHandle)

/;

Event OnExternalModRegister(String ModName = "-EMPTY-")
	If ModName == "-EMPTY-"
		SLSF_Reloaded_Logger.Log("SLSF Reloaded Mod Register: Cannot Register EMPTY.")
		return
	EndIf
	Data.RegisterExternalMod(ModName)
EndEvent

Event OnExternalModUnregister(String ModName = "-EMPTY-")
	If ModName == "-EMPTY-"
		SLSF_Reloaded_Logger.Log("SLSF Reloaded Mod Unregister: Cannot Unregister EMPTY.")
		return
	EndIf
	Data.UnregisterExternalMod(ModName)
EndEvent

;/
==============================
========FLAG LISTENERS========
==============================
These listeners allow you to manually set Fame flags, which will enable the periodic check
to increase fame based on whatever you decide. They also allow you to re-enable certain fame
types if your mod requires them via the 'SLSF_Reloaded_EnableFameType' ModEvent

In order to prevent conflicts, these flags are filtered by plugin name, with a maximum of 100 different plugins that can set flags.

YOU MUST REGISTER YOUR MOD WITH SLSF RELOADED FIRST!!! SEE ABOVE EXAMPLE!!!

Therefore, you must send the PLUGIN NAME of your mod in a string and the BOOLEAN for that category.

TRUE means that you want to enable fame gains for that category from your mod
(This WILL overrule the mod's internal conditions)

FALSE means you want to disable fame gains for that category from your mod
(This WILL NOT overrule this mod's internal conditions, and if another mod is still enabling fame gains for that category it will remain enabled.)

Example (enable Slut Flag):

Int EventHandle = ModEvent.Create("SLSF_Reloaded_SetSlutFlag")
ModEvent.PushString("SLSF Reloaded.esp")
ModEvent.PushBool(True)
ModEvent.Send(EventHandle)

Example (disable Slut Flag):

Int EventHandle = ModEvent.Create("SLSF_Reloaded_SetSlutFlag")
ModEvent.PushString("SLSF Reloaded.esp")
ModEvent.PushBool(False)
ModEvent.Send(EventHandle)

Example (enable Cum Dump fame even if the user doesn't have Fill Her Up installed):

Int EventHandle = ModEvent.Create("SLSF_Reloaded_EnableFameType")
ModEvent.PushString("Cum Dump")
ModEvent.PushString("SLSF Reloaded.esp")
ModEvent.PushBool(True)
ModEvent.Send(EventHandle)
/;

Event OnExternalSlutFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Slut", Flag)
EndEvent

;This only gives PERIODIC Whore Fame. If you want sex acts to give Whore Fame instead of Slut Fame, use "Whore Event Flag".
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

;DEPRECATED - The Whore Event flag turns any potential "Slut" fame from SEX ACTS - aka from Sexlab Animations - into Whore fame. Useful for prostitution mods not inherently used by SLSF Reloaded.
Event OnExternalWhoreEventFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Sex Worker", Flag)
EndEvent

;The Sex Worker flag turns any potential "Slut" fame from SEX ACTS - aka from Sexlab Animations - into Whore fame. Useful for prostitution mods not inherently used by SLSF Reloaded.
Event OnExternalSexWorkerFlag(String ModName, Bool Flag)
	Data.SetExternalFlags(ModName, "Sex Worker", Flag)
EndEvent

Event OnEnableFameType(String FameType, String ModName, Bool Flag)
	If FameType == "Cum Dump"
		Data.SetExternalFlags(ModName, "EnableCumDump", Flag)
	ElseIf FameType == "Cuck"
		Data.SetExternalFlags(ModName, "EnableCuck", Flag)
	ElseIf FameType == "Unfaithful"
		Data.SetExternalFlags(ModName, "EnableUnfaithful", Flag)
	ElseIf FameType == "Airhead"
		Data.SetExternalFlags(ModName, "EnableAirhead", Flag)
	EndIf
EndEvent

;/
==============================
========DATA LISTENERS========
==============================

You can use these events to pull data from SLSF Reloaded without making it a Hard dependency, and are useful for debugging your mod
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

Event OnRequestRecognitionTime(String FameLocation)
	Float RecognitionTime = 0.0
	
	If FameLocation == "Current"
		FameLocation = LocationManager.CurrentLocationName()
	EndIf
	
	Int LocationIndex = LocationManager.DefaultLocation.Find(FameLocation)
	
	If LocationIndex >= 0
		RecognitionTime = Anonymity.DefaultLocationRecognitionTime[LocationIndex]
	Else
		LocationIndex = LocationManager.CustomLocation.Find(FameLocation)
		If LocationIndex >= 0
			RecognitionTime = Anonymity.CustomLocationRecognitionTime[LocationIndex]
		Else
			Debug.Trace("SLSF Reloaded - Location " + FameLocation + " does not exist or was not registered as a Custom Location")
			return
		EndIf
	EndIf
	
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_ReturnRecognitionTime")
	ModEvent.PushFloat(EventHandle, RecognitionTime)
	ModEvent.Send(EventHandle)
EndEvent

Event OnRequestFame(String LocationName, String Category)
	If LocationName == "Current"
		LocationName = LocationManager.CurrentLocationName()
	EndIf
	
	If LocationManager.IsLocationValid(LocationName) == False
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - External Fame Request Location Invalid")
		return
	EndIf
	
	If FameManager.FameType.Find(Category) < 0 || FameManager.FameType.Find(Category) > FameManager.FameType.Length
		SLSF_Reloaded_Logger.Log("SLSF Reloaded - External Fame Request Category Invalid")
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

;Get the Flag State for SLSF Reloaded
Event OnRequestFlagState(String FlagName)
	Bool RequestedFlagState = Data.GetExternalFlags(FlagName)
	String FlagExists = Data.DoesFlagExist(FlagName)
	
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_ReturnFlagState")
	ModEvent.PushString(EventHandle, FlagName) ;Sends back the Flag Name you requested the State for
	ModEvent.PushString(EventHandle, FlagExists) ;Tells you if the Flag exists - Useful in case you misspelled the Flag Name. If the Flag does not exist, the Flag State will be False
	ModEvent.PushBool(EventHandle, RequestedFlagState) ;Will return TRUE if ANY mod has set it to true
	ModEvent.Send(EventHandle)
EndEvent

;Get the Flag State from a specific mod - ModName MUST be the PLUGIN NAME (Example: "mrt_SimpleProstitution.esp")
Event OnRequestModFlagState(String ModName, String FlagName)
	Bool RequestedModFlagState = Data.GetModFlagState(ModName, FlagName)
	String FlagExists = Data.DoesFlagExist(FlagName)
	Bool IsModRegistered = Data.IsModRegistered(ModName)
	
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_ReturnModFlagState")
	ModEvent.PushString(EventHandle, ModName) ;Sends back the mod name you requested the Flag State for
	ModEvent.PushBool(EventHandle, IsModRegistered) ;True if the mod is Registered - If False, maybe you misspelled your plugin name or forgot to register it?
	ModEvent.PushString(EventHandle, FlagName) ;Sends back your requested Flag Name
	ModEvent.PushString(EventHandle, FlagExists) ;Tells you if the Flag exists - Useful in case you misspelled
	ModEvent.PushBool(EventHandle, RequestedModFlagState) ;State of the flag you requested - False if the mod is not registered or if the flag does not exist
	ModEvent.Send(EventHandle)
EndEvent

;This will tell you if the mod is registered with SLSF Reloaded or not
Event OnRequestModRegisterState(String ModName)
	Bool IsModRegistered = Data.IsModRegistered(ModName)
	
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_ReturnModRegisteredState")
	ModEvent.PushString(EventHandle, ModName)
	ModEvent.PushBool(EventHandle, IsModRegistered)
	ModEvent.Send(EventHandle)
EndEvent