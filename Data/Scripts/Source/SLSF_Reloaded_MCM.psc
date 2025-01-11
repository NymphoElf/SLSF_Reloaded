ScriptName SLSF_Reloaded_MCM extends SKI_ConfigBase

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_CommentManager Property Comments Auto
SLSF_Reloaded_Data_Exporter Property DataExporter Auto
SLSF_Reloaded_Data_Importer Property DataImporter Auto
SLSF_Reloaded_Uninstall Property Uninstaller Auto

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
Bool Property ExportData Auto Hidden
Bool Property ImportData Auto Hidden
Bool Property ArmUninstall Auto Hidden
Bool Property ConfirmUninstall Auto Hidden
Bool Property FriendsBetrayFromHighFame Auto Hidden
Bool Property LoversBetrayFromHighFame Auto Hidden

Bool[] Property HasFameAtDefaultLocation Auto
Bool[] Property HasFameAtCustomLocation Auto
Bool[] Property FameForbiddenByFriend Auto
Bool[] Property FameForbiddenByLover Auto

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
Float Property SexFameChanceByFriend Auto Hidden
Float Property FameChanceByLover Auto Hidden
Float Property SexFameChanceByLover Auto Hidden
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
Int Property LocationDetailsIndex Auto Hidden
Int Property FriendBetrayChance Auto Hidden
Int Property FriendHighFameThreshold Auto Hidden
Int Property LoverBetrayChance Auto Hidden
Int Property LoverHighFameThreshold Auto Hidden
Int[] Property OptionID Auto Hidden

String Property TattooStatusSelect Auto Hidden

;Registration Variables
String Property LocationDetailsSelected Auto Hidden
String Property UnregisterLocationSelection Auto Hidden
Int Property UnregisterLocationIndex Auto Hidden

String Property ExportName Auto Hidden

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto
GlobalVariable Property SLSF_Reloaded_CommentFrequency Auto
GlobalVariable Property IsVisiblyBound Auto
GlobalVariable Property WICommentChanceNaked Auto

Event OnConfigInit()
	Utility.Wait(1.0)
	Debug.Notification("$MCMInitializingMSG")
	RegisterForSingleUpdate(1)
EndEvent

Event OnUpdate()
	InstallMCM()
	SetDefaults()
	Debug.Notification("$MCMReadyMSG")
EndEvent

Function InstallMCM()
	ModName = "$SLSFReloadedTitle"
	Pages = New String[13]
	Pages[0] = "$FameOverviewPage"
	Pages[1] = "$DetailedFameViewPage"
	Pages[2] = "$GeneralSettingsPage"
	Pages[3] = "$FameSettingsPage"
	Pages[4] = "$FriendLoverSettingsPage"
	Pages[5] = "$TattooSettingsPage"
	Pages[6] = "$CustomLocationsPage"
	Pages[7] = "$GeneralInfoPage"
	Pages[8] = "$TattooInfoPage"
	Pages[9] = "$DecayInfoPage"
	Pages[10] = "$SpreadInfoPage"
	Pages[11] = "$RegisteredModsPage"
	Pages[12] = "$MiscPage"
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
	SexFameChanceByFriend = 50
	FameChanceByLover = 25
	SexFameChanceByLover = 25
	TattooStatusSelect = "$BodyArea"
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
	FriendBetrayChance = 50
	LoverBetrayChance = 25
	
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
	
	UnregisterLocationSelection = ""
	
	ClearAllFameConfirm = False
	ClearAllFameTrigger = False
	
	LocationDetailsSelected = LocationManager.MajorLocations[0].GetName()
	AllowForeplayFame = True
	EnableTracing = False
	
	SLSF_Reloaded_CommentFrequency.SetValue(50)
	
	ExportData = False
	ImportData = False
	ExportName = ""
	
	ArmUninstall = False
	ConfirmUninstall = False
	
	FriendsBetrayFromHighFame = True
	LoversBetrayFromHighFame = True
	FriendHighFameThreshold = 0
	LoverHighFameThreshold = 50
EndFunction

Int Function PullFameSpreadChance(String LocationName)
	Int DefaultLocationsNumber = LocationManager.DefaultLocation.Length
	Int CustomLocationsNumber = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	Int TotalLocations = DefaultLocationsNumber + CustomLocationsNumber
	Int LocationIndex = 0
	
	While LocationIndex < TotalLocations
		If LocationIndex < DefaultLocationsNumber
			If LocationIndex < LocationManager.MajorLocations.Length && LocationName == LocationManager.MajorLocations[LocationIndex].GetName()
				return DefaultLocationSpreadChance[LocationIndex]
			ElseIf LocationIndex >= LocationManager.MajorLocations.Length \
			&& (LocationIndex - LocationManager.MajorLocations.Length) < LocationManager.MinorLocations.Length \
			&& LocationName == LocationManager.MinorLocations[(LocationIndex - LocationManager.MajorLocations.Length)].GetName()
				return DefaultLocationSpreadChance[LocationIndex]
			EndIf
		Else
			If LocationName == LocationManager.CustomLocation[(LocationIndex - DefaultLocationsNumber)]
				return CustomLocationSpreadChance[(LocationIndex - DefaultLocationsNumber)]
			EndIf
		EndIf
		
		LocationIndex += 1
	EndWhile
	return -1
EndFunction

String Function LocationDetailsLookup()
	If LocationDetailsIndex < LocationManager.DefaultLocation.Length
		return LocationManager.DefaultLocation[LocationDetailsIndex]
	Else
		return LocationManager.CustomLocation[(LocationDetailsIndex - LocationManager.DefaultLocation.Length)]
	EndIf
EndFunction

Function CheckClearAllFame()
	If ClearAllFameConfirm == True
		Utility.Wait(1.0)
		Debug.Notification("$ClearAllFameMSG")
		FameManager.ClearAllFame()
	EndIf
EndFunction

Function CheckLocationRegister()
	If RegisterLocationConfirm == True
		Utility.Wait(1.0)
		Debug.Notification("$RegisterLocationMSG")
		LocationManager.RegisterCustomLocation()
	EndIf
EndFunction

Function CheckLocationUnregister()
	If UnregisterLocationConfirm == True
		Utility.Wait(1.0)
		Debug.Notification("$UnregisterLocationMSG")
		LocationManager.UnregisterCustomLocation(UnregisterLocationIndex)
	EndIf
EndFunction

Event OnConfigOpen()
	Pages = New String[13]
	Pages[0] = "$FameOverviewPage"
	Pages[1] = "$DetailedFameViewPage"
	Pages[2] = "$GeneralSettingsPage"
	Pages[3] = "$FameSettingsPage"
	Pages[4] = "$FriendLoverSettingsPage"
	Pages[5] = "$TattooSettingsPage"
	Pages[6] = "$CustomLocationsPage"
	Pages[7] = "$GeneralInfoPage"
	Pages[8] = "$TattooInfoPage"
	Pages[9] = "$DecayInfoPage"
	Pages[10] = "$SpreadInfoPage"
	Pages[11] = "$RegisteredModsPage"
	Pages[12] = "$MiscPage"
	
	VisibilityManager.RegisterForSingleUpdate(0.1)
	
	If Mods.IsPWInstalled == False
		DisableNakedCommentsWhilePW = False
	EndIf
	
	If Mods.IsDDInstalled == False
		AllowCollarBoundFame = False
		AllowSLSCursedCollarBoundFame = False
	EndIf
	
	If Mods.IsSLSInstalled == False
		AllowSLSCursedCollarBoundFame = False
	EndIf
EndEvent

Event OnConfigClose()
	CheckClearAllFame()
	CheckLocationRegister()
	CheckLocationUnregister()
	
	If ExportData == True
		DataExporter.RunExport(ExportName)
	EndIf
	
	If ImportData == True
		DataImporter.RunImport(ExportName)
	EndIf
	
	If ArmUninstall == True && ConfirmUninstall == True
		Uninstaller.RunUninstall()
	EndIf
	
	ArmUninstall = False
	ConfirmUninstall = False
	ExportData = False
	ImportData = False
	ClearAllFameTrigger = False
	ClearAllFameConfirm = False
	RegisterLocationTrigger = False
	RegisterLocationConfirm = False
	UnregisterLocationTrigger = False
	UnregisterLocationConfirm = False
	UnregisterLocationSelection = ""
EndEvent

Event OnPageReset(String page)
	
	If (page == "")
		LoadCustomContent("SLSF Reloaded/SLSFReloadedLogo.dds", 250, 0)
		return
	Else
		UnloadCustomContent()
	EndIf
	
	OptionID = New Int[50]
	
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	If (page == "$FameOverviewPage")
		AddHeaderOption("$DefaultLocationWithFame")
		If HasFameAtDefaultLocation[0] == True
			AddTextOption(LocationManager.MajorLocations[0].GetName(), "$TrueText") ;Whiterun
		Else
			AddTextOption(LocationManager.MajorLocations[0].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[1] == True
			AddTextOption(LocationManager.MajorLocations[1].GetName(), "$TrueText") ;Winterhold
		Else
			AddTextOption(LocationManager.MajorLocations[1].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[2] == True
			AddTextOption(LocationManager.MajorLocations[2].GetName(), "$TrueText") ;Windhelm
		Else
			AddTextOption(LocationManager.MajorLocations[2].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[3] == True
			AddTextOption(LocationManager.MajorLocations[3].GetName(), "$TrueText") ;Solitude
		Else
			AddTextOption(LocationManager.MajorLocations[3].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[4] == True
			AddTextOption(LocationManager.MajorLocations[4].GetName(), "$TrueText") ;Riften
		Else
			AddTextOption(LocationManager.MajorLocations[4].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[5] == True
			AddTextOption(LocationManager.MajorLocations[5].GetName(), "$TrueText") ;Markarth
		Else
			AddTextOption(LocationManager.MajorLocations[5].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[6] == True
			AddTextOption(LocationManager.MajorLocations[6].GetName(), "$TrueText") ;Morthal
		Else
			AddTextOption(LocationManager.MajorLocations[6].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[7] == True
			AddTextOption(LocationManager.MajorLocations[7].GetName(), "$TrueText") ;Dawnstar
		Else
			AddTextOption(LocationManager.MajorLocations[7].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[8] == True
			AddTextOption(LocationManager.MajorLocations[8].GetName(), "$TrueText") ;Falkreath
		Else
			AddTextOption(LocationManager.MajorLocations[8].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[9] == True
			AddTextOption(LocationManager.MajorLocations[9].GetName(), "$TrueText") ;Raven Rock
		Else
			AddTextOption(LocationManager.MajorLocations[9].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[10] == True
			AddTextOption(LocationManager.MinorLocations[0].GetName(), "$TrueText") ;Riverwood
		Else
			AddTextOption(LocationManager.MinorLocations[0].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[11] == True
			AddTextOption(LocationManager.MinorLocations[1].GetName(), "$TrueText") ;Rorikstead
		Else
			AddTextOption(LocationManager.MinorLocations[1].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[12] == True
			AddTextOption(LocationManager.MinorLocations[2].GetName(), "$TrueText") ;Ivarstead
		Else
			AddTextOption(LocationManager.MinorLocations[2].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[13] == True
			AddTextOption(LocationManager.MinorLocations[3].GetName(), "$TrueText") ;Shor's Stone
		Else
			AddTextOption(LocationManager.MinorLocations[3].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[14] == True
			AddTextOption(LocationManager.MinorLocations[4].GetName(), "$TrueText") ;Dragon Bridge
		Else
			AddTextOption(LocationManager.MinorLocations[4].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[15] == True
			AddTextOption(LocationManager.MinorLocations[5].GetName(), "$TrueText") ;Karthwasten
		Else
			AddTextOption(LocationManager.MinorLocations[5].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[16] == True
			AddTextOption(LocationManager.MinorLocations[6].GetName(), "$TrueText") ;Skaal Village
		Else
			AddTextOption(LocationManager.MinorLocations[6].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[17] == True
			AddTextOption(LocationManager.MinorLocations[7].GetName(), "$TrueText") ;Largashbur
		Else
			AddTextOption(LocationManager.MinorLocations[7].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[18] == True
			AddTextOption(LocationManager.MinorLocations[8].GetName(), "$TrueText") ;Dushnikh Yal
		Else
			AddTextOption(LocationManager.MinorLocations[8].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[19] == True
			AddTextOption(LocationManager.MinorLocations[9].GetName(), "$TrueText") ;Mor Khazgur
		Else
			AddTextOption(LocationManager.MinorLocations[9].GetName(), "$FalseText")
		EndIf
		
		If HasFameAtDefaultLocation[20] == True
			AddTextOption(LocationManager.MinorLocations[10].GetName(), "$TrueText") ;Narzulbur
		Else
			AddTextOption(LocationManager.MinorLocations[10].GetName(), "$FalseText")
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("$CustomLocationWithFame")
		
		If HasFameAtCustomLocation[0] == True
			AddTextOption(LocationManager.CustomLocation[0], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[0], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[1] == True
			AddTextOption(LocationManager.CustomLocation[1], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[1], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[2] == True
			AddTextOption(LocationManager.CustomLocation[2], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[2], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[3] == True
			AddTextOption(LocationManager.CustomLocation[3], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[3], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[4] == True
			AddTextOption(LocationManager.CustomLocation[4], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[4], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[5] == True
			AddTextOption(LocationManager.CustomLocation[5], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[5], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[6] == True
			AddTextOption(LocationManager.CustomLocation[6], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[6], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[7] == True
			AddTextOption(LocationManager.CustomLocation[7], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[7], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[8] == True
			AddTextOption(LocationManager.CustomLocation[8], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[8], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[9] == True
			AddTextOption(LocationManager.CustomLocation[9], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[9], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[10] == True
			AddTextOption(LocationManager.CustomLocation[10], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[10], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[11] == True
			AddTextOption(LocationManager.CustomLocation[11], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[11], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[12] == True
			AddTextOption(LocationManager.CustomLocation[12], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[12], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[13] == True
			AddTextOption(LocationManager.CustomLocation[13], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[13], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[14] == True
			AddTextOption(LocationManager.CustomLocation[14], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[14], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[15] == True
			AddTextOption(LocationManager.CustomLocation[15], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[15], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[16] == True
			AddTextOption(LocationManager.CustomLocation[16], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[16], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[17] == True
			AddTextOption(LocationManager.CustomLocation[17], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[17], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[18] == True
			AddTextOption(LocationManager.CustomLocation[18], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[18], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[19] == True
			AddTextOption(LocationManager.CustomLocation[19], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[19], "$FalseText")
		EndIf
		
		If HasFameAtCustomLocation[20] == True
			AddTextOption(LocationManager.CustomLocation[20], "$TrueText")
		Else
			AddTextOption(LocationManager.CustomLocation[20], "$FalseText")
		EndIf
		
	ElseIf (page == "$DetailedFameViewPage")
		AddHeaderOption("$CurrentLocationHeader")
		If LocationManager.CurrentLocation != None
			AddTextOption("$DetectedLocation", LocationManager.CurrentLocation.GetName())
		Else
			AddTextOption("$DetectedLocation", "$NoneText")
		EndIf
		String FameLocation = LocationManager.GetLocalizedName(LocationManager.CurrentLocation)
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
		AddTextOption("$FameLocation", FameLocation)
		
		SetCursorPosition(1)
		AddHeaderOption("$SelectedLocationHeader")
		AddMenuOptionST("SLSF_Reloaded_LocationDetailsState", "$Showing", LocationDetailsSelected, 0)
		AddTextOption("$ChanceToSpread", PullFameSpreadChance(LocationDetailsSelected) + "%")
		
		String DataLocation = LocationDetailsLookup()
		
		SetCursorPosition(6)
		AddHeaderOption("")
		SetCursorPosition(7)
		AddHeaderOption("")
		
		SetCursorPosition(8)
		AddTextOption("$SlutFame", Data.GetFameValue(DataLocation, "Slut") as String)
		AddTextOption("$WhoreFame", Data.GetFameValue(DataLocation, "Whore") as String)
		AddTextOption("$ExhibitionistFame", Data.GetFameValue(DataLocation, "Exhibitionist") as String)
		AddTextOption("$OralFame", Data.GetFameValue(DataLocation, "Oral") as String)
		AddTextOption("$AnalFame", Data.GetFameValue(DataLocation, "Anal") as String)
		AddTextOption("$NastyFame", Data.GetFameValue(DataLocation, "Nasty") as String)
		AddTextOption("$PregnantFame", Data.GetFameValue(DataLocation, "Pregnant") as String)
		AddTextOption("$DominantFame", Data.GetFameValue(DataLocation, "Dominant") as String)
		AddTextOption("$SubmissiveFame", Data.GetFameValue(DataLocation, "Submissive") as String)
		AddTextOption("$SadistFame", Data.GetFameValue(DataLocation, "Sadist") as String)
		AddTextOption("$MasochistFame", Data.GetFameValue(DataLocation, "Masochist") as String)
		
		If Mods.IsFameCommentsInstalled == True
			AddTextOption("$UnfaithfulFame", Data.GetFameValue(DataLocation, "Unfaithful") as String)
		EndIf
		
		If Mods.IsBimbosInstalled == True
			AddTextOption("$AirheadFame", Data.GetFameValue(DataLocation, "Airhead") as String)
		EndIf
		
		SetCursorPosition(9)
		AddTextOption("$GentleFame", Data.GetFameValue(DataLocation, "Gentle") as String)
		AddTextOption("$LikesMenFame", Data.GetFameValue(DataLocation, "Likes Men") as String)
		AddTextOption("$LikesWomenFame", Data.GetFameValue(DataLocation, "Likes Women") as String)
		AddTextOption("$LikesOrcFame", Data.GetFameValue(DataLocation, "Likes Orc") as String)
		AddTextOption("$LikesKhajiitFame", Data.GetFameValue(DataLocation, "Likes Khajiit") as String)
		AddTextOption("$LikesArgonianFame", Data.GetFameValue(DataLocation, "Likes Argonian") as String)
		AddTextOption("$BestialityFame", Data.GetFameValue(DataLocation, "Bestiality") as String)
		AddTextOption("$GroupFame", Data.GetFameValue(DataLocation, "Group") as String)
		AddTextOption("$BoundFame", Data.GetFameValue(DataLocation, "Bound") as String)
		AddTextOption("$TattooFame", Data.GetFameValue(DataLocation, "Tattoo") as String)
		
		If Mods.IsFHUInstalled == True
			AddTextOption("$CumDumpFame", Data.GetFameValue(DataLocation, "Cum Dump") as String)
		EndIf
		
		If Mods.IsFameCommentsInstalled == True
			AddTextOption("$CuckFame", Data.GetFameValue(DataLocation, "Cuck") as String)
		EndIf
	
	ElseIf (page == "$GeneralSettingsPage")
		AddHeaderOption("$LegacyOverwriteHeader")
		AddToggleOptionST("SLSF_Reloaded_AllowLegacyOverwriteState", "$LegacyOverwriteToggle", AllowLegacyOverwrite, GetDisabledOptionFlagIf(Mods.IsLegacySLSFInstalled == False))
		
		AddHeaderOption("$DomSubHeader")
		AddToggleOptionST("SLSF_Reloaded_SubmissiveDefaultState", "$SubOnly", SubmissiveDefault, GetDisabledOptionFlagIf(DominantDefault == True))
		AddToggleOptionST("SLSF_Reloaded_DominantDefaultState", "$DomOnly", DominantDefault, GetDisabledOptionFlagIf(SubmissiveDefault == True))
		
		AddHeaderOption("$CommentSettingsHeader")
		AddSliderOptionST("SLSF_Reloaded_CommentChanceState", "$CommentChance", SLSF_Reloaded_CommentFrequency.GetValue(), "{0}%", GetDisabledOptionFlagIf(Mods.IsFameCommentsInstalled == False))
		AddToggleOptionST("SLSF_Reloaded_DisableNakedCommentsWhilePWState", "$NoCommentWhilePW", DisableNakedCommentsWhilePW, GetDisabledOptionFlagIf(Mods.IsPWInstalled == False))
		
		SetCursorPosition(1)
		AddHeaderOption("$NotificationHeader")
		AddToggleOptionST("SLSF_Reloaded_NotifyFameIncreaseState", "$NotifyIncrease", NotifyFameIncrease, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameDecayState", "$NotifyDecay", NotifyFameDecay, 0)
		AddToggleOptionST("SLSF_Reloaded_NotifyFameSpreadState", "$NotifySpread", NotifyFameSpread, 0)
		
	ElseIf (page == "$FameSettingsPage")
		AddHeaderOption("$FameGainSettingsHeader")
		AddToggleOptionST("SLSF_Reloaded_PlayerAnonymousState", "$PlayerAnonymous", AnonymityEnabled, 0)
		AddToggleOptionST("SLSF_Reloaded_ForeplayFameState", "$ForeplayBonus", AllowForeplayFame, 0)
		AddToggleOptionST("SLSF_Reloaded_AllowLikeFameWhenRapedState", "$LikeFameWhenRaped", AllowLikeFameWhenRaped, 0)
		AddToggleOptionST("SLSF_Reloaded_AllowBestialityWhenRapedState", "$BestialityWhenRaped", AllowBestialityWhenRaped, 0)
		AddToggleOptionST("SLSF_Reloaded_VictimsAreMasochistState", "$VictimMasochist", VictimsAreMasochist, 0)
		AddToggleOptionST("SLSF_Reloaded_AllowCollarBoundFame", "$BoundFameFromCollar", AllowCollarBoundFame, GetDisabledOptionFlagIf(Mods.IsDDInstalled == False))
		AddToggleOptionST("SLSF_Reloaded_AllowSLSCurseCollarBoundFameState", "$SLSCollarFame", AllowSLSCursedCollarBoundFame, GetDisabledOptionFlagIf(Mods.IsSLSInstalled == False || AllowCollarBoundFame == False))
		AddToggleOptionST("SLSF_Reloaded_ReduceFameAtNightState", "$NightReduction", ReduceFameAtNight, 0)
		AddSliderOptionST("SLSF_Reloaded_NightStartState", "$NightStart", NightStart, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		AddSliderOptionST("SLSF_Reloaded_NightEndState", "$NightEnd", NightEnd, "{0}", GetDisabledOptionFlagIf(ReduceFameAtNight == False))
		AddSliderOptionST("SLSF_Reloaded_FHUThresholdState", "$InflationForCumDump", CumDumpFHUReq, "{2}", GetDisabledOptionFlagIf(Mods.IsFHUInstalled == False))
		AddSliderOptionST("SLSF_Reloaded_MaxVLowFameGainState", "$VeryLowFameGain", MaxVLowFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxLowFameGainState", "$LowFameGain", MaxLowFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxMedFameGainState", "$MediumFameGain", MaxMedFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxHighFameGainState", "$HighFameGain", MaxHighFameGain, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxVHighFameGainState", "$VeryHighFameGain", MaxVHighFameGain, "{0}", 0)
		
		AddHeaderOption("$FameDecaySettingsHeader")
		AddSliderOptionST("SLSF_Reloaded_DecayTimeNeededState", "$TimeBetweenDecay", (DecayTimeNeeded / 2), "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxVLowFameDecayState", "$VeryLowFameDecay", MaxVLowFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxLowFameDecayState", "$LowFameDecay", MaxLowFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxMedFameDecayState", "$MediumFameDecay", MaxMedFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxHighFameDecayState", "$HighFameDecay", MaxHighFameDecay, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaxVHighFameDecayState", "$VeryHighFameDecay", MaxVHighFameDecay, "{0}", 0)
		
		AddHeaderOption("$FameSpreadSettingsHeader")
		AddSliderOptionST("SLSF_Reloaded_SpreadTimeNeededState", "$TimeBetweenSpread", (SpreadTimeNeeded / 2), "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_FailedSpreadIncreaseState", "$ChanceOnFail", FailedSpreadIncrease, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_SuccessfulSpreadDecreaseState", "$ChanceOnSuccess", SuccessfulSpreadReduction, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumFameToSpreadState", "$FameSpreadMinimum", MinimumFameToSpread, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadCategoriesState", "$MaximumSpreadCategories", MaximumSpreadCategories, "{0}", 0)
		AddSliderOptionST("SLSF_Reloaded_MaximumSpreadPercentageState", "$MaximumSpreadPercentage", MaximumSpreadPercentage, "{0}%", 0)
		
		AddHeaderOption("$NPCFameHeader")
		AddToggleOptionST("SLSF_Reloaded_NPCNeedsLOSState", "$NeedsLOS", NPCNeedsLOS, 0)
		AddSliderOptionST("SLSF_Reloaded_MinimumNPCLOSDistanceState", "$MinimumLOS", MinimumNPCLOSDistance as Int, "{0}", GetDisabledOptionFlagIf(NPCNeedsLOS == False))
		AddSliderOptionST("SLSF_Reloaded_FameChanceByEnemyState", "$EnemyChance", FameChanceByEnemy, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByNeutralState", "$NeutralChance", FameChanceByNeutral, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByFriendState", "$FriendChance", FameChanceByFriend, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_SexFameChanceByFriendState", "$FriendSexChance", SexFameChanceByFriend, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_FameChanceByLoverState", "$LoverChance", FameChanceByLover, "{0}%", 0)
		AddSliderOptionST("SLSF_Reloaded_SexFameChanceByLoverState", "$LoverSexChance", SexFameChanceByLover, "{0}%", 0)
		
		SetCursorPosition(1)
		AddHeaderOption("$MultiplierHeader")
		AddToggleOptionST("SLSF_Reloaded_UseGlobalMultiplierState", "$UseGlobalMultiplier", UseGlobalFameMultiplier, 0)
		AddSliderOptionST("SLSF_Reloaded_FameChangeMultiplierState", "$GlobalMultiplier", FameChangeMultiplier, "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == False))
		AddHeaderOption("$CategoryMultipliers")
		AddSliderOptionST("SLSF_Reloaded_WhoreMultiplierState", "$WhoreMult", FameCategoryMultiplier[0], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_SlutMultiplierState", "$SlutMult", FameCategoryMultiplier[1], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_ExhibitionistMultiplierState", "$ExhibMult", FameCategoryMultiplier[2], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_OralMultiplierState", "$OralMult", FameCategoryMultiplier[3], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_AnalMultiplierState", "$AnalMult", FameCategoryMultiplier[4], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_NastyMultiplierState", "$NastyMult", FameCategoryMultiplier[5], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_PregnantMultiplierState", "$PregMult", FameCategoryMultiplier[6], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_DominantMultiplierState", "$DomMult", FameCategoryMultiplier[7], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_SubmissiveMultiplierState", "$SubMult", FameCategoryMultiplier[8], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_SadistMultiplierState", "$SadMult", FameCategoryMultiplier[9], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_MasochistMultiplierState", "$MasMult", FameCategoryMultiplier[10], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_GentleMultiplierState", "$GenMult", FameCategoryMultiplier[11], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesMenMultiplierState", "$LkMMult", FameCategoryMultiplier[12], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesWomenMultiplierState", "$LkWMult", FameCategoryMultiplier[13], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesOrcMultiplierState", "$LkOMult", FameCategoryMultiplier[14], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesKhajiitMultiplierState", "$LkKMult", FameCategoryMultiplier[15], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_LikesArgonianMultiplierState", "$LkAMult", FameCategoryMultiplier[16], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_BestialityMultiplierState", "$BesMult", FameCategoryMultiplier[17], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_GroupMultiplierState", "$GrpMult", FameCategoryMultiplier[18], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_BoundMultiplierState", "$BndMult", FameCategoryMultiplier[19], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		AddSliderOptionST("SLSF_Reloaded_TattooMultiplierState", "$TatMult", FameCategoryMultiplier[20], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		
		If Mods.IsFHUInstalled == True
			AddSliderOptionST("SLSF_Reloaded_CumDumpMultiplierState", "$DmpMult", FameCategoryMultiplier[21], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		EndIf
		
		If Mods.IsFameCommentsInstalled == True
			AddSliderOptionST("SLSF_Reloaded_UnfaithfulMultiplierState", "$UnfMult", FameCategoryMultiplier[22], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
			AddSliderOptionST("SLSF_Reloaded_CuckMultiplierState", "$CukMult", FameCategoryMultiplier[23], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		EndIf
		
		If Mods.IsBimbosInstalled == True
			AddSliderOptionST("SLSF_Reloaded_AirheadMultiplierState", "$AirMult", FameCategoryMultiplier[24], "{1}", GetDisabledOptionFlagIf(UseGlobalFameMultiplier == True))
		EndIf
		
		AddHeaderOption("$ResetFameHeader")
		AddToggleOptionST("SLSF_Reloaded_ClearAllFameState", "$ClearAllFame", ClearAllFameTrigger, 0)
		AddToggleOptionST("SLSF_Reloaded_ClearAllFameConfirmState", "$ConfirmClearAllFame", ClearAllFameConfirm, GetDisabledOptionFlagIf(ClearAllFameTrigger == False))
	
	ElseIf (page == "$TattooSettingsPage")
		AddHeaderOption("$BodyTatHeader")
		AddMenuOptionST("SLSF_Reloaded_BodyTattooSlotState", "$BodyTatSlot", (BodyTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeBodySlotState", "$ExcludeSlot", VisibilityManager.BodyTattooExcluded[BodyTattooIndex], 0)
		If VisibilityManager.BodyTattooApplied[BodyTattooIndex] == True
			If VisibilityManager.BodyTattooExcluded[BodyTattooIndex] == True
				AddTextOption("$SlotUsed", "$YesExcluded")
			Else
				AddTextOption("$SlotUsed", "$Yes")
			EndIf
			If VisibilityManager.IsBodyTattooVisible(BodyTattooIndex) == True
				AddTextOption("$SlotVisible", "$Yes")
			Else
				AddTextOption("$SlotVisible", "$No")
			EndIf
		Else
			If VisibilityManager.BodyTattooExcluded[BodyTattooIndex] == True
				AddTextOption("$SlotUsed", "$NoExcluded")
			Else
				AddTextOption("$SlotUsed", "$No")
			EndIf
			AddTextOption("$SlotVisible", "$NoUnused")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_BodySlotFameState", "$ExtraFame", VisibilityManager.BodyTattooExtraFameType[BodyTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[BodyTattooIndex] == False))
		AddMenuOptionST("SLSF_Reloaded_BodySlotSubcategoryState", "$Subcategory", VisibilityManager.BodyTattooSubcategory[BodyTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.BodyTattooApplied[BodyTattooIndex] == False))
		
		AddHeaderOption("$HandTatHeader")
		AddMenuOptionST("SLSF_Reloaded_HandTattooSlotState", "$HandTatSlot", (HandTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeHandSlotState", "$ExcludeSlot", VisibilityManager.HandTattooExcluded[HandTattooIndex], 0)
		If VisibilityManager.HandTattooApplied[HandTattooIndex] == True
			If VisibilityManager.HandTattooExcluded[HandTattooIndex]
				AddTextOption("$SlotUsed", "$YesExcluded")
			Else
				AddTextOption("$SlotUsed", "$Yes")
			EndIf
			If VisibilityManager.IsHandTattooVisible(HandTattooIndex) == True
				AddTextOption("$SlotVisible", "$Yes")
			Else
				AddTextOption("$SlotVisible", "$No")
			EndIf
		Else
			If VisibilityManager.HandTattooExcluded[HandTattooIndex] == True
				AddTextOption("$SlotUsed", "$NoExcluded")
			Else
				AddTextOption("$SlotUsed", "$No")
			EndIf
			AddTextOption("$SlotVisible", "$NoUnused")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_HandSlotFameState", "$ExtraFame", VisibilityManager.HandTattooExtraFameType[HandTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.HandTattooApplied[HandTattooIndex] == False))
		
		SetCursorPosition(1)
		AddHeaderOption("$FaceTatHeader")
		AddMenuOptionST("SLSF_Reloaded_FaceTattooSlotState", "$FaceTatSlot", (FaceTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeFaceSlotState", "$ExcludeSlot", VisibilityManager.FaceTattooExcluded[FaceTattooIndex], 0)
		If VisibilityManager.FaceTattooApplied[FaceTattooIndex] == True
			If VisibilityManager.FaceTattooExcluded[FaceTattooIndex]
				AddTextOption("$SlotUsed", "$YesExcluded")
			Else
				AddTextOption("$SlotUsed", "$Yes")
			EndIf
			If VisibilityManager.IsFaceTattooVisible(FaceTattooIndex) == True
				AddTextOption("$SlotVisible", "$Yes")
			Else
				AddTextOption("$SlotVisible", "$No")
			EndIf
		Else
			If VisibilityManager.FaceTattooExcluded[FaceTattooIndex] == True
				AddTextOption("$SlotUsed", "$NoExcluded")
			Else
				AddTextOption("$SlotUsed", "$No")
			EndIf
			AddTextOption("$SlotVisible", "$NoUnused")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_FaceSlotFameState", "$ExtraFame", VisibilityManager.FaceTattooExtraFameType[FaceTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.FaceTattooApplied[FaceTattooIndex] == False))
		
		AddEmptyOption()
		AddHeaderOption("$FootTatHeader")
		AddMenuOptionST("SLSF_Reloaded_FootTattooSlotState", "$FootTatSlot", (FootTattooIndex + 1), 0)
		AddToggleOptionST("SLSF_Reloaded_ExcludeFootSlotState", "$ExcludeSlot", VisibilityManager.FootTattooExcluded[FootTattooIndex], 0)
		If VisibilityManager.FootTattooApplied[FootTattooIndex] == True
			If VisibilityManager.FootTattooExcluded[FootTattooIndex]
				AddTextOption("$SlotUsed", "$YesExcluded")
			Else
				AddTextOption("$SlotUsed", "$Yes")
			EndIf
			If VisibilityManager.IsFootTattooVisible(FootTattooIndex) == True
				AddTextOption("$SlotVisible", "$Yes")
			Else
				AddTextOption("$SlotVisible", "$No")
			EndIf
		Else
			If VisibilityManager.FootTattooExcluded[FootTattooIndex] == True
				AddTextOption("$SlotUsed", "$NoExcluded")
			Else
				AddTextOption("$SlotUsed", "$No")
			EndIf
			AddTextOption("$SlotVisible", "$NoUnused")
		EndIf
		AddMenuOptionST("SLSF_Reloaded_FootSlotFameState", "$ExtraFame", VisibilityManager.FootTattooExtraFameType[FootTattooIndex], GetDisabledOptionFlagIf(VisibilityManager.FootTattooApplied[FootTattooIndex] == False))
		
	ElseIf (page == "$CustomLocationsPage")
		AddHeaderOption("$RegisterLocationHeader")
		If LocationManager.CurrentLocation != None
			AddTextOption("$DetectedLocation", LocationManager.CurrentLocation.GetName())
		Else
			AddTextOption("$DetectedLocation", "$NoneText")
		EndIf
		AddToggleOptionST("SLSF_Reloaded_RegisterLocationState", "$RegisterLocation", RegisterLocationTrigger, GetDisabledOptionFlagIf((LocationManager.CurrentLocation == None) || (LocationManager.CurrentLocation.GetName() == "$NoneText")))
		AddToggleOptionST("SLSF_Reloaded_RegisterLocationConfirmState", "$ConfirmRegisterLocation", RegisterLocationConfirm, GetDisabledOptionFlagIf(RegisterLocationTrigger == False))
		AddHeaderOption("$UnregisterLocationHeader")
		AddMenuOptionST("SLSF_Reloaded_UnregisterLocationSelectState", "$UnregisterSelection", UnregisterLocationSelection, 0)
		AddToggleOptionST("SLSF_Reloaded_UnregisterLocationState", "$UnregisterLocation", UnregisterLocationTrigger, GetDisabledOptionFlagIf(UnregisterLocationSelection == ""))
		AddToggleOptionST("SLSF_Reloaded_UnregisterLocationConfirmState", "$ConfirmUnregisterLocation", UnregisterLocationConfirm, GetDisabledOptionFlagIf(UnregisterLocationTrigger == False))
		
		SetCursorPosition(1)
		AddHeaderOption("$RegisteredLocationsHeader")
		AddTextOption("", LocationManager.CustomLocation[0])
		AddTextOption("", LocationManager.CustomLocation[1])
		AddTextOption("", LocationManager.CustomLocation[2])
		AddTextOption("", LocationManager.CustomLocation[3])
		AddTextOption("", LocationManager.CustomLocation[4])
		AddTextOption("", LocationManager.CustomLocation[5])
		AddTextOption("", LocationManager.CustomLocation[6])
		AddTextOption("", LocationManager.CustomLocation[7])
		AddTextOption("", LocationManager.CustomLocation[8])
		AddTextOption("", LocationManager.CustomLocation[9])
		AddTextOption("", LocationManager.CustomLocation[10])
		AddTextOption("", LocationManager.CustomLocation[11])
		AddTextOption("", LocationManager.CustomLocation[12])
		AddTextOption("", LocationManager.CustomLocation[13])
		AddTextOption("", LocationManager.CustomLocation[14])
		AddTextOption("", LocationManager.CustomLocation[15])
		AddTextOption("", LocationManager.CustomLocation[16])
		AddTextOption("", LocationManager.CustomLocation[17])
		AddTextOption("", LocationManager.CustomLocation[18])
		AddTextOption("", LocationManager.CustomLocation[19])
		AddTextOption("", LocationManager.CustomLocation[20])
	
	ElseIf (page == "$GeneralInfoPage")
		AddHeaderOption("$DetectedModsHeader")
		If Mods.IsANDInstalled == True
			AddTextOption("Advanced Nudity Detection", "$TrueText")
		Else
			AddTextOption("Advanced Nudity Detection", "$FalseText")
		EndIf
		
		If Mods.IsDDInstalled == True
			AddTextOption("Devious Devices", "$TrueText")
		Else
			AddTextOption("Devious Devices", "$FalseText")
		EndIf
		
		If Mods.IsECInstalled == True
			AddTextOption("Estrus Chaurus", "$TrueText")
		Else
			AddTextOption("Estrus Chaurus", "$FalseText")
		EndIf
		
		If Mods.IsESInstalled == True
			AddTextOption("Estrus Spider", "$TrueText")
		Else
			AddTextOption("Estrus Spider", "$FalseText")
		EndIf
		
		If Mods.IsPWInstalled == True
			AddTextOption("Public Whore", "$TrueText")
		Else
			AddTextOption("Public Whore", "$FalseText")
		EndIf
		
		If Mods.IsFMInstalled == True
			AddTextOption("Fertility Mode", "$TrueText")
		Else
			AddTextOption("Fertility Mode", "$FalseText")
		EndIf
		
		If Mods.IsFHUInstalled == True
			AddTextOption("Fill Her Up", "$TrueText")
		Else
			AddTextOption("Fill Her Up", "$FalseText")
		EndIf
		
		If Mods.IsHentaiPregInstalled == True
			AddTextOption("Hentai Pregnancy", "$TrueText")
		Else
			AddTextOption("Hentai Pregnancy", "$FalseText")
		EndIf
		
		If Mods.IsSlaveTatsInstalled == True
			AddTextOption("Slave Tats", "$TrueText")
		Else
			AddTextOption("Slave Tats", "$FalseText")
		EndIf
		
		If Mods.IsSLSInstalled == True
			AddTextOption("Sexlab Survival", "$TrueText")
		Else
			AddTextOption("Sexlab Survival", "$FalseText")
		EndIf
		
		If Mods.IsFameCommentsInstalled == True
			AddTextOption("SLSF Fame Comments", "$TrueText")
		Else
			AddTextOption("SLSF Fame Comments", "$FalseText")
		EndIf
		
		If Mods.IsBimbosInstalled == True
			AddTextOption("Bimbos of Skyrim", "$TrueText")
		Else
			AddTextOption("Bimbos of Skyrim", "$FalseText")
		EndIf
		
		If Mods.IsLegacySLSFInstalled == True
			AddTextOption("Legacy SLSF", "$TrueText")
		Else
			AddTextOption("Legacy SLSF", "$FalseText")
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("$DetectedConditionsHeader")
		AddTextOption("$AnonymousCondition", VisibilityManager.IsPlayerAnonymous() as String)
		
		If Mods.IsECInstalled == True
			If Mods.IsECPregnant(PlayerScript.PlayerRef) == True
				AddTextOption("$ChaurusPregCondition", "$TrueText")
			Else
				AddTextOption("$ChaurusPregCondition", "$FalseText")
			EndIf
		EndIf
		If Mods.IsESInstalled == True
			If Mods.IsESPregnant(PlayerScript.PlayerRef) == True
				AddTextOption("$SpiderPregCondition", "$TrueText")
			Else
				AddTextOption("$SpiderPregCondition", "$FalseText")
			EndIf
		EndIf
		If Mods.IsFMInstalled == True
			If Mods.IsFMPregnant(PlayerScript.PlayerRef) == True
				AddTextOption("$FMPregCondition", "$TrueText")
			Else
				AddTextOption("$FMPregCondition", "$FalseText")
			EndIf
		EndIf
		If Mods.IsHentaiPregInstalled == True
			If Mods.IsHentaiPregnant(PlayerScript.PlayerRef) == True
				AddTextOption("$HentaiPregCondition", "$TrueText")
			Else
				AddTextOption("$HentaiPregCondition", "$FalseText")
			EndIf
		EndIf
		If Mods.IsPWInstalled == True
			If Mods.IsPublicWhore() == True
				AddTextOption("$PublicWhoreCondition", "$TrueText")
			Else
				AddTextOption("$PublicWhoreCondition", "$FalseText")
			EndIf
		EndIf
		If Mods.IsFHUInstalled == True
			AddTextOption("$FHUCondition", Mods.GetFHUInflation(PlayerScript.PlayerRef) as String)
		EndIf
		
		AddTextOption("$VisibleTatsCondition", VisibilityManager.CountVisibleTattoos() as String)
		
		If IsVisiblyBound.GetValue() == 1
			AddTextOption("$VisiblyBoundCondition", "$Yes")
		Else
			AddTextOption("$VisiblyBoundCondition", "$No")
		EndIf
		
		If VisibilityManager.IsOralCumVisible() == True
			AddTextOption("$OralCumCondition", "$Yes")
		Else
			AddTextOption("$OralCumCondition", "$No")
		EndIf
		
		If PlayerScript.PlayerRef.GetActorBase().GetSex() == 0
			AddTextOption("$VaginalCumCondition", "$No")
		ElseIf VisibilityManager.IsVaginalCumVisible() == True
			AddTextOption("$VaginalCumCondition", "$Yes")
		Else
			AddTextOption("$VaginalCumCondition", "$No")
		EndIf
		
		If VisibilityManager.IsAssCumVisible() == True
			AddTextOption("$AnalCumCondition", "$Yes")
		Else
			AddTextOption("$AnalCumCondition", "$No")
		EndIf
		
		Float DecayTimeBase = ((FameManager.DecayCountdown as Float) / 2)
		Float DecayCountdownHalfHours = ((DecayTimeBase - (DecayTimeBase as Int)) * 10)
		
		Float SpreadTimeBase = ((FameManager.SpreadCountdown as Float) / 2)
		Float SpreadCountdownHalfHours = ((SpreadTimeBase - (SpreadTimeBase as Int)) * 10)
		
		AddHeaderOption("$DecaySpreadTimerHeader")
		AddTextOption("$TimeToDecay", (DecayTimeBase as Int) + "." + (DecayCountdownHalfHours as Int))
		AddTextOption("$TimeToSpread", (SpreadTimeBase as Int) + "." + (SpreadCountdownHalfHours as Int))
	
	ElseIf (page == "$TattooInfoPage")
		AddHeaderOption("$SelectTattooHeader")
		AddMenuOptionST("SLSF_Reloaded_TattooStatusState", "$TattooArea", TattooStatusSelect, 0)
		
		AddHeaderOption("$VisibilityHeader")
		Int TattooIndex = 0
		Int SlotNumber = 1
		If TattooStatusSelect == "$BodyArea"
			While TattooIndex < BodyTattooSlots
				If BodyTattooSlots > 8 && TattooIndex == (BodyTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsBodyTattooVisible(TattooIndex) == True
					AddTextOption(SlotNumber, "$Yes")
				Else
					AddTextOption(SlotNumber, "$No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "$FaceArea"
			While TattooIndex < FaceTattooSlots
				If FaceTattooSlots > 8 && TattooIndex == (FaceTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsFaceTattooVisible(TattooIndex) == True
					AddTextOption(SlotNumber, "$Yes")
				Else
					AddTextOption(SlotNumber, "$No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "$HandArea"
			While TattooIndex < HandTattooSlots
				If HandTattooSlots > 8 && TattooIndex == (HandTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsHandTattooVisible(TattooIndex) == True
					AddTextOption(SlotNumber, "$Yes")
				Else
					AddTextOption(SlotNumber, "$No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
		
		If TattooStatusSelect == "$FootArea"
			While TattooIndex < FootTattooSlots
				If FootTattooSlots > 8 && TattooIndex == (FootTattooSlots / 2)
					SetCursorPosition(7)
				EndIf
				
				If VisibilityManager.IsFootTattooVisible(TattooIndex) == True
					AddTextOption(SlotNumber, "$Yes")
				Else
					AddTextOption(SlotNumber, "$No")
				EndIf
				TattooIndex += 1
				SlotNumber += 1
			EndWhile
		EndIf
	
	ElseIf (page == "$DecayInfoPage")
		Float DecayTimeBase = ((FameManager.DecayCountdown as Float) / 2)
		Float DecayCountdownHalfHours = ((DecayTimeBase - (DecayTimeBase as Int)) * 10)
		
		AddTextOption("$TimeToDecay", (DecayTimeBase as Int) + "." + (DecayCountdownHalfHours as Int))
		AddHeaderOption("$DefaultLocationsCanDecayHeader")
		Int LocationIndex = 0
		While LocationIndex < LocationManager.DefaultLocation.Length
			If (FameManager.DefaultLocationCanDecay[LocationIndex] && HasFameAtDefaultLocation[LocationIndex]) == True
				If LocationIndex < LocationManager.MajorLocations.Length
					AddTextOption(LocationManager.MajorLocations[LocationIndex].GetName(), "$TrueText")
				ElseIf LocationIndex >= LocationManager.MajorLocations.Length && (LocationIndex - 10) < LocationManager.MinorLocations.Length
					AddTextOption(LocationManager.MinorLocations[(LocationIndex - 10)].GetName(), "$TrueText")
				EndIf
			Else
				If LocationIndex < LocationManager.MajorLocations.Length
					AddTextOption(LocationManager.MajorLocations[LocationIndex].GetName(), "$FalseText")
				ElseIf LocationIndex >= LocationManager.MajorLocations.Length && (LocationIndex - 10) < LocationManager.MinorLocations.Length
					AddTextOption(LocationManager.MinorLocations[(LocationIndex - 10)].GetName(), "$FalseText")
				EndIf
			EndIf
			LocationIndex += 1
		EndWhile
		
		LocationIndex = 0
		
		SetCursorPosition(3)
		AddHeaderOption("$CustomLocationsCanDecayHeader")
		While LocationIndex < LocationManager.CustomLocation.Length
			If (FameManager.CustomLocationCanDecay[LocationIndex] && HasFameAtCustomLocation[LocationIndex]) == True
				AddTextOption(LocationManager.CustomLocation[LocationIndex], "$TrueText")
			Else
				AddTextOption(LocationManager.CustomLocation[LocationIndex], "$FalseText")
			EndIf
			LocationIndex += 1
		EndWhile
		
	ElseIf (page == "$SpreadInfoPage")
		Float SpreadTimeBase = ((FameManager.SpreadCountdown as Float) / 2)
		Float SpreadCountdownHalfHours = ((SpreadTimeBase - (SpreadTimeBase as Int)) * 10)
		
		AddTextOption("$TimeToSpread", (SpreadTimeBase as Int) + "." + (SpreadCountdownHalfHours as Int))
		AddHeaderOption("$DefaultLocationsSpreadHeader")
		
		Int LocationIndex = 0
		While LocationIndex < LocationManager.DefaultLocation.Length
			If Data.DefaultLocationHasSpreadableFame[LocationIndex] == True
				If LocationIndex < LocationManager.MajorLocations.Length
					AddTextOption(LocationManager.MajorLocations[LocationIndex].GetName(), "$TrueText")
				ElseIf LocationIndex >= LocationManager.MajorLocations.Length && (LocationIndex - 10) < LocationManager.MinorLocations.Length
					AddTextOption(LocationManager.MinorLocations[(LocationIndex - 10)].GetName(), "$TrueText")
				EndIf
			Else
				If LocationIndex < LocationManager.MajorLocations.Length
					AddTextOption(LocationManager.MajorLocations[LocationIndex].GetName(), "$FalseText")
				ElseIf LocationIndex >= LocationManager.MajorLocations.Length && (LocationIndex - 10) < LocationManager.MinorLocations.Length
					AddTextOption(LocationManager.MinorLocations[(LocationIndex - 10)].GetName(), "$FalseText")
				EndIf
			EndIf
			LocationIndex += 1
		EndWhile
		
		LocationIndex = 0
		SetCursorPosition(3)
		AddHeaderOption("$CustomLocationsSpreadHeader")
		While LocationIndex < LocationManager.CustomLocation.Length
			 If Data.CustomLocationHasSpreadableFame[LocationIndex] == True
				AddTextOption(LocationManager.CustomLocation[LocationIndex], "$TrueText")
			Else
				AddTextOption(LocationManager.CustomLocation[LocationIndex], "$FalseText")
			EndIf
			;AddTextOption(LocationManager.CustomLocation[LocationIndex] + " Spread Pause Timer:", FameManager.CustomLocationSpreadPauseTimer[LocationIndex] as String)
			LocationIndex += 1
		EndWhile
		
	ElseIf (page == "$RegisteredModsPage")
		Int PageFillIndex = 0
		Int ModCount = Data.CountExternalMods()
		;String MaxString = "$MaximumText"
		AddTextOption("$ModNumberText", ModCount + "/" + Data.ExternalMods.Length)
		AddHeaderOption("$RegisteredModHeader")
		While PageFillIndex < ModCount
			If PageFillIndex == (Data.ExternalMods.Length / 2)
				SetCursorPosition(5)
			EndIf
			AddTextOption(Data.ExternalMods[PageFillIndex], "")
			PageFillIndex += 1
		EndWhile
	ElseIf (page == "$MiscPage")
		AddHeaderOption("$ImportExportHeader")
		AddInputOptionST("SLSF_Reloaded_ExportNameState", "$ExportName", ExportName, 0)
		AddToggleOptionST("SLSF_Reloaded_DataExportState", "$ExportData", ExportData, GetDisabledOptionFlagIf(ImportData == True))
		AddToggleOptionST("SLSF_Reloaded_DataImportState", "$ImportData", ImportData, GetDisabledOptionFlagIf(ExportData == True))
		
		AddHeaderOption("$UninstallHeader")
		AddToggleOptionST("SLSF_Reloaded_ArmUninstall_State", "$ArmUninstall", ArmUninstall, GetDisabledOptionFlagIf(ConfirmUninstall == True))
		AddToggleOptionST("SLSF_Reloaded_ConfirmUninstall_State", "$ConfirmUninstall", ConfirmUninstall, GetDisabledOptionFlagIf(ArmUninstall == False))
		
		SetCursorPosition(1)
		AddHeaderOption("$DebuggingHeader")
		AddToggleOptionST("SLSF_Reloaded_EnableTraceState", "$EnableTrace", EnableTracing, 0)
	
	ElseIf (page == "$FriendLoverSettingsPage")
		AddHeaderOption("$FameFromFriendsHeader")
		AddSliderOptionST("SLSF_Reloaded_FriendBetrayChanceState", "$FriendsIgnoreForbiddenChance", FriendBetrayChance, "{0}%", 0)
		AddToggleOptionST("SLSF_Reloaded_FriendsBetrayFromHighFameState", "$FameIncreasesFriendIgnoreChance", FriendsBetrayFromHighFame, 0)
		AddSliderOptionST("SLSF_Reloaded_FriendHighFameMinimumState", "$MinimumHighFameThreshold", FriendHighFameThreshold, "{0}%", GetDisabledOptionFlagIf(FriendsBetrayFromHighFame == False))
		AddHeaderOption("")
		OptionID[0] = AddToggleOption("$ForbidWhore", FameForbiddenByFriend[0], 0)
		OptionID[1] = AddToggleOption("$ForbidSlut", FameForbiddenByFriend[1], 0)
		OptionID[2] = AddToggleOption("$ForbidExhib", FameForbiddenByFriend[2], 0)
		OptionID[3] = AddToggleOption("$ForbidOral", FameForbiddenByFriend[3], 0)
		OptionID[4] = AddToggleOption("$ForbidAnal", FameForbiddenByFriend[4], 0)
		OptionID[5] = AddToggleOption("$ForbidNasty", FameForbiddenByFriend[5], 0)
		OptionID[6] = AddToggleOption("$ForbidPreg", FameForbiddenByFriend[6], 0)
		OptionID[7] = AddToggleOption("$ForbidDom", FameForbiddenByFriend[7], 0)
		OptionID[8] = AddToggleOption("$ForbidSub", FameForbiddenByFriend[8], 0)
		OptionID[9] = AddToggleOption("$ForbidSad", FameForbiddenByFriend[9], 0)
		OptionID[10] = AddToggleOption("$ForbidMas", FameForbiddenByFriend[10], 0)
		OptionID[11] = AddToggleOption("$ForbidGen", FameForbiddenByFriend[11], 0)
		OptionID[12] = AddToggleOption("$ForbidMen", FameForbiddenByFriend[12], 0)
		OptionID[13] = AddToggleOption("$ForbidWom", FameForbiddenByFriend[13], 0)
		OptionID[14] = AddToggleOption("$ForbidOrc", FameForbiddenByFriend[14], 0)
		OptionID[15] = AddToggleOption("$ForbidKha", FameForbiddenByFriend[15], 0)
		OptionID[16] = AddToggleOption("$ForbidArg", FameForbiddenByFriend[16], 0)
		OptionID[17] = AddToggleOption("$ForbidBes", FameForbiddenByFriend[17], 0)
		OptionID[18] = AddToggleOption("$ForbidGrp", FameForbiddenByFriend[18], 0)
		OptionID[19] = AddToggleOption("$ForbidBnd", FameForbiddenByFriend[19], 0)
		OptionID[20] = AddToggleOption("$ForbidTat", FameForbiddenByFriend[20], 0)
		OptionID[21] = AddToggleOption("$ForbidDmp", FameForbiddenByFriend[21], 0)
		
		If Mods.IsFameCommentsInstalled == True
			OptionID[22] = AddToggleOption("$ForbidUnf", FameForbiddenByFriend[22], 0)
			OptionID[23] = AddToggleOption("$ForbidCuk", FameForbiddenByFriend[23], 0)
		EndIf
		
		If Mods.IsBimbosInstalled == True
			OptionID[24] = AddToggleOption("$ForbidAir", FameForbiddenByFriend[24], 0)
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("$FameFromLoversHeader")
		AddSliderOptionST("SLSF_Reloaded_LoverBetrayChanceState", "$LoversIgnoreForbiddenChance", LoverBetrayChance, "{0}%", 0)
		AddToggleOptionST("SLSF_Reloaded_LoversBetrayFromHighFameState", "$FameIncreasesLoverIgnoreChance", LoversBetrayFromHighFame, 0)
		AddSliderOptionST("SLSF_REloaded_LoverHighFameMinimumState", "$MinimumHighFameThreshold", LoverHighFameThreshold, "{0}", GetDisabledOptionFlagIf(LoversBetrayFromHighFame == False))
		AddHeaderOption("")
		OptionID[25] = AddToggleOption("$ForbidWhore", FameForbiddenByLover[0], 0)
		OptionID[26] = AddToggleOption("$ForbidSlut", FameForbiddenByLover[1], 0)
		OptionID[27] = AddToggleOption("$ForbidExhib", FameForbiddenByLover[2], 0)
		OptionID[28] = AddToggleOption("$ForbidOral", FameForbiddenByLover[3], 0)
		OptionID[29] = AddToggleOption("$ForbidAnal", FameForbiddenByLover[4], 0)
		OptionID[30] = AddToggleOption("$ForbidNasty", FameForbiddenByLover[5], 0)
		OptionID[31] = AddToggleOption("$ForbidPreg", FameForbiddenByLover[6], 0)
		OptionID[32] = AddToggleOption("$ForbidDom", FameForbiddenByLover[7], 0)
		OptionID[33] = AddToggleOption("$ForbidSub", FameForbiddenByLover[8], 0)
		OptionID[34] = AddToggleOption("$ForbidSad", FameForbiddenByLover[9], 0)
		OptionID[35] = AddToggleOption("$ForbidMas", FameForbiddenByLover[10], 0)
		OptionID[36] = AddToggleOption("$ForbidGen", FameForbiddenByLover[11], 0)
		OptionID[37] = AddToggleOption("$ForbidMen", FameForbiddenByLover[12], 0)
		OptionID[38] = AddToggleOption("$ForbidWom", FameForbiddenByLover[13], 0)
		OptionID[39] = AddToggleOption("$ForbidOrc", FameForbiddenByLover[14], 0)
		OptionID[40] = AddToggleOption("$ForbidKha", FameForbiddenByLover[15], 0)
		OptionID[41] = AddToggleOption("$ForbidArg", FameForbiddenByLover[16], 0)
		OptionID[42] = AddToggleOption("$ForbidBes", FameForbiddenByLover[17], 0)
		OptionID[43] = AddToggleOption("$ForbidGrp", FameForbiddenByLover[18], 0)
		OptionID[44] = AddToggleOption("$ForbidBnd", FameForbiddenByLover[19], 0)
		OptionID[45] = AddToggleOption("$ForbidTat", FameForbiddenByLover[20], 0)
		OptionID[46] = AddToggleOption("$ForbidDmp", FameForbiddenByLover[21], 0)
		
		If Mods.IsFameCommentsInstalled == True
			OptionID[47] = AddToggleOption("$ForbidUnf", FameForbiddenByLover[22], 0)
			OptionID[48] = AddToggleOption("$ForbidCuk", FameForbiddenByLover[23], 0)
		EndIf
		
		If Mods.IsBimbosInstalled == True
			OptionID[49] = AddToggleOption("$ForbidAir", FameForbiddenByLover[24], 0)
		EndIf
	
	EndIf
EndEvent

Int Function GetDisabledOptionFlagIf(Bool Condition)
	If (Condition)
		return OPTION_FLAG_DISABLED
	Else
		return 0
	EndIf
EndFunction

Event OnOptionSelect(Int Option)
	If Option == OptionID[0]
		If FameForbiddenByFriend[0] == False
			FameForbiddenByFriend[0] = True
		Else
			FameForbiddenByFriend[0] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[0])
	ElseIf Option == OptionID[1]
		If FameForbiddenByFriend[1] == False
			FameForbiddenByFriend[1] = True
		Else
			FameForbiddenByFriend[1] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[1])
	ElseIf Option == OptionID[2]
		If FameForbiddenByFriend[2] == False
			FameForbiddenByFriend[2] = True
		Else
			FameForbiddenByFriend[2] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[2])
	ElseIf Option == OptionID[3]
		If FameForbiddenByFriend[3] == False
			FameForbiddenByFriend[3] = True
		Else
			FameForbiddenByFriend[3] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[3])
	ElseIf Option == OptionID[4]
		If FameForbiddenByFriend[4] == False
			FameForbiddenByFriend[4] = True
		Else
			FameForbiddenByFriend[4] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[4])
	ElseIf Option == OptionID[5]
		If FameForbiddenByFriend[5] == False
			FameForbiddenByFriend[5] = True
		Else
			FameForbiddenByFriend[5] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[5])
	ElseIf Option == OptionID[6]
		If FameForbiddenByFriend[6] == False
			FameForbiddenByFriend[6] = True
		Else
			FameForbiddenByFriend[6] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[6])
	ElseIf Option == OptionID[7]
		If FameForbiddenByFriend[7] == False
			FameForbiddenByFriend[7] = True
		Else
			FameForbiddenByFriend[7] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[7])
	ElseIf Option == OptionID[8]
		If FameForbiddenByFriend[8] == False
			FameForbiddenByFriend[8] = True
		Else
			FameForbiddenByFriend[8] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[8])
	ElseIf Option == OptionID[9]
		If FameForbiddenByFriend[9] == False
			FameForbiddenByFriend[9] = True
		Else
			FameForbiddenByFriend[9] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[9])
	ElseIf Option == OptionID[10]
		If FameForbiddenByFriend[10] == False
			FameForbiddenByFriend[10] = True
		Else
			FameForbiddenByFriend[10] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[10])
	ElseIf Option == OptionID[11]
		If FameForbiddenByFriend[11] == False
			FameForbiddenByFriend[11] = True
		Else
			FameForbiddenByFriend[11] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[11])
	ElseIf Option == OptionID[12]
		If FameForbiddenByFriend[12] == False
			FameForbiddenByFriend[12] = True
		Else
			FameForbiddenByFriend[12] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[12])
	ElseIf Option == OptionID[13]
		If FameForbiddenByFriend[13] == False
			FameForbiddenByFriend[13] = True
		Else
			FameForbiddenByFriend[13] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[13])
	ElseIf Option == OptionID[14]
		If FameForbiddenByFriend[14] == False
			FameForbiddenByFriend[14] = True
		Else
			FameForbiddenByFriend[14] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[14])
	ElseIf Option == OptionID[15]
		If FameForbiddenByFriend[15] == False
			FameForbiddenByFriend[15] = True
		Else
			FameForbiddenByFriend[15] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[15])
	ElseIf Option == OptionID[16]
		If FameForbiddenByFriend[16] == False
			FameForbiddenByFriend[16] = True
		Else
			FameForbiddenByFriend[16] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[16])
	ElseIf Option == OptionID[17]
		If FameForbiddenByFriend[17] == False
			FameForbiddenByFriend[17] = True
		Else
			FameForbiddenByFriend[17] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[17])
	ElseIf Option == OptionID[18]
		If FameForbiddenByFriend[18] == False
			FameForbiddenByFriend[18] = True
		Else
			FameForbiddenByFriend[18] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[18])
	ElseIf Option == OptionID[19]
		If FameForbiddenByFriend[19] == False
			FameForbiddenByFriend[19] = True
		Else
			FameForbiddenByFriend[19] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[19])
	ElseIf Option == OptionID[20]
		If FameForbiddenByFriend[20] == False
			FameForbiddenByFriend[20] = True
		Else
			FameForbiddenByFriend[20] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[20])
	ElseIf Option == OptionID[21]
		If FameForbiddenByFriend[21] == False
			FameForbiddenByFriend[21] = True
		Else
			FameForbiddenByFriend[21] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[21])
	ElseIf Option == OptionID[22]
		If FameForbiddenByFriend[22] == False
			FameForbiddenByFriend[22] = True
		Else
			FameForbiddenByFriend[22] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[22])
	ElseIf Option == OptionID[23]
		If FameForbiddenByFriend[23] == False
			FameForbiddenByFriend[23] = True
		Else
			FameForbiddenByFriend[23] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[23])
	ElseIf Option == OptionID[24]
		If FameForbiddenByFriend[24] == False
			FameForbiddenByFriend[24] = True
		Else
			FameForbiddenByFriend[24] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByFriend[24])
	ElseIf Option == OptionID[25]
		If FameForbiddenByLover[0] == False
			FameForbiddenByLover[0] = True
		Else
			FameForbiddenByLover[0] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[0])
	ElseIf Option == OptionID[26]
		If FameForbiddenByLover[1] == False
			FameForbiddenByLover[1] = True
		Else
			FameForbiddenByLover[1] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[1])
	ElseIf Option == OptionID[27]
		If FameForbiddenByLover[2] == False
			FameForbiddenByLover[2] = True
		Else
			FameForbiddenByLover[2] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[2])
	ElseIf Option == OptionID[28]
		If FameForbiddenByLover[3] == False
			FameForbiddenByLover[3] = True
		Else
			FameForbiddenByLover[3] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[3])
	ElseIf Option == OptionID[29]
		If FameForbiddenByLover[4] == False
			FameForbiddenByLover[4] = True
		Else
			FameForbiddenByLover[4] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[4])
	ElseIf Option == OptionID[30]
		If FameForbiddenByLover[5] == False
			FameForbiddenByLover[5] = True
		Else
			FameForbiddenByLover[5] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[5])
	ElseIf Option == OptionID[31]
		If FameForbiddenByLover[6] == False
			FameForbiddenByLover[6] = True
		Else
			FameForbiddenByLover[6] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[6])
	ElseIf Option == OptionID[32]
		If FameForbiddenByLover[7] == False
			FameForbiddenByLover[7] = True
		Else
			FameForbiddenByLover[7] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[7])
	ElseIf Option == OptionID[33]
		If FameForbiddenByLover[8] == False
			FameForbiddenByLover[8] = True
		Else
			FameForbiddenByLover[8] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[8])
	ElseIf Option == OptionID[34]
		If FameForbiddenByLover[9] == False
			FameForbiddenByLover[9] = True
		Else
			FameForbiddenByLover[9] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[9])
	ElseIf Option == OptionID[35]
		If FameForbiddenByLover[10] == False
			FameForbiddenByLover[10] = True
		Else
			FameForbiddenByLover[10] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[10])
	ElseIf Option == OptionID[36]
		If FameForbiddenByLover[11] == False
			FameForbiddenByLover[11] = True
		Else
			FameForbiddenByLover[11] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[11])
	ElseIf Option == OptionID[37]
		If FameForbiddenByLover[12] == False
			FameForbiddenByLover[12] = True
		Else
			FameForbiddenByLover[12] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[12])
	ElseIf Option == OptionID[38]
		If FameForbiddenByLover[13] == False
			FameForbiddenByLover[13] = True
		Else
			FameForbiddenByLover[13] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[13])
	ElseIf Option == OptionID[39]
		If FameForbiddenByLover[14] == False
			FameForbiddenByLover[14] = True
		Else
			FameForbiddenByLover[14] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[14])
	ElseIf Option == OptionID[40]
		If FameForbiddenByLover[15] == False
			FameForbiddenByLover[15] = True
		Else
			FameForbiddenByLover[15] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[15])
	ElseIf Option == OptionID[41]
		If FameForbiddenByLover[16] == False
			FameForbiddenByLover[16] = True
		Else
			FameForbiddenByLover[16] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[16])
	ElseIf Option == OptionID[42]
		If FameForbiddenByLover[17] == False
			FameForbiddenByLover[17] = True
		Else
			FameForbiddenByLover[17] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[17])
	ElseIf Option == OptionID[43]
		If FameForbiddenByLover[18] == False
			FameForbiddenByLover[18] = True
		Else
			FameForbiddenByLover[18] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[18])
	ElseIf Option == OptionID[44]
		If FameForbiddenByLover[19] == False
			FameForbiddenByLover[19] = True
		Else
			FameForbiddenByLover[19] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[19])
	ElseIf Option == OptionID[45]
		If FameForbiddenByLover[20] == False
			FameForbiddenByLover[20] = True
		Else
			FameForbiddenByLover[20] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[20])
	ElseIf Option == OptionID[46]
		If FameForbiddenByLover[21] == False
			FameForbiddenByLover[21] = True
		Else
			FameForbiddenByLover[21] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[21])
	ElseIf Option == OptionID[47]
		If FameForbiddenByLover[22] == False
			FameForbiddenByLover[22] = True
		Else
			FameForbiddenByLover[22] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[22])
	ElseIf Option == OptionID[48]
		If FameForbiddenByLover[23] == False
			FameForbiddenByLover[23] = True
		Else
			FameForbiddenByLover[23] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[23])
	ElseIf Option == OptionID[49]
		If FameForbiddenByLover[24] == False
			FameForbiddenByLover[24] = True
		Else
			FameForbiddenByLover[24] = False
		EndIf
		SetToggleOptionValue(Option, FameForbiddenByLover[24])
	EndIf
EndEvent

Event OnOptionHightlight(Int Option)
	If Option == OptionID[0]
		SetInfoText("$FriendForbidWhoreTooltip")
	ElseIf Option == OptionID[1]
		SetInfoText("$FriendForbidSlutTooltip")
	ElseIf Option == OptionID[2]
		SetInfoText("$FriendForbidExhibitionistTooltip")
	ElseIf Option == OptionID[3]
		SetInfoText("$FriendForbidOralTooltip")
	ElseIf Option == OptionID[4]
		SetInfoText("$FriendForbidAnalTooltip")
	ElseIf Option == OptionID[5]
		SetInfoText("$FriendForbidNastyTooltip")
	ElseIf Option == OptionID[6]
		SetInfoText("$FriendForbidPregnantTooltip")
	ElseIf Option == OptionID[7]
		SetInfoText("$FriendForbidDominantTooltip")
	ElseIf Option == OptionID[8]
		SetInfoText("$FriendForbidSubmissiveTooltip")
	ElseIf Option == OptionID[9]
		SetInfoText("$FriendForbidSadistTooltip")
	ElseIf Option == OptionID[10]
		SetInfoText("$FriendForbidMasochistTooltip")
	ElseIf Option == OptionID[11]
		SetInfoText("$FriendForbidGentleTooltip")
	ElseIf Option == OptionID[12]
		SetInfoText("$FriendForbidLikesMenTooltip")
	ElseIf Option == OptionID[13]
		SetInfoText("$FriendForbidLikesWomenTooltip")
	ElseIf Option == OptionID[14]
		SetInfoText("$FriendForbidLikesOrcTooltip")
	ElseIf Option == OptionID[15]
		SetInfoText("$FriendForbidLikesKhajiitTooltip")
	ElseIf Option == OptionID[16]
		SetInfoText("$FriendForbidLikesArgonianTooltip")
	ElseIf Option == OptionID[17]
		SetInfoText("$FriendForbidBestialityTooltip")
	ElseIf Option == OptionID[18]
		SetInfoText("$FriendForbidGroupTooltip")
	ElseIf Option == OptionID[19]
		SetInfoText("$FriendForbidBoundTooltip")
	ElseIf Option == OptionID[20]
		SetInfoText("$FriendForbidTattooTooltip")
	ElseIf Option == OptionID[21]
		SetInfoText("$FriendForbidCumDumpTooltip")
	ElseIf Option == OptionID[22]
		SetInfoText("$FriendForbidUnfaithfulTooltip")
	ElseIf Option == OptionID[23]
		SetInfoText("$FriendForbidCuckTooltip")
	ElseIf Option == OptionID[24]
		SetInfoText("$FriendForbidAirheadTooltip")
	ElseIf Option == OptionID[25]
		SetInfoText("$LoverForbidWhoreTooltip")
	ElseIf Option == OptionID[26]
		SetInfoText("$LoverForbidSlutTooltip")
	ElseIf Option == OptionID[27]
		SetInfoText("$LoverForbidExhibitionistTooltip")
	ElseIf Option == OptionID[28]
		SetInfoText("$LoverForbidOralTooltip")
	ElseIf Option == OptionID[29]
		SetInfoText("$LoverForbidAnalTooltip")
	ElseIf Option == OptionID[30]
		SetInfoText("$LoverForbidNastyTooltip")
	ElseIf Option == OptionID[31]
		SetInfoText("$LoverForbidPregnantTooltip")
	ElseIf Option == OptionID[32]
		SetInfoText("$LoverForbidDominantTooltip")
	ElseIf Option == OptionID[33]
		SetInfoText("$LoverForbidSubmissiveTooltip")
	ElseIf Option == OptionID[34]
		SetInfoText("$LoverForbidSadistTooltip")
	ElseIf Option == OptionID[35]
		SetInfoText("$LoverForbidMasochistTooltip")
	ElseIf Option == OptionID[36]
		SetInfoText("$LoverForbidGentleTooltip")
	ElseIf Option == OptionID[37]
		SetInfoText("$LoverForbidLikesMenTooltip")
	ElseIf Option == OptionID[38]
		SetInfoText("$LoverForbidLikesWomenTooltip")
	ElseIf Option == OptionID[39]
		SetInfoText("$LoverForbidLikesOrcTooltip")
	ElseIf Option == OptionID[40]
		SetInfoText("$LoverForbidLikesKhajiitTooltip")
	ElseIf Option == OptionID[41]
		SetInfoText("$LoverForbidLikesArgonianTooltip")
	ElseIf Option == OptionID[42]
		SetInfoText("$LoverForbidBestialityTooltip")
	ElseIf Option == OptionID[43]
		SetInfoText("$LoverForbidGroupTooltip")
	ElseIf Option == OptionID[44]
		SetInfoText("$LoverForbidBoundTooltip")
	ElseIf Option == OptionID[45]
		SetInfoText("$LoverForbidTattooTooltip")
	ElseIf Option == OptionID[46]
		SetInfoText("$LoverForbidCumDumpTooltip")
	ElseIf Option == OptionID[47]
		SetInfoText("$LoverForbidUnfaithfulTooltip")
	ElseIf Option == OptionID[48]
		SetInfoText("$LoverForbidCuckTooltip")
	ElseIf Option == OptionID[49]
		SetInfoText("$LoverForbidAirheadTooltip")
	EndIf
EndEvent

State SLSF_Reloaded_FriendBetrayChanceState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FriendBetrayChance)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FriendBetrayChance = value as Int
		SetSliderOptionValueST(FriendBetrayChance, "{0}", False, "SLSF_Reloaded_FriendBetrayChanceState")
	EndEvent
	
	Event OnDefaultST()
		FriendBetrayChance = 50
		SetSliderOptionValueST(FriendBetrayChance, "{0}", False, "SLSF_Reloaded_FriendBetrayChanceState")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FriendBetrayChanceTooltip")
	EndEvent
EndState

State SLSF_Reloaded_LoverBetrayChanceState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(LoverBetrayChance)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		LoverBetrayChance = value as Int
		SetSliderOptionValueST(LoverBetrayChance, "{0}", False, "SLSF_Reloaded_LoverBetrayChanceState")
	EndEvent
	
	Event OnDefaultST()
		LoverBetrayChance = 25
		SetSliderOptionValueST(LoverBetrayChance, "{0}", False, "SLSF_Reloaded_LoverBetrayChanceState")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$LoverBetrayChanceTooltip")
	EndEvent
EndState

State SLSF_Reloaded_FriendsBetrayFromHighFameState
	Event OnSelectST()
		If FriendsBetrayFromHighFame == False
			FriendsBetrayFromHighFame = True
		Else
			FriendsBetrayFromHighFame = False
		EndIf
		
		SetToggleOptionValueST(FriendsBetrayFromHighFame, False, "SLSF_Reloaded_FriendsBetrayFromHighFameState")
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FriendsBetrayFromFameTooltip")
	EndEvent
EndState

State SLSF_Reloaded_FriendHighFameMinimumState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(FriendHighFameThreshold)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		FriendHighFameThreshold = value as Int
		SetSliderOptionValueST(FriendHighFameThreshold, "{0}", False, "SLSF_Reloaded_FriendHighFameMinimumState")
	EndEvent
	
	Event OnDefaultST()
		FriendHighFameThreshold = 0
		SetSliderOptionValueST(FriendHighFameThreshold, "{0}", False, "SLSF_Reloaded_FriendHighFameMinimumState")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FriendHighFameThresholdTooltip")
	EndEvent
EndState

State SLSF_Reloaded_LoversBetrayFromHighFameState
	Event OnSelectST()
		If LoversBetrayFromHighFame == False
			LoversBetrayFromHighFame = True
		Else
			LoversBetrayFromHighFame = False
		EndIf
		
		SetToggleOptionValueST(LoversBetrayFromHighFame, False, "SLSF_Reloaded_LoversBetrayFromHighFameState")
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$LoversBetrayFromFameTooltip")
	EndEvent
EndState

State SLSF_Reloaded_LoverHighFameMinimumState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(LoverHighFameThreshold)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		LoverHighFameThreshold = value as Int
		SetSliderOptionValueST(LoverHighFameThreshold, "{0}", False, "SLSF_Reloaded_LoverHighFameMinimumState")
	EndEvent
	
	Event OnDefaultST()
		LoverHighFameThreshold = 0
		SetSliderOptionValueST(LoverHighFameThreshold, "{0}", False, "SLSF_Reloaded_LoverHighFameMinimumState")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$LoverHighFameThresholdTooltip")
	EndEvent
EndState

State SLSF_Reloaded_ArmUninstall_State
	Event OnSelectST()
		If ArmUninstall == False
			ArmUninstall = True
		Else
			ArmUninstall = False
		EndIf
		
		SetToggleOptionValueST(ArmUninstall, False, "SLSF_Reloaded_ArmUninstall_State")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_ConfirmUninstall_State
	Event OnSelectST()
		If ConfirmUninstall == False
			ConfirmUninstall = True
		Else
			ConfirmUninstall = False
		EndIf
		
		SetToggleOptionValueST(ConfirmUninstall, False, "SLSF_Reloaded_ConfirmUninstall_State")
		Debug.MessageBox("SLSF Reloaded Uninstaller ready! Exit to game to uninstall! If this is a mistake, uncheck Confirm!!!")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_ExportNameState
	Event OnInputOpenST()
		SetInputDialogStartText(ExportName)
	EndEvent
	
	Event OnInputAcceptST(string a_input)
		ExportName = a_input
		SetInputOptionValueST(ExportName, False, "SLSF_Reloaded_ExportNameState")
	EndEvent 

	Event OnDefaultST()
		ExportName = ""
		SetInputOptionValueST("", False, "SLSF_Reloaded_ExportNameState")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$ExportNameTooltip")
	EndEvent
EndState

State SLSF_Reloaded_DataExportState
	Event OnSelectST()
		If ExportData == False
			ExportData = True
		Else
			ExportData = False
		EndIf
		
		SetToggleOptionValueST(ExportData, False, "SLSF_Reloaded_DataExportState")
		
		If ExportData == True
			Debug.MessageBox("Ready to export your SLSF Reloaded Data! Close the MCM to start the export! If this is a mistake, uncheck Export SLSFR Data NOW!")
		EndIf
		
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_DataImportState
	Event OnSelectST()
		If ImportData == False
			ImportData = True
		Else
			ImportData = False
		EndIf
		
		SetToggleOptionValueST(ImportData, False, "SLSF_Reloaded_DataImportState")
		
		If ImportData == True
			Debug.MessageBox("Ready to import your SLSF Reloaded Data! Close the MCM to start the import! WARNING: THIS WILL OVERWRITE ALL OF YOUR CURRENT DATA!!! If this is a mistake, uncheck Import SLSFR Data NOW!!!")
		EndIf
		
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$ImportDataTooltip")
	EndEvent
EndState

State SLSF_Reloaded_VictimsAreMasochistState
	Event OnSelectST()
		If VictimsAreMasochist == False
			VictimsAreMasochist = True
		Else
			VictimsAreMasochist = False
		EndIf
		
		SetToggleOptionValueST(VictimsAreMasochist, False, "SLSF_Reloaded_VictimsAreMasochistState")
	EndEvent
EndState

State SLSF_Reloaded_AllowBestialityWhenRapedState
	Event OnSelectST()
		If AllowBestialityWhenRaped == False
			AllowBestialityWhenRaped = True
		Else
			AllowBestialityWhenRaped = False
		EndIf
		
		SetToggleOptionValueST(AllowBestialityWhenRaped, False, "SLSF_Reloaded_AllowBestialityWhenRapedState")
	EndEvent
EndState

State SLSF_Reloaded_DisableNakedCommentsWhilePWState
	Event OnSelectST()
		If DisableNakedCommentsWhilePW == False
			DisableNakedCommentsWhilePW = True
		Else
			DisableNakedCommentsWhilePW = False
		EndIf
		
		SetToggleOptionValueST(DisableNakedCommentsWhilePW, False, "SLSF_Reloaded_DisableNakedCommentsWhilePWState")
	EndEvent
EndState

State SLSF_Reloaded_AllowLegacyOverwriteState
	Event OnSelectST()
		If AllowLegacyOverwrite == False
			AllowLegacyOverwrite = True
		Else
			AllowLegacyOverwrite = False
		EndIf
		
		SetToggleOptionValueST(AllowLegacyOverwrite, False, "SLSF_Reloaded_AllowLegacyOverwriteState")
	EndEvent
EndState

State SLSF_Reloaded_AllowCollarBoundFame
	Event OnSelectST()
		If AllowCollarBoundFame == False
			AllowCollarBoundFame = True
		Else
			AllowCollarBoundFame = False
		EndIf
		
		SetToggleOptionValueST(AllowCollarBoundFame, False, "SLSF_Reloaded_AllowCollarBoundFame")
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
		
		SetToggleOptionValueST(AllowSLSCursedCollarBoundFame, False, "SLSF_Reloaded_AllowSLSCurseCollarBoundFameState")
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
	
	Event OnHighlightST()
		SetInfoText("$VeryLowFameGainTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$LowFameGainTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$MediumFameGainTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$HighFameGainTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$VeryHighFameGainTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$VeryLowFameDecayTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$LowFameDecayTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$MediumFameDecayTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$HighFameDecayTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$VeryHighFameDecayTooltip")
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
		
		SetToggleOptionValueST(EnableTracing, False, "SLSF_Reloaded_EnableTraceState")
	EndEvent
EndState

State SLSF_Reloaded_AllowLikeFameWhenRapedState
	Event OnSelectST()
		If AllowLikeFameWhenRaped == False
			AllowLikeFameWhenRaped = True
		Else
			AllowLikeFameWhenRaped = False
		EndIf
		
		SetToggleOptionValueST(AllowLikeFameWhenRaped, False, "SLSF_Reloaded_AllowLikeFameWhenRapedState")
	EndEvent
EndState

State SLSF_Reloaded_TattooStatusState
	Event OnMenuOpenST()
		String[] TattooArea = New String[4]
		TattooArea[0] = "$BodyArea"
		TattooArea[1] = "$FaceArea"
		TattooArea[2] = "$HandArea"
		TattooArea[3] = "$FootArea"
		
		Int StartIndex = TattooArea.Find(TattooStatusSelect)
		
		SetMenuDialogOptions(TattooArea)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] TattooArea = New String[4]
		TattooArea[0] = "$BodyArea"
		TattooArea[1] = "$FaceArea"
		TattooArea[2] = "$HandArea"
		TattooArea[3] = "$FootArea"
		
		SetMenuOptionValueST(TattooArea[AcceptedIndex], False, "SLSF_Reloaded_TattooStatusState")
		TattooStatusSelect = TattooArea[AcceptedIndex]
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_BodyTattooSlotState
	Event OnMenuOpenST()
		String[] BodySlotIndex = Utility.CreateStringArray(BodyTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < BodyTattooSlots
			BodySlotIndex[ArrayIndex] = (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(BodySlotIndex)
		SetMenuDialogStartIndex(BodyTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		BodyTattooIndex = AcceptedIndex
		SetMenuOptionValueST(BodyTattooIndex + 1, False, "SLSF_Reloaded_BodyTattooSlotState")
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
		SetToggleOptionValueST(VisibilityManager.BodyTattooExcluded[BodyTattooIndex], False, "SLSF_Reloaded_ExcludeBodySlotState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_BodySlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuDialogOptions(FameTexts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuOptionValueST(FameTexts[AcceptedIndex], False, "SLSF_Reloaded_BodySlotFameState")
		VisibilityManager.BodyTattooExtraFameType[BodyTattooIndex] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_BodySlotSubcategoryState
	Event OnMenuOpenST()
		Int StartIndex = 0
		String[] Texts = New String[5]
		
		Texts[0] = "$NoneText"
		Texts[1] = "$ChestArea"
		Texts[2] = "$PelvisArea"
		Texts[3] = "$AssArea"
		Texts[4] = "$BackArea"
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] Texts = New String[5]
		String[] TranslatedText = New String[5]
		
		Texts[0] = "$NoneText"
		Texts[1] = "$ChestArea"
		Texts[2] = "$PelvisArea"
		Texts[3] = "$AssArea"
		Texts[4] = "$BackArea"
		
		;We need an english return for the Visibility Manager to function properly
		TranslatedText[0] = "-NONE-"
		TranslatedText[1] = "Chest"
		TranslatedText[2] = "Pelvis"
		TranslatedText[3] = "Ass"
		TranslatedText[4] = "Back"
		
		SetMenuOptionValueST(Texts[AcceptedIndex], False, "SLSF_Reloaded_BodySlotSubcategoryState")
		VisibilityManager.BodyTattooSubcategory[BodyTattooIndex] = TranslatedText[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FaceTattooSlotState
	Event OnMenuOpenST()
		String[] FaceSlotIndex = Utility.CreateStringArray(FaceTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < FaceTattooSlots
			FaceSlotIndex[ArrayIndex] = (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(FaceSlotIndex)
		SetMenuDialogStartIndex(FaceTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		FaceTattooIndex = AcceptedIndex
		SetMenuOptionValueST(FaceTattooIndex + 1, False, "SLSF_Reloaded_FaceTattooSlotState")
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
		SetToggleOptionValueST(VisibilityManager.FaceTattooExcluded[FaceTattooIndex], False, "SLSF_Reloaded_ExcludeFaceSlotState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_FaceSlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuDialogOptions(FameTexts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuOptionValueST(FameTexts[AcceptedIndex], False, "SLSF_Reloaded_FaceSlotFameState")
		VisibilityManager.FaceTattooExtraFameType[FaceTattooIndex] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_HandTattooSlotState
	Event OnMenuOpenST()
		String[] HandSlotIndex = Utility.CreateStringArray(HandTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < HandTattooSlots
			HandSlotIndex[ArrayIndex] = (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(HandSlotIndex)
		SetMenuDialogStartIndex(HandTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		HandTattooIndex = AcceptedIndex
		SetMenuOptionValueST(HandTattooIndex + 1, False, "SLSF_Reloaded_HandTattooSlotState")
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
		SetToggleOptionValueST(VisibilityManager.HandTattooExcluded[HandTattooIndex], False, "SLSF_Reloaded_ExcludeHandSlotState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_HandSlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuDialogOptions(FameTexts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuOptionValueST(FameTexts[AcceptedIndex], False, "SLSF_Reloaded_HandSlotFameState")
		VisibilityManager.HandTattooExtraFameType[HandTattooIndex] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_FootTattooSlotState
	Event OnMenuOpenST()
		String[] FootSlotIndex = Utility.CreateStringArray(FootTattooSlots)
		
		Int ArrayIndex = 0
		While ArrayIndex < FootTattooSlots
			FootSlotIndex[ArrayIndex] = (ArrayIndex + 1)
			ArrayIndex += 1
		EndWhile
		
		SetMenuDialogOptions(FootSlotIndex)
		SetMenuDialogStartIndex(FootTattooIndex)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		FootTattooIndex = AcceptedIndex
		SetMenuOptionValueST(FootTattooIndex + 1, False, "SLSF_Reloaded_FootTattooSlotState")
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
		SetToggleOptionValueST(VisibilityManager.FootTattooExcluded[FootTattooIndex], False, "SLSF_Reloaded_ExcludeFootSlotState")
		ForcePageReset()
	EndEvent
EndState

State SLSF_Reloaded_FootSlotFameState
	Event OnMenuOpenST()
		Int StartIndex = 0
		
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuDialogOptions(FameTexts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		String[] FameTexts = New String[25]
		
		FameTexts[0] = "$WhoreText"
		FameTexts[1] = "$SlutText"
		FameTexts[2] = "$ExhibitionistText"
		FameTexts[3] = "$OralText"
		FameTexts[4] = "$AnalText"
		FameTexts[5] = "$NastyText"
		FameTexts[6] = "$PregnantText"
		FameTexts[7] = "$DominantText"
		FameTexts[8] = "$SubmissiveText"
		FameTexts[9] = "$SadistText"
		FameTexts[10] = "$MasochistText"
		FameTexts[11] = "$GentleText"
		FameTexts[12] = "$LikesMenText"
		FameTexts[13] = "$LikesWomenText"
		FameTexts[14] = "$LikesOrcText"
		FameTexts[15] = "$LikesKhajiitText"
		FameTexts[16] = "$LikesArgonianText"
		FameTexts[17] = "$BestialityText"
		FameTexts[18] = "$GroupText"
		FameTexts[19] = "$BoundText"
		FameTexts[20] = "$TattooText"
		FameTexts[21] = "$CumDumpText"
		FameTexts[22] = "$UnfaithfulText"
		FameTexts[23] = "$CuckText"
		FameTexts[24] = "$AirheadText"
		
		SetMenuOptionValueST(FameTexts[AcceptedIndex], False, "SLSF_Reloaded_FootSlotFameState")
		VisibilityManager.FootTattooExtraFameType[FootTattooIndex] = FameManager.FameType[AcceptedIndex]
	EndEvent
EndState

State SLSF_Reloaded_LocationDetailsState
	Event OnMenuOpenST()
		Int TotalLocations = (LocationManager.DefaultLocation.Length + SLSF_Reloaded_CustomLocationCount.GetValue()) as Int
		String[] Texts = Utility.CreateStringArray(TotalLocations)
		
		Int FillIndex = 0
		While FillIndex < TotalLocations
			If FillIndex < LocationManager.MajorLocations.Length
				Texts[FillIndex] = LocationManager.MajorLocations[FillIndex].GetName()
			ElseIf (FillIndex - 10) < LocationManager.MinorLocations.Length
				Texts[FillIndex] = LocationManager.MinorLocations[(FillIndex - 10)].GetName()
			Else
				Texts[FillIndex] = LocationManager.CustomLocation[(FillIndex - LocationManager.DefaultLocation.Length)]
			EndIf
			FillIndex += 1
		EndWhile
		
		Int StartIndex = Texts.Find(LocationDetailsSelected)
		
		SetMenuDialogOptions(Texts)
		SetMenuDialogStartIndex(StartIndex)
		SetMenuDialogDefaultIndex(StartIndex)
	EndEvent
	
	Event OnMenuAcceptST(Int AcceptedIndex)
		Int TotalLocations = (LocationManager.DefaultLocation.Length + SLSF_Reloaded_CustomLocationCount.GetValue()) as Int
		String[] Texts = Utility.CreateStringArray(TotalLocations)
		
		Int FillIndex = 0
		
		While FillIndex < TotalLocations
			If FillIndex < LocationManager.MajorLocations.Length
				Texts[FillIndex] = LocationManager.MajorLocations[FillIndex].GetName()
			ElseIf (FillIndex - 10) < LocationManager.MinorLocations.Length
				Texts[FillIndex] = LocationManager.MinorLocations[(FillIndex - 10)].GetName()
			Else
				Texts[FillIndex] = LocationManager.CustomLocation[(FillIndex - LocationManager.DefaultLocation.Length)]
			EndIf
			FillIndex += 1
		EndWhile
		
		SetMenuOptionValueST(Texts[AcceptedIndex], False, "SLSF_Reloaded_LocationDetailsState")
		LocationDetailsSelected = Texts[AcceptedIndex]
		LocationDetailsIndex = AcceptedIndex
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
	
	Event OnHighlightST()
		SetInfoText("$ReduceAtNightTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$SpreadFailedIncreaseTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$SpreadSuccessDecreaseTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$MinimumFameToSpreadTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$MaximumSpreadCategoriesTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$MaximumSpreadPercentageTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$ForeplayFameTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$EnemyFameTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$NeutralFameTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$FriendFameTooltip")
	EndEvent
EndState

State SLSF_Reloaded_SexFameChanceByFriendState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SexFameChanceByFriend)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		SexFameChanceByFriend = value
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_SexFameChanceByFriendState")
	EndEvent
	
	Event OnDefaultST()
		SexFameChanceByFriend = 50
		SetSliderOptionValueST(50, "{0}%", False, "SLSF_Reloaded_SexFameChanceByFriendState")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FriendSexFameTooltip")
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
	
	Event OnHighlightST()
		SetInfoText("$LoverFameTooltip")
	EndEvent
EndState

State SLSF_Reloaded_SexFameChanceByLoverState
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SexFameChanceByLover)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	EndEvent
	
	Event OnSliderAcceptST(float value)
		SexFameChanceByLover = value
		SetSliderOptionValueST(value, "{0}%", False, "SLSF_Reloaded_SexFameChanceByLoverState")
	EndEvent
	
	Event OnDefaultST()
		SexFameChanceByLover = 25
		SetSliderOptionValueST(25, "{0}%", False, "SLSF_Reloaded_SexFameChanceByLoverState")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$LoverSexFameTooltip")
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