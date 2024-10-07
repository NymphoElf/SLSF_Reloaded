ScriptName SLSF_Reloaded_MCM extends SKI_ConfigBase

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_CommentManager Property Comments Auto

Bool Property NPCNeedsLOS Auto Hidden
Bool Property ReduceFameAtNight Auto Hidden
Bool Property NotifyFameIncrease Auto Hidden
Bool Property NotifyFameDecay Auto Hidden
Bool Property NotifyFameSpread Auto Hidden
Bool Property PlayerIsAnonymous Auto Hidden
Bool Property AnonymityEnabled Auto Hidden
Bool Property RegisterLocationTrigger Auto Hidden
Bool Property RegisterLocationConfirm Auto Hidden
Bool Property UnregisterLocationTrigger Auto Hidden
Bool Property UnregisterLocationConfirm Auto Hidden
Bool Property ClearAllFameTrigger Auto Hidden
Bool Property ClearAllFameConfirm Auto Hidden
Bool Property AllowForeplayFame Auto Hidden
Bool Property SubmissiveDefault Auto Hidden
Bool Property DominantDefault Auto Hidden
Bool Property UseGlobalFameMultiplier Auto Hidden
Bool Property AllowLikeFameWhenRaped Auto Hidden
Bool[] Property HasFameAtDefaultLocation Auto
Bool[] Property HasFameAtCustomLocation Auto
Bool Property EnableTracing Auto Hidden

Float Property NightStart Auto Hidden
Float Property NightEnd Auto Hidden
Float Property FailedSpreadIncrease Auto Hidden
Float Property SuccessfulSpreadReduction Auto Hidden
Float Property MinimumFameToSpread Auto Hidden
Float Property MaximumSpreadCategories Auto Hidden
Float Property MaximumSpreadPercentage Auto Hidden
Float Property DecayTimeNeeded Auto Hidden
Float Property SpreadTimeNeeded Auto Hidden
Float Property FameChanceByEnemy Auto Hidden
Float Property FameChanceByNeutral Auto Hidden
Float Property FameChanceByFriend Auto Hidden
Float Property FameChanceByLover Auto Hidden
Float Property MinimumNPCLOSDistance Auto Hidden
Float Property FameChangeMultiplier Auto Hidden
Float[] Property FameCategoryMultiplier Auto

Int Property TattooSlots Auto Hidden
Int Property BodyTattooIndex Auto Hidden
Int Property FaceTattooIndex Auto Hidden
Int Property HandTattooIndex Auto Hidden
Int Property FootTattooIndex Auto Hidden
Int[] Property DefaultLocationSpreadChance Auto
Int[] Property CustomLocationSpreadChance Auto

String Property TattooStatusSelect Auto Hidden

;Registration Variables
String Property LocationDetailsSelected Auto Hidden
String Property UnregisterLocationSelection Auto Hidden
Int Property UnregisterLocationIndex Auto Hidden

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto
GlobalVariable Property SLSF_Reloaded_CommentFrequency Auto
GlobalVariable Property IsVisiblyBound Auto

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
	Pages = New String[11]
	Pages[0] = "Fame Overview"
	Pages[1] = "Detailed Fame View"
	Pages[2] = "General Settings"
	Pages[3] = "Fame Settings"
	Pages[4] = "Tattoo Settings"
	Pages[5] = "Custom Locations"
	Pages[6] = "General Info"
	Pages[7] = "Tattoo Info"
	Pages[8] = "Decay Info"
	Pages[9] = "Spread Info"
	Pages[10] = "Debug"
EndFunction

Function SetDefaults()
	NPCNeedsLOS = True
	ReduceFameAtNight = True
	NotifyFameIncrease = False
	NotifyFameDecay = False
	NotifyFameSpread = False
	PlayerIsAnonymous = False
	AnonymityEnabled = True
	AllowLikeFameWhenRaped = True
	
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
	TattooSlots = 6
	TattooStatusSelect = "Body"
	BodyTattooIndex = 0
	FaceTattooIndex = 0
	HandTattooIndex = 0
	FootTattooIndex = 0
	
	UseGlobalFameMultiplier = True
	FameChangeMultiplier = 1.0
	
	Int TypeIndex = 0
	While TypeIndex < FameCategoryMultiplier.Length
		FameCategoryMultiplier[TypeIndex] = 1.0
		TypeIndex += 1
	EndWhile
	
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
	EnableTracing = False
	
	SLSF_Reloaded_CommentFrequency.SetValue(50)
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

Function CheckClearAllFame()
	If ClearAllFameConfirm == True
		Utility.Wait(1.0)
		Debug.Notification("Clearing All Fame...")
		FameManager.ClearAllFame()
	EndIf
EndFunction

Function CheckLocationRegister()
	If RegisterLocationConfirm == True
		Utility.Wait(1.0)
		Debug.Notification("Attempting Location Registration...")
		LocationManager.RegisterCustomLocation()
	EndIf
