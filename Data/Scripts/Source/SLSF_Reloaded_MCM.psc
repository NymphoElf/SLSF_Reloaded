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
Bool Property AllowForeplayFame Auto
Bool Property SubmissiveDefault Auto
Bool Property DominantDefault Auto

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
	Pages = New String[8]
	Pages[0] = "Fame Overview"
	Pages[1] = "Detailed Fame View"
	Pages[2] = "Settings"
	Pages[3] = "Tattoos"
	Pages[4] = "Custom Locations"
	Pages[5] = "General Info"
	Pages[6] = "Decay Info"
	Pages[7] = "Spread Info"
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
	AllowForeplayFame = True
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
		Debug.Trace("FameOverviewCheck - Location: " + LocationManager.CustomLocation[LocationIndex])
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
	Pages = New String[8]
	Pages[0] = "Fame Overview"
	Pages[1] = "Detailed Fame View"
	Pages[2] = "Settings"
	Pages[3] = "Tattoos"
	Pages[4] = "Custom Locations"
	Pages[5] = "General Info"
	Pages[6] = "Decay Info"
	Pages[7] = "Spread Info"
	VisibilityManager.RegisterForSingleUpdate(0.1)
	If Mods.IsFameCommentsInstalled == False
		If MaximumSpreadCategories > 22
			MaximumSpreadCategories = 22
		EndIf
	EndIf
	FameOverviewCheck()
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
	If (page == "")
		;LoadCustomContent("SLSF Reloaded/Sexlab Sexual Fame Reloaded Logo.dds", 226, -2)
	Else
		;UnloadCustomContent()
	EndIf
	
	If (page == "Fame Overview")
		
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
		AddTextOption(LocationManager.CustomLocation[20], HasFameAtCustomLocation[20] as String)
	ElseIf (page == "Detailed Fame View")
		AddHeaderOption("Current Location")
		If LocationManager.CurrentLocation != None
			AddTextOption("Detected Location:", LocationManager.CurrentLocation.GetName())
		Else
			AddTextOption("Detected Location:", "-NONE-")
		EndIf
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
		AddToggleOptionST("SLSF_Reloaded_ForeplayFameState", "Allow Foreplay Fame", AllowForeplayFame, 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByEnemyState", "Enemy Fame Chance", FameChanceByEnemy, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByNeutralState", "Neutral Fame Chance", FameChanceByNeutral, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByFriendState", "Friend Fame Chance", FameChanceByFriend, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByLoverState", "Lover Fame Chance", FameChanceByLover, "{0}%", 0)
		
		AddHeaderOption("Dom/Sub Defaults")
		AddToggleOptionST("SLSF_Reloaded_SubmissiveDefaultState", "Default to Submissive", SubmissiveDefault, GetDisabledOptionFlagIf(DominantDefault == True))
		AddToggleOptionST("SLSF_Reloaded_DominantDefaultState", "Default to Dominant", DominantDefault, GetDisabledOptionFlagIf(SubmissiveDefault == True))
		
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
		AddSliderOptionST("SLSF_Reloaded_MinimumFameToSpreadState", "Minimum Category Fame:", MinimumFameToSpread, "{0}", 0)
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
		If LocationManager.CurrentLocation != None
			AddTextOption("Detected Location:", LocationManager.CurrentLocation.GetName())
		Else
			AddTextOption("Detected Location:", "-NONE-")
		EndIf
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
		AddTextOption("Slot 21:", LocationManager.CustomLocation[20])
	
	ElseIf (page == "General Info")
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
		AddHeaderOption("Decay & Spread Timers")
		AddTextOption("Time Until Decay:", (FameManager.DecayCountdown/2) as Int + " Hours")
		AddTextOption("Time Until Spread:", (FameManager.SpreadCountdown/2) as Int + " Hours")
		
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
	
	ElseIf (page == "Decay Info")
		AddTextOption("Decay Countdown:", FameManager.DecayCountdown as String)
		AddHeaderOption("Default Locations")
		AddTextOption(LocationManager.DefaultLocation[0] + " Can Decay:", FameManager.DefaultLocationCanDecay[0] as String)
		;AddTextOption(LocationManager.DefaultLocation[0] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[0] as String)
		AddTextOption(LocationManager.DefaultLocation[1] + " Can Decay:", FameManager.DefaultLocationCanDecay[1] as String)
		;AddTextOption(LocationManager.DefaultLocation[1] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[1] as String)
		AddTextOption(LocationManager.DefaultLocation[2] + " Can Decay:", FameManager.DefaultLocationCanDecay[2] as String)
		;AddTextOption(LocationManager.DefaultLocation[2] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[2] as String)
		AddTextOption(LocationManager.DefaultLocation[3] + " Can Decay:", FameManager.DefaultLocationCanDecay[3] as String)
		;AddTextOption(LocationManager.DefaultLocation[3] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[3] as String)
		AddTextOption(LocationManager.DefaultLocation[4] + " Can Decay:", FameManager.DefaultLocationCanDecay[4] as String)
		;AddTextOption(LocationManager.DefaultLocation[4] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[4] as String)
		AddTextOption(LocationManager.DefaultLocation[5] + " Can Decay:", FameManager.DefaultLocationCanDecay[5] as String)
		;AddTextOption(LocationManager.DefaultLocation[5] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[5] as String)
		AddTextOption(LocationManager.DefaultLocation[6] + " Can Decay:", FameManager.DefaultLocationCanDecay[6] as String)
		;AddTextOption(LocationManager.DefaultLocation[6] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[6] as String)
		AddTextOption(LocationManager.DefaultLocation[7] + " Can Decay:", FameManager.DefaultLocationCanDecay[7] as String)
		;AddTextOption(LocationManager.DefaultLocation[7] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[7] as String)
		AddTextOption(LocationManager.DefaultLocation[8] + " Can Decay:", FameManager.DefaultLocationCanDecay[8] as String)
		;AddTextOption(LocationManager.DefaultLocation[8] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[8] as String)
		AddTextOption(LocationManager.DefaultLocation[9] + " Can Decay:", FameManager.DefaultLocationCanDecay[9] as String)
		;AddTextOption(LocationManager.DefaultLocation[9] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[9] as String)
		AddTextOption(LocationManager.DefaultLocation[10] + " Can Decay:", FameManager.DefaultLocationCanDecay[10] as String)
		;AddTextOption(LocationManager.DefaultLocation[10] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[10] as String)
		AddTextOption(LocationManager.DefaultLocation[11] + " Can Decay:", FameManager.DefaultLocationCanDecay[11] as String)
		;AddTextOption(LocationManager.DefaultLocation[11] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[11] as String)
		AddTextOption(LocationManager.DefaultLocation[12] + " Can Decay:", FameManager.DefaultLocationCanDecay[12] as String)
		;AddTextOption(LocationManager.DefaultLocation[12] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[12] as String)
		AddTextOption(LocationManager.DefaultLocation[13] + " Can Decay:", FameManager.DefaultLocationCanDecay[13] as String)
		;AddTextOption(LocationManager.DefaultLocation[13] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[13] as String)
		AddTextOption(LocationManager.DefaultLocation[14] + " Can Decay:", FameManager.DefaultLocationCanDecay[14] as String)
		;AddTextOption(LocationManager.DefaultLocation[14] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[14] as String)
		AddTextOption(LocationManager.DefaultLocation[15] + " Can Decay:", FameManager.DefaultLocationCanDecay[15] as String)
		;AddTextOption(LocationManager.DefaultLocation[15] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[15] as String)
		AddTextOption(LocationManager.DefaultLocation[16] + " Can Decay:", FameManager.DefaultLocationCanDecay[16] as String)
		;AddTextOption(LocationManager.DefaultLocation[16] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[16] as String)
		AddTextOption(LocationManager.DefaultLocation[17] + " Can Decay:", FameManager.DefaultLocationCanDecay[17] as String)
		;AddTextOption(LocationManager.DefaultLocation[17] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[17] as String)
		AddTextOption(LocationManager.DefaultLocation[18] + " Can Decay:", FameManager.DefaultLocationCanDecay[18] as String)
		;AddTextOption(LocationManager.DefaultLocation[18] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[18] as String)
		AddTextOption(LocationManager.DefaultLocation[19] + " Can Decay:", FameManager.DefaultLocationCanDecay[19] as String)
		;AddTextOption(LocationManager.DefaultLocation[19] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[19] as String)
		AddTextOption(LocationManager.DefaultLocation[20] + " Can Decay:", FameManager.DefaultLocationCanDecay[20] as String)
		;AddTextOption(LocationManager.DefaultLocation[20] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[20] as String)
		
		SetCursorPosition(5)
		AddHeaderOption("Custom Locations")
		AddTextOption(LocationManager.CustomLocation[0] + " Can Decay:", FameManager.CustomLocationCanDecay[0] as String)
		;AddTextOption(LocationManager.CustomLocation[0] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[0] as String)
		AddTextOption(LocationManager.CustomLocation[1] + " Can Decay:", FameManager.CustomLocationCanDecay[1] as String)
		;AddTextOption(LocationManager.CustomLocation[1] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[1] as String)
		AddTextOption(LocationManager.CustomLocation[2] + " Can Decay:", FameManager.CustomLocationCanDecay[2] as String)
		;AddTextOption(LocationManager.CustomLocation[2] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[2] as String)
		AddTextOption(LocationManager.CustomLocation[3] + " Can Decay:", FameManager.CustomLocationCanDecay[3] as String)
		;AddTextOption(LocationManager.CustomLocation[3] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[3] as String)
		AddTextOption(LocationManager.CustomLocation[4] + " Can Decay:", FameManager.CustomLocationCanDecay[4] as String)
		;AddTextOption(LocationManager.CustomLocation[4] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[4] as String)
		AddTextOption(LocationManager.CustomLocation[5] + " Can Decay:", FameManager.CustomLocationCanDecay[5] as String)
		;AddTextOption(LocationManager.CustomLocation[5] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[5] as String)
		AddTextOption(LocationManager.CustomLocation[6] + " Can Decay:", FameManager.CustomLocationCanDecay[6] as String)
		;AddTextOption(LocationManager.CustomLocation[6] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[6] as String)
		AddTextOption(LocationManager.CustomLocation[7] + " Can Decay:", FameManager.CustomLocationCanDecay[7] as String)
		;AddTextOption(LocationManager.CustomLocation[7] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[7] as String)
		AddTextOption(LocationManager.CustomLocation[8] + " Can Decay:", FameManager.CustomLocationCanDecay[8] as String)
		;AddTextOption(LocationManager.CustomLocation[8] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[8] as String)
		AddTextOption(LocationManager.CustomLocation[9] + " Can Decay:", FameManager.CustomLocationCanDecay[9] as String)
		;AddTextOption(LocationManager.CustomLocation[9] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[9] as String)
		AddTextOption(LocationManager.CustomLocation[10] + " Can Decay:", FameManager.CustomLocationCanDecay[10] as String)
		;AddTextOption(LocationManager.CustomLocation[10] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[10] as String)
		AddTextOption(LocationManager.CustomLocation[11] + " Can Decay:", FameManager.CustomLocationCanDecay[11] as String)
		;AddTextOption(LocationManager.CustomLocation[11] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[11] as String)
		AddTextOption(LocationManager.CustomLocation[12] + " Can Decay:", FameManager.CustomLocationCanDecay[12] as String)
		;AddTextOption(LocationManager.CustomLocation[12] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[12] as String)
		AddTextOption(LocationManager.CustomLocation[13] + " Can Decay:", FameManager.CustomLocationCanDecay[13] as String)
		;AddTextOption(LocationManager.CustomLocation[13] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[13] as String)
		AddTextOption(LocationManager.CustomLocation[14] + " Can Decay:", FameManager.CustomLocationCanDecay[14] as String)
		;AddTextOption(LocationManager.CustomLocation[14] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[14] as String)
		AddTextOption(LocationManager.CustomLocation[15] + " Can Decay:", FameManager.CustomLocationCanDecay[15] as String)
		;AddTextOption(LocationManager.CustomLocation[15] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[15] as String)
		AddTextOption(LocationManager.CustomLocation[16] + " Can Decay:", FameManager.CustomLocationCanDecay[16] as String)
		;AddTextOption(LocationManager.CustomLocation[16] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[16] as String)
		AddTextOption(LocationManager.CustomLocation[17] + " Can Decay:", FameManager.CustomLocationCanDecay[17] as String)
		;AddTextOption(LocationManager.CustomLocation[17] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[17] as String)
		AddTextOption(LocationManager.CustomLocation[18] + " Can Decay:", FameManager.CustomLocationCanDecay[18] as String)
		;AddTextOption(LocationManager.CustomLocation[18] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[18] as String)
		AddTextOption(LocationManager.CustomLocation[19] + " Can Decay:", FameManager.CustomLocationCanDecay[19] as String)
		;AddTextOption(LocationManager.CustomLocation[19] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[19] as String)
		AddTextOption(LocationManager.CustomLocation[20] + " Can Decay:", FameManager.CustomLocationCanDecay[20] as String)
		;AddTextOption(LocationManager.CustomLocation[20] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[20] as String)
		
	ElseIf (page == "Spread Info")
		AddTextOption("Spread Countdown:", FameManager.SpreadCountdown as String)
		AddHeaderOption("Default Locations")
		AddTextOption(LocationManager.DefaultLocation[0] + " Can Spread:", FameManager.DefaultLocationCanSpread[0] as String)
		;AddTextOption(LocationManager.DefaultLocation[0] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[0] as String)
		AddTextOption(LocationManager.DefaultLocation[1] + " Can Spread:", FameManager.DefaultLocationCanSpread[1] as String)
		;AddTextOption(LocationManager.DefaultLocation[1] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[1] as String)
		AddTextOption(LocationManager.DefaultLocation[2] + " Can Spread:", FameManager.DefaultLocationCanSpread[2] as String)
		;AddTextOption(LocationManager.DefaultLocation[2] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[2] as String)
		AddTextOption(LocationManager.DefaultLocation[3] + " Can Spread:", FameManager.DefaultLocationCanSpread[3] as String)
		;AddTextOption(LocationManager.DefaultLocation[3] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[3] as String)
		AddTextOption(LocationManager.DefaultLocation[4] + " Can Spread:", FameManager.DefaultLocationCanSpread[4] as String)
		;AddTextOption(LocationManager.DefaultLocation[4] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[4] as String)
		AddTextOption(LocationManager.DefaultLocation[5] + " Can Spread:", FameManager.DefaultLocationCanSpread[5] as String)
		;AddTextOption(LocationManager.DefaultLocation[5] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[5] as String)
		AddTextOption(LocationManager.DefaultLocation[6] + " Can Spread:", FameManager.DefaultLocationCanSpread[6] as String)
		;AddTextOption(LocationManager.DefaultLocation[6] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[6] as String)
		AddTextOption(LocationManager.DefaultLocation[7] + " Can Spread:", FameManager.DefaultLocationCanSpread[7] as String)
		;AddTextOption(LocationManager.DefaultLocation[7] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[7] as String)
		AddTextOption(LocationManager.DefaultLocation[8] + " Can Spread:", FameManager.DefaultLocationCanSpread[8] as String)
		;AddTextOption(LocationManager.DefaultLocation[8] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[8] as String)
		AddTextOption(LocationManager.DefaultLocation[9] + " Can Spread:", FameManager.DefaultLocationCanSpread[9] as String)
		;AddTextOption(LocationManager.DefaultLocation[9] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[9] as String)
		AddTextOption(LocationManager.DefaultLocation[10] + " Can Spread:", FameManager.DefaultLocationCanSpread[10] as String)
		;AddTextOption(LocationManager.DefaultLocation[10] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[10] as String)
		AddTextOption(LocationManager.DefaultLocation[11] + " Can Spread:", FameManager.DefaultLocationCanSpread[11] as String)
		;AddTextOption(LocationManager.DefaultLocation[11] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[11] as String)
		AddTextOption(LocationManager.DefaultLocation[12] + " Can Spread:", FameManager.DefaultLocationCanSpread[12] as String)
		;AddTextOption(LocationManager.DefaultLocation[12] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[12] as String)
		AddTextOption(LocationManager.DefaultLocation[13] + " Can Spread:", FameManager.DefaultLocationCanSpread[13] as String)
		;AddTextOption(LocationManager.DefaultLocation[13] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[13] as String)
		AddTextOption(LocationManager.DefaultLocation[14] + " Can Spread:", FameManager.DefaultLocationCanSpread[14] as String)
		;AddTextOption(LocationManager.DefaultLocation[14] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[14] as String)
		AddTextOption(LocationManager.DefaultLocation[15] + " Can Spread:", FameManager.DefaultLocationCanSpread[15] as String)
		;AddTextOption(LocationManager.DefaultLocation[15] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[15] as String)
		AddTextOption(LocationManager.DefaultLocation[16] + " Can Spread:", FameManager.DefaultLocationCanSpread[16] as String)
		;AddTextOption(LocationManager.DefaultLocation[16] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[16] as String)
		AddTextOption(LocationManager.DefaultLocation[17] + " Can Spread:", FameManager.DefaultLocationCanSpread[17] as String)
		;AddTextOption(LocationManager.DefaultLocation[17] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[17] as String)
		AddTextOption(LocationManager.DefaultLocation[18] + " Can Spread:", FameManager.DefaultLocationCanSpread[18] as String)
		;AddTextOption(LocationManager.DefaultLocation[18] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[18] as String)
		AddTextOption(LocationManager.DefaultLocation[19] + " Can Spread:", FameManager.DefaultLocationCanSpread[19] as String)
		;AddTextOption(LocationManager.DefaultLocation[19] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[19] as String)
		AddTextOption(LocationManager.DefaultLocation[20] + " Can Spread:", FameManager.DefaultLocationCanSpread[20] as String)
		;AddTextOption(LocationManager.DefaultLocation[20] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[20] as String)
		
		SetCursorPosition(5)
		AddHeaderOption("Custom Locations")
		AddTextOption(LocationManager.CustomLocation[0] + " Can Spread:", FameManager.CustomLocationCanSpread[0] as String)
		;AddTextOption(LocationManager.CustomLocation[0] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[0] as String)
		AddTextOption(LocationManager.CustomLocation[1] + " Can Spread:", FameManager.CustomLocationCanSpread[1] as String)
		;AddTextOption(LocationManager.CustomLocation[1] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[1] as String)
		AddTextOption(LocationManager.CustomLocation[2] + " Can Spread:", FameManager.CustomLocationCanSpread[2] as String)
		;AddTextOption(LocationManager.CustomLocation[2] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[2] as String)
		AddTextOption(LocationManager.CustomLocation[3] + " Can Spread:", FameManager.CustomLocationCanSpread[3] as String)
		;AddTextOption(LocationManager.CustomLocation[3] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[3] as String)
		AddTextOption(LocationManager.CustomLocation[4] + " Can Spread:", FameManager.CustomLocationCanSpread[4] as String)
		;AddTextOption(LocationManager.CustomLocation[4] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[4] as String)
		AddTextOption(LocationManager.CustomLocation[5] + " Can Spread:", FameManager.CustomLocationCanSpread[5] as String)
		;AddTextOption(LocationManager.CustomLocation[5] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[5] as String)
		AddTextOption(LocationManager.CustomLocation[6] + " Can Spread:", FameManager.CustomLocationCanSpread[6] as String)
		;AddTextOption(LocationManager.CustomLocation[6] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[6] as String)
		AddTextOption(LocationManager.CustomLocation[7] + " Can Spread:", FameManager.CustomLocationCanSpread[7] as String)
		;AddTextOption(LocationManager.CustomLocation[7] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[7] as String)
		AddTextOption(LocationManager.CustomLocation[8] + " Can Spread:", FameManager.CustomLocationCanSpread[8] as String)
		;AddTextOption(LocationManager.CustomLocation[8] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[8] as String)
		AddTextOption(LocationManager.CustomLocation[9] + " Can Spread:", FameManager.CustomLocationCanSpread[9] as String)
		;AddTextOption(LocationManager.CustomLocation[9] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[9] as String)
		AddTextOption(LocationManager.CustomLocation[10] + " Can Spread:", FameManager.CustomLocationCanSpread[10] as String)
		;AddTextOption(LocationManager.CustomLocation[10] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[10] as String)
		AddTextOption(LocationManager.CustomLocation[11] + " Can Spread:", FameManager.CustomLocationCanSpread[11] as String)
		;AddTextOption(LocationManager.CustomLocation[11] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[11] as String)
		AddTextOption(LocationManager.CustomLocation[12] + " Can Spread:", FameManager.CustomLocationCanSpread[12] as String)
		;AddTextOption(LocationManager.CustomLocation[12] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[12] as String)
		AddTextOption(LocationManager.CustomLocation[13] + " Can Spread:", FameManager.CustomLocationCanSpread[13] as String)
		;AddTextOption(LocationManager.CustomLocation[13] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[13] as String)
		AddTextOption(LocationManager.CustomLocation[14] + " Can Spread:", FameManager.CustomLocationCanSpread[14] as String)
		;AddTextOption(LocationManager.CustomLocation[14] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[14] as String)
		AddTextOption(LocationManager.CustomLocation[15] + " Can Spread:", FameManager.CustomLocationCanSpread[15] as String)
		;AddTextOption(LocationManager.CustomLocation[15] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[15] as String)
		AddTextOption(LocationManager.CustomLocation[16] + " Can Spread:", FameManager.CustomLocationCanSpread[16] as String)
		;AddTextOption(LocationManager.CustomLocation[16] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[16] as String)
		AddTextOption(LocationManager.CustomLocation[17] + " Can Spread:", FameManager.CustomLocationCanSpread[17] as String)
		;AddTextOption(LocationManager.CustomLocation[17] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[17] as String)
		AddTextOption(LocationManager.CustomLocation[18] + " Can Spread:", FameManager.CustomLocationCanSpread[18] as String)
		;AddTextOption(LocationManager.CustomLocation[18] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[18] as String)
		AddTextOption(LocationManager.CustomLocation[19] + " Can Spread:", FameManager.CustomLocationCanSpread[19] as String)
		;AddTextOption(LocationManager.CustomLocation[19] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[19] as String)
		AddTextOption(LocationManager.CustomLocation[20] + " Can Spread:", FameManager.CustomLocationCanSpread[20] as String)
		;AddTextOption(LocationManager.CustomLocation[20] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[20] as String)
	EndIf
