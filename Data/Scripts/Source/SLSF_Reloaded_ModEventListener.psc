ScriptName SLSF_Reloaded_ModEventListener extends Quest

Import JsonUtil

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Event OnInit()
	RegisterExternalEvents()
EndEvent

Event OnPlayerLoadGame()
	RegisterExternalEvents()
EndEvent

Function RegisterExternalEvents()
	;AUTOMATED FAME INCREASE LISTENERS
	RegisterForModEvent("SLSF_Reloaded_SendFameGainRoll", "OnExternalFameGainRoll")
	RegisterForModEvent("SLSF_Reloaded_SendSlutFameGain", "OnExternalSlutGain")
	RegisterForModEvent("SLSF_Reloaded_SendWhoreFameGain", "OnExternalWhoreGain")
	RegisterForModEvent("SLSF_Reloaded_SendExhibitionistFameGain", "OnExternalExhibitionistGain")
	RegisterForModEvent("SLSF_Reloaded_SendOralFameGain", "OnExternalOralGain")
	RegisterForModEvent("SLSF_Reloaded_SendAnalFameGain", "OnExternalAnalGain")
	RegisterForModEvent("SLSF_Reloaded_SendNastyFameGain", "OnExternalNastyGain")
	RegisterForModEvent("SLSF_Reloaded_SendPregnantFameGain", "OnExternalPregnantGain")
	RegisterForModEvent("SLSF_Reloaded_SendDominantFameGain", "OnExternalDominantGain")
	RegisterForModEvent("SLSF_Reloaded_SendSubmissiveFameGain", "OnExternalSubmissiveGain")
	RegisterForModEvent("SLSF_Reloaded_SendSadistFameGain", "OnExternalSadistGain")
	RegisterForModEvent("SLSF_Reloaded_SendMasochistFameGain", "OnExternalMasochistGain")
	RegisterForModEvent("SLSF_Reloaded_SendGentleFameGain", "OnExternalGentleGain")
	RegisterForModEvent("SLSF_Reloaded_SendLikesMenFameGain", "OnExternalLikesMenGain")
	RegisterForModEvent("SLSF_Reloaded_SendLikesWomenFameGain", "OnExternalLikesWomenGain")
	RegisterForModEvent("SLSF_Reloaded_SendLikesOrcFameGain", "OnExternalLikesOrcGain")
	RegisterForModEvent("SLSF_Reloaded_SendLikesKhajiitFameGain", "OnExternalLikesKhajiitGain")
	RegisterForModEvent("SLSF_Reloaded_SendLikesArgonianFameGain", "OnExternalLikesArgonianGain")
	RegisterForModEvent("SLSF_Reloaded_SendBestialityFameGain", "OnExternalBestialityGain")
	RegisterForModEvent("SLSF_Reloaded_SendGroupFameGain", "OnExternalGroupGain")
	RegisterForModEvent("SLSF_Reloaded_SendBoundFameGain", "OnExternalBoundGain")
	RegisterForModEvent("SLSF_Reloaded_SendTattooFameGain", "OnExternalTattooGain")
	RegisterForModEvent("SLSF_Reloaded_SendCumDumpFameGain", "OnExternalCumDumpGain")
	
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
	RegisterForModEvent("SLSF_Reloaded_SendLocationRegisterByName", "OnExternalLocationRegisterByName")
	RegisterForModEvent("SLSF_Reloaded_SendLocationUnregister", "OnExternalLocationUnregister")
	RegisterForModEvent("SLSF_Reloaded_SendLocationUnregisterByName", "OnExternalLocationUnregisterByName")
EndFunction

;/
=================================================
========AUTOMATED FAME INCREASE LISTENERS========
=================================================

USE THESE TO PERFORM ONE-TIME FAME INCREASES VIA THE INTERNAL FUNCTIONS. USE THESE CAREFULLY SO FAME DOESN'T SPIRAL OUT OF CONTROL

==PARAMETERS/ARGUMENTS==
EventLocation = YOU MUST MANUALLY DEFINE A LOCATION NAME, OTHERWISE THE EVENT WILL FAIL

MinFame       = YOU MAY MANUALLY DEFINE A MINIMUM FAME VALUE THAT YOUR EVENT NEEDS BEFORE IT STARTS AFFECTING FAME. DEFAULT IS 0

MaxFame       = YOU MAY MANUALLY DEFINE A MAXIMUM FAME VALUE THAT YOUR EVENT CAN REACH BEFORE IT STOPS AFFECTING FAME. DEFAULT IS 150

==HOW TO WRITE YOUR MOD EVENT PROPERLY==
Example - Sending an event with default variables:

Int Handle = ModEvent.Create("SLSF_Reloaded_SendSlutFameGain")
ModEvent.Send(Handle)

Example - Sending an event with one or more edited variables:

Int Handle = ModEvent.Create("SLSF_Reloaded_SendSlutFameGain")
ModEvent.PushString(Handle, "Whiterun")
ModEvent.PushInt(Handle, 100)
ModEvent.Send(Handle)

NOTE: You MUST send the variables in the correct order in the 'ModEvent.Push' lines:
Parameter 1 (left-most parameter)
Parameter 2 (First parameter right of Parameter 1)
[and so on...]
/;

Event OnExternalFameGainRoll(String EventLocation)
	FameManager.FameGainRoll(EventLocation, True)
EndEvent

Event OnExternalSlutGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("External Slut Gain Event Location is Invalid")
	ElseIf GetIntValue(FameManager.JsonFileString, "Slut Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Slut Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Slut", EventLocation)
	EndIf
EndEvent

Event OnExternalWhoreGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Whore Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Whore Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Whore", EventLocation)
	EndIf
EndEvent

Event OnExternalExhibitionistGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Exhibitionist Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Exhibitionist Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Exhibitionist", EventLocation)
	EndIf
EndEvent

Event OnExternalOralGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Oral Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Oral Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Oral", EventLocation)
	EndIf
EndEvent

Event OnExternalAnalGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Anal Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Anal Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Anal", EventLocation)
	EndIf
EndEvent

Event OnExternalNastyGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Nasty Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Nasty Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Nasty", EventLocation)
	EndIf
EndEvent

Event OnExternalPregnantGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Pregnant Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Pregnant Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Pregnant", EventLocation)
	EndIf
EndEvent

Event OnExternalDominantGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Dominant Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Dominant Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Dominant", EventLocation)
	EndIf
EndEvent

Event OnExternalSubmissiveGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Submissive Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Submissive Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Submissive", EventLocation)
	EndIf
EndEvent

Event OnExternalSadistGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Sadist Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Sadist Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Sadist", EventLocation)
	EndIf
EndEvent

Event OnExternalMasochistGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Masochist Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Masochist Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Masochist", EventLocation)
	EndIf
EndEvent

Event OnExternalGentleGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Gentle Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Gentle Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Gentle", EventLocation)
	EndIf
EndEvent

Event OnExternalLikesMenGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Likes Men Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Likes Men Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Likes Men", EventLocation)
	EndIf
EndEvent

Event OnExternalLikesWomenGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Likes Women Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Likes Women Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Likes Women", EventLocation)
	EndIf
EndEvent

Event OnExternalLikesOrcGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Likes Orc Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Likes Orc Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Likes Orc", EventLocation)
	EndIf
EndEvent

Event OnExternalLikesKhajiitGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Likes Khajiit Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Likes Khajiit Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Likes Khajiit", EventLocation)
	EndIf
EndEvent

Event OnExternalLikesArgonianGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Likes Argonian Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Likes Argonian Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Likes Argonian", EventLocation)
	EndIf
EndEvent

Event OnExternalBestialityGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Bestiality Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Bestiality Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Bestiality", EventLocation)
	EndIf
EndEvent

Event OnExternalGroupGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Group Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Group Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Group", EventLocation)
	EndIf
EndEvent

Event OnExternalBoundGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Bound Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Bound Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Bound", EventLocation)
	EndIf
EndEvent

Event OnExternalTattooGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Tattoo Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Tattoo Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Tattoo", EventLocation)
	EndIf
EndEvent

Event OnExternalCumDumpGain(String EventLocation, Int MinFame = 0, Int MaxFame = 150)
	If GetIntValue(FameManager.JsonFileString, "Cum Dump Fame: " + EventLocation) >= MinFame && GetIntValue(FameManager.JsonFileString, "Cum Dump Fame: " + EventLocation) < MaxFame
		FameManager.GainFame("Cum Dump", EventLocation)
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
The location will default to the player's current location if not specified. If location is invalid, the event fails.
If the category is not specified, or is not a valid category, the event will fail.
If Minimums and Maximums are not specified, they default to 1. If the Minimum is higher than the Maximum, it will apply the Minimum.
If either are below 0, they will set to 0. If either are above 150, they will set to 150. If increase is not possible, event fails.
If the Minimum and Maximums are different, it will randomly pick a number between those values to increase.
/;

Event OnExternalManualFameGain(String EventLocation, String Category = "NULL", Int MinIncrease = 1, Int MaxIncrease = 1)
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameGain - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	If Category == "NULL"
		Debug.Trace("SLSF Reloaded - ExternalManualFameGain - Category is NULL")
		return
	Else
		Int CategoryIndex = 0
		Bool ValidCategoryFound = False
		While CategoryIndex < FameManager.FameType.Length && ValidCategoryFound == False
			If Category == FameManager.FameType[CategoryIndex]
				ValidCategoryFound = True
			EndIf
			CategoryIndex += 1
		EndWhile
		
		If ValidCategoryFound == False
			Debug.Trace("SLSF Reloaded - ExternalManualFameGain - Fame Category " + Category + " is Invalid.")
			return
		EndIf
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
	
	Int IncreaseValue = 0
	If MinIncrease >= MaxIncrease
		IncreaseValue = MinIncrease
	Else
		IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
	EndIf
	
	If GetIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation) < 150
		AdjustIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation, IncreaseValue)
	EndIf
	
	If GetIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation) > 150
		SetIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation, 150)
	EndIf
EndEvent

;/
This event will increase all fame categories in a specific location. Functions similarly to the above event.
/;

Event OnExternalManualFameGainAllInLocation(String EventLocation, Int MinIncrease = 1, Int MaxIncrease = 1)
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
	
	Int FameIndex = 0
	While FameIndex < FameManager.FameType.Length
		If RandomizeIncreaseValue == True
			IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
		EndIf
		
		If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation) < 150
			AdjustIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation, IncreaseValue)
		EndIf
		
		If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation) > 150
			SetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation, 150)
		EndIf
		
		FameIndex += 1
	EndWhile
EndEvent

;/
This event will increase all fame categories in ALL registered locations. Functions similarly to the above event.
MAKE SURE YOU KNOW WHAT YOU'RE DOING HERE! THIS COULD SKYROCKET A CHARACTER'S FAME AND MAKE IT HARD TO DECREASE!
/;

Event OnExternalManualFameGainAll(Int MinIncrease = 1, Int MaxIncrease = 1)
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
	
	Int FameIndex = 0
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		While FameIndex < FameManager.FameType.Length
			If RandomizeIncreaseValue == True
				IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex]) < 150
				AdjustIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex], IncreaseValue)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex]) > 150
				SetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex], 150)
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
			If RandomizeIncreaseValue == True
				IncreaseValue = Utility.RandomInt(MinIncrease, MaxIncrease)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex]) < 150
				AdjustIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex], IncreaseValue)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex]) > 150
				SetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex], 150)
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
If Minimums and Maximums are not specified, they default to 1. If the Minimum is higher than the Maximum, it will apply the Minimum.
If either are below 0, they will set to 0. If either are above 150, they will set to 150. If decay is not possible, event fails.
If the Minimum and Maximums are different, it will randomly pick a number between those values to decay.
/;

Event OnExternalManualFameDecay(String EventLocation, String Category = "NULL", Int MinDecay = 1, Int MaxDecay = 1)
	If LocationManager.IsLocationValid(EventLocation) == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Fame Location " + EventLocation + " is Invalid.")
		return
	EndIf
	
	If Category == "NULL"
		Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Category is NULL")
		return
	Else
		Int CategoryIndex = 0
		Bool ValidCategoryFound = False
		While CategoryIndex < FameManager.FameType.Length && ValidCategoryFound == False
			If Category == FameManager.FameType[CategoryIndex]
				ValidCategoryFound = True
			EndIf
			CategoryIndex += 1
		EndWhile
		
		If ValidCategoryFound == False
			Debug.Trace("SLSF Reloaded - ExternalManualFameDecay - Fame Category " + Category + " is Invalid.")
			return
		EndIf
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
	
	If GetIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation) > 0
		AdjustIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation, -DecayValue)
	EndIf
	
	If GetIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation) < 0
		SetIntValue(FameManager.JsonFileString, Category + " Fame: " + EventLocation, 0)
	EndIf
EndEvent

;/
This event will decay all fame categories in a specific location. Functions similarly to the above event.
/;

Event OnExternalManualFameDecayAllInLocation(String EventLocation, Int MinDecay = 1, Int MaxDecay = 1)
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
	
	Int FameIndex = 0
	While FameIndex < FameManager.FameType.Length
		If RandomizeDecayValue == True
			DecayValue = Utility.RandomInt(MinDecay, MaxDecay)
		EndIf
		
		If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation) > 0
			AdjustIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation, -DecayValue)
		EndIf
		
		If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation) < 0
			SetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + EventLocation, 0)
		EndIf
		
		FameIndex += 1
	EndWhile
EndEvent

;/
This event will decay all fame categories in ALL registered locations. Functions similarly to the above event.
MAKE SURE YOU KNOW WHAT YOU'RE DOING HERE! THIS COULD EFFECTIVELY WIPE ALL FAME FOR A CHARACTER!
/;

Event OnExternalManualFameDecayAll(Int MinDecay = 1, Int MaxDecay = 1)
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
	
	Int FameIndex = 0
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		While FameIndex < FameManager.FameType.Length
			If RandomizeDecayValue == True
				DecayValue = Utility.RandomInt(MinDecay, MaxDecay)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex]) > 0
				AdjustIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex], -DecayValue)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex]) < 0
				SetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex], 0)
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
			If RandomizeDecayValue == True
				DecayValue = Utility.RandomInt(MinDecay, MaxDecay)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex]) > 0
				AdjustIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex], -DecayValue)
			EndIf
			
			If GetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex]) < 0
				SetIntValue(FameManager.JsonFileString, FameManager.FameType[FameIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex], 0)
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
Event OnExternalFameSpread(Location SpreadFromLocation = None)
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

Event OnExternalFameSpreadByName(String SpreadFromLocation = "NULL")
	If SpreadFromLocation == "NULL" || SpreadFromLocation == "-EMPTY-"
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
	
	Int FameIndex = 0
	Bool CategoryIsValid = False
	While FameIndex < FameManager.FameType.Length && CategoryIsValid == False
		If Category == FameManager.FameType[FameIndex]
			CategoryIsValid = True
		EndIf
		FameIndex += 1
	EndWhile
	
	If CategoryIsValid == False
		Debug.Trace("SLSF Reloaded - ExternalManualFameSpread - Fame Category is Invalid.")
		return
	EndIf
	
	If GetIntValue(FameManager.JsonFileString, Category + " Fame: " + SpreadFromLocation) < 10
		Debug.Trace("SLSF Reloaded - ExternalManualFameSpread - Fame Value is too low. Cannot Spread Fame.")
		return
	EndIf
	
	If PercentToSpread < 10
		PercentToSpread = 10
	EndIf
	
	If PercentToSpread > 100
		PercentToSpread = 100
	EndIf
	
	Int FameSpreadValue = (GetIntValue(FameManager.JsonFileString, Category + " Fame: " + SpreadFromLocation) * (PercentToSpread / 100)) as Int
	AdjustIntValue(FameManager.JsonFileString, Category + " Fame: " + SpreadToLocation, FameSpreadValue)
	
	If GetIntValue(FameManager.JsonFileString, Category + " Fame: " + SpreadToLocation) > 150
		SetIntValue(FameManager.JsonFileString, Category + " Fame: " + SpreadToLocation, 150)
	EndIf
EndEvent

;/
===============================================
========LOCATION REGISTRATION LISTENERS========
===============================================
THESE EVENTS ALLOW YOU TO MANUALLY REGISTER OR UNREGISTER LOCATIONS VIA MOD EVENT
PLEASE DO NOT TRY TO INCREASE THE CUSTOM LOCATION ARRAY SIZE!
TOO MANY LOCATIONS WILL BOG DOWN THE SCRIPT!
20 CUSTOM LOCATIONS SHOULD BE PLENTY!
THE INTERNAL FUNCTIONS ASSUME THE CUSTOM LOCATION ARRAY IS LIMITED TO 20!
/;

;Pass a Location value to this event
Event OnExternalLocationRegister(Location LocationToRegister = None)
	If LocationToRegister == None
		Debug.Trace("SLSF Reloaded - ExternalLocationRegister - Location is NONE.")
		return
	Else
		String LocationName = LocationManager.FetchLocationName(LocationToRegister)
		If LocationManager.LocationCanBeRegistered(LocationName, True) == True
			LocationManager.RegisterCustomLocationExternal(LocationName)
		EndIf
	EndIf
EndEvent

;Pass a String value to this event. Please be careful! Misspelled locations will successfully register but will be effectively useless.
;Please use this event responsibly.
Event OnExternalLocationRegisterByName(String LocationToRegister = "NULL")
	If LocationToRegister == "NULL" || LocationToRegister == "-EMPTY-"
		Debug.Trace("SLSF Reloaded - ExternalLocationRegisterByName - Location is NULL.")
		return
	Else
		If LocationManager.LocationCanBeRegistered(LocationToRegister, True) == True
			LocationManager.RegisterCustomLocationExternal(LocationToRegister)
		EndIf
	EndIf
EndEvent

;The following events are similar to above, but remove the location instead
Event OnExternalLocationUnregister(Location LocationToUnregister = None)
	If LocationToUnregister == None
		Debug.Trace("SLSF Reloaded - ExternalLocationUnregister - Location is NONE.")
		return
	Else
		String LocationName = LocationManager.FetchLocationName(LocationToUnregister)
		LocationManager.UnregisterCustomLocationExternal(LocationName)
	EndIf
EndEvent

Event OnExternalLocationUnregisterByName(String LocationToUnregister = "NULL")
	If LocationToUnregister == "NULL" || LocationToUnregister == "-EMPTY-"
		Debug.Trace("SLSF Reloaded - ExternalLocationUnregisterByName - Location is NULL.")
		return
	Else
		LocationManager.UnregisterCustomLocationExternal(LocationToUnregister)
	EndIf
EndEvent