EndFunction

Function CheckLocationUnregister()
	If UnregisterLocationConfirm == True
		Utility.Wait(1.0)
		Debug.Notification("Attempting Location Unregistration...")
		LocationManager.UnregisterCustomLocation(UnregisterLocationIndex)
	EndIf
EndFunction

Event OnConfigOpen()
	Pages = New String[11]
	Pages[0] = "Fame Overview"
	Pages[1] = "Detailed Fame View"
	Pages[2] = "General Settings"
	Pages[3] = "Fame Settings"
	Pages[4] = "Tattoo Settings"
	Pages[5] = "Custom Locations"
	Pages[6] = "General Info"
	Pages[7] = "Tattoo Info"
	Pages[8] = "Decay Info"
	Pages[9] = "Spread Info"
	Pages[10] = "Debug"
	
	VisibilityManager.RegisterForSingleUpdate(0.1)
	
	If Mods.IsSexlabPlusInstalled == True
		DominantDefault = False
		SubmissiveDefault = False
	EndIf
EndEvent

Event OnConfigClose()
	CheckClearAllFame()
	CheckLocationRegister()
	CheckLocationUnregister()
	
	ClearAllFameTrigger = False
	ClearAllFameConfirm = False
	RegisterLocationTrigger = False
	RegisterLocationConfirm = False
	UnregisterLocationTrigger = False
	UnregisterLocationConfirm = False
	UnregisterLocationSelection = "NONE"
EndEvent