EndEvent

Int Function GetDisabledOptionFlagIf(Bool Condition)
	If (Condition)
		return OPTION_FLAG_DISABLED
	Else
		return 0
	EndIf
EndFunction

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

State SLSF_Reloaded_SubmissiveDefaultState
	Event OnSelectST()
		If SubmissiveDefault == False
			SubmissiveDefault = True
		Else
			SubmissiveDefault = False
		EndIf
		SetToggleOptionValueST(SubmissiveDefault, False, "SLSF_Reloaded_SubmissiveDefaultState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_DominantDefaultState
	Event OnSelectST()
		If DominantDefault == False
			DominantDefault = True
		Else
			DominantDefault = False
		EndIf
		SetToggleOptionValueST(DominantDefault, False, "SLSF_Reloaded_DominantDefaultState")
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
		SetSliderOptionValueST(MinimumNPCLOSDistance, "{0}", False, "SLSF_Reloaded_MinimumNPCLOSDistanceState")
	EndEvent
	
	Event OnDefaultST()
		MinimumNPCLOSDistance = 160
		SetSliderOptionValueST(MinimumNPCLOSDistance, "{0}", False, "SLSF_Reloaded_MinimumNPCLOSDistanceState")
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
		If Mods.IsFameCommentsInstalled == False
			SetSliderDialogRange(1, 24)
		Else
			SetSliderDialogRange(1, 22)
		EndIf
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

State SLSF_Reloaded_ForeplayFameState
	Event OnSelectST()
		If AllowForeplayFame == False
			AllowForeplayFame = True
		Else
			AllowForeplayFame = False
		EndIf
		SetToggleOptionValueST(AllowForeplayFame, False, "SLSF_Reloaded_ForeplayFameState")
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