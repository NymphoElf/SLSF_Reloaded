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
Bool Property AllowBestialityWhenRaped Auto Hidden
Bool Property VictimsAreMasochist Auto Hidden
Bool Property EnableTracing Auto Hidden
Bool Property AllowSLSCursedCollarBoundFame Auto Hidden
Bool Property AllowCollarBoundFame Auto Hidden
Bool Property AllowLegacyOverwrite Auto Hidden
Bool Property DisableNakedCommentsWhilePW Auto Hidden

Bool[] Property HasFameAtDefaultLocation Auto
Bool[] Property HasFameAtCustomLocation Auto

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
Float Property CumDumpFHUReq Auto Hidden

Int Property BodyTattooSlots Auto Hidden
Int Property FaceTattooSlots Auto Hidden
Int Property HandTattooSlots Auto Hidden
Int Property FootTattooSlots Auto Hidden
Int Property BodyTattooIndex Auto Hidden
Int Property FaceTattooIndex Auto Hidden
Int Property HandTattooIndex Auto Hidden
Int Property FootTattooIndex Auto Hidden
Int[] Property DefaultLocationSpreadChance Auto
Int[] Property CustomLocationSpreadChance Auto
Int Property MaxVLowFameGain Auto Hidden
Int Property MaxLowFameGain Auto Hidden
Int Property MaxMedFameGain Auto Hidden
Int Property MaxHighFameGain Auto Hidden
Int Property MaxVHighFameGain Auto Hidden
Int Property MaxVLowFameDecay Auto Hidden
Int Property MaxLowFameDecay Auto Hidden
Int Property MaxMedFameDecay Auto Hidden
Int Property MaxHighFameDecay Auto Hidden
Int Property MaxVHighFameDecay Auto Hidden

String Property TattooStatusSelect Auto Hidden

;Registration Variables
String Property LocationDetailsSelected Auto Hidden
String Property UnregisterLocationSelection Auto Hidden
Int Property UnregisterLocationIndex Auto Hidden

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto
GlobalVariable Property SLSF_Reloaded_CommentFrequency Auto
GlobalVariable Property IsVisiblyBound Auto
GlobalVariable Property WICommentChanceNaked Auto

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
	Pages = New String[12]
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
	Pages[10] = "Registered Mods"
	Pages[11] = "Debug"
EndFunction

Function SetDefaults()
	NPCNeedsLOS = True
	ReduceFameAtNight = True
	NotifyFameIncrease = False
	NotifyFameDecay = False
	NotifyFameSpread = False
	PlayerIsAnonymous = False
	AnonymityEnabled = True
	AllowLikeFameWhenRaped = False
	AllowBestialityWhenRaped = False
	VictimsAreMasochist = False
	AllowSLSCursedCollarBoundFame = False
	AllowCollarBoundFame = False
	If Mods.IsLegacySLSFInstalled == True
		AllowLegacyOverwrite = True
	Else
		AllowLegacyOverwrite = False
	EndIf
	
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
	TattooStatusSelect = "Body"
	BodyTattooIndex = 0
	FaceTattooIndex = 0
	HandTattooIndex = 0
	FootTattooIndex = 0
	MaxVLowFameGain = 10
	MaxLowFameGain = 8
	MaxMedFameGain = 6
	MaxHighFameGain = 4
	MaxVHighFameGain = 2
	MaxVLowFameDecay = 5
	MaxLowFameDecay = 4
	MaxMedFameDecay = 3
	MaxHighFameDecay = 2
	MaxVHighFameDecay = 1
	
	UseGlobalFameMultiplier = True
	FameChangeMultiplier = 1.0
	CumDumpFHUReq = 2.0
	
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
	Pages = New String[12]
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
	Pages[10] = "Registered Mods"
	Pages[11] = "Debug"
	
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
		String FameLocation = LocationManager.CurrentLocationName()
		If FameLocation == "Haafingar"
			FameLocation = "Haafingar (Solitude)"
		ElseIf FameLocation == "Eastmarch"
			FameLocation = "Eastmarch (Windhelm)"
		ElseIf FameLocation == "the Pale"
			FameLocation = "the Pale (Dawnstar)"
		ElseIf FameLocation == "the Reach"
			FameLocation = "the Reach (Markarth)"
		ElseIf FameLocation == "the Rift"
			FameLocation = "the Rift (Riften)"
		EndIf
		AddTextOption("Fame Location:", FameLocation)
		
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
		AddHeaderOption("Legacy Overwrite")
		AddToggleOptionST("SLSF_Reloaded_AllowLegacyOverwriteState", "Overwrite Legacy SLSF", AllowLegacyOverwrite, GetDisabledOptionFlagIf(Mods.IsLegacySLSFInstalled == False))
		
		AddHeaderOption("Dom/Sub Defaults")
		AddTextOption("Sexlab P+ Installed:", (Mods.IsSexlabPlusInstalled) as String)
		AddToggleOptionST("SLSF_Reloaded_SubmissiveDefaultState", "Default to Submissive", SubmissiveDefault, GetDisabledOptionFlagIf(DominantDefault == True || Mods.IsSexlabPlusInstalled == True))
		AddToggleOptionST("SLSF_Reloaded_DominantDefaultState", "Default to Dominant", DominantDefault, GetDisabledOptionFlagIf(SubmissiveDefault == True || Mods.IsSexlabPlusInstalled == True))
		AddToggleOptionST("SLSF_Reloaded_DisableNakedCommentsWhilePWState", "No Naked Comments While Public Whore", DisableNakedCommentsWhilePW, GetDisabledOptionFlagIf(Mods.IsPWInstalled == False))
		
		AddHeaderOption("Fame Comments Settings")
		AddSliderOptionST("SLSF_Reloaded_CommentChanceState", "Fame Comment Chance:", SLSF_Reloaded_CommentFrequency.GetValue(), "{0}%", GetDisabledOptionFlagIf(Mods.IsFameCommentsInstalled == False))
		
		SetCursorPosition(1)
		AddHeaderOption("Notification Toggles")
		AddToggleOptionST("SLSF_Reloaded_NotifyFameIncreaseState", "Notify on Fame Increase", NotifyFameIncrease, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameDecayState", "Notify on Fame Decay", NotifyFameDecay, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameSpreadState", "Notify on Fame Spread", NotifyFameSpread, 0)
		
	ElseIf (page == "Fame Settings")
		AddHeaderOption("Fame Gain Settings")
		AddToggleOptionST("SLSF_Reloaded_PlayerAnonymousState", "Player Can Be Anonymous", AnonymityEnabled, 0)
		AddToggleOptionST("SLSF_Reloaded_ForeplayFameState", "Allow Foreplay Fame Bonus", AllowForeplayFame, 0)
		AddToggleOptionST("SLSF_Reloaded_AllowLikeFameWhenRapedState", "Allow 'Likes' Fame When Raped", AllowLikeFameWhenRaped, 0)
		AddToggleOptionST("SLSF_Reloaded_AllowBestialityWhenRapedState", "Allow Bestiality Fame When Raped", AllowBestialityWhenRaped, 0)
		AddToggleOptionST("SLSF_Reloaded_VictimsAreMasochistState", "Allow Masochist Fame When Raped", VictimsAreMasochist, 0)
		AddToggleOptionST("SLSF_Reloaded_AllowCollarBoundFame", "Allow Bound Fame from Collars", AllowCollarBoundFame, GetDisabledOptionFlagIf(Mods.IsDDInstalled == False))
		AddToggleOptionST("SLSF_Reloaded_AllowSLSCurseCollarBoundFameState", "Allow SLS Cursed Collar Bound Fame", AllowSLSCursedCollarBoundFame, GetDisabledOptionFlagIf(Mods.IsSLSInstalled == False || AllowCollarBoundFame == False))
		AddToggleOptionST("SLSF_Reloaded_ReduceFameAtNightState", "Reduce Fame Gain at Night", ReduceFameAtNight, 0)
		AddSliderOptionST("SLSF_Reloaded_NightStartState", "Night Starts at:", NightStart, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		AddSliderOptionST("SLSF_Reloaded_NightEndState", "Night Ends at:", NightEnd, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		AddSliderOptionST("SLSF_Reloaded_FHUThresholdState", "FHU Inflation needed for Cum Dump:", CumDumpFHUReq, "{2}", GetDisabledOptionFlagIf(Mods.IsFHUInstalled == False))
		AddSliderOptionST("SLSF_Reloaded_MaxVLowFameGainState", "Maximum Very Low Fame Gain:", MaxVLowFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxLowFameGainState", "Maximum Low Fame Gain:", MaxLowFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxMedFameGainState", "Maximum Medium Fame Gain:", MaxMedFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxHighFameGainState", "Maximum High Fame Gain:", MaxHighFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxVHighFameGainState", "Maximum Very High Fame Gain:", MaxVHighFameGain, "{0}", 0)
		
		AddHeaderOption("Fame Decay Settings")
		AddSliderOptionST("SLSF_Reloaded_DecayTimeNeededState", "Time Between Decays (Hours):", (DecayTimeNeeded / 2), "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxVLowFameDecayState", "Maximum Very Low Fame Decay:", MaxVLowFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxLowFameDecayState", "Maximum Low Fame Decay:", MaxLowFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxMedFameDecayState", "Maximum Medium Fame Decay:", MaxMedFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxHighFameDecayState", "Maximum High Fame Decay:", MaxHighFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxVHighFameDecayState", "Maximum Very High Fame Decay:", MaxVHighFameDecay, "{0}", 0)
		
		AddHeaderOption("Multiplier Settings")
		AddToggleOptionST("SLSF_Reloaded_UseGlobalMultiplierState", "Use Global Multiplier", UseGlobalFameMultiplier, 0)
		AddSliderOptionST("SLSF_Reloaded_FameChangeMultiplierState", "Global Fame Multiplier:", FameChangeMultiplier, "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == False))
		
		AddHeaderOption("Fame Spread Settings")
		AddSliderOptionST("SLSF_Reloaded_SpreadTimeNeededState", "Time Between Spreads (Hours):", (SpreadTimeNeeded / 2), "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_FailedSpreadIncreaseState", "Chance Increase on Fail:", FailedSpreadIncrease, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_SuccessfulSpreadDecreaseState", "Chance Decrease on Success:", SuccessfulSpreadReduction, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumFameToSpreadState", "Minimum Category Fame:", MinimumFameToSpread, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadCategoriesState", "Maximum Spread Categories:", MaximumSpreadCategories, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadPercentageState", "Maximum Spread Percentage:", MaximumSpreadPercentage, "{0}%", 0)
		
		AddHeaderOption("NPC Fame Chances")
		AddToggleOptionST("SLSF_Reloaded_NPCNeedsLOSState", "NPCs Need Line of Sight", NPCNeedsLOS, 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumNPCLOSDistanceState", "Minimum NPC Distance for LOS:", MinimumNPCLOSDistance as Int, "{0}", GetDisabledOptionFlagIf(NPCNeedsLOS == False))
		AddSliderOptionST("SLSF_Reloaded_FameChanceByEnemyState", "Enemy Fame Chance", FameChanceByEnemy, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByNeutralState", "Neutral Fame Chance", FameChanceByNeutral, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByFriendState", "Friend Fame Chance", FameChanceByFriend, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByLoverState", "Lover Fame Chance", FameChanceByLover, "{0}%", 0)
		
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
		AddHeaderOption("Body Tattoos")
		AddMenuOptionST("SLSF_Reloaded_BodyTattooSlotState", "Body Tattoo Slot", (BodyTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeBodySlotState", "Exclude From Fame", VisibilityManager.BodyTattooExcluded[BodyTattooIndex], 0)
		If VisibilityManager.BodyTattooApplied[BodyTattooIndex] == True
			If VisibilityManager.BodyTattooExcluded[BodyTattooIndex] == True
				AddTextOption("Slot Used:", "Yes (Excluded)")
			Else
				AddTextOption("Slot Used:", "Yes")
			EndIf
			If VisibilityManager.IsBodyTattooVisible(BodyTattooIndex) == True
				AddTextOption("Slot Visible:", "Yes")
			Else
				AddTextOption("Slot Visible:", "No")
			EndIf
		Else
			If VisibilityManager.BodyTattooExcluded[BodyTattooIndex] == True
				AddTextOption("Slot Used:", "No (Excluded)")
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
		
		SetCursorPosition(1)
		AddHeaderOption("Face Tattoos")
		AddMenuOptionST("SLSF_Reloaded_FaceTattooSlotState", "Face Tattoo Slot", (FaceTattooIndex + 1), 0)
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
		
		If Mods.IsLegacySLSFInstalled == True
			AddTextOption("Legacy SLSF", "True")
		Else
			AddTextOption("Legacy SLSF", "False")
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("Detected Conditions")
		AddTextOption("Player is Anonymous:", VisibilityManager.IsPlayerAnonymous() as String)
		
		If Mods.IsECInstalled == True
			AddTextOption("Player is Chaurus Pregnant:", Mods.IsECPregnant(PlayerScript.PlayerRef) as String)
		EndIf
		If Mods.IsESInstalled == True
			AddTextOption("Player is Spider Pregnant:", Mods.IsESPregnant(PlayerScript.PlayerRef) as String)
		EndIf
		If Mods.IsFMInstalled == True
			AddTextOption("Player is Fertility Mode Pregnant:", Mods.IsFMPregnant(PlayerScript.PlayerRef) as String)
		EndIf
		If Mods.IsHentaiPregInstalled == True
			AddTextOption("Player is Hentai Pregnant:", Mods.IsHentaiPregnant(PlayerScript.PlayerRef) as String)
		EndIf
		If Mods.IsPWInstalled == True
			AddTextOption("Player is Public Whore:", Mods.IsPublicWhore() as String)
		EndIf
		If Mods.IsFHUInstalled == True
			AddTextOption("Player's FHU Inflation:", Mods.GetFHUInflation(PlayerScript.PlayerRef) as String)
		EndIf
		
		AddTextOption("Total Visible Tattoos:", VisibilityManager.CountVisibleTattoos() as String)
		
		If IsVisiblyBound.GetValue() == 1
			AddTextOption("Visibly Bound:", "Yes")
		Else
			AddTextOption("Visibly Bound:", "No")
		EndIf
		
		If VisibilityManager.IsOralCumVisible() == True
			AddTextOption("Oral Cum Visible:", "Yes")
		Else
			AddTextOption("Oral Cum Visible:", "No")
		EndIf
		
		If PlayerScript.PlayerRef.GetActorBase().GetSex() == 0
			AddTextOption("Vaginal Cum Visible:", "N/A")
		ElseIf VisibilityManager.IsVaginalCumVisible() == True
			AddTextOption("Vaginal Cum Visible:", "Yes")
		Else
			AddTextOption("Vaginal Cum Visible:", "No")
		EndIf
		
		If VisibilityManager.IsAssCumVisible() == True
			AddTextOption("Anal Cum Visible:", "Yes")
		Else
			AddTextOption("Anal Cum Visible:", "No")
		EndIf
		
		Float DecayTimeBase = (FameManager.DecayCountdown / 2)
		Int DecayCountdownHours = DecayTimeBase as Int
		Int DecayCountdownHalfHours = ((DecayTimeBase - DecayCountdownHours) * 10) as Int
		
		Float SpreadTimeBase = (FameManager.SpreadCountdown / 2)
		Int SpreadCountdownHours = SpreadTimeBase as Int
		Int SpreadCountdownHalfHours = ((SpreadTimeBase - SpreadCountdownHours) * 10) as Int
		
		AddHeaderOption("Decay & Spread Timers")
		AddTextOption("Time Until Decay:", DecayCountdownHours + "." + DecayCountdownHalfHours + " Hours")
		AddTextOption("Time Until Spread:", SpreadCountdownHours + "." + SpreadCountdownHalfHours + " Hours")
	
	ElseIf (page == "Tattoo Info")
		AddHeaderOption("Select Tattoo Area")
		AddMenuOptionST("SLSF_Reloaded_TattooStatusState", "Tattoo Area:", TattooStatusSelect, 0)
		
		AddHeaderOption("Visibility Status")
		Int TattooIndex = 0
		Int SlotNumber = 1
		If TattooStatusSelect == "Body"
			While TattooIndex < BodyTattooSlots
				If BodyTattooSlots > 8 && TattooIndex == (BodyTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsBodyTattooVisible(TattooIndex) == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "Face"
			While TattooIndex < FaceTattooSlots
				If FaceTattooSlots > 8 && TattooIndex == (FaceTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsFaceTattooVisible(TattooIndex) == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "Hands"
			While TattooIndex < HandTattooSlots
				If HandTattooSlots > 8 && TattooIndex == (HandTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsHandTattooVisible(TattooIndex) == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "Feet"
			While TattooIndex < FootTattooSlots
				If FootTattooSlots > 8 && TattooIndex == (FootTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsFootTattooVisible(TattooIndex) == True
					AddTextOption("Slot " + SlotNumber, "Yes")
				Else
					AddTextOption("Slot " + SlotNumber, "No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
	
	ElseIf (page == "Decay Info")
		Float TimeBase = (FameManager.DecayCountdown / 2)
		Int CountdownHours = TimeBase as Int
		Int CountdownHalfHours = ((TimeBase - CountdownHours) * 10) as Int
		
		AddTextOption("Decay Countdown:", CountdownHours + "." + CountdownHalfHours + " Hours")
		AddHeaderOption("Default Locations")
		Int LocationIndex = 0
		While LocationIndex < LocationManager.DefaultLocation.Length
			AddTextOption(LocationManager.DefaultLocation[LocationIndex] + " Can Decay:", (FameManager.DefaultLocationCanDecay[LocationIndex] && HasFameAtDefaultLocation[LocationIndex]) as String)
			;AddTextOption(LocationManager.DefaultLocation[LocationIndex] + " Decay Pause Timer:", FameManager.DefaultLocationDecayPauseTimer[LocationIndex] as String)
			LocationIndex += 1
		EndWhile
		
		LocationIndex = 0
		
		SetCursorPosition(3)
		AddHeaderOption("Custom Locations")
		While LocationIndex < LocationManager.CustomLocation.Length
			AddTextOption(LocationManager.CustomLocation[LocationIndex] + " Can Decay:", (FameManager.CustomLocationCanDecay[LocationIndex] && HasFameAtCustomLocation[LocationIndex]) as String)
			;AddTextOption(LocationManager.CustomLocation[LocationIndex] + " Decay Pause Timer:", FameManager.CustomLocationDecayPauseTimer[LocationIndex] as String)
			LocationIndex += 1
		EndWhile
		
	ElseIf (page == "Spread Info")
		Float TimeBase = (FameManager.SpreadCountdown / 2)
		Int CountdownHours = TimeBase as Int
		Int CountdownHalfHours = ((TimeBase - CountdownHours) * 10) as Int
		
		AddTextOption("Spread Countdown:", CountdownHours + "." + CountdownHalfHours + " Hours")
		AddHeaderOption("Default Locations")
		
		Int LocationIndex = 0
		While LocationIndex < LocationManager.DefaultLocation.Length
			AddTextOption(LocationManager.DefaultLocation[LocationIndex] + " Can Spread:", Data.DefaultLocationHasSpreadableFame[LocationIndex] as String)
			;AddTextOption(LocationManager.DefaultLocation[LocationIndex] + " Spread Pause Timer:", FameManager.DefaultLocationSpreadPauseTimer[LocationIndex] as String)
			LocationIndex += 1
		EndWhile
		
		LocationIndex = 0
		SetCursorPosition(3)
		AddHeaderOption("Custom Locations")
		While LocationIndex < LocationManager.CustomLocation.Length
			AddTextOption(LocationManager.CustomLocation[LocationIndex] + " Can Spread:", Data.CustomLocationHasSpreadableFame[LocationIndex] as String)
			;AddTextOption(LocationManager.CustomLocation[LocationIndex] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[LocationIndex] as String)
			LocationIndex += 1
		EndWhile
		
	ElseIf (page == "Registered Mods")
		Int PageFillIndex = 0
		Int ModCount = Data.CountExternalMods()
		AddTextOption("Number of Mods:", ModCount + " (" + Data.ExternalMods.Length + " Max)")
		AddHeaderOption("Registered Mod List")
		While PageFillIndex < ModCount
			If PageFillIndex == (Data.ExternalMods.Length / 2)
				SetCursorPosition(5)
			EndIf
			AddTextOption(Data.ExternalMods[PageFillIndex], "")
			PageFillIndex += 1
		EndWhile
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

State SLSF_Reloaded_VictimsAreMasochistState
	Event OnSelectST()
		If VictimsAreMasochist == False
			VictimsAreMasochist = True
		Else
			VictimsAreMasochist = False
		EndIf
		
		SetToggleOptionValueST(VictimsAreMasochist)
	EndEvent
EndState

State SLSF_Reloaded_AllowBestialityWhenRapedState
	Event OnSelectST()
		If AllowBestialityWhenRaped == False
			AllowBestialityWhenRaped = True
		Else
			AllowBestialityWhenRaped = False
		EndIf
		
		SetToggleOptionValueST(AllowBestialityWhenRaped)
	EndEvent
EndState

State SLSF_Reloaded_DisableNakedCommentsWhilePWState
	Event OnSelectST()
		If DisableNakedCommentsWhilePW == False
			DisableNakedCommentsWhilePW = True
		Else
			DisableNakedCommentsWhilePW = False
		EndIf
		
		SetToggleOptionValueST(DisableNakedCommentsWhilePW)
	EndEvent
EndState

State SLSF_Reloaded_AllowLegacyOverwriteState
	Event OnSelectST()
		If AllowLegacyOverwrite == False
			AllowLegacyOverwrite = True
		Else
			AllowLegacyOverwrite = False
		EndIf
		
		SetToggleOptionValueST(AllowLegacyOverwrite)
	EndEvent
EndState

State SLSF_Reloaded_AllowCollarBoundFame
	Event OnSelectST()
		If AllowCollarBoundFame == False
			AllowCollarBoundFame = True
		Else
			AllowCollarBoundFame = False
		EndIf
		
		SetToggleOptionValueST(AllowCollarBoundFame)
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_AllowSLSCurseCollarBoundFameState
	Event OnSelectST()
		If AllowSLSCursedCollarBoundFame == False
			AllowSLSCursedCollarBoundFame = True
		Else
			AllowSLSCursedCollarBoundFame = False
		EndIf
		
		SetToggleOptionValueST(AllowSLSCursedCollarBoundFame)
	EndEvent
EndState

State SLSF_Reloaded_MaxVLowFameGainState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxVLowFameGain)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxVLowFameGain = value as Int
		SetSliderOptionValueST(MaxVLowFameGain, "{0}", False, "SLSF_Reloaded_MaxVLowFameGainState")
	EndEvent
	
	Event OnDefaultST()
		MaxVLowFameGain = 10
		SetSliderOptionValueST(MaxVLowFameGain, "{0}", False, "SLSF_Reloaded_MaxVLowFameGainState")
	EndEvent
EndState

State SLSF_Reloaded_MaxLowFameGainState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxLowFameGain)
		SetSliderDialogDefaultValue(8)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxLowFameGain = value as Int
		SetSliderOptionValueST(MaxLowFameGain, "{0}", False, "SLSF_Reloaded_MaxLowFameGainState")
	EndEvent
	
	Event OnDefaultST()
		MaxLowFameGain = 8
		SetSliderOptionValueST(MaxLowFameGain, "{0}", False, "SLSF_Reloaded_MaxLowFameGainState")
	EndEvent
EndState

State SLSF_Reloaded_MaxMedFameGainState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxMedFameGain)
		SetSliderDialogDefaultValue(6)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxMedFameGain = value as Int
		SetSliderOptionValueST(MaxMedFameGain, "{0}", False, "SLSF_Reloaded_MaxMedFameGainState")
	EndEvent
	
	Event OnDefaultST()
		MaxMedFameGain = 6
		SetSliderOptionValueST(MaxMedFameGain, "{0}", False, "SLSF_Reloaded_MaxMedFameGainState")
	EndEvent
EndState

State SLSF_Reloaded_MaxHighFameGainState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxHighFameGain)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxHighFameGain = value as Int
		SetSliderOptionValueST(MaxHighFameGain, "{0}", False, "SLSF_Reloaded_MaxHighFameGainState")
	EndEvent
	
	Event OnDefaultST()
		MaxHighFameGain = 4
		SetSliderOptionValueST(MaxHighFameGain, "{0}", False, "SLSF_Reloaded_MaxHighFameGainState")
	EndEvent
EndState

State SLSF_Reloaded_MaxVHighFameGainState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxVHighFameGain)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxVHighFameGain = value as Int
		SetSliderOptionValueST(MaxVHighFameGain, "{0}", False, "SLSF_Reloaded_MaxVHighFameGainState")
	EndEvent
	
	Event OnDefaultST()
		MaxVHighFameGain = 2
		SetSliderOptionValueST(MaxVHighFameGain, "{0}", False, "SLSF_Reloaded_MaxVHighFameGainState")
	EndEvent
EndState

State SLSF_Reloaded_MaxVLowFameDecayState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxVLowFameDecay)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxVLowFameDecay = value as Int
		SetSliderOptionValueST(MaxVLowFameDecay, "{0}", False, "SLSF_Reloaded_MaxVLowFameDecayState")
	EndEvent
	
	Event OnDefaultST()
		MaxVLowFameDecay = 5
		SetSliderOptionValueST(MaxVLowFameDecay, "{0}", False, "SLSF_Reloaded_MaxVLowFameDecayState")
	EndEvent
EndState

State SLSF_Reloaded_MaxLowFameDecayState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxLowFameDecay)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxLowFameDecay = value as Int
		SetSliderOptionValueST(MaxLowFameDecay, "{0}", False, "SLSF_Reloaded_MaxLowFameDecayState")
	EndEvent
	
	Event OnDefaultST()
		MaxLowFameDecay = 4
		SetSliderOptionValueST(MaxLowFameDecay, "{0}", False, "SLSF_Reloaded_MaxLowFameDecayState")
	EndEvent
EndState

State SLSF_Reloaded_MaxMedFameDecayState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxMedFameDecay)
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxMedFameDecay = value as Int
		SetSliderOptionValueST(MaxMedFameDecay, "{0}", False, "SLSF_Reloaded_MaxMedFameDecayState")
	EndEvent
	
	Event OnDefaultST()
		MaxMedFameDecay = 3
		SetSliderOptionValueST(MaxMedFameDecay, "{0}", False, "SLSF_Reloaded_MaxMedFameDecayState")
	EndEvent
EndState

State SLSF_Reloaded_MaxHighFameDecayState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxHighFameDecay)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxHighFameDecay = value as Int
		SetSliderOptionValueST(MaxHighFameDecay, "{0}", False, "SLSF_Reloaded_MaxHighFameDecayState")
	EndEvent
	
	Event OnDefaultST()
		MaxHighFameDecay = 4
		SetSliderOptionValueST(MaxHighFameDecay, "{0}", False, "SLSF_Reloaded_MaxHighFameDecayState")
	EndEvent
EndState

State SLSF_Reloaded_MaxVHighFameDecayState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MaxVHighFameDecay)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MaxVHighFameDecay = value as Int
		SetSliderOptionValueST(MaxVHighFameDecay, "{0}", False, "SLSF_Reloaded_MaxVHighFameDecayState")
	EndEvent
	
	Event OnDefaultST()
		MaxVHighFameDecay = 2
		SetSliderOptionValueST(MaxVHighFameDecay, "{0}", False, "SLSF_Reloaded_MaxVHighFameDecayState")
	EndEvent
EndState

State SLSF_Reloaded_FHUThresholdState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(CumDumpFHUReq)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.5, 4.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		CumDumpFHUReq = value
		SetSliderOptionValueST(CumDumpFHUReq, "{2}", False, "SLSF_Reloaded_FHUThresholdState")
	EndEvent
	
	Event OnDefaultST()
		CumDumpFHUReq = 2.0
		SetSliderOptionValueST(CumDumpFHUReq, "{2}", False, "SLSF_Reloaded_FHUThresholdState")
	EndEvent
EndState

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
		String[] BodySlotIndex = Utility.CreateStringArray(BodyTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < BodyTattooSlots
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
		String[] FaceSlotIndex = Utility.CreateStringArray(FaceTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < FaceTattooSlots
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
		String[] HandSlotIndex = Utility.CreateStringArray(HandTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < HandTattooSlots
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
		String[] FootSlotIndex = Utility.CreateStringArray(FootTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < FootTattooSlots
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
		SetSliderDialogStartValue(MinimumNPCLOSDistance)
		SetSliderDialogDefaultValue(160)
		SetSliderDialogRange(32, 1024)
		SetSliderDialogInterval(32) ;Skyrim Units, which we are doing in steps of 32, or ~18 inches
	EndEvent
	
	Event OnSliderAcceptST(float value)
		MinimumNPCLOSDistance = value
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