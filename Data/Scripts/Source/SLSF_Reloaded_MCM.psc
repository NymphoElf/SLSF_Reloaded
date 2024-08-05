ScriptName SLSF_Reloaded_MCM extends SKI_ConfigBase

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto

Bool Property NPCNeedsLOS Auto
Bool Property ReduceFameAtNight Auto
Bool Property NotifyFameIncrease Auto
Bool Property NotifyFameDecay Auto
Bool Property NotifyFameSpread Auto
Bool Property PlayerIsAnonymous Auto
Bool Property AnonymityEnabled Auto
Bool Property RegisterLocationTrigger Auto
Bool Property RegisterLocationConfirm Auto
Bool Property UnregisterLocationTrigger Auto
Bool Property UnregisterLocationConfirm Auto
Bool Property ClearAllFameTrigger Auto
Bool Property ClearAllFameConfirm Auto

Bool[] Property HasFameAtDefaultLocation Auto
Bool[] Property HasFameAtCustomLocation Auto

Float Property NightStart Auto
Float Property NightEnd Auto
Float Property FailedSpreadIncrease Auto
Float Property SuccessfulSpreadReduction Auto
Float Property MinimumFameToSpread Auto
Float Property MaximumSpreadCategories Auto
Float Property MaximumSpreadPercentage Auto
Float Property DecayTimeNeeded Auto
Float Property SpreadTimeNeeded Auto
Float Property FameChanceByEnemy Auto
Float Property FameChanceByNeutral Auto
Float Property FameChanceByFriend Auto
Float Property FameChanceByLover Auto

Int[] Property DefaultLocationSpreadChance Auto
Int[] Property CustomLocationSpreadChance Auto

Float Property FameChangeMultiplier Auto
Float Property MinimumNPCLOSDistance Auto

String Property LocationDetailsSelected Auto
String Property UnregisterLocationSelection Auto
Int Property UnregisterLocationIndex Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

;/
EXTERNAL MOD EVENT TESTING VARIABLES
/;

Bool SendFameGainRoll = False
Bool SendSlutFameGain = False
Bool SendWhoreFameGain = False
Bool SendExhibitionistFameGain = False
Bool SendOralFameGain = False
Bool SendAnalFameGain = False
Bool SendNastyFameGain = False
Bool SendPregnantFameGain = False
Bool SendDominantFameGain = False
Bool SendSubmissiveFameGain = False
Bool SendSadistFameGain = False
Bool SendMasochistFameGain = False
Bool SendGentleFameGain = False
Bool SendLikesMenFameGain = False
Bool SendLikesWomenFameGain = False
Bool SendLikesOrcFameGain = False
Bool SendLikesKhajiitFameGain = False
Bool SendLikesArgonianFameGain = False
Bool SendBestialityFameGain = False
Bool SendGroupFameGain = False
Bool SendBoundFameGain = False
Bool SendTattooFameGain = False
Bool SendCumDumpFameGain = False

Bool SendManualFameGain = False
Bool SendManualFameGainAllInLocation = False
Bool SendManualFameGainAll = False
String ManualFameGainCategory = "NULL"

Bool SendFameDecay = False
Bool SendManualFameDecay = False
Bool SendManualFameDecayAllInLocation = False
Bool SendManualFameDecayAll = False
String ManualFameDecayCategory = "NULL"

Bool SendFameSpreadRoll = False
Bool SendFameSpread = False
Bool SendFameSpreadByName = False
Bool SendManualFameSpread = False
String SpreadFameCategory = "NULL"
String SendSpreadFromLocation = "NULL"
String SendSpreadToLocation = "NULL"

Bool SendLocationRegister = False
Bool SendLocationRegisterByName = False
Bool SendLocationUnregister = False
Bool SendLocationUnregisterByName = False
String LocationToRegisterByName = "NULL"
String LocationToUnregisterByName = "NULL"

Event OnConfigInit()
	Utility.Wait(1.0)
	Debug.Notification("SLSF Reloaded MCM Initializing...")
	RegisterForSingleUpdate(1)
EndEvent

Event OnUpdate()
	InstallMCM()
	SetDefaults()
	Debug.Notification("SLSF Reloaded MCM Ready!")
EndEvent

Function InstallMCM()
	ModName = "SLSF Reloaded"
	Pages = New String[9]
	Pages[0] = "Fame Overview"
	Pages[1] = "Detailed Fame View"
	Pages[2] = "Settings"
	Pages[3] = "Tattoos"
	Pages[4] = "Custom Locations"
	Pages[5] = "Beta Info - General"
	Pages[6] = "Beta Info - Decay"
	Pages[7] = "Beta Info - Spread"
	Pages[8] = "External Mod Events"
EndFunction

Function SetDefaults()
	NPCNeedsLOS = True
	ReduceFameAtNight = True
	NotifyFameIncrease = False
	NotifyFameDecay = False
	NotifyFameSpread = False
	PlayerIsAnonymous = False
	AnonymityEnabled = True
	
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		HasFameAtDefaultLocation[LocationIndex] = False
		DefaultLocationSpreadChance[LocationIndex] = 30
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	While LocationIndex < LocationManager.CustomLocation.Length
		HasFameAtCustomLocation[LocationIndex] = False
		CustomLocationSpreadChance[LocationIndex] = 30
		LocationIndex += 1
	EndWhile
	
	NightStart = 22
	NightEnd = 6
	FailedSpreadIncrease = 10
	SuccessfulSpreadReduction = 10
	MinimumFameToSpread = 30
	MaximumSpreadCategories = 5
	MaximumSpreadPercentage = 30
	DecayTimeNeeded = 24
	SpreadTimeNeeded = 48
	FameChanceByEnemy = 100
	FameChanceByNeutral = 75
	FameChanceByFriend = 50
	FameChanceByLover = 25
	
	FameChangeMultiplier = 1.0
	MinimumNPCLOSDistance = 160.0
	
	RegisterLocationTrigger = False
	RegisterLocationConfirm = False
	UnregisterLocationTrigger = False
	UnregisterLocationConfirm = False
	
	UnregisterLocationSelection = "NONE"
	
	ClearAllFameConfirm = False
	ClearAllFameTrigger = False
	
	LocationDetailsSelected = "Whiterun"
EndFunction

Function FameOverviewCheck()
	Int LocationIndex = 0
	Int TypeIndex = 0
	Bool HasFameInLocation = False
	While LocationIndex < LocationManager.DefaultLocation.Length
		Debug.Trace("FameOverviewCheck - Location: " + LocationManager.DefaultLocation[LocationIndex])
		While TypeIndex < FameManager.FameType.Length && HasFameInLocation == False
			Debug.Trace("FameOverviewCheck - Fame Type: " + FameManager.FameType[TypeIndex])
			If Data.GetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[TypeIndex]) > 0
				HasFameInLocation = True
				HasFameAtDefaultLocation[LocationIndex] = True
			EndIf
			TypeIndex += 1
		EndWhile
		
		If HasFameInLocation == False
			HasFameAtDefaultLocation[LocationIndex] = False
		EndIf
		
		HasFameInLocation = False
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	TypeIndex = 0
	HasFameInLocation = False
	
	While LocationIndex < LocationManager.CustomLocation.Length
		Debug.Trace("FameOverviewCheck - Location: " + LocationManager.DefaultLocation[LocationIndex])
		While TypeIndex < FameManager.FameType.Length && HasFameInLocation == False
			Debug.Trace("FameOverviewCheck - Fame Type: " + FameManager.FameType[TypeIndex])
			If Data.GetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[TypeIndex]) > 0
				HasFameInLocation = True
				HasFameAtCustomLocation[LocationIndex] = True
			EndIf
			TypeIndex += 1
		EndWhile
		
		If HasFameInLocation == False
			HasFameAtCustomLocation[LocationIndex] = False
		EndIf
		
		HasFameInLocation = False
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
EndFunction

Int Function PullFameSpreadChance(String LocationName)
	Int DefaultLocationIndex = LocationManager.DefaultLocation.Find(LocationName)
	Int CustomLocationIndex = LocationManager.CustomLocation.Find(LocationName)
	If DefaultLocationIndex >= 0
		return DefaultLocationSpreadChance[DefaultLocationIndex]
	ElseIf CustomLocationIndex >= 0
		return CustomLocationSpreadChance[CustomLocationIndex]
	EndIf
	return -1
EndFunction

Event OnConfigOpen()
	Pages = New String[9]
	Pages[0] = "Fame Overview"
	Pages[1] = "Detailed Fame View"
	Pages[2] = "Settings"
	Pages[3] = "Tattoos"
	Pages[4] = "Custom Locations"
	Pages[5] = "Beta Info - General"
	Pages[6] = "Beta Info - Decay"
	Pages[7] = "Beta Info - Spread"
	Pages[8] = "External Mod Events"
	VisibilityManager.CheckAppliedTattoos()
EndEvent

Event OnConfigClose()
	RegisterLocationTrigger = False
	RegisterLocationConfirm = False
	UnregisterLocationTrigger = False
	UnregisterLocationConfirm = False
	UnregisterLocationSelection = "NONE"
EndEvent