Event OnPageReset(String page)
	
	If (page == "")
		LoadCustomContent("SLSF Reloaded/SLSFReloadedLogo.dds", 250, 0)
		return
	Else
		UnloadCustomContent()
	EndIf
	
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
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
		
		If Mods.IsBimbosInstalled == True
			AddTextOption("Airhead Fame:", Data.GetFameValue(LocationDetailsSelected, "Airhead") as String)
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
	
	ElseIf (page == "General Settings")
		AddHeaderOption("Dom/Sub Defaults")
		AddTextOption("Sexlab P+ Installed:", (Mods.IsSexlabPlusInstalled) as String)
		AddToggleOptionST("SLSF_Reloaded_SubmissiveDefaultState", "Default to Submissive", SubmissiveDefault, GetDisabledOptionFlagIf(DominantDefault == True || Mods.IsSexlabPlusInstalled == True))
		AddToggleOptionST("SLSF_Reloaded_DominantDefaultState", "Default to Dominant", DominantDefault, GetDisabledOptionFlagIf(SubmissiveDefault == True || Mods.IsSexlabPlusInstalled == True))
		
		If Mods.IsFameCommentsInstalled == True
			AddHeaderOption("Comment Settings")
			AddSliderOptionST("SLSF_Reloaded_CommentChanceState", "Fame Comment Chance: ", SLSF_Reloaded_CommentFrequency.GetValue(), "{0}%", 0)
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("Notification Toggles")
		AddToggleOptionST("SLSF_Reloaded_NotifyFameIncreaseState", "Notify on Fame Increase", NotifyFameIncrease, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameDecayState", "Notify on Fame Decay", NotifyFameDecay, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameSpreadState", "Notify on Fame Spread", NotifyFameSpread, 0)
		
	ElseIf (page == "Fame Settings")
		AddHeaderOption("Fame Gain Settings")
		AddToggleOptionST("SLSF_Reloaded_PlayerAnonymousState", "Player Can Be Anonymous", AnonymityEnabled, 0)
		AddToggleOptionST("SLSF_Reloaded_ForeplayFameState", "Allow Foreplay Fame", AllowForeplayFame, 0)
		AddToggleOptionST("SLSF_Reloaded_AllowLikeFameWhenRapedState", "Allow Like Fame When Raped", AllowLikeFameWhenRaped, 0)
		AddToggleOptionST("SLSF_Reloaded_ReduceFameAtNightState", "Reduce Fame Gain at Night", ReduceFameAtNight, 0)
		AddSliderOptionST("SLSF_Reloaded_NightStartState", "Night Starts at:", NightStart, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		AddSliderOptionST("SLSF_Reloaded_NightEndState", "Night Ends at:", NightEnd, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		
		AddHeaderOption("NPC Fame Chances")
		AddToggleOptionST("SLSF_Reloaded_NPCNeedsLOSState", "NPCs Need Line of Sight", NPCNeedsLOS, 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumNPCLOSDistanceState", "Minimum NPC Distance for LOS:", MinimumNPCLOSDistance as Int, "{0}", GetDisabledOptionFlagIf(NPCNeedsLOS == False))
		AddSliderOptionST("SLSF_Reloaded_FameChanceByEnemyState", "Enemy Fame Chance", FameChanceByEnemy, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByNeutralState", "Neutral Fame Chance", FameChanceByNeutral, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByFriendState", "Friend Fame Chance", FameChanceByFriend, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByLoverState", "Lover Fame Chance", FameChanceByLover, "{0}%", 0)
		
		AddHeaderOption("Fame Decay Settings")
		AddSliderOptionST("SLSF_Reloaded_DecayTimeNeededState", "Time Between Decays (Hours):", (DecayTimeNeeded / 2), "{0}", 0)
		
		AddHeaderOption("Fame Spread Settings")
		AddSliderOptionST("SLSF_Reloaded_SpreadTimeNeededState", "Time Between Spreads (Hours):", (SpreadTimeNeeded / 2), "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_FailedSpreadIncreaseState", "Chance Increase on Fail:", FailedSpreadIncrease, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_SuccessfulSpreadDecreaseState", "Chance Decrease on Success:", SuccessfulSpreadReduction, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumFameToSpreadState", "Minimum Category Fame:", MinimumFameToSpread, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadCategoriesState", "Maximum Spread Categories:", MaximumSpreadCategories, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadPercentageState", "Maximum Spread Percentage:", MaximumSpreadPercentage, "{0}%", 0)
		
		AddHeaderOption("Multiplier Settings")
		AddToggleOptionST("SLSF_Reloaded_UseGlobalMultiplierState", "Use Global Multiplier", UseGlobalFameMultiplier, 0)
		AddSliderOptionST("SLSF_Reloaded_FameChangeMultiplierState", "Global Fame Multiplier:", FameChangeMultiplier, "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == False))
		
		AddHeaderOption("Reset Fame")
		AddToggleOptionST("SLSF_Reloaded_ClearAllFameState", "Clear All Fame", ClearAllFameTrigger, 0)
		AddToggleOptionST("SLSF_Reloaded_ClearAllFameConfirmState", "Confirm Clear All Fame", ClearAllFameConfirm, GetDisabledOptionFlagIf(ClearAllFameTrigger == False))
		
		SetCursorPosition(1)
		AddSliderOptionST("SLSF_Reloaded_WhoreMultiplierState", "Whore Multiplier:", FameCategoryMultiplier[0], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_SlutMultiplierState", "Slut Multiplier:", FameCategoryMultiplier[1], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_ExhibitionistMultiplierState", "Exhibitionist Multiplier:", FameCategoryMultiplier[2], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_OralMultiplierState", "Oral Multiplier:", FameCategoryMultiplier[3], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_AnalMultiplierState", "Anal Multiplier:", FameCategoryMultiplier[4], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_NastyMultiplierState", "Nasty Multiplier:", FameCategoryMultiplier[5], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_PregnantMultiplierState", "Pregnant Multiplier:", FameCategoryMultiplier[6], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_DominantMultiplierState", "Dominant Multiplier:", FameCategoryMultiplier[7], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_SubmissiveMultiplierState", "Submissive Multiplier:", FameCategoryMultiplier[8], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_SadistMultiplierState", "Sadist Multiplier:", FameCategoryMultiplier[9], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_MasochistMultiplierState", "Masochist Multiplier:", FameCategoryMultiplier[10], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_GentleMultiplierState", "Gentle Multiplier:", FameCategoryMultiplier[11], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesMenMultiplierState", "Likes Men Multiplier:", FameCategoryMultiplier[12], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesWomenMultiplierState", "Likes Women Multiplier:", FameCategoryMultiplier[13], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesOrcMultiplierState", "Likes Orc Multiplier:", FameCategoryMultiplier[14], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesKhajiitMultiplierState", "Likes Khajiit Multiplier:", FameCategoryMultiplier[15], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesArgonianMultiplierState", "Likes Argonian Multiplier:", FameCategoryMultiplier[16], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_BestialityMultiplierState", "Bestiality Multiplier:", FameCategoryMultiplier[17], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_GroupMultiplierState", "Group Multiplier:", FameCategoryMultiplier[18], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_BoundMultiplierState", "Bound Multiplier:", FameCategoryMultiplier[19], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_TattooMultiplierState", "Tattoo Multiplier:", FameCategoryMultiplier[20], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_CumDumpMultiplierState", "Cum Dump Multiplier:", FameCategoryMultiplier[21], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		
		If Mods.IsFameCommentsInstalled == True
			AddSliderOptionST("SLSF_Reloaded_UnfaithfulMultiplierState", "Unfaithful Multiplier:", FameCategoryMultiplier[22], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
			AddSliderOptionST("SLSF_Reloaded_CuckMultiplierState", "Cuck Multiplier:", FameCategoryMultiplier[23], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		EndIf
		
		If Mods.IsBimbosInstalled == True
			AddSliderOptionST("SLSF_Reloaded_AirheadMultiplierState", "Airhead Multiplier", FameCategoryMultiplier[24], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		EndIf
	
	ElseIf (page == "Tattoo Settings")
		AddHeaderOption("Maximum Tattoo Slots")
		AddSliderOptionST("SLSF_Reloaded_MaxTattooSlotsState", "Number of Slots", TattooSlots, "{0}", 0)
		
		AddHeaderOption("Body Tattoos")
		AddMenuOptionST("SLSF_Reloaded_BodyTattooSlotState", "Body Tattoo Slot", (BodyTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeBodySlotState", "Exclude From Fame", VisibilityManager.BodyTattooExcluded[BodyTattooIndex], 0)
		If VisibilityManager.BodyTattooApplied[BodyTattooIndex] == True
			AddTextOption("Slot Used:", "Yes")
			If VisibilityManager.IsBodyTattooVisible(BodyTattooIndex) == True
				AddTextOption("Slot Visible:", "Yes")
			Else
				AddTextOption("Slot Visible:", "No")
			EndIf
		Else
			If VisibilityManager.BodyTattooExcluded[BodyTattooIndex] == True
				AddTextOption("Slot Used:", "Excluded")
			Else
				AddTextOption("Slot Used:", "No")
			EndIf
			AddTextOption("Slot Visible:", "No")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_BodySlotFameState", "Extra Fame", VisibilityManager.BodyTattooExtraFameType[BodyTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[BodyTattooIndex] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlotSubcategoryState", "Subcategory", VisibilityManager.BodyTattooSubcategory[BodyTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[BodyTattooIndex] == False))
		
		AddHeaderOption("Hand Tattoos")
		AddMenuOptionST("SLSF_Reloaded_HandTattooSlotState", "Hand Tattoo Slot", (HandTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeHandSlotState", "Exclude From Fame", VisibilityManager.HandTattooExcluded[HandTattooIndex], 0)
		If VisibilityManager.HandTattooApplied[HandTattooIndex] == True
			AddTextOption("Slot Used:", "Yes")
			If VisibilityManager.IsHandTattooVisible(HandTattooIndex) == True
				AddTextOption("Slot Visible:", "Yes")
			Else
				AddTextOption("Slot Visible:", "No")
			EndIf
		Else
			If VisibilityManager.HandTattooExcluded[HandTattooIndex] == True
				AddTextOption("Slot Used:", "Excluded")
			Else
				AddTextOption("Slot Used:", "No")
			EndIf
			AddTextOption("Slot Visible:", "No")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_HandSlotFameState", "Extra Fame", VisibilityManager.HandTattooExtraFameType[HandTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[HandTattooIndex] == False))
		
		SetCursorPosition(5)
		AddHeaderOption("Face Tattoos")
		AddMenuOptionST("SLSF_ReloadedFaceTattoSlotState", "Face Tattoo Slot", (FaceTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeFaceSlotState", "Exclude From Fame", VisibilityManager.FaceTattooExcluded[FaceTattooIndex], 0)
		If VisibilityManager.FaceTattooApplied[FaceTattooIndex] == True
			AddTextOption("Slot Used:", "Yes")
			If VisibilityManager.IsFaceTattooVisible(FaceTattooIndex) == True
				AddTextOption("Slot Visible:", "Yes")
			Else
				AddTextOption("Slot Visible:", "No")
			EndIf
		Else
			If VisibilityManager.FaceTattooExcluded[FaceTattooIndex] == True
				AddTextOption("Slot Used:", "Excluded")
			Else
				AddTextOption("Slot Used:", "No")
			EndIf
			AddTextOption("Slot Visible:", "No")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_FaceSlotFameState", "Extra Fame", VisibilityManager.FaceTattooExtraFameType[FaceTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[FaceTattooIndex] == False))
		
		AddHeaderOption("Foot Tattoos")
		AddMenuOptionST("SLSF_Reloaded_FootTattooSlotState", "Foot Tattoo Slot", (FootTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeFootSlotState", "Exclude From Fame", VisibilityManager.FootTattooExcluded[FootTattooIndex], 0)
		If VisibilityManager.FootTattooApplied[FootTattooIndex] == True
			AddTextOption("Slot Used:", "Yes")
			If VisibilityManager.IsFootTattooVisible(FootTattooIndex) == True
				AddTextOption("Slot Visible:", "Yes")
			Else
				AddTextOption("Slot Visible:", "No")
			EndIf
		Else
			If VisibilityManager.FootTattooExcluded[FootTattooIndex] == True
				AddTextOption("Slot Used:", "Excluded")
			Else
				AddTextOption("Slot Used:", "No")
			EndIf
			AddTextOption("Slot Visible:", "No")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_FootSlotFameState", "Extra Fame", VisibilityManager.FootTattooExtraFameType[FootTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[FootTattooIndex] == False))
		
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
		
		If Mods.IsHentaiPregInstalled == True
			AddTextOption("Hentai Pregnancy", "True")
		Else
			AddTextOption("Hentai Pregnancy", "False")
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
		
		If Mods.IsBimbosInstalled == True
			AddTextOption("Bimbos of Skyrim", "True")
		Else
			AddTextOption("Bimbos of Skyrim", "False")
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("Detected Conditions")
		AddTextOption("Player is Anonymous:", VisibilityManager.IsPlayerAnonymous() as String)
		AddTextOption("Player is EC Pregnant:", Mods.IsECPregnant(PlayerScript.PlayerRef) as String)
		AddTextOption("Player is ES Pregnant:", Mods.IsESPregnant(PlayerScript.PlayerRef) as String)
		AddTextOption("Player is FM Pregnant:", Mods.IsFMPregnant(PlayerScript.PlayerRef) as String)
		AddTextOption("Player is Public Whore:", Mods.IsPublicWhore() as String)
		AddTextOption("Player's FHU Inflation:", Mods.GetFHUInflation(PlayerScript.PlayerRef) as String)
		AddTextOption("Total Visible Tattoos:", VisibilityManager.VisibleTattoos as String)
		If IsVisiblyBound.GetValue() == 1
			AddTextOption("Visibly Bound:", "Yes")
		Else
			AddTextOption("Visibly Bound:", "No")
		EndIf
		AddHeaderOption("Decay & Spread Timers")
		AddTextOption("Time Until Decay:", (FameManager.DecayCountdown/2) as Int + " Hours")
		AddTextOption("Time Until Spread:", (FameManager.SpreadCountdown/2) as Int + " Hours")
	
	ElseIf (page == "Tattoo Info")
		AddHeaderOption("Select Tattoo Area")
		AddMenuOptionST("SLSF_Reloaded_TattooStatusState", "Tattoo Area:", TattooStatusSelect, 0)
		
		AddHeaderOption("Visibility Status")
		Int TattooIndex = 0
		Int SlotNumber = 1
		If TattooStatusSelect == "Body"
			While TattooIndex < TattooSlots
				If TattooIndex == (TattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.BodyTattooVisible[TattooIndex] == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "Face"
			While TattooIndex < TattooSlots
				If TattooIndex == (TattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.FaceTattooVisible[TattooIndex] == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "Hands"
			While TattooIndex < TattooSlots
				If TattooIndex == (TattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.HandTattooVisible[TattooIndex] == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "Feet"
			While TattooIndex < TattooSlots
				If TattooIndex == (TattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.FootTattooVisible[TattooIndex] == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
	
	ElseIf (page == "Decay Info")
		AddTextOption("Decay Countdown:", (FameManager.DecayCountdown / 2) as Int + " Hours")
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
		
		SetCursorPosition(3)
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
		AddTextOption("Spread Countdown:", (FameManager.SpreadCountdown / 2) as Int + " Hours")
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
		
		SetCursorPosition(3)
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
	ElseIf (page == "Debug")
		AddToggleOptionST("SLSF_Reloaded_EnableTraceState", "Enable Tracing", EnableTracing, 0)
	EndIf
EndEvent

Int Function GetDisabledOptionFlagIf(Bool Condition)
	If (Condition)
		return OPTION_FLAG_DISABLED
	Else
		return 0
	EndIf
EndFunction

State SLSF_Reloaded_EnableTraceState
	Event OnSelectST()
		If EnableTracing == False
			EnableTracing = True
		Else
			EnableTracing = False
		EndIf
		
		SetToggleOptionValueST(EnableTracing)
	EndEvent
EndState

State SLSF_Reloaded_AllowLikeFameWhenRapedState
	Event OnSelectST()
		If AllowLikeFameWhenRaped == False
			AllowLikeFameWhenRaped = True
		Else
			AllowLikeFameWhenRaped = False
		EndIf
		
		SetToggleOptionValueST(AllowLikeFameWhenRaped)
	EndEvent
EndState

State SLSF_Reloaded_MaxTattooSlotsState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(TattooSlots)
		SetSliderDialogDefaultValue(6)
		SetSliderDialogRange(6, 90)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		TattooSlots = value as Int
		SetSliderOptionValueST(TattooSlots, "{0}", False, "SLSF_Reloaded_MaxTattooSlotsState")
	EndEvent
	
	Event OnDefaultST()
		TattooSlots = 6
		SetSliderOptionValueST(TattooSlots, "{0}", False, "SLSF_Reloaded_MaxTattooSlotsState")
	EndEvent
EndState

State SLSF_Reloaded_TattooStatusState
	Event OnMenuOpenST()
		String[] TattooArea = New String[4]
		TattooArea[0] = "Body"
		TattooArea[1] = "Face"
		TattooArea[2] = "Hands"
		TattooArea[3] = "Feet"
		
		SetMenuDialogOptions(TattooArea)
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] TattooArea = New String[4]
		TattooArea[0] = "Body"
		TattooArea[1] = "Face"
		TattooArea[2] = "Hands"
		TattooArea[3] = "Feet"
		
		SetMenuOptionValueST(TattooArea[AcceptedIndex])
		TattooStatusSelect = TattooArea[AcceptedIndex]
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_BodyTattooSlotState
	Event OnMenuOpenST()
		String[] BodySlotIndex = Utility.CreateStringArray(TattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < TattooSlots
			BodySlotIndex[ArrayIndex] = "Slot " + (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(BodySlotIndex)
		SetMenuDialogStartIndex(BodyTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		BodyTattooIndex = AcceptedIndex
		SetMenuOptionValueST(BodyTattooIndex + 1)
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_ExcludeBodySlotState
	Event OnSelectST()
		If VisibilityManager.BodyTattooExcluded[BodyTattooIndex] == False
			VisibilityManager.BodyTattooExcluded[BodyTattooIndex] = True
		Else
			VisibilityManager.BodyTattooExcluded[BodyTattooIndex] = False
		EndIf
		SetToggleOptionValueST(VisibilityManager.BodyTattooExcluded[BodyTattooIndex])
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_BodySlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.BodyTattooExtraFameType[BodyTattooIndex] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlotSubcategoryState
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
		VisibilityManager.BodyTattooSubcategory[BodyTattooIndex] = Texts[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceTattooSlotState
	Event OnMenuOpenST()
		String[] FaceSlotIndex = Utility.CreateStringArray(TattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < TattooSlots
			FaceSlotIndex[ArrayIndex] = "Slot " + (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(FaceSlotIndex)
		SetMenuDialogStartIndex(FaceTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		FaceTattooIndex = AcceptedIndex
		SetMenuOptionValueST(FaceTattooIndex + 1)
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_ExcludeFaceSlotState
	Event OnSelectST()
		If VisibilityManager.FaceTattooExcluded[FaceTattooIndex] == False
			VisibilityManager.FaceTattooExcluded[FaceTattooIndex] = True
		Else
			VisibilityManager.FaceTattooExcluded[FaceTattooIndex] = False
		EndIf
		SetToggleOptionValueST(VisibilityManager.FaceTattooExcluded[FaceTattooIndex])
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_FaceSlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FaceTattooExtraFameType[FaceTattooIndex] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandTattooSlotState
	Event OnMenuOpenST()
		String[] HandSlotIndex = Utility.CreateStringArray(TattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < TattooSlots
			HandSlotIndex[ArrayIndex] = "Slot " + (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(HandSlotIndex)
		SetMenuDialogStartIndex(HandTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		HandTattooIndex = AcceptedIndex
		SetMenuOptionValueST(HandTattooIndex + 1)
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_ExcludeHandSlotState
	Event OnSelectST()
		If VisibilityManager.HandTattooExcluded[HandTattooIndex] == False
			VisibilityManager.HandTattooExcluded[HandTattooIndex] = True
		Else
			VisibilityManager.HandTattooExcluded[HandTattooIndex] = False
		EndIf
		SetToggleOptionValueST(VisibilityManager.HandTattooExcluded[HandTattooIndex])
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_HandSlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.HandTattooExtraFameType[HandTattooIndex] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootTattooSlotState
	Event OnMenuOpenST()
		String[] FootSlotIndex = Utility.CreateStringArray(TattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < TattooSlots
			FootSlotIndex[ArrayIndex] = "Slot " + (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(FootSlotIndex)
		SetMenuDialogStartIndex(FootTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		FootTattooIndex = AcceptedIndex
		SetMenuOptionValueST(FootTattooIndex + 1)
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_ExcludeFootSlotState
	Event OnSelectST()
		If VisibilityManager.FootTattooExcluded[FootTattooIndex] == False
			VisibilityManager.FootTattooExcluded[FootTattooIndex] = True
		Else
			VisibilityManager.FootTattooExcluded[FootTattooIndex] = False
		EndIf
		SetToggleOptionValueST(VisibilityManager.FootTattooExcluded[FootTattooIndex])
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_FootSlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		SetMenuDialogOptions(FameManager.FameType)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		SetMenuOptionValueST(FameManager.FameType[AcceptedIndex])
		VisibilityManager.FootTattooExtraFameType[FootTattooIndex] = FameManager.FameType[AcceptedIndex]
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
			DominantDefault = False
		Else
			SubmissiveDefault = False
		EndIf
		SetToggleOptionValueST(SubmissiveDefault, False, "SLSF_Reloaded_SubmissiveDefaultState")
		SetToggleOptionValueST(DominantDefault, False, "SLSF_Reloaded_DominantDefaultState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_DominantDefaultState
	Event OnSelectST()
		If DominantDefault == False
			DominantDefault = True
			SubmissiveDefault = False
		Else
			DominantDefault = False
		EndIf
		SetToggleOptionValueST(DominantDefault, False, "SLSF_Reloaded_DominantDefaultState")
		SetToggleOptionValueST(SubmissiveDefault, False, "SLSF_Reloaded_SubmissiveDefaultState")
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
		SetSliderDialogRange(1, 10)
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

State SLSF_Reloaded_CommentChanceState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SLSF_Reloaded_CommentFrequency.GetValue() as Int)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		SLSF_Reloaded_CommentFrequency.SetValue(value)
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_CommentChanceState")
	EndEvent
	
	Event OnDefaultST()
		SLSF_Reloaded_CommentFrequency.SetValue(50)
		SetSliderOptionValueST(50, "{0}%", False, "SLSF_Reloaded_CommentChanceState")
	EndEvent
EndState

State SLSF_Reloaded_RegisterLocationState
	Event OnSelectST()
		If RegisterLocationTrigger == False
			RegisterLocationTrigger = True
		Else
			RegisterLocationTrigger = False
		EndIf
		SetToggleOptionValueST(RegisterLocationTrigger, False, "SLSF_Reloaded_RegisterLocationState")
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
		
		SetToggleOptionValueST(RegisterLocationConfirm, False, "SLSF_Reloaded_RegisterLocationConfirmState")
		
		If RegisterLocationConfirm == True
			Debug.MessageBox("Please Exit all menus to register this location. If this is a mistake, uncheck the Confirm option.")
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
		SetToggleOptionValueST(UnregisterLocationTrigger, False, "SLSF_Reloaded_UnregisterLocationState")
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
		
		SetToggleOptionValueST(UnregisterLocationConfirm, False, "SLSF_Reloaded_UnregisterLocationConfirmState")
		
		If UnregisterLocationConfirm == True
			Debug.MessageBox("Please Exit all menus to unregister the location. If this is a mistake, uncheck the Confirm option.")
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
		SetToggleOptionValueST(ClearAllFameTrigger, False, "SLSF_Reloaded_ClearAllFameState")
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
		
		SetToggleOptionValueST(ClearAllFameConfirm, False, "SLSF_Reloaded_ClearAllFameConfirmState")
		
		If ClearAllFameConfirm == True
			Debug.MessageBox("Please Exit all menus to Clear All Fame. If this is a mistake, uncheck the Confirm option.")
		EndIf
	EndEvent
EndState

State SLSF_Reloaded_UseGlobalMultiplierState
	Event OnSelectST()
		If UseGlobalFameMultiplier == False
			UseGlobalFameMultiplier = True
		Else
			UseGlobalFameMultiplier = False
		EndIf
		SetToggleOptionValueST(UseGlobalFameMultiplier, False, "SLSF_Reloaded_UseGlobalMultiplierState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_WhoreMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[0])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[0] = value
		SetSliderOptionValueST(FameCategoryMultiplier[0], "{1}", False, "SLSF_Reloaded_WhoreMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[0] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[0], "{1}", False, "SLSF_Reloaded_WhoreMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_SlutMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[1])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[1] = value
		SetSliderOptionValueST(FameCategoryMultiplier[1], "{1}", False, "SLSF_Reloaded_SlutMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[1] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[1], "{1}", False, "SLSF_Reloaded_SlutMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_ExhibitionistMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[2])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[2] = value
		SetSliderOptionValueST(FameCategoryMultiplier[2], "{1}", False, "SLSF_Reloaded_ExhibitionistMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[2] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[2], "{1}", False, "SLSF_Reloaded_ExhibitionistMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_OralMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[3])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[3] = value
		SetSliderOptionValueST(FameCategoryMultiplier[3], "{1}", False, "SLSF_Reloaded_OralMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[3] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[3], "{1}", False, "SLSF_Reloaded_OralMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_AnalMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[4])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[4] = value
		SetSliderOptionValueST(FameCategoryMultiplier[4], "{1}", False, "SLSF_Reloaded_AnalMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[4] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[4], "{1}", False, "SLSF_Reloaded_AnalMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_NastyMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[5])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[5] = value
		SetSliderOptionValueST(FameCategoryMultiplier[5], "{1}", False, "SLSF_Reloaded_NastyMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[5] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[5], "{1}", False, "SLSF_Reloaded_NastyMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_PregnantMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[6])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[6] = value
		SetSliderOptionValueST(FameCategoryMultiplier[6], "{1}", False, "SLSF_Reloaded_PregnantMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[6] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[6], "{1}", False, "SLSF_Reloaded_PregnantMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_DominantMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[7])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[7] = value
		SetSliderOptionValueST(FameCategoryMultiplier[7], "{1}", False, "SLSF_Reloaded_DominantMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[7] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[7], "{1}", False, "SLSF_Reloaded_DominantMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_SubmissiveMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[8])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[8] = value
		SetSliderOptionValueST(FameCategoryMultiplier[8], "{1}", False, "SLSF_Reloaded_SubmissiveMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[8] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[8], "{1}", False, "SLSF_Reloaded_SubmissiveMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_SadistMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[9])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[9] = value
		SetSliderOptionValueST(FameCategoryMultiplier[9], "{1}", False, "SLSF_Reloaded_SadistMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[9] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[9], "{1}", False, "SLSF_Reloaded_SadistMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_MasochistMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[10])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[10] = value
		SetSliderOptionValueST(FameCategoryMultiplier[10], "{1}", False, "SLSF_Reloaded_MasochistMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[10] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[10], "{1}", False, "SLSF_Reloaded_MasochistMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_GentleMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[11])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[11] = value
		SetSliderOptionValueST(FameCategoryMultiplier[11], "{1}", False, "SLSF_Reloaded_GentleMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[11] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[11], "{1}", False, "SLSF_Reloaded_GentleMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_LikesMenMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[12])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[12] = value
		SetSliderOptionValueST(FameCategoryMultiplier[12], "{1}", False, "SLSF_Reloaded_LikesMenMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[12] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[12], "{1}", False, "SLSF_Reloaded_LikesMenMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_LikesWomenMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[13])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[13] = value
		SetSliderOptionValueST(FameCategoryMultiplier[13], "{1}", False, "SLSF_Reloaded_LikesWomenMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[13] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[13], "{1}", False, "SLSF_Reloaded_LikesWomenMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_LikesOrcMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[14])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[14] = value
		SetSliderOptionValueST(FameCategoryMultiplier[14], "{1}", False, "SLSF_Reloaded_LikesOrcMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[14] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[14], "{1}", False, "SLSF_Reloaded_LikesOrcMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_LikesKhajiitMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[15])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[15] = value
		SetSliderOptionValueST(FameCategoryMultiplier[15], "{1}", False, "SLSF_Reloaded_LikesKhajiitMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[15] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[15], "{1}", False, "SLSF_Reloaded_LikesKhajiitMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_LikesArgonianMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[16])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[16] = value
		SetSliderOptionValueST(FameCategoryMultiplier[16], "{1}", False, "SLSF_Reloaded_LikesArgonianMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[16] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[16], "{1}", False, "SLSF_Reloaded_LikesArgonianMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_BestialityMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[17])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[17] = value
		SetSliderOptionValueST(FameCategoryMultiplier[17], "{1}", False, "SLSF_Reloaded_BestialityMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[17] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[17], "{1}", False, "SLSF_Reloaded_BestialityMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_GroupMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[18])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[18] = value
		SetSliderOptionValueST(FameCategoryMultiplier[18], "{1}", False, "SLSF_Reloaded_GroupMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[18] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[18], "{1}", False, "SLSF_Reloaded_GroupMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_BoundMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[19])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[19] = value
		SetSliderOptionValueST(FameCategoryMultiplier[19], "{1}", False, "SLSF_Reloaded_BoundMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[19] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[19], "{1}", False, "SLSF_Reloaded_BoundMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_TattooMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[20])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[20] = value
		SetSliderOptionValueST(FameCategoryMultiplier[20], "{1}", False, "SLSF_Reloaded_TattooMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[20] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[20], "{1}", False, "SLSF_Reloaded_TattooMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_CumDumpMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[21])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[21] = value
		SetSliderOptionValueST(FameCategoryMultiplier[21], "{1}", False, "SLSF_Reloaded_CumDumpMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[21] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[21], "{1}", False, "SLSF_Reloaded_CumDumpMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_UnfaithfulMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[22])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[22] = value
		SetSliderOptionValueST(FameCategoryMultiplier[22], "{1}", False, "SLSF_Reloaded_UnfaithfulMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[22] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[22], "{1}", False, "SLSF_Reloaded_UnfaithfulMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_CuckMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[23])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[23] = value
		SetSliderOptionValueST(FameCategoryMultiplier[23], "{1}", False, "SLSF_Reloaded_CuckMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[23] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[23], "{1}", False, "SLSF_Reloaded_CuckMultiplierState")
	EndEvent
EndState

State SLSF_Reloaded_AirheadMultiplierState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FameCategoryMultiplier[24])
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 3)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FameCategoryMultiplier[24] = value
		SetSliderOptionValueST(FameCategoryMultiplier[24], "{1}", False, "SLSF_Reloaded_AirheadMultiplierState")
	EndEvent
	
	Event OnDefaultST()
		FameCategoryMultiplier[24] = 1.0
		SetSliderOptionValueST(FameCategoryMultiplier[24], "{1}", False, "SLSF_Reloaded_AirheadMultiplierState")
	EndEvent
EndState