Event OnPageReset(String page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	If (page == "" || page == "Fame Overview")
		FameOverviewCheck()
		
		AddHeaderOption("Default Locations With Fame")
		AddTextOption(LocationManager.DefaultLocation[0], HasFameAtDefaultLocation[0] as String)
		AddTextOption(LocationManager.DefaultLocation[1], HasFameAtDefaultLocation[1] as String)
		AddTextOption(LocationManager.DefaultLocation[2], HasFameAtDefaultLocation[2] as String)
		AddTextOption(LocationManager.DefaultLocation[3], HasFameAtDefaultLocation[3] as String)
		AddTextOption(LocationManager.DefaultLocation[4], HasFameAtDefaultLocation[4] as String)
		AddTextOption(LocationManager.DefaultLocation[5], HasFameAtDefaultLocation[5] as String)
		AddTextOption(LocationManager.DefaultLocation[6], HasFameAtDefaultLocation[6] as String)
		AddTextOption(LocationManager.DefaultLocation[7], HasFameAtDefaultLocation[7] as String)
		AddTextOption(LocationManager.DefaultLocation[8], HasFameAtDefaultLocation[8] as String)
		AddTextOption(LocationManager.DefaultLocation[9], HasFameAtDefaultLocation[9] as String)
		AddTextOption(LocationManager.DefaultLocation[10], HasFameAtDefaultLocation[10] as String)
		AddTextOption(LocationManager.DefaultLocation[11], HasFameAtDefaultLocation[11] as String)
		AddTextOption(LocationManager.DefaultLocation[12], HasFameAtDefaultLocation[12] as String)
		AddTextOption(LocationManager.DefaultLocation[13], HasFameAtDefaultLocation[13] as String)
		AddTextOption(LocationManager.DefaultLocation[14], HasFameAtDefaultLocation[14] as String)
		AddTextOption(LocationManager.DefaultLocation[15], HasFameAtDefaultLocation[15] as String)
		AddTextOption(LocationManager.DefaultLocation[16], HasFameAtDefaultLocation[16] as String)
		AddTextOption(LocationManager.DefaultLocation[17], HasFameAtDefaultLocation[17] as String)
		AddTextOption(LocationManager.DefaultLocation[18], HasFameAtDefaultLocation[18] as String)
		AddTextOption(LocationManager.DefaultLocation[19], HasFameAtDefaultLocation[19] as String)
		AddTextOption(LocationManager.DefaultLocation[20], HasFameAtDefaultLocation[20] as String)
		
		SetCursorPosition(1)
		AddHeaderOption("Custom Locations With Fame")
		AddTextOption(LocationManager.CustomLocation[0], HasFameAtCustomLocation[0] as String)
		AddTextOption(LocationManager.CustomLocation[1], HasFameAtCustomLocation[1] as String)
		AddTextOption(LocationManager.CustomLocation[2], HasFameAtCustomLocation[2] as String)
		AddTextOption(LocationManager.CustomLocation[3], HasFameAtCustomLocation[3] as String)
		AddTextOption(LocationManager.CustomLocation[4], HasFameAtCustomLocation[4] as String)
		AddTextOption(LocationManager.CustomLocation[5], HasFameAtCustomLocation[5] as String)
		AddTextOption(LocationManager.CustomLocation[6], HasFameAtCustomLocation[6] as String)
		AddTextOption(LocationManager.CustomLocation[7], HasFameAtCustomLocation[7] as String)
		AddTextOption(LocationManager.CustomLocation[8], HasFameAtCustomLocation[8] as String)
		AddTextOption(LocationManager.CustomLocation[9], HasFameAtCustomLocation[9] as String)
		AddTextOption(LocationManager.CustomLocation[10], HasFameAtCustomLocation[10] as String)
		AddTextOption(LocationManager.CustomLocation[11], HasFameAtCustomLocation[11] as String)
		AddTextOption(LocationManager.CustomLocation[12], HasFameAtCustomLocation[12] as String)
		AddTextOption(LocationManager.CustomLocation[13], HasFameAtCustomLocation[13] as String)
		AddTextOption(LocationManager.CustomLocation[14], HasFameAtCustomLocation[14] as String)
		AddTextOption(LocationManager.CustomLocation[15], HasFameAtCustomLocation[15] as String)
		AddTextOption(LocationManager.CustomLocation[16], HasFameAtCustomLocation[16] as String)
		AddTextOption(LocationManager.CustomLocation[17], HasFameAtCustomLocation[17] as String)
		AddTextOption(LocationManager.CustomLocation[18], HasFameAtCustomLocation[18] as String)
		AddTextOption(LocationManager.CustomLocation[19], HasFameAtCustomLocation[19] as String)
	ElseIf (page == "Detailed Fame View")
		AddHeaderOption("Current Location")
		AddTextOption("Detected Location:", LocationManager.CurrentLocation.GetName())
		AddTextOption("Fame Location:", LocationManager.CurrentLocationName())
		
		SetCursorPosition(1)
		AddHeaderOption("Selected Location")
		AddMenuOptionST("SLSF_Reloaded_LocationDetailsState", "Showing: ", LocationDetailsSelected, 0)
		AddTextOption("Location Chance to Spread:", PullFameSpreadChance(LocationDetailsSelected) + "%")
		
		SetCursorPosition(6)
		AddHeaderOption("")
		SetCursorPosition(7)
		AddHeaderOption("")
		
		SetCursorPosition(8)
		AddTextOption("Slut Fame: ", Data.GetFameValue(LocationDetailsSelected, "Slut") as String)
		AddTextOption("Whore Fame: ", Data.GetFameValue(LocationDetailsSelected, "Whore") as String)
		AddTextOption("Exhibitionist Fame: ", Data.GetFameValue(LocationDetailsSelected, "Exhibitionist") as String)
		AddTextOption("Oral Fame: ", Data.GetFameValue(LocationDetailsSelected, "Oral") as String)
		AddTextOption("Anal Fame: ", Data.GetFameValue(LocationDetailsSelected, "Anal") as String)
		AddTextOption("Nasty Fame: ", Data.GetFameValue(LocationDetailsSelected, "Nasty") as String)
		AddTextOption("Pregnant Fame: ", Data.GetFameValue(LocationDetailsSelected, "Pregnant") as String)
		AddTextOption("Dominant Fame: ", Data.GetFameValue(LocationDetailsSelected, "Dominant") as String)
		AddTextOption("Submissive Fame: ", Data.GetFameValue(LocationDetailsSelected, "Submissive") as String)
		AddTextOption("Sadist Fame: ", Data.GetFameValue(LocationDetailsSelected, "Sadist") as String)
		AddTextOption("Masochist Fame: ", Data.GetFameValue(LocationDetailsSelected, "Masochist") as String)
		
		If Mods.IsFameCommentsInstalled == True
			AddTextOption("Unfaithful Fame:", Data.GetFameValue(LocationDetailsSelected, "Unfaithful") as String)
		EndIf
		
		SetCursorPosition(9)
		AddTextOption("Gentle Fame: ", Data.GetFameValue(LocationDetailsSelected, "Gentle") as String)
		AddTextOption("Likes Men Fame: ", Data.GetFameValue(LocationDetailsSelected, "Likes Men") as String)
		AddTextOption("Likes Women Fame: ", Data.GetFameValue(LocationDetailsSelected, "Likes Women") as String)
		AddTextOption("Likes Orc Fame: ", Data.GetFameValue(LocationDetailsSelected, "Likes Orc") as String)
		AddTextOption("Likes Khajiit Fame: ", Data.GetFameValue(LocationDetailsSelected, "Likes Khajiit") as String)
		AddTextOption("Likes Argonian Fame: ", Data.GetFameValue(LocationDetailsSelected, "Likes Argonian") as String)
		AddTextOption("Bestiality Fame: ", Data.GetFameValue(LocationDetailsSelected, "Bestiality") as String)
		AddTextOption("Group Fame: ", Data.GetFameValue(LocationDetailsSelected, "Group") as String)
		AddTextOption("Bound Fame: ", Data.GetFameValue(LocationDetailsSelected, "Bound") as String)
		AddTextOption("Tattoo Fame: ", Data.GetFameValue(LocationDetailsSelected, "Tattoo") as String)
		AddTextOption("Cum Dump Fame: ", Data.GetFameValue(LocationDetailsSelected, "Cum Dump") as String)
		
		If Mods.IsFameCommentsInstalled == True
			AddTextOption("Cuck Fame:", Data.GetFameValue(LocationDetailsSelected, "Cuck") as String)
		EndIf
	
	ElseIf (page == "Settings")
		AddHeaderOption("General Settings")
		AddToggleOptionST("SLSF_Reloaded_PlayerAnonymousState", "Player Can Be Anonymous", AnonymityEnabled, 0)
		AddToggleOptionST("SLSF_Reloaded_NPCNeedsLOSState", "NPCs Need Line of Sight", NPCNeedsLOS, 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumNPCLOSDistanceState", "Minimum NPC Distance for LOS:", MinimumNPCLOSDistance as Int, "{0}", GetDisabledOptionFlagIf(NPCNeedsLOS == False))
		AddToggleOptionST("SLSF_Reloaded_ReduceFameAtNightState", "Reduce Fame Gain at Night", ReduceFameAtNight, 0)
		AddSliderOptionST("SLSF_Reloaded_NightStartState", "Night Starts at:", NightStart, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		AddSliderOptionST("SLSF_Reloaded_NightEndState", "Night Ends at:", NightEnd, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		AddSliderOptionST("SLSF_Reloaded_FameChangeMultiplierState", "Fame Change Multiplier:", FameChangeMultiplier, "{1}", 0)
		
		AddHeaderOption("Fame Gain Settings")
		AddSliderOptionST("SLSF_Reloaded_FameChanceByEnemyState", "Enemy Fame Chance", FameChanceByEnemy, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByNeutralState", "Neutral Fame Chance", FameChanceByNeutral, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByFriendState", "Friend Fame Chance", FameChanceByFriend, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByLoverState", "Lover Fame Chance", FameChanceByLover, "{0}%", 0)
		
		AddHeaderOption("Reset Fame")
		AddToggleOptionST("SLSF_Reloaded_ClearAllFameState", "Clear All Fame", ClearAllFameTrigger, 0)
		AddToggleOptionST("SLSF_Reloaded_ClearAllFameConfirmState", "Confirm Clear All Fame", ClearAllFameConfirm, GetDisabledOptionFlagIf(ClearAllFameTrigger == False))
		
		SetCursorPosition(1)
		AddHeaderOption("Notification Toggles")
		AddToggleOptionST("SLSF_Reloaded_NotifyFameIncreaseState", "Notify on Fame Increase", NotifyFameIncrease, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameDecayState", "Notify on Fame Decay", NotifyFameDecay, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameSpreadState", "Notify on Fame Spread", NotifyFameSpread, 0)
		
		AddHeaderOption("Fame Decay Settings")
		AddSliderOptionST("SLSF_Reloaded_DecayTimeNeededState", "Time Between Decays (Hours):", (DecayTimeNeeded / 2), "{0}", 0)
		
		AddHeaderOption("Fame Spread Settings")
		AddSliderOptionST("SLSF_Reloaded_SpreadTimeNeededState", "Time Between Spreads (Hours):", (SpreadTimeNeeded / 2), "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_FailedSpreadIncreaseState", "Chance Increase on Fail:", FailedSpreadIncrease, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_SuccessfulSpreadDecreaseState", "Chance Decrease on Success:", SuccessfulSpreadReduction, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumFameToSpreadState", "Minimum Fame to Spread:", MinimumFameToSpread, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadCategoriesState", "Maximum Spread Categories:", MaximumSpreadCategories, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadPercentageState", "Maximum Spread Percentage:", MaximumSpreadPercentage, "{0}%", 0)
	
	ElseIf (page == "Tattoos")
		AddHeaderOption("Body Tattoos")
		AddMenuOptionST("SLSF_Reloaded_BodySlot1FameState", "Slot 1 Fame Type: ", VisibilityManager.BodyTattooExtraFameType[0], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[0] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlot1SubcategoryState", "Slot 1 Subcategory: ", VisibilityManager.BodyTattooSubcategory[0], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[0] == False))
		
		AddMenuOptionST("SLSF_Reloaded_BodySlot2FameState", "Slot 2 Fame Type: ", VisibilityManager.BodyTattooExtraFameType[1], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[1] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlot2SubcategoryState", "Slot 2 Subcategory: ", VisibilityManager.BodyTattooSubcategory[1], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[1] == False))
		
		AddMenuOptionST("SLSF_Reloaded_BodySlot3FameState", "Slot 3 Fame Type: ", VisibilityManager.BodyTattooExtraFameType[2], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[2] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlot3SubcategoryState", "Slot 3 Subcategory: ", VisibilityManager.BodyTattooSubcategory[2], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[2] == False))
		
		AddMenuOptionST("SLSF_Reloaded_BodySlot4FameState", "Slot 4 Fame Type: ", VisibilityManager.BodyTattooExtraFameType[3], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[3] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlot4SubcategoryState", "Slot 4 Subcategory: ", VisibilityManager.BodyTattooSubcategory[3], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[3] == False))
		
		AddMenuOptionST("SLSF_Reloaded_BodySlot5FameState", "Slot 5 Fame Type: ", VisibilityManager.BodyTattooExtraFameType[4], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[4] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlot5SubcategoryState", "Slot 5 Subcategory: ", VisibilityManager.BodyTattooSubcategory[4], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[4] == False))
		
		AddMenuOptionST("SLSF_Reloaded_BodySlot6FameState", "Slot 6 Fame Type: ", VisibilityManager.BodyTattooExtraFameType[5], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[5] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlot6SubcategoryState", "Slot 6 Subcategory: ", VisibilityManager.BodyTattooSubcategory[5], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[5] == False))
		
		AddHeaderOption("Face Tattoos")
		AddMenuOptionST("SLSF_Reloaded_FaceSlot1FameState", "Slot 1 Fame Type: ", VisibilityManager.FaceTattooExtraFameType[0], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[0] == False))
		AddMenuOptionST("SLSF_Reloaded_FaceSlot2FameState", "Slot 2 Fame Type: ", VisibilityManager.FaceTattooExtraFameType[1], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[1] == False))
		AddMenuOptionST("SLSF_Reloaded_FaceSlot3FameState", "Slot 3 Fame Type: ", VisibilityManager.FaceTattooExtraFameType[2], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[2] == False))
		AddMenuOptionST("SLSF_Reloaded_FaceSlot4FameState", "Slot 4 Fame Type: ", VisibilityManager.FaceTattooExtraFameType[3], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[3] == False))
		AddMenuOptionST("SLSF_Reloaded_FaceSlot5FameState", "Slot 5 Fame Type: ", VisibilityManager.FaceTattooExtraFameType[4], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[4] == False))
		AddMenuOptionST("SLSF_Reloaded_FaceSlot6FameState", "Slot 6 Fame Type: ", VisibilityManager.FaceTattooExtraFameType[5], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[5] == False))
		
		SetCursorPosition(1)
		AddHeaderOption("Hand Tattoos")
		AddMenuOptionST("SLSF_Reloaded_HandSlot1FameState", "Slot 1 Fame Type: ", VisibilityManager.HandTattooExtraFameType[0], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[0] == False))
		AddMenuOptionST("SLSF_Reloaded_HandSlot2FameState", "Slot 2 Fame Type: ", VisibilityManager.HandTattooExtraFameType[1], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[1] == False))
		AddMenuOptionST("SLSF_Reloaded_HandSlot3FameState", "Slot 3 Fame Type: ", VisibilityManager.HandTattooExtraFameType[2], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[2] == False))
		AddMenuOptionST("SLSF_Reloaded_HandSlot4FameState", "Slot 4 Fame Type: ", VisibilityManager.HandTattooExtraFameType[3], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[3] == False))
		AddMenuOptionST("SLSF_Reloaded_HandSlot5FameState", "Slot 5 Fame Type: ", VisibilityManager.HandTattooExtraFameType[4], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[4] == False))
		AddMenuOptionST("SLSF_Reloaded_HandSlot6FameState", "Slot 6 Fame Type: ", VisibilityManager.HandTattooExtraFameType[5], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[5] == False))
		
		AddHeaderOption("Foot Tattoos")
		AddMenuOptionST("SLSF_Reloaded_FootSlot1FameState", "Slot 1 Fame Type: ", VisibilityManager.FootTattooExtraFameType[0], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[0] == False))
		AddMenuOptionST("SLSF_Reloaded_FootSlot2FameState", "Slot 2 Fame Type: ", VisibilityManager.FootTattooExtraFameType[1], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[1] == False))
		AddMenuOptionST("SLSF_Reloaded_FootSlot3FameState", "Slot 3 Fame Type: ", VisibilityManager.FootTattooExtraFameType[2], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[2] == False))
		AddMenuOptionST("SLSF_Reloaded_FootSlot4FameState", "Slot 4 Fame Type: ", VisibilityManager.FootTattooExtraFameType[3], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[3] == False))
		AddMenuOptionST("SLSF_Reloaded_FootSlot5FameState", "Slot 5 Fame Type: ", VisibilityManager.FootTattooExtraFameType[4], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[4] == False))
		AddMenuOptionST("SLSF_Reloaded_FootSlot6FameState", "Slot 6 Fame Type: ", VisibilityManager.FootTattooExtraFameType[5], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[5] == False))
		
		
	ElseIf (page == "Custom Locations")
		AddHeaderOption("Register Location")
		AddTextOption("Current Location:", LocationManager.CurrentLocationName())
		AddToggleOptionST("SLSF_Reloaded_RegisterLocationState", "Register Location", RegisterLocationTrigger, 0)
		AddToggleOptionST("SLSF_Reloaded_RegisterLocationConfirmState", "Confirm Location Register", RegisterLocationConfirm, GetDisabledOptionFlagIf(RegisterLocationTrigger == False))
		AddHeaderOption("Unregister Location")
		AddMenuOptionST("SLSF_Reloaded_UnregisterLocationSelectState", "Location to Unregister:", UnregisterLocationSelection, 0)
		AddToggleOptionST("SLSF_Reloaded_UnregisterLocationState", "Unregister Location", UnregisterLocationTrigger, GetDisabledOptionFlagIf(UnregisterLocationSelection == "NONE"))
		AddToggleOptionST("SLSF_Reloaded_UnregisterLocationConfirmState", "Confirm Unregister Location", UnregisterLocationConfirm, GetDisabledOptionFlagIf(UnregisterLocationTrigger == False))
		
		SetCursorPosition(1)
		AddHeaderOption("Registered Locations")
		AddTextOption("Slot 1:", LocationManager.CustomLocation[0])
		AddTextOption("Slot 2:", LocationManager.CustomLocation[1])
		AddTextOption("Slot 3:", LocationManager.CustomLocation[2])
		AddTextOption("Slot 4:", LocationManager.CustomLocation[3])
		AddTextOption("Slot 5:", LocationManager.CustomLocation[4])
		AddTextOption("Slot 6:", LocationManager.CustomLocation[5])
		AddTextOption("Slot 7:", LocationManager.CustomLocation[6])
		AddTextOption("Slot 8:", LocationManager.CustomLocation[7])
		AddTextOption("Slot 9:", LocationManager.CustomLocation[8])
		AddTextOption("Slot 10:", LocationManager.CustomLocation[9])
		AddTextOption("Slot 11:", LocationManager.CustomLocation[10])
		AddTextOption("Slot 12:", LocationManager.CustomLocation[11])
		AddTextOption("Slot 13:", LocationManager.CustomLocation[12])
		AddTextOption("Slot 14:", LocationManager.CustomLocation[13])
		AddTextOption("Slot 15:", LocationManager.CustomLocation[14])
		AddTextOption("Slot 16:", LocationManager.CustomLocation[15])
		AddTextOption("Slot 17:", LocationManager.CustomLocation[16])
		AddTextOption("Slot 18:", LocationManager.CustomLocation[17])
		AddTextOption("Slot 19:", LocationManager.CustomLocation[18])
		AddTextOption("Slot 20:", LocationManager.CustomLocation[19])
	
	ElseIf (page == "Beta Info - General")
		AddHeaderOption("Detected Mods")
		If Mods.IsANDInstalled == True
			AddTextOption("Advanced Nudity Detection", "True")
		Else
			AddTextOption("Advanced Nudity Detection", "False")
		EndIf
		
		If Mods.IsDDInstalled == True
			AddTextOption("Devious Devices", "True")
		Else
			AddTextOption("Devious Devices", "False")
		EndIf
		
		If Mods.IsECInstalled == True
			AddTextOption("Estrus Chaurus", "True")
		Else
			AddTextOption("Estrus Chaurus", "False")
		EndIf
		
		If Mods.IsESInstalled == True
			AddTextOption("Estrus Spider", "True")
		Else
			AddTextOption("Estrus Spider", "False")
		EndIf
		
		If Mods.IsPWInstalled == True
			AddTextOption("Public Whore", "True")
		Else
			AddTextOption("Public Whore", "False")
		EndIf
		
		If Mods.IsFMInstalled == True
			AddTextOption("Fertility Mode", "True")
		Else
			AddTextOption("Fertility Mode", "False")
		EndIf
		
		If Mods.IsFHUInstalled == True
			AddTextOption("Fill Her Up", "True")
		Else
			AddTextOption("Fill Her Up", "False")
		EndIf
		
		If Mods.IsSlaveTatsInstalled == True
			AddTextOption("Slave Tats", "True")
		Else
			AddTextOption("Slave Tats", "False")
		EndIf
		
		If Mods.IsSLSInstalled == True
			AddTextOption("Sexlab Survival", "True")
		Else
			AddTextOption("Sexlab Survival", "False")
		EndIf
		
		If Mods.IsFameCommentsInstalled == True
			AddTextOption("SLSF Fame Comments", "True")
		Else
			AddTextOption("SLSF Fame Comments", "False")
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("Detected Conditions")
		AddTextOption("Player is Anonymous:", VisibilityManager.IsPlayerAnonymous() as String)
		AddTextOption("Player is EC Pregnant:", Mods.IsECPregnant(PlayerScript.PlayerRef) as String)
		AddTextOption("Player is ES Pregnant:", Mods.IsESPregnant(PlayerScript.PlayerRef) as String)
		AddTextOption("Player is FM Pregnant:", Mods.IsFMPregnant(PlayerScript.PlayerRef) as String)
		AddTextOption("Player is Public Whore:", Mods.IsPublicWhore(PlayerScript.PlayerRef) as String)
		AddTextOption("Player's FHU Inflation:", Mods.GetFHUInflation(PlayerScript.PlayerRef) as String)
		AddTextOption("Total Visible Tattoos:", VisibilityManager.CountVisibleTattoos() as String)
		
		SetCursorPosition(22)
		AddHeaderOption("Body Tattoo Status")
		AddTextOption("Slot 1 Applied:", VisibilityManager.BodyTattooApplied[0] as String)
		AddTextOption("Slot 1 Visible:", VisibilityManager.IsBodyTattooVisible(0) as String)
		AddTextOption("Slot 1 Subcategory:", VisibilityManager.BodyTattooSubcategory[0])
		
		AddTextOption("Slot 2 Applied:", VisibilityManager.BodyTattooApplied[1] as String)
		AddTextOption("Slot 2 Visible:", VisibilityManager.IsBodyTattooVisible(1) as String)
		AddTextOption("Slot 2 Subcategory:", VisibilityManager.BodyTattooSubcategory[1])
		
		AddTextOption("Slot 3 Applied:", VisibilityManager.BodyTattooApplied[2] as String)
		AddTextOption("Slot 3 Visible:", VisibilityManager.IsBodyTattooVisible(2) as String)
		AddTextOption("Slot 3 Subcategory:", VisibilityManager.BodyTattooSubcategory[2])
		
		AddTextOption("Slot 4 Applied:", VisibilityManager.BodyTattooApplied[3] as String)
		AddTextOption("Slot 4 Visible:", VisibilityManager.IsBodyTattooVisible(3) as String)
		AddTextOption("Slot 4 Subcategory:", VisibilityManager.BodyTattooSubcategory[3])
		
		AddTextOption("Slot 5 Applied:", VisibilityManager.BodyTattooApplied[4] as String)
		AddTextOption("Slot 5 Visible:", VisibilityManager.IsBodyTattooVisible(4) as String)
		AddTextOption("Slot 5 Subcategory:", VisibilityManager.BodyTattooSubcategory[4])
		
		AddTextOption("Slot 6 Applied:", VisibilityManager.BodyTattooApplied[5] as String)
		AddTextOption("Slot 6 Visible:", VisibilityManager.IsBodyTattooVisible(5) as String)
		AddTextOption("Slot 6 Subcategory:", VisibilityManager.BodyTattooSubcategory[5])
		
		AddHeaderOption("Face Tattoo Status")
		AddTextOption("Slot 1 Applied:", VisibilityManager.FaceTattooApplied[0] as String)
		AddTextOption("Slot 1 Visible:", VisibilityManager.IsFaceTattooVisible(0) as String)
		
		AddTextOption("Slot 2 Applied:", VisibilityManager.FaceTattooApplied[1] as String)
		AddTextOption("Slot 2 Visible:", VisibilityManager.IsFaceTattooVisible(1) as String)
		
		AddTextOption("Slot 3 Applied:", VisibilityManager.FaceTattooApplied[2] as String)
		AddTextOption("Slot 3 Visible:", VisibilityManager.IsFaceTattooVisible(2) as String)
		
		AddTextOption("Slot 4 Applied:", VisibilityManager.FaceTattooApplied[3] as String)
		AddTextOption("Slot 4 Visible:", VisibilityManager.IsFaceTattooVisible(3) as String)
		
		AddTextOption("Slot 5 Applied:", VisibilityManager.FaceTattooApplied[4] as String)
		AddTextOption("Slot 5 Visible:", VisibilityManager.IsFaceTattooVisible(4) as String)
		
		AddTextOption("Slot 6 Applied:", VisibilityManager.FaceTattooApplied[5] as String)
		AddTextOption("Slot 6 Visible:", VisibilityManager.IsFaceTattooVisible(5) as String)
		
		SetCursorPosition(23)
		AddHeaderOption("Hand Tattoo Status")
		AddTextOption("Slot 1 Applied:", VisibilityManager.HandTattooApplied[0] as String)
		AddTextOption("Slot 1 Visible:", VisibilityManager.IsHandTattooVisible(0) as String)
		
		AddTextOption("Slot 2 Applied:", VisibilityManager.HandTattooApplied[1] as String)
		AddTextOption("Slot 2 Visible:", VisibilityManager.IsHandTattooVisible(1) as String)
		
		AddTextOption("Slot 3 Applied:", VisibilityManager.HandTattooApplied[2] as String)
		AddTextOption("Slot 3 Visible:", VisibilityManager.IsHandTattooVisible(2) as String)
		
		AddTextOption("Slot 4 Applied:", VisibilityManager.HandTattooApplied[3] as String)
		AddTextOption("Slot 4 Visible:", VisibilityManager.IsHandTattooVisible(3) as String)
		
		AddTextOption("Slot 5 Applied:", VisibilityManager.HandTattooApplied[4] as String)
		AddTextOption("Slot 5 Visible:", VisibilityManager.IsHandTattooVisible(4) as String)
		
		AddTextOption("Slot 6 Applied:", VisibilityManager.HandTattooApplied[5] as String)
		AddTextOption("Slot 6 Visible:", VisibilityManager.IsHandTattooVisible(5) as String)
		
		AddHeaderOption("Foot Tattoo Status")
		AddTextOption("Slot 1 Applied:", VisibilityManager.FootTattooApplied[0] as String)
		AddTextOption("Slot 1 Visible:", VisibilityManager.IsFootTattooVisible(0) as String)
		
		AddTextOption("Slot 2 Applied:", VisibilityManager.FootTattooApplied[1] as String)
		AddTextOption("Slot 2 Visible:", VisibilityManager.IsFootTattooVisible(1) as String)
		
		AddTextOption("Slot 3 Applied:", VisibilityManager.FootTattooApplied[2] as String)
		AddTextOption("Slot 3 Visible:", VisibilityManager.IsFootTattooVisible(2) as String)
		
		AddTextOption("Slot 4 Applied:", VisibilityManager.FootTattooApplied[3] as String)
		AddTextOption("Slot 4 Visible:", VisibilityManager.IsFootTattooVisible(3) as String)
		
		AddTextOption("Slot 5 Applied:", VisibilityManager.FootTattooApplied[4] as String)
		AddTextOption("Slot 5 Visible:", VisibilityManager.IsFootTattooVisible(4) as String)
		
		AddTextOption("Slot 6 Applied:", VisibilityManager.FootTattooApplied[5] as String)
		AddTextOption("Slot 6 Visible:", VisibilityManager.IsFootTattooVisible(5) as String)
	
	ElseIf (page == "Beta Info - Decay")
		AddTextOption("Decay Countdown:", FameManager.DecayCountdown as String)
		AddHeaderOption("Default Locations")
		AddTextOption(LocationManager.DefaultLocation[0] + " Can Decay:", FameManager.DefaultLocationCanDecay[0] as String)
		AddTextOption(LocationManager.DefaultLocation[0] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[0] as String)
		AddTextOption(LocationManager.DefaultLocation[1] + " Can Decay:", FameManager.DefaultLocationCanDecay[1] as String)
		AddTextOption(LocationManager.DefaultLocation[1] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[1] as String)
		AddTextOption(LocationManager.DefaultLocation[2] + " Can Decay:", FameManager.DefaultLocationCanDecay[2] as String)
		AddTextOption(LocationManager.DefaultLocation[2] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[2] as String)
		AddTextOption(LocationManager.DefaultLocation[3] + " Can Decay:", FameManager.DefaultLocationCanDecay[3] as String)
		AddTextOption(LocationManager.DefaultLocation[3] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[3] as String)
		AddTextOption(LocationManager.DefaultLocation[4] + " Can Decay:", FameManager.DefaultLocationCanDecay[4] as String)
		AddTextOption(LocationManager.DefaultLocation[4] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[4] as String)
		AddTextOption(LocationManager.DefaultLocation[5] + " Can Decay:", FameManager.DefaultLocationCanDecay[5] as String)
		AddTextOption(LocationManager.DefaultLocation[5] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[5] as String)
		AddTextOption(LocationManager.DefaultLocation[6] + " Can Decay:", FameManager.DefaultLocationCanDecay[6] as String)
		AddTextOption(LocationManager.DefaultLocation[6] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[6] as String)
		AddTextOption(LocationManager.DefaultLocation[7] + " Can Decay:", FameManager.DefaultLocationCanDecay[7] as String)
		AddTextOption(LocationManager.DefaultLocation[7] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[7] as String)
		AddTextOption(LocationManager.DefaultLocation[8] + " Can Decay:", FameManager.DefaultLocationCanDecay[8] as String)
		AddTextOption(LocationManager.DefaultLocation[8] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[8] as String)
		AddTextOption(LocationManager.DefaultLocation[9] + " Can Decay:", FameManager.DefaultLocationCanDecay[9] as String)
		AddTextOption(LocationManager.DefaultLocation[9] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[9] as String)
		AddTextOption(LocationManager.DefaultLocation[10] + " Can Decay:", FameManager.DefaultLocationCanDecay[10] as String)
		AddTextOption(LocationManager.DefaultLocation[10] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[10] as String)
		AddTextOption(LocationManager.DefaultLocation[11] + " Can Decay:", FameManager.DefaultLocationCanDecay[11] as String)
		AddTextOption(LocationManager.DefaultLocation[11] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[11] as String)
		AddTextOption(LocationManager.DefaultLocation[12] + " Can Decay:", FameManager.DefaultLocationCanDecay[12] as String)
		AddTextOption(LocationManager.DefaultLocation[12] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[12] as String)
		AddTextOption(LocationManager.DefaultLocation[13] + " Can Decay:", FameManager.DefaultLocationCanDecay[13] as String)
		AddTextOption(LocationManager.DefaultLocation[13] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[13] as String)
		AddTextOption(LocationManager.DefaultLocation[14] + " Can Decay:", FameManager.DefaultLocationCanDecay[14] as String)
		AddTextOption(LocationManager.DefaultLocation[14] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[14] as String)
		AddTextOption(LocationManager.DefaultLocation[15] + " Can Decay:", FameManager.DefaultLocationCanDecay[15] as String)
		AddTextOption(LocationManager.DefaultLocation[15] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[15] as String)
		AddTextOption(LocationManager.DefaultLocation[16] + " Can Decay:", FameManager.DefaultLocationCanDecay[16] as String)
		AddTextOption(LocationManager.DefaultLocation[16] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[16] as String)
		AddTextOption(LocationManager.DefaultLocation[17] + " Can Decay:", FameManager.DefaultLocationCanDecay[17] as String)
		AddTextOption(LocationManager.DefaultLocation[17] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[17] as String)
		AddTextOption(LocationManager.DefaultLocation[18] + " Can Decay:", FameManager.DefaultLocationCanDecay[18] as String)
		AddTextOption(LocationManager.DefaultLocation[18] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[18] as String)
		AddTextOption(LocationManager.DefaultLocation[19] + " Can Decay:", FameManager.DefaultLocationCanDecay[19] as String)
		AddTextOption(LocationManager.DefaultLocation[19] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[19] as String)
		AddTextOption(LocationManager.DefaultLocation[20] + " Can Decay:", FameManager.DefaultLocationCanDecay[20] as String)
		AddTextOption(LocationManager.DefaultLocation[20] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[20] as String)
		
		SetCursorPosition(5)
		AddHeaderOption("Custom Locations")
		AddTextOption(LocationManager.CustomLocation[0] + " Can Decay:", FameManager.CustomLocationCanDecay[0] as String)
		AddTextOption(LocationManager.CustomLocation[0] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[0] as String)
		AddTextOption(LocationManager.CustomLocation[1] + " Can Decay:", FameManager.CustomLocationCanDecay[1] as String)
		AddTextOption(LocationManager.CustomLocation[1] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[1] as String)
		AddTextOption(LocationManager.CustomLocation[2] + " Can Decay:", FameManager.CustomLocationCanDecay[2] as String)
		AddTextOption(LocationManager.CustomLocation[2] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[2] as String)
		AddTextOption(LocationManager.CustomLocation[3] + " Can Decay:", FameManager.CustomLocationCanDecay[3] as String)
		AddTextOption(LocationManager.CustomLocation[3] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[3] as String)
		AddTextOption(LocationManager.CustomLocation[4] + " Can Decay:", FameManager.CustomLocationCanDecay[4] as String)
		AddTextOption(LocationManager.CustomLocation[4] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[4] as String)
		AddTextOption(LocationManager.CustomLocation[5] + " Can Decay:", FameManager.CustomLocationCanDecay[5] as String)
		AddTextOption(LocationManager.CustomLocation[5] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[5] as String)
		AddTextOption(LocationManager.CustomLocation[6] + " Can Decay:", FameManager.CustomLocationCanDecay[6] as String)
		AddTextOption(LocationManager.CustomLocation[6] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[6] as String)
		AddTextOption(LocationManager.CustomLocation[7] + " Can Decay:", FameManager.CustomLocationCanDecay[7] as String)
		AddTextOption(LocationManager.CustomLocation[7] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[7] as String)
		AddTextOption(LocationManager.CustomLocation[8] + " Can Decay:", FameManager.CustomLocationCanDecay[8] as String)
		AddTextOption(LocationManager.CustomLocation[8] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[8] as String)
		AddTextOption(LocationManager.CustomLocation[9] + " Can Decay:", FameManager.CustomLocationCanDecay[9] as String)
		AddTextOption(LocationManager.CustomLocation[9] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[9] as String)
		AddTextOption(LocationManager.CustomLocation[10] + " Can Decay:", FameManager.CustomLocationCanDecay[10] as String)
		AddTextOption(LocationManager.CustomLocation[10] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[10] as String)
		AddTextOption(LocationManager.CustomLocation[11] + " Can Decay:", FameManager.CustomLocationCanDecay[11] as String)
		AddTextOption(LocationManager.CustomLocation[11] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[11] as String)
		AddTextOption(LocationManager.CustomLocation[12] + " Can Decay:", FameManager.CustomLocationCanDecay[12] as String)
		AddTextOption(LocationManager.CustomLocation[12] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[12] as String)
		AddTextOption(LocationManager.CustomLocation[13] + " Can Decay:", FameManager.CustomLocationCanDecay[13] as String)
		AddTextOption(LocationManager.CustomLocation[13] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[13] as String)
		AddTextOption(LocationManager.CustomLocation[14] + " Can Decay:", FameManager.CustomLocationCanDecay[14] as String)
		AddTextOption(LocationManager.CustomLocation[14] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[14] as String)
		AddTextOption(LocationManager.CustomLocation[15] + " Can Decay:", FameManager.CustomLocationCanDecay[15] as String)
		AddTextOption(LocationManager.CustomLocation[15] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[15] as String)
		AddTextOption(LocationManager.CustomLocation[16] + " Can Decay:", FameManager.CustomLocationCanDecay[16] as String)
		AddTextOption(LocationManager.CustomLocation[16] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[16] as String)
		AddTextOption(LocationManager.CustomLocation[17] + " Can Decay:", FameManager.CustomLocationCanDecay[17] as String)
		AddTextOption(LocationManager.CustomLocation[17] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[17] as String)
		AddTextOption(LocationManager.CustomLocation[18] + " Can Decay:", FameManager.CustomLocationCanDecay[18] as String)
		AddTextOption(LocationManager.CustomLocation[18] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[18] as String)
		AddTextOption(LocationManager.CustomLocation[19] + " Can Decay:", FameManager.CustomLocationCanDecay[19] as String)
		AddTextOption(LocationManager.CustomLocation[19] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[19] as String)
		
		
	ElseIf (page == "Beta Info - Spread")
		AddTextOption("Spread Countdown:", FameManager.SpreadCountdown as String)
		AddHeaderOption("Default Locations")
		AddTextOption(LocationManager.DefaultLocation[0] + " Can Spread:", FameManager.DefaultLocationCanSpread[0] as String)
		AddTextOption(LocationManager.DefaultLocation[0] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[0] as String)
		AddTextOption(LocationManager.DefaultLocation[1] + " Can Spread:", FameManager.DefaultLocationCanSpread[1] as String)
		AddTextOption(LocationManager.DefaultLocation[1] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[1] as String)
		AddTextOption(LocationManager.DefaultLocation[2] + " Can Spread:", FameManager.DefaultLocationCanSpread[2] as String)
		AddTextOption(LocationManager.DefaultLocation[2] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[2] as String)
		AddTextOption(LocationManager.DefaultLocation[3] + " Can Spread:", FameManager.DefaultLocationCanSpread[3] as String)
		AddTextOption(LocationManager.DefaultLocation[3] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[3] as String)
		AddTextOption(LocationManager.DefaultLocation[4] + " Can Spread:", FameManager.DefaultLocationCanSpread[4] as String)
		AddTextOption(LocationManager.DefaultLocation[4] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[4] as String)
		AddTextOption(LocationManager.DefaultLocation[5] + " Can Spread:", FameManager.DefaultLocationCanSpread[5] as String)
		AddTextOption(LocationManager.DefaultLocation[5] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[5] as String)
		AddTextOption(LocationManager.DefaultLocation[6] + " Can Spread:", FameManager.DefaultLocationCanSpread[6] as String)
		AddTextOption(LocationManager.DefaultLocation[6] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[6] as String)
		AddTextOption(LocationManager.DefaultLocation[7] + " Can Spread:", FameManager.DefaultLocationCanSpread[7] as String)
		AddTextOption(LocationManager.DefaultLocation[7] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[7] as String)
		AddTextOption(LocationManager.DefaultLocation[8] + " Can Spread:", FameManager.DefaultLocationCanSpread[8] as String)
		AddTextOption(LocationManager.DefaultLocation[8] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[8] as String)
		AddTextOption(LocationManager.DefaultLocation[9] + " Can Spread:", FameManager.DefaultLocationCanSpread[9] as String)
		AddTextOption(LocationManager.DefaultLocation[9] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[9] as String)
		AddTextOption(LocationManager.DefaultLocation[10] + " Can Spread:", FameManager.DefaultLocationCanSpread[10] as String)
		AddTextOption(LocationManager.DefaultLocation[10] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[10] as String)
		AddTextOption(LocationManager.DefaultLocation[11] + " Can Spread:", FameManager.DefaultLocationCanSpread[11] as String)
		AddTextOption(LocationManager.DefaultLocation[11] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[11] as String)
		AddTextOption(LocationManager.DefaultLocation[12] + " Can Spread:", FameManager.DefaultLocationCanSpread[12] as String)
		AddTextOption(LocationManager.DefaultLocation[12] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[12] as String)
		AddTextOption(LocationManager.DefaultLocation[13] + " Can Spread:", FameManager.DefaultLocationCanSpread[13] as String)
		AddTextOption(LocationManager.DefaultLocation[13] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[13] as String)
		AddTextOption(LocationManager.DefaultLocation[14] + " Can Spread:", FameManager.DefaultLocationCanSpread[14] as String)
		AddTextOption(LocationManager.DefaultLocation[14] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[14] as String)
		AddTextOption(LocationManager.DefaultLocation[15] + " Can Spread:", FameManager.DefaultLocationCanSpread[15] as String)
		AddTextOption(LocationManager.DefaultLocation[15] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[15] as String)
		AddTextOption(LocationManager.DefaultLocation[16] + " Can Spread:", FameManager.DefaultLocationCanSpread[16] as String)
		AddTextOption(LocationManager.DefaultLocation[16] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[16] as String)
		AddTextOption(LocationManager.DefaultLocation[17] + " Can Spread:", FameManager.DefaultLocationCanSpread[17] as String)
		AddTextOption(LocationManager.DefaultLocation[17] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[17] as String)
		AddTextOption(LocationManager.DefaultLocation[18] + " Can Spread:", FameManager.DefaultLocationCanSpread[18] as String)
		AddTextOption(LocationManager.DefaultLocation[18] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[18] as String)
		AddTextOption(LocationManager.DefaultLocation[19] + " Can Spread:", FameManager.DefaultLocationCanSpread[19] as String)
		AddTextOption(LocationManager.DefaultLocation[19] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[19] as String)
		AddTextOption(LocationManager.DefaultLocation[20] + " Can Spread:", FameManager.DefaultLocationCanSpread[20] as String)
		AddTextOption(LocationManager.DefaultLocation[20] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[20] as String)
		
		SetCursorPosition(5)
		AddHeaderOption("Custom Locations")
		AddTextOption(LocationManager.CustomLocation[0] + " Can Spread:", FameManager.CustomLocationCanSpread[0] as String)
		AddTextOption(LocationManager.CustomLocation[0] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[0] as String)
		AddTextOption(LocationManager.CustomLocation[1] + " Can Spread:", FameManager.CustomLocationCanSpread[1] as String)
		AddTextOption(LocationManager.CustomLocation[1] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[1] as String)
		AddTextOption(LocationManager.CustomLocation[2] + " Can Spread:", FameManager.CustomLocationCanSpread[2] as String)
		AddTextOption(LocationManager.CustomLocation[2] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[2] as String)
		AddTextOption(LocationManager.CustomLocation[3] + " Can Spread:", FameManager.CustomLocationCanSpread[3] as String)
		AddTextOption(LocationManager.CustomLocation[3] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[3] as String)
		AddTextOption(LocationManager.CustomLocation[4] + " Can Spread:", FameManager.CustomLocationCanSpread[4] as String)
		AddTextOption(LocationManager.CustomLocation[4] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[4] as String)
		AddTextOption(LocationManager.CustomLocation[5] + " Can Spread:", FameManager.CustomLocationCanSpread[5] as String)
		AddTextOption(LocationManager.CustomLocation[5] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[5] as String)
		AddTextOption(LocationManager.CustomLocation[6] + " Can Spread:", FameManager.CustomLocationCanSpread[6] as String)
		AddTextOption(LocationManager.CustomLocation[6] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[6] as String)
		AddTextOption(LocationManager.CustomLocation[7] + " Can Spread:", FameManager.CustomLocationCanSpread[7] as String)
		AddTextOption(LocationManager.CustomLocation[7] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[7] as String)
		AddTextOption(LocationManager.CustomLocation[8] + " Can Spread:", FameManager.CustomLocationCanSpread[8] as String)
		AddTextOption(LocationManager.CustomLocation[8] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[8] as String)
		AddTextOption(LocationManager.CustomLocation[9] + " Can Spread:", FameManager.CustomLocationCanSpread[9] as String)
		AddTextOption(LocationManager.CustomLocation[9] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[9] as String)
		AddTextOption(LocationManager.CustomLocation[10] + " Can Spread:", FameManager.CustomLocationCanSpread[10] as String)
		AddTextOption(LocationManager.CustomLocation[10] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[10] as String)
		AddTextOption(LocationManager.CustomLocation[11] + " Can Spread:", FameManager.CustomLocationCanSpread[11] as String)
		AddTextOption(LocationManager.CustomLocation[11] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[11] as String)
		AddTextOption(LocationManager.CustomLocation[12] + " Can Spread:", FameManager.CustomLocationCanSpread[12] as String)
		AddTextOption(LocationManager.CustomLocation[12] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[12] as String)
		AddTextOption(LocationManager.CustomLocation[13] + " Can Spread:", FameManager.CustomLocationCanSpread[13] as String)
		AddTextOption(LocationManager.CustomLocation[13] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[13] as String)
		AddTextOption(LocationManager.CustomLocation[14] + " Can Spread:", FameManager.CustomLocationCanSpread[14] as String)
		AddTextOption(LocationManager.CustomLocation[14] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[14] as String)
		AddTextOption(LocationManager.CustomLocation[15] + " Can Spread:", FameManager.CustomLocationCanSpread[15] as String)
		AddTextOption(LocationManager.CustomLocation[15] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[15] as String)
		AddTextOption(LocationManager.CustomLocation[16] + " Can Spread:", FameManager.CustomLocationCanSpread[16] as String)
		AddTextOption(LocationManager.CustomLocation[16] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[16] as String)
		AddTextOption(LocationManager.CustomLocation[17] + " Can Spread:", FameManager.CustomLocationCanSpread[17] as String)
		AddTextOption(LocationManager.CustomLocation[17] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[17] as String)
		AddTextOption(LocationManager.CustomLocation[18] + " Can Spread:", FameManager.CustomLocationCanSpread[18] as String)
		AddTextOption(LocationManager.CustomLocation[18] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[18] as String)
		AddTextOption(LocationManager.CustomLocation[19] + " Can Spread:", FameManager.CustomLocationCanSpread[19] as String)
		AddTextOption(LocationManager.CustomLocation[19] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[19] as String)
	ElseIf (page == "External Mod Events")
		Debug.MessageBox("IMPORTANT: These options are here to test the mod's external event listeners. They will cause preset actions to happen in SLSF Reloaded. DO NOT SPAM THEM! TEST ONE AT A TIME!")
		
		AddHeaderOption("Automated Fame Gain Events")
		AddToggleOptionST("SLSF_Reloaded_SendFameGainRollState", "Fame Gain Roll", SendFameGainRoll, 0)
		AddToggleOptionST("SLSF_Reloaded_SendSlutFameGainState", "Slut Fame Gain", SendSlutFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendWhoreFameGainState", "Whore Fame Gain", SendWhoreFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendExhibitionistFameGainState", "Exhibitionist Fame Gain", SendExhibitionistFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendOralFameGainState", "Oral Fame Gain", SendOralFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendAnalFameGainState", "Anal Fame Gain", SendAnalFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendNastyFameGainState", "Nasty Fame Gain", SendNastyFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendPregnantFameGainState", "Pregnant Fame Gain", SendPregnantFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendDominantFameGainState", "Dominant Fame Gain", SendDominantFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendSubmissiveFameGainState", "Submissive Fame Gain", SendSubmissiveFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendSadistFameGainState", "Sadist Fame Gain", SendSadistFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendMasochistFameGainState", "Masochist Fame Gain", SendMasochistFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendGentleFameGainState", "Gentle Fame Gain", SendGentleFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendLikesMenFameGainState", "Likes Men Fame Gain", SendLikesMenFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendLikesWomenFameGainState", "Likes Women Fame Gain", SendLikesWomenFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendLikesOrcFameGainState", "Likes Orc Fame Gain", SendLikesOrcFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendLikesKhajiitFameGainState", "Likes Khajiit Fame Gain", SendLikesKhajiitFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendLikesArgonianFameGainState", "Likes Argonian Fame Gain", SendLikesArgonianFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendBestialityFameGainState", "Bestiality Fame Gain", SendBestialityFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendGroupFameGainState", "Group Fame Gain", SendGroupFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendBoundFameGainState", "Bound Fame Gain", SendBoundFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendTattooFameGainState", "Tattoo Fame Gain", SendTattooFameGain, 0)
		AddToggleOptionST("SLSF_Reloaded_SendCumDumpFameGainState", "Cum Dump Fame Gain", SendCumDumpFameGain, 0)
		
		SetCursorPosition(1)
		AddHeaderOption("Manual Fame Gain Events")
		AddToggleOptionST("SLSF_Reloaded_SendManualFameGainState", "Send Manual Fame Gain", SendManualFameGain, 0)
		AddMenuOptionST("SLSF_Reloaded_SendManualFameGainCategoryState", "Manual Fame Gain Category:", ManualFameGainCategory, 0)
		AddToggleOptionST("SLSF_Reloaded_SendManualFameGainAllInLocationState", "Send Manual Fame Gain All In Location", SendManualFameGainAllInLocation, 0)
		AddToggleOptionST("SLSF_Reloaded_SendManualFameGainAllState", "Send Manual Fame Gain ALL", SendManualFameGainAll, 0)
		
		AddHeaderOption("Fame Decay Events")
		AddToggleOptionST("SLSF_Reloaded_SendFameDecayState", "Send Fame Decay", SendFameDecay, 0)
		AddToggleOptionST("SLSF_Reloaded_SendManualFameDecayState", "Send Manual Fame Decay", SendManualFameDecay, 0)
		AddMenuOptionST("SLSF_Reloaded_SendManualFameDecayCategoryState", "Manual Fame Decay Category:", ManualFameDecayCategory, 0)
		AddToggleOptionST("SLSF_Reloaded_SendManualFameDecayAllInLocationState", "Send Manual Fame Decay All In Location", SendManualFameDecayAllInLocation, 0)
		AddToggleOptionST("SLSF_Reloaded_SendManualFameDecayAllState", "Send Manual Fame Decay ALL", SendManualFameDecayAll, 0)
		
		AddHeaderOption("Fame Spread Events")
		AddToggleOptionST("SLSF_Reloaded_SendFameSpreadRollState", "Send Fame Spread Roll", SendFameSpreadRoll, 0)
		AddToggleOptionST("SLSF_Reloaded_SendFameSpreadState", "Send Fame Spread", SendFameSpread, 0)
		AddToggleOptionST("SLSF_Reloaded_SendManualFameSpreadState", "Send Manual Fame Spread", SendManualFameSpread, 0)
		AddMenuOptionST("SLSF_Reloaded_SendManualFameSpreadCategoryState", "Manual Fame Spread Category:", SpreadFameCategory, 0)
		AddMenuOptionST("SLSF_Reloaded_SendManualFameSpreadFromState", "Manual Fame Spread FROM:", SendSpreadFromLocation, 0)
		AddMenuOptionST("SLSF_Reloaded_SendManualFameSpreadToState", "Manual Fame Spread TO:", SendSpreadToLocation, 0)
	EndIf
EndEvent

Int Function GetDisabledOptionFlagIf(Bool Condition)
	If (Condition)
		return OPTION_FLAG_DISABLED
	Else
		return 0
	EndIf
EndFunction

;/
=====================================
START DEBUG EXTERNAL EVENTS FUNCTIONS
=====================================
/;

Function SendExternalModEventTest(String EventTest)
	If EventTest == "Fame Gain Roll"
		Debug.Notification("Fame Gain Roll Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Fame Gain Roll Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendFameGainRoll")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Slut Fame Gain"
		Debug.Notification("Slut Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Slut Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendSlutFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Whore Fame Gain"
		Debug.Notification("Whore Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Whore Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendWhoreFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Exhibitionist Fame Gain"
		Debug.Notification("Exhibitionist Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Exhibitionist Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendExhibitionistFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Oral Fame Gain"
		Debug.Notification("Oral Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Oral Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendOralFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Anal Fame Gain"
		Debug.Notification("Anal Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Anal Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendAnalFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Nasty Fame Gain"
		Debug.Notification("Nasty Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Nasty Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendNastyFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Pregnant Fame Gain"
		Debug.Notification("Pregnant Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Pregnant Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendPregnantFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Dominant Fame Gain"
		Debug.Notification("Dominant Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Dominant Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendDominantFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Submissive Fame Gain"
		Debug.Notification("Submissive Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Submissive Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendSubmissiveFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Sadist Fame Gain"
		Debug.Notification("Sadist Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Sadist Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendSadistFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Masochist Fame Gain"
		Debug.Notification("Masochist Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Masochist Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendMasochistFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Gentle Fame Gain"
		Debug.Notification("Gentle Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Gentle Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendGentleFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Likes Men Fame Gain"
		Debug.Notification("Likes Men Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Likes Men Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendLikesMenFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Likes Women Fame Gain"
		Debug.Notification("Likes Women Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Likes Women Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendLikesWomenFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Likes Orc Fame Gain"
		Debug.Notification("Likes Orc Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Likes Orc Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendLikesOrcFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Likes Khajiit Fame Gain"
		Debug.Notification("Likes Khajiit Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Likes Khajiit Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendLikesKhajiitFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Likes Argonian Fame Gain"
		Debug.Notification("Likes Argonian Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Likes Argonian Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendLikesArgonianFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Bestiality Fame Gain"
		Debug.Notification("Bestiality Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Bestiality Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendBestialityFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Group Fame Gain"
		Debug.Notification("Group Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Group Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendGroupFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Bound Fame Gain"
		Debug.Notification("Bound Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Bound Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendBoundFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Tattoo Fame Gain"
		Debug.Notification("Tattoo Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Tattoo Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendTattooFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Cum Dump Fame Gain"
		Debug.Notification("Cum Dump Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Cum Dump Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendCumDumpFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 0)
		ModEvent.PushInt(EventHandle, 150)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Manual Fame Gain"
		Debug.Notification("Manual Fame Gain Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Manual Fame Gain Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendManualFameGain")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushString(EventHandle, ManualFameGainCategory)
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Manual Fame Gain All In Location"
		Debug.Notification("Manual Fame Gain All In Location Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Manual Fame Gain All In Location Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendManualFameGainAllInLocation")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Manual Fame Gain ALL"
		Debug.Notification("Manual Fame Gain ALL Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Manual Fame Gain ALL Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendManualFameGainAll")
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Fame Decay"
		Debug.Notification("Fame Decay Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Fame Decay Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendFameDecay")
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Manual Fame Decay"
		Debug.Notification("Manual Fame Decay Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Manual Fame Decay Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendManualFameDecay")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName()) ;EventLocation
		ModEvent.PushString(EventHandle, ManualFameDecayCategory) ;Category
		ModEvent.PushInt(EventHandle, 10) ;MinDecay
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Manual Fame Decay All In Location"
		Debug.Notification("Manual Fame Decay All In Location Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Manual Fame Decay All In Location Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendManualFameDecayAllInLocation")
		ModEvent.PushString(EventHandle, LocationManager.CurrentLocationName())
		ModEvent.PushInt(EventHandle, 10) ;MinDecay
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Manual Fame Decay ALL"
		Debug.Notification("Manual Fame Decay ALL Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Manual Fame Decay ALL Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendManualFameDecayAll")
		ModEvent.PushInt(EventHandle, 10) ;MinDecay
		ModEvent.PushInt(EventHandle, 10)
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Fame Spread Roll"
		Debug.Notification("Fame Spread Roll Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Fame Spread Roll Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendFameSpreadRoll")
		ModEvent.Send(EventHandle)
	ElseIf EventTest == "Manual Fame Spread"
		Debug.Notification("Manual Fame Spread Event Armed!")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 3...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 2...")
		Utility.Wait(1.0)
		Debug.Notification("Event Firing in 1...")
		Utility.Wait(1.0)
		Debug.Notification("Manual Fame Spread Event Fired!")
		
		Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendManualFameSpread")
		ModEvent.PushString(EventHandle, SendSpreadFromLocation) ;SpreadFromLocation
		ModEvent.PushString(EventHandle, SendSpreadToLocation) ;SpreadToLocation
		ModEvent.PushString(EventHandle, SpreadFameCategory) ;Category
		ModEvent.PushInt(EventHandle, 30) ;PercentToSpread
		ModEvent.Send(EventHandle)
	EndIf
EndFunction

State SLSF_Reloaded_SendFameGainRollState
	Event OnSelectST()
		If SendFameGainRoll == False
			SendFameGainRoll = True
		Else
			SendFameGainRoll = False
		EndIf
		
		If SendFameGainRoll == True
			Debug.MessageBox("External Fame Gain Roll Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendFameGainRoll == True
				SendExternalModEventTest("Fame Gain Roll")
				SendFameGainRoll = False
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendSlutFameGainState
	Event OnSelectST()
		If SendSlutFameGain == False
			SendSlutFameGain = True
		Else
			SendSlutFameGain = False
		EndIf
		
		If SendSlutFameGain == True
			Debug.MessageBox("External Slut Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendSlutFameGain == True
				SendExternalModEventTest("Slut Fame Gain")
				SendSlutFameGain = False
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendWhoreFameGainState
	Event OnSelectST()
		If SendWhoreFameGain == False
			SendWhoreFameGain = True
		Else
			SendWhoreFameGain = False
		EndIf
		
		If SendWhoreFameGain == True
			Debug.MessageBox("External Whore Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendWhoreFameGain == True
				SendExternalModEventTest("Whore Fame Gain")
				SendWhoreFameGain = False
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendExhibitionistFameGainState
	Event OnSelectST()
		If SendExhibitionistFameGain == False
			SendExhibitionistFameGain = True
		Else
			SendExhibitionistFameGain = False
		EndIf
		
		If SendExhibitionistFameGain == True
			Debug.MessageBox("External Exhibitionist Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendExhibitionistFameGain == True
				SendExternalModEventTest("Exhibitionist Fame Gain")
				SendExhibitionistFameGain = False
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendOralFameGainState
	Event OnSelectST()
		If SendOralFameGain == False
			SendOralFameGain = True
		Else
			SendOralFameGain = False
		EndIf
		
		If SendOralFameGain == True
			Debug.MessageBox("External Oral Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendOralFameGain == True
				SendExternalModEventTest("Oral Fame Gain")
				SendOralFameGain = False
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendAnalFameGainState
	Event OnSelectST()
		If SendAnalFameGain == False
			SendAnalFameGain = True
		Else
			SendAnalFameGain = False
		EndIf
		
		If SendAnalFameGain == True
			Debug.MessageBox("External Anal Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendAnalFameGain == True
				SendExternalModEventTest("Anal Fame Gain")
				SendAnalFameGain = False
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendNastyFameGainState
	Event OnSelectST()
		If SendNastyFameGain == False
			SendNastyFameGain = True
		Else
			SendNastyFameGain = False
		EndIf
		
		If SendNastyFameGain == True
			Debug.MessageBox("External Nasty Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendNastyFameGain == True
				SendExternalModEventTest("Nasty Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendPregnantFameGainState
	Event OnSelectST()
		If SendPregnantFameGain == False
			SendPregnantFameGain = True
		Else
			SendPregnantFameGain = False
		EndIf
		
		If SendPregnantFameGain == True
			Debug.MessageBox("External Pregnant Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendPregnantFameGain == True
				SendExternalModEventTest("Pregnant Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendDominantFameGainState
	Event OnSelectST()
		If SendDominantFameGain == False
			SendDominantFameGain = True
		Else
			SendDominantFameGain = False
		EndIf
		
		If SendDominantFameGain == True
			Debug.MessageBox("External Dominant Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendDominantFameGain == True
				SendExternalModEventTest("Dominant Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendSubmissiveFameGainState
	Event OnSelectST()
		If SendSubmissiveFameGain == False
			SendSubmissiveFameGain = True
		Else
			SendSubmissiveFameGain = False
		EndIf
		
		If SendSubmissiveFameGain == True
			Debug.MessageBox("External Submissive Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendSubmissiveFameGain == True
				SendExternalModEventTest("Submissive Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendSadistFameGainState
	Event OnSelectST()
		If SendSadistFameGain == False
			SendSadistFameGain = True
		Else
			SendSadistFameGain = False
		EndIf
		
		If SendSadistFameGain == True
			Debug.MessageBox("External Sadist Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendSadistFameGain == True
				SendExternalModEventTest("Sadist Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendMasochistFameGainState
	Event OnSelectST()
		If SendMasochistFameGain == False
			SendMasochistFameGain = True
		Else
			SendMasochistFameGain = False
		EndIf
		
		If SendMasochistFameGain == True
			Debug.MessageBox("External Masochist Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendMasochistFameGain == True
				SendExternalModEventTest("Masochist Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendGentleFameGainState
	Event OnSelectST()
		If SendGentleFameGain == False
			SendGentleFameGain = True
		Else
			SendGentleFameGain = False
		EndIf
		
		If SendGentleFameGain == True
			Debug.MessageBox("External Gentle Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendGentleFameGain == True
				SendExternalModEventTest("Gentle Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendLikesMenFameGainState
	Event OnSelectST()
		If SendLikesMenFameGain == False
			SendLikesMenFameGain = True
		Else
			SendLikesMenFameGain = False
		EndIf
		
		If SendLikesMenFameGain == True
			Debug.MessageBox("External Likes Men Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendLikesMenFameGain == True
				SendExternalModEventTest("Likes Men Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendLikesWomenFameGainState
	Event OnSelectST()
		If SendLikesWomenFameGain == False
			SendLikesWomenFameGain = True
		Else
			SendLikesWomenFameGain = False
		EndIf
		
		If SendLikesWomenFameGain == True
			Debug.MessageBox("External Likes Women Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendLikesWomenFameGain == True
				SendExternalModEventTest("Likes Women Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendLikesOrcFameGainState
	Event OnSelectST()
		If SendLikesOrcFameGain == False
			SendLikesOrcFameGain = True
		Else
			SendLikesOrcFameGain = False
		EndIf
		
		If SendLikesOrcFameGain == True
			Debug.MessageBox("External Likes Orc Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendLikesOrcFameGain == True
				SendExternalModEventTest("Likes Orc Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendLikesKhajiitFameGainState
	Event OnSelectST()
		If SendLikesKhajiitFameGain == False
			SendLikesKhajiitFameGain = True
		Else
			SendLikesKhajiitFameGain = False
		EndIf
		
		If SendLikesKhajiitFameGain == True
			Debug.MessageBox("External Likes Khajiit Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendLikesKhajiitFameGain == True
				SendExternalModEventTest("Likes Khajiit Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendLikesArgonianFameGainState
	Event OnSelectST()
		If SendLikesArgonianFameGain == False
			SendLikesArgonianFameGain = True
		Else
			SendLikesArgonianFameGain = False
		EndIf
		
		If SendLikesArgonianFameGain == True
			Debug.MessageBox("External Likes Argonian Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendLikesArgonianFameGain == True
				SendExternalModEventTest("Likes Argonian Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendBestialityFameGainState
	Event OnSelectST()
		If SendBestialityFameGain == False
			SendBestialityFameGain = True
		Else
			SendBestialityFameGain = False
		EndIf
		
		If SendBestialityFameGain == True
			Debug.MessageBox("External Bestiality Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendBestialityFameGain == True
				SendExternalModEventTest("Bestiality Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendGroupFameGainState
	Event OnSelectST()
		If SendGroupFameGain == False
			SendGroupFameGain = True
		Else
			SendGroupFameGain = False
		EndIf
		
		If SendGroupFameGain == True
			Debug.MessageBox("External Group Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendGroupFameGain == True
				SendExternalModEventTest("Group Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendBoundFameGainState
	Event OnSelectST()
		If SendBoundFameGain == False
			SendBoundFameGain = True
		Else
			SendBoundFameGain = False
		EndIf
		
		If SendBoundFameGain == True
			Debug.MessageBox("External Bound Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendBoundFameGain == True
				SendExternalModEventTest("Bound Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendTattooFameGainState
	Event OnSelectST()
		If SendTattooFameGain == False
			SendTattooFameGain = True
		Else
			SendTattooFameGain = False
		EndIf
		
		If SendTattooFameGain == True
			Debug.MessageBox("External Tattoo Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendTattooFameGain == True
				SendExternalModEventTest("Tattoo Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendCumDumpFameGainState
	Event OnSelectST()
		If SendCumDumpFameGain == False
			SendCumDumpFameGain = True
		Else
			SendCumDumpFameGain = False
		EndIf
		
		If SendCumDumpFameGain == True
			Debug.MessageBox("External Cum Dump Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendCumDumpFameGain == True
				SendExternalModEventTest("Cum Dump Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameGainState
	Event OnSelectST()
		If SendManualFameGain == False
			SendManualFameGain = True
		Else
			SendManualFameGain = False
		EndIf
		
		If SendManualFameGain == True
			Debug.MessageBox("External Manual Fame Gain Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendManualFameGain == True
				SendExternalModEventTest("Manual Fame Gain")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameGainCategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		ManualFameGainCategory = FameManager.FameType[AcceptedIndex]
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameGainAllInLocationState
	Event OnSelectST()
		If SendManualFameGainAllInLocation == False
			SendManualFameGainAllInLocation = True
		Else
			SendManualFameGainAllInLocation = False
		EndIf
		
		If SendManualFameGainAllInLocation == True
			Debug.MessageBox("External Manual Fame Gain All In Location Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendManualFameGainAllInLocation == True
				SendExternalModEventTest("Manual Fame Gain All In Location")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameGainAllState
	Event OnSelectST()
		If SendManualFameGainAll == False
			SendManualFameGainAll = True
		Else
			SendManualFameGainAll = False
		EndIf
		
		If SendManualFameGainAll == True
			Debug.MessageBox("External Manual Fame Gain ALL Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendManualFameGainAll == True
				SendExternalModEventTest("Manual Fame Gain ALL")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendFameDecayState
	Event OnSelectST()
		If SendFameDecay == False
			SendFameDecay = True
		Else
			SendFameDecay = False
		EndIf
		
		If SendFameDecay == True
			Debug.MessageBox("External Fame Decay Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendFameDecay == True
				SendExternalModEventTest("Fame Decay")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameDecayState
	Event OnSelectST()
		If SendManualFameDecay == False
			SendManualFameDecay = True
		Else
			SendManualFameDecay = False
		EndIf
		
		If SendManualFameDecay == True
			Debug.MessageBox("External Manual Fame Decay Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendManualFameDecay == True
				SendExternalModEventTest("Manual Fame Decay")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameDecayCategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		ManualFameGainCategory = FameManager.FameType[AcceptedIndex]
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameDecayAllInLocationState
	Event OnSelectST()
		If SendManualFameDecayAllInLocation == False
			SendManualFameDecayAllInLocation = True
		Else
			SendManualFameDecayAllInLocation = False
		EndIf
		
		If SendManualFameDecayAllInLocation == True
			Debug.MessageBox("External Manual Fame Decay All In Location Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendManualFameDecayAllInLocation == True
				SendExternalModEventTest("Manual Fame Decay All In Location")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameDecayAllState
	Event OnSelectST()
		If SendManualFameDecayAll == False
			SendManualFameDecayAll = True
		Else
			SendManualFameDecayAll = False
		EndIf
		
		If SendManualFameDecayAll == True
			Debug.MessageBox("External Manual Fame Decay ALL Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendManualFameDecayAll == True
				SendExternalModEventTest("Manual Fame Decay ALL")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendFameSpreadRollState
	Event OnSelectST()
		If SendFameSpreadRoll == False
			SendFameSpreadRoll = True
		Else
			SendFameSpreadRoll = False
		EndIf
		
		If SendFameSpreadRoll == True
			Debug.MessageBox("External Fame Spread Roll Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendFameSpreadRoll == True
				SendExternalModEventTest("Fame Spread Roll")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameSpreadState
	Event OnSelectST()
		If SendManualFameSpread == False
			SendManualFameSpread = True
		Else
			SendManualFameSpread = False
		EndIf
		
		If SendManualFameSpread == True
			Debug.MessageBox("External Manual Fame Spread Event is arming! If this is a mistake, you have 10 seconds to turn it off.")
			Utility.WaitMenuMode(15.0) ;Give the reader 5 seconds to read notification, then 10 extra seconds to turn off event if needed.
			If SendManualFameSpread == True
				SendExternalModEventTest("Manual Fame Spread")
			EndIf
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameSpreadCategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		ManualFameGainCategory = FameManager.FameType[AcceptedIndex]
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameSpreadFromState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(LocationManager.DefaultLocation)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SendSpreadFromLocation = LocationManager.DefaultLocation[AcceptedIndex]
		SetMenuOptionValueST(LocationManager.DefaultLocation[AcceptedIndex])
	EndEvent
EndState

State SLSF_Reloaded_SendManualFameSpreadToState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(LocationManager.DefaultLocation)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SendSpreadFromLocation = LocationManager.DefaultLocation[AcceptedIndex]
		SetMenuOptionValueST(LocationManager.DefaultLocation[AcceptedIndex])
	EndEvent
EndState

;/
===================================
END DEBUG EXTERNAL EVENTS FUNCTIONS
===================================
/;

State SLSF_Reloaded_BodySlot1FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.BodyTattooExtraFameType[0] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot2FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.BodyTattooExtraFameType[1] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot3FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.BodyTattooExtraFameType[2] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot4FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.BodyTattooExtraFameType[3] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot5FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.BodyTattooExtraFameType[4] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot6FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.BodyTattooExtraFameType[5] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot1SubcategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuOptionValueST(Texts[AcceptedIndex])
		VisibilityManager.BodyTattooSubcategory[0] = Texts[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot2SubcategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuOptionValueST(Texts[AcceptedIndex])
		VisibilityManager.BodyTattooSubcategory[1] = Texts[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot3SubcategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuOptionValueST(Texts[AcceptedIndex])
		VisibilityManager.BodyTattooSubcategory[2] = Texts[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot4SubcategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuOptionValueST(Texts[AcceptedIndex])
		VisibilityManager.BodyTattooSubcategory[3] = Texts[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot5SubcategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuOptionValueST(Texts[AcceptedIndex])
		VisibilityManager.BodyTattooSubcategory[4] = Texts[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlot6SubcategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = New String[5]
		
		Texts[0] = "(None)"
		Texts[1] = "Chest"
		Texts[2] = "Pelvis"
		Texts[3] = "Ass"
		Texts[4] = "Back"
		
		SetMenuOptionValueST(Texts[AcceptedIndex])
		VisibilityManager.BodyTattooSubcategory[5] = Texts[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceSlot1FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FaceTattooExtraFameType[0] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceSlot2FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FaceTattooExtraFameType[1] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceSlot3FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FaceTattooExtraFameType[2] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceSlot4FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FaceTattooExtraFameType[3] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceSlot5FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FaceTattooExtraFameType[4] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceSlot6FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FaceTattooExtraFameType[5] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandSlot1FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.HandTattooExtraFameType[0] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandSlot2FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.HandTattooExtraFameType[1] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandSlot3FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.HandTattooExtraFameType[2] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandSlot4FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.HandTattooExtraFameType[3] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandSlot5FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.HandTattooExtraFameType[4] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandSlot6FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.HandTattooExtraFameType[5] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootSlot1FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FootTattooExtraFameType[0] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootSlot2FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FootTattooExtraFameType[1] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootSlot3FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FootTattooExtraFameType[2] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootSlot4FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FootTattooExtraFameType[3] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootSlot5FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FootTattooExtraFameType[4] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootSlot6FameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FootTattooExtraFameType[5] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_LocationDetailsState
	Event OnMenuOpenST()
		Int TotalLocations = (LocationManager.DefaultLocation.Length + SLSF_Reloaded_CustomLocationCount.GetValue()) as Int
		String[] Texts = Utility.CreateStringArray(TotalLocations)
		
		Int StartIndex = 0
		Int FillIndex = 0
		
		While FillIndex < TotalLocations
			If FillIndex < LocationManager.DefaultLocation.Length
				Texts[FillIndex] = LocationManager.DefaultLocation[FillIndex]
			Else
				Texts[FillIndex] = LocationManager.CustomLocation[(FillIndex - LocationManager.DefaultLocation.Length)]
			EndIf
			FillIndex += 1
		EndWhile
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		Int TotalLocations = (LocationManager.DefaultLocation.Length + SLSF_Reloaded_CustomLocationCount.GetValue()) as Int
		String[] Texts = Utility.CreateStringArray(TotalLocations)
		
		Int FillIndex = 0
		
		While FillIndex < TotalLocations
			If FillIndex < LocationManager.DefaultLocation.Length
				Texts[FillIndex] = LocationManager.DefaultLocation[FillIndex]
			Else
				Texts[FillIndex] = LocationManager.CustomLocation[(FillIndex - LocationManager.DefaultLocation.Length)]
			EndIf
			FillIndex += 1
		EndWhile
		
		SetMenuOptionValueST(Texts[AcceptedIndex], False, "SLSF_Reloaded_LocationDetailsState")
		LocationDetailsSelected = Texts[AcceptedIndex]
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_PlayerAnonymousState
	Event OnSelectST()
		If AnonymityEnabled == False
			AnonymityEnabled = True
		Else
			AnonymityEnabled = False
		EndIf
		SetToggleOptionValueST(AnonymityEnabled, False, "SLSF_Reloaded_PlayerAnonymousState")
	EndEvent
EndState

State SLSF_Reloaded_NPCNeedsLOSState
	Event OnSelectST()
		If NPCNeedsLOS == False
			NPCNeedsLOS = True
		Else
			NPCNeedsLOS = False
		EndIf
		SetToggleOptionValueST(NPCNeedsLOS, False, "SLSF_Reloaded_NPCNeedsLOSState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_NotifyFameIncreaseState
	Event OnSelectST()
		If NotifyFameIncrease == False
			NotifyFameIncrease = True
		Else
			NotifyFameIncrease = False
		EndIf
		SetToggleOptionValueST(NotifyFameIncrease, False, "SLSF_Reloaded_NotifyFameIncreaseState")
	EndEvent
EndState

State SLSF_Reloaded_NotifyFameDecayState
	Event OnSelectST()
		If NotifyFameDecay == False
			NotifyFameDecay = True
		Else
			NotifyFameDecay = False
		EndIf
		SetToggleOptionValueST(NotifyFameDecay, False, "SLSF_Reloaded_NotifyFameDecayState")
	EndEvent
EndState

State SLSF_Reloaded_NotifyFameSpreadState
	Event OnSelectST()
		If NotifyFameSpread == False
			NotifyFameSpread = True
		Else
			NotifyFameSpread = False
		EndIf
		SetToggleOptionValueST(NotifyFameSpread, False, "SLSF_Reloaded_NotifyFameSpreadState")
	EndEvent
EndState

State SLSF_Reloaded_MinimumNPCLOSDistanceState
	Event OnSliderOpenST()
		SetSliderDialogStartValue((MinimumNPCLOSDistance / 32))
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MinimumNPCLOSDistance = value * 32 ;Need to convert to Skyrim Units, which we are doing ins steps of 32, or ~18 inches
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_MinimumNPCLOSDistanceState")
	EndEvent
	
	Event OnDefaultST()
		MinimumNPCLOSDistance = 160
		SetSliderOptionValueST(5, "{0}", False, "SLSF_Reloaded_MinimumNPCLOSDistanceState")
	EndEvent
EndState

State SLSF_Reloaded_ReduceFameAtNightState
	Event OnSelectST()
		If ReduceFameAtNight == False
			ReduceFameAtNight = True
		Else
			ReduceFameAtNight = False
		EndIf
		SetToggleOptionValueST(ReduceFameAtNight, False, "SLSF_Reloaded_ReduceFameAtNightState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_NightStartState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(NightStart)
		SetSliderDialogDefaultValue(22)
		SetSliderDialogRange(20, 23)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		NightStart = value
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_NightStartState")
	EndEvent
	
	Event OnDefaultST()
		NightStart = 22
		SetSliderOptionValueST(22, "{0}", False, "SLSF_Reloaded_NightStartState")
	EndEvent
EndState

State SLSF_Reloaded_NightEndState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(NightEnd)
		SetSliderDialogDefaultValue(6)
		SetSliderDialogRange(5, 8)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		NightEnd = value
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_NightEndState")
	EndEvent
	
	Event OnDefaultST()
		NightEnd = 6
		SetSliderOptionValueST(6, "{0}", False, "SLSF_Reloaded_NightEndState")
	EndEvent
EndState

State SLSF_Reloaded_FailedSpreadIncreaseState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FailedSpreadIncrease)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(5, 25)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FailedSpreadIncrease = value
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_FailedSpreadIncreaseState")
	EndEvent
	
	Event OnDefaultST()
		FailedSpreadIncrease = 10
		SetSliderOptionValueST(10, "{0}", False, "SLSF_Reloaded_FailedSpreadIncreaseState")
	EndEvent
EndState

State SLSF_Reloaded_SuccessfulSpreadDecreaseState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SuccessfulSpreadReduction)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(5, 25)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		SuccessfulSpreadReduction = value
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_SuccessfulSpreadDecreaseState")
	EndEvent
	
	Event OnDefaultST()
		SuccessfulSpreadReduction = 10
		SetSliderOptionValueST(10, "{0}", False, "SLSF_Reloaded_SuccessfulSpreadDecreaseState")
	EndEvent
EndState

State SLSF_Reloaded_MinimumFameToSpreadState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MinimumFameToSpread)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(10, 100)
		SetSliderDialogInterval(10)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MinimumFameToSpread = value
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_MinimumFameToSpreadState")
	EndEvent
	
	Event OnDefaultST()
		MinimumFameToSpread = 30
		SetSliderOptionValueST(30, "{0}%", False, "SLSF_Reloaded_MinimumFameToSpreadState")
	EndEvent
EndState

State SLSF_Reloaded_MaximumSpreadCategoriesState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaximumSpreadCategories)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 22)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaximumSpreadCategories = value
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_MaximumSpreadCategoriesState")
	EndEvent
	
	Event OnDefaultST()
		MaximumSpreadCategories = 5
		SetSliderOptionValueST(5, "{0}", False, "SLSF_Reloaded_MaximumSpreadCategoriesState")
	EndEvent
EndState

State SLSF_Reloaded_MaximumSpreadPercentageState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaximumSpreadPercentage)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(10, 50)
		SetSliderDialogInterval(5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaximumSpreadPercentage = value
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_MaximumSpreadPercentageState")
	EndEvent
	
	Event OnDefaultST()
		MaximumSpreadPercentage = 30
		SetSliderOptionValueST(30, "{0}", False, "SLSF_Reloaded_MaximumSpreadPercentageState")
	EndEvent
EndState

State SLSF_Reloaded_DecayTimeNeededState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DecayTimeNeeded / 2)
		SetSliderDialogDefaultValue(12)
		SetSliderDialogRange(12, 72)
		SetSliderDialogInterval(12)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		DecayTimeNeeded = value * 2
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_DecayTimeNeededState")
	EndEvent
	
	Event OnDefaultST()
		DecayTimeNeeded = 24
		SetSliderOptionValueST(12, "{0}", False, "SLSF_Reloaded_DecayTimeNeededState")
	EndEvent
EndState

State SLSF_Reloaded_SpreadTimeNeededState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SpreadTimeNeeded / 2)
		SetSliderDialogDefaultValue(24)
		SetSliderDialogRange(24, 144)
		SetSliderDialogInterval(12)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		SpreadTimeNeeded = value * 2
		SetSliderOptionValueST(value, "{0}", False, "SLSF_Reloaded_SpreadTimeNeededState")
	EndEvent
	
	Event OnDefaultST()
		SpreadTimeNeeded = 48
		SetSliderOptionValueST(24, "{0}", False, "SLSF_Reloaded_SpreadTimeNeededState")
	EndEvent
EndState

State SLSF_Reloaded_FameChangeMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameChangeMultiplier)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameChangeMultiplier = value
		SetSliderOptionValueST(value, "{1}", False, "SLSF_Reloaded_FameChangeMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameChangeMultiplier = 1
		SetSliderOptionValueST(1, "{1}", False, "SLSF_Reloaded_FameChangeMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_FameChanceByEnemyState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameChanceByEnemy)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameChanceByEnemy = value
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_FameChanceByEnemyState")
	EndEvent
	
	Event OnDefaultST()
		FameChanceByEnemy = 100
		SetSliderOptionValueST(100, "{0}%", False, "SLSF_Reloaded_FameChanceByEnemyState")
	EndEvent
EndState

State SLSF_Reloaded_FameChanceByNeutralState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameChanceByNeutral)
		SetSliderDialogDefaultValue(75)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameChanceByNeutral = value
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_FameChanceByNeutralState")
	EndEvent
	
	Event OnDefaultST()
		FameChanceByNeutral = 75
		SetSliderOptionValueST(75, "{0}%", False, "SLSF_Reloaded_FameChanceByNeutralState")
	EndEvent
EndState

State SLSF_Reloaded_FameChanceByFriendState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameChanceByFriend)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameChanceByFriend = value
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_FameChanceByFriendState")
	EndEvent
	
	Event OnDefaultST()
		FameChanceByFriend = 50
		SetSliderOptionValueST(50, "{0}%", False, "SLSF_Reloaded_FameChanceByFriendState")
	EndEvent
EndState

State SLSF_Reloaded_FameChanceByLoverState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameChanceByLover)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameChanceByLover = value
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_FameChanceByLoverState")
	EndEvent
	
	Event OnDefaultST()
		FameChanceByLover = 25
		SetSliderOptionValueST(25, "{0}%", False, "SLSF_Reloaded_FameChanceByLoverState")
	EndEvent
EndState

State SLSF_Reloaded_RegisterLocationState
	Event OnSelectST()
		If RegisterLocationTrigger == False
			RegisterLocationTrigger = True
		Else
			RegisterLocationTrigger = False
		EndIf
		
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_RegisterLocationConfirmState
	Event OnSelectST()
		If RegisterLocationConfirm == False
			RegisterLocationConfirm = True
		Else
			RegisterLocationConfirm = False
		EndIf
		
		Utility.WaitMenuMode(3.0)
		
		If RegisterLocationConfirm == True
			Debug.Notification("Attempting Location Registration...")
			LocationManager.RegisterCustomLocation()
			RegisterLocationTrigger = False
			RegisterLocationConfirm = False
			ForcePageReset()
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_UnregisterLocationSelectState
	Event OnMenuOpenST()
		String[] Texts = Utility.CreateStringArray(LocationManager.CustomLocation.Length)
		Int StartIndex = 0
		Int FillIndex = 0
		
		While FillIndex < LocationManager.CustomLocation.Length
			Texts[FillIndex] = LocationManager.CustomLocation[FillIndex]
			FillIndex += 1
		EndWhile
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = Utility.CreateStringArray(LocationManager.CustomLocation.Length)
		Int FillIndex = 0
		
		While FillIndex < LocationManager.CustomLocation.Length
			Texts[FillIndex] = LocationManager.CustomLocation[FillIndex]
			FillIndex += 1
		EndWhile
		
		SetMenuOptionValueST(Texts[AcceptedIndex], False, "SLSF_Reloaded_LocationDetailsState")
		UnregisterLocationSelection = Texts[AcceptedIndex]
		UnregisterLocationIndex = AcceptedIndex
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_UnregisterLocationState
	Event OnSelectST()
		If UnregisterLocationTrigger == False
			UnregisterLocationTrigger = True
		Else
			UnregisterLocationTrigger = False
		EndIf
		
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_UnregisterLocationConfirmState
	Event OnSelectST()
		If UnregisterLocationConfirm == False
			UnregisterLocationConfirm = True
		Else
			UnregisterLocationConfirm = False
		EndIf
		
		Utility.WaitMenuMode(3.0)
		
		If UnregisterLocationConfirm == True
			Debug.Notification("Attempting Location Unregistration...")
			LocationManager.UnregisterCustomLocation(UnregisterLocationIndex)
			UnregisterLocationTrigger = False
			UnregisterLocationConfirm = False
			ForcePageReset()
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_ClearAllFameState
	Event OnSelectST()
		If ClearAllFameTrigger == False
			ClearAllFameTrigger = True
		Else
			ClearAllFameTrigger = False
		EndIf
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_ClearAllFameConfirmState
	Event OnSelectST()
		If ClearAllFameConfirm == False
			ClearAllFameConfirm = True
		Else
			ClearAllFameConfirm = False
		EndIf
		
		Utility.WaitMenuMode(3.0)
		
		If ClearAllFameConfirm == True
			FameManager.ClearAllFame()
			ClearAllFameConfirm = False
			ClearAllFameTrigger = False
			ForcePageReset()
		EndIf
	EndEvent
EndState