ScriptName SLSF_Reloaded_FameManager extends Quest

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_ModEventListener Property ExternalListener Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_NPCScan Property NPCScan Auto
SexlabFramework Property Sexlab Auto

Bool[] Property DefaultLocationCanSpread Auto 
Bool[] Property CustomLocationCanSpread Auto 
Bool[] Property DefaultLocationCanDecay Auto 
Bool[] Property CustomLocationCanDecay Auto 

String[] Property FameType Auto
String[] Property PossibleFameArray Auto Hidden
String[] Property PossibleSpreadTargets Auto Hidden
String[] Property PossibleSpreadCategories Auto Hidden

Int[] Property DefaultLocationSpreadPauseTimer Auto
Int[] Property CustomLocationSpreadPauseTimer Auto
Int[] Property DefaultLocationDecayPauseTimer Auto 
Int[] Property CustomLocationDecayPauseTimer Auto 
Int Property DecayCountdown Auto Hidden
Int Property SpreadCountdown Auto Hidden
Int Property IterationMultiplier Auto Hidden

Float Property LastCheckedTime Auto Hidden

Armor[] Property ArmorSlots Auto Hidden

Keyword[] Property DD_Keywords Auto Hidden
Keyword Property SLSF_Reloaded_NipplePiercing Auto
Keyword Property SLSF_Reloaded_VaginalPiercing Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto
GlobalVariable Property IsVisiblyBound Auto

Actor Property PlayerRef Auto

Bool Property ExternalWhoreFlag Auto Hidden
Bool Property ExternalSlutFlag Auto Hidden
Bool Property ExternalExhibitionistFlag Auto Hidden
Bool Property ExternalOralFlag Auto Hidden
Bool Property ExternalAnalFlag Auto Hidden
Bool Property ExternalNastyFlag Auto Hidden
Bool Property ExternalPregnantFlag Auto Hidden
Bool Property ExternalDominantFlag Auto Hidden
Bool Property ExternalSubmissiveFlag Auto Hidden
Bool Property ExternalSadistFlag Auto Hidden
Bool Property ExternalMasochistFlag Auto Hidden
Bool Property ExternalGentleFlag Auto Hidden
Bool Property ExternalLikesMenFlag Auto Hidden
Bool Property ExternalLikesWomenFlag Auto Hidden
Bool Property ExternalLikesOrcFlag Auto Hidden
Bool Property ExternalLikesKhajiitFlag Auto Hidden
Bool Property ExternalLikesArgonianFlag Auto Hidden
Bool Property ExternalBestialityFlag Auto Hidden
Bool Property ExternalGroupFlag Auto Hidden
Bool Property ExternalBoundFlag Auto Hidden
Bool Property ExternalTattooFlag Auto Hidden
Bool Property ExternalCumDumpFlag Auto Hidden
Bool Property ExternalUnfaithfulFlag Auto Hidden
Bool Property ExternalCuckFlag Auto Hidden
Bool Property ExternalAirheadFlag Auto Hidden

;Globals for SLSF Fame Comments
GlobalVariable Property SlutGlobal Auto
GlobalVariable Property WhoreGlobal Auto
GlobalVariable Property ExhibGlobal Auto
GlobalVariable Property OralGlobal Auto
GlobalVariable Property AnalGlobal Auto
GlobalVariable Property NastyGlobal Auto
GlobalVariable Property PregGlobal Auto
GlobalVariable Property DomGlobal Auto
GlobalVariable Property SubGlobal Auto
GlobalVariable Property SadistGlobal Auto
GlobalVariable Property MasochistGlobal Auto
GlobalVariable Property GentleGlobal Auto
GlobalVariable Property MenGlobal Auto
GlobalVariable Property WomenGlobal Auto
GlobalVariable Property KhajiitGlobal Auto
GlobalVariable Property OrcGlobal Auto
GlobalVariable Property ArgonianGlobal Auto
GlobalVariable Property BeastGlobal Auto
GlobalVariable Property GroupGlobal Auto
GlobalVariable Property BoundGlobal Auto
GlobalVariable Property TattooGlobal Auto
GlobalVariable Property CumDumpGlobal Auto
GlobalVariable Property CheatGlobal Auto
GlobalVariable Property CuckGlobal Auto
GlobalVariable Property AirheadGlobal Auto

Bool Property SLSFCFameTypesCleared Auto Hidden
Bool Property AirheadFameCleared Auto Hidden

Event OnInit()
	Startup()
EndEvent

Function Startup()
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		DefaultLocationCanSpread[LocationIndex] = True
		DefaultLocationCanDecay[LocationIndex] = True
		DefaultLocationSpreadPauseTimer[LocationIndex] = 0
		DefaultLocationDecayPauseTimer[LocationIndex] = 0
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < LocationManager.CustomLocation.Length
		CustomLocationCanSpread[LocationIndex] = False
		CustomLocationCanDecay[LocationIndex] = False
		CustomLocationSpreadPauseTimer[LocationIndex] = 0
		CustomLocationDecayPauseTimer[LocationIndex] = 0
		LocationIndex += 1
	EndWhile
	
	DecayCountdown = 24
	SpreadCountdown = 48
	LastCheckedTime = Utility.GetCurrentGameTime()
	IterationMultiplier = 1
EndFunction

Event OnUpdate()
	Float Time = Utility.GetCurrentGameTime()
	Int CountdownChange = ((Time - LastCheckedTime) * 48) as Int
	Int DecayIterations = (CountdownChange/24) as Int
	
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	If CountdownChange < 1
		CountdownChange = 1
	EndIf
	Debug.Trace("SLSF Realoaded Fame Manager - Countdown Change = " + CountdownChange)
	
	;Update countdown timers
	DecayCountdown -= CountdownChange
	SpreadCountdown -= CountdownChange
	
	;Always perform at least one iteration if triggered. Perform multiple if long time passes between checks (repeated Sleep/Wait).
	If DecayIterations < 1
		DecayIterations = 1
	EndIf
	
	IterationMultiplier = DecayIterations ;Multiply Decay changes by the number of decays that should have happened normally
	
	If DecayCountdown <= 0
		DecayFame()
		DecayCountdown = (Config.DecayTimeNeeded) as Int
	EndIf
	
	If SpreadCountdown <= 0
		SpreadFameRoll()
		SpreadCountdown = (Config.SpreadTimeNeeded) as Int
	EndIf
	
	;Update Individual Decay Pause Timers
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationDecayPauseTimer[LocationIndex] > 0 && DefaultLocationCanDecay[LocationIndex] == False
			Int CurrentDecayTimer = DefaultLocationDecayPauseTimer[LocationIndex]
			Int NewDecayTimer = (CurrentDecayTimer - CountdownChange)
			DefaultLocationDecayPauseTimer[LocationIndex] = NewDecayTimer
		EndIf
		If DefaultLocationDecayPauseTimer[LocationIndex] <= 0
			DefaultLocationDecayPauseTimer[LocationIndex] = 0
			DefaultLocationCanDecay[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < CustomLocations
		If CustomLocationDecayPauseTimer[LocationIndex] > 0 && CustomLocationCanDecay[LocationIndex] == False
			Int CurrentDecayTimer = CustomLocationDecayPauseTimer[LocationIndex]
			Int NewDecayTimer = (CurrentDecayTimer - CountdownChange)
			CustomLocationDecayPauseTimer[LocationIndex] = NewDecayTimer
		EndIf
		If CustomLocationDecayPauseTimer[LocationIndex] <= 0
			CustomLocationDecayPauseTimer[LocationIndex] = 0
			CustomLocationCanDecay[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	;Update Individual Spread Pause Timers
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationSpreadPauseTimer[LocationIndex] > 0 && DefaultLocationCanSpread[LocationIndex] == False
			Int CurrentSpreadTimer = DefaultLocationSpreadPauseTimer[LocationIndex]
			Int NewSpreadTimer = (CurrentSpreadTimer - CountdownChange)
			DefaultLocationSpreadPauseTimer[LocationIndex] = NewSpreadTimer
		EndIf
		If DefaultLocationSpreadPauseTimer[LocationIndex] <= 0
			DefaultLocationSpreadPauseTimer[LocationIndex] = 0
			DefaultLocationCanSpread[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < CustomLocations
		If CustomLocationSpreadPauseTimer[LocationIndex] > 0 && CustomLocationCanSpread[LocationIndex] == False
			Int CurrentSpreadTimer = CustomLocationSpreadPauseTimer[LocationIndex]
			Int NewSpreadTimer = (CurrentSpreadTimer - CountdownChange)
			CustomLocationSpreadPauseTimer[LocationIndex] = NewSpreadTimer
		EndIf
		If CustomLocationSpreadPauseTimer[LocationIndex] <= 0
			CustomLocationSpreadPauseTimer[LocationIndex] = 0
			CustomLocationCanSpread[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	;Update last Checked Time now that Decay and Spread has been processed
	LastCheckedTime = Time
	
	If Mods.IsFameCommentsInstalled == False && SLSFCFameTypesCleared == False
		LocationIndex = 0
		While LocationIndex < LocationManager.DefaultLocation.Length
			Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], "Unfaithful", 0)
			Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], "Cuck", 0)
			LocationIndex += 1
		EndWhile
		
		LocationIndex = 0
		
		While LocationIndex < CustomLocations
			Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], "Unfaithful", 0)
			Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], "Cuck", 0)
			LocationIndex += 1
		EndWhile
		SLSFCFameTypesCleared = True
	ElseIf Mods.IsFameCommentsInstalled == True
		SLSFCFameTypesCleared = False
	EndIf
	
	If Mods.IsBimbosInstalled == False && AirheadFameCleared == False
		LocationIndex = 0
		While LocationIndex < LocationManager.DefaultLocation.Length
			Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], "Airhead", 0)
			LocationIndex += 1
		EndWhile
		
		LocationIndex = 0
		
		While LocationIndex < CustomLocations
			Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], "Airhead", 0)
			LocationIndex += 1
		EndWhile
		AirheadFameCleared = True
	ElseIf Mods.IsBimbosInstalled == True
		AirheadFameCleared = False
	EndIf
	
	Bool ValidScanLocation = True
	If LocationManager.CurrentLocation != None
		NPCScan.CurrentLocation = LocationManager.CurrentLocationName()
		If LocationManager.IsLocationValid(NPCScan.CurrentLocation) == False
			ValidScanLocation = False
		EndIf
	Else
		ValidScanLocation = False
	EndIf
	
	;Multiply Fame Gains by the number of times NPC Scanning should have happened
	If CountdownChange > 1
		IterationMultiplier = CountdownChange
	Else
		IterationMultiplier = 1
	EndIf
	
	If ValidScanLocation == True && VisibilityManager.IsPlayerAnonymous() == False
		PlayerScript.RunNPCDetect()
	EndIf
	
	;Reset Multiplier - Required to not improperly multiply other events
	If IterationMultiplier != 1
		IterationMultiplier = 1
	EndIf
EndEvent

Function CheckExternalFlags()
	If Data.GetExternalFlags("Whore") == True
		ExternalWhoreFlag = True
	Else
		ExternalWhoreFlag = False
	EndIf
	
	If Data.GetExternalFlags("Slut") == True
		ExternalSlutFlag = True
	Else
		ExternalSlutFlag = False
	EndIf
	
	If Data.GetExternalFlags("Exhibitionist") == True
		ExternalExhibitionistFlag = True
	Else
		ExternalExhibitionistFlag = False
	EndIf
	
	If Data.GetExternalFlags("Oral") == True
		ExternalOralFlag = True
	Else
		ExternalOralFlag = False
	EndIf
	
	If Data.GetExternalFlags("Anal") == True
		ExternalAnalFlag = True
	Else
		ExternalAnalFlag = False
	EndIf
	
	If Data.GetExternalFlags("Nasty") == True
		ExternalNastyFlag = True
	Else
		ExternalNastyFlag = False
	EndIf
	
	If Data.GetExternalFlags("Pregnant") == True
		ExternalPregnantFlag = True
	Else
		ExternalPregnantFlag = False
	EndIf
	
	If Data.GetExternalFlags("Dominant") == True
		ExternalDominantFlag = True
	Else
		ExternalDominantFlag = False
	EndIf
	
	If Data.GetExternalFlags("Submissive") == True
		ExternalSubmissiveFlag = True
	Else
		ExternalSubmissiveFlag = False
	EndIf
	
	If Data.GetExternalFlags("Sadist") == True
		ExternalSadistFlag = True
	Else
		ExternalSadistFlag = False
	EndIf
	
	If Data.GetExternalFlags("Masochist") == True
		ExternalMasochistFlag = True
	Else
		ExternalMasochistFlag = False
	EndIf
	
	If Data.GetExternalFlags("Gentle") == True
		ExternalGentleFlag = True
	Else
		ExternalGentleFlag = False
	EndIf
	
	If Data.GetExternalFlags("Likes Men") == True
		ExternalLikesMenFlag = True
	Else
		ExternalLikesMenFlag = False
	EndIf
	
	If Data.GetExternalFlags("Likes Women") == True
		ExternalLikesWomenFlag = True
	Else
		ExternalLikesWomenFlag = False
	EndIf
	
	If Data.GetExternalFlags("Likes Orc") == True
		ExternalLikesOrcFlag = True
	Else
		ExternalLikesOrcFlag = False
	EndIf
	
	If Data.GetExternalFlags("Likes Khajiit")
		ExternalLikesKhajiitFlag = True
	Else
		ExternalLikesKhajiitFlag = False
	EndIf
	
	If Data.GetExternalFlags("Likes Argonian")
		ExternalLikesArgonianFlag = True
	Else
		ExternalLikesArgonianFlag = False
	EndIf
	
	If Data.GetExternalFlags("Bestiality") == True
		ExternalBestialityFlag = True
	Else
		ExternalBestialityFlag = False
	EndIf
	
	If Data.GetExternalFlags("Group") == True
		ExternalGroupFlag = True
	Else
		ExternalGroupFlag = False
	EndIf
	
	If Data.GetExternalFlags("Bound") == True
		ExternalBoundFlag = True
	Else
		ExternalBoundFlag = False
	EndIf
	
	If Data.GetExternalFlags("Tattoo") == True
		ExternalTattooFlag = True
	Else
		ExternalTattooFlag = False
	EndIf
	
	If Data.GetExternalFlags("Cum Dump") == True
		ExternalCumDumpFlag = True
	Else
		ExternalCumDumpFlag = False
	EndIf
	
	If Data.GetExternalFlags("Unfaithful") == True
		ExternalUnfaithfulFlag = True
	Else
		ExternalUnfaithfulFlag = False
	EndIf
	
	If Data.GetExternalFlags("Cuck") == True
		ExternalCuckFlag = True
	Else
		ExternalCuckFlag = False
	EndIf
	
	If Data.GetExternalFlags("Airhead") == True
		ExternalAirheadFlag = True
	Else
		ExternalAirheadFlag = False
	EndIf
EndFunction

Bool Function CanGainWhoreFame()
	;Check Whore Fame
	If Mods.IsPublicWhore(PlayerRef)
		return True
	EndIf
	return False
EndFunction

Bool Function CanGainSlutFame(String FameLocation)
	;Check Slut Fame
	If Mods.IsDDInstalled == True && Mods.IsANDInstalled == False
		If PlayerRef.WornHasKeyword(Mods.DD_NipplePiercing) || PlayerRef.WornHasKeyword(Mods.DD_VaginalPiercing) || PlayerRef.WornHasKeyword(Mods.DD_VaginalPlug) || PlayerRef.WornHasKeyword(SLSF_Reloaded_NipplePiercing) || PlayerRef.WornHasKeyword(SLSF_Reloaded_VaginalPiercing)
			If PlayerRef.GetEquippedArmorInSlot(32) == None
				return True
			EndIf
		EndIf
	ElseIf Mods.IsDDInstalled == True && Mods.IsANDInstalled == True
		If PlayerRef.WornHasKeyword(Mods.DD_NipplePiercing) || PlayerRef.WornHasKeyword(SLSF_Reloaded_NipplePiercing)
			If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 && Data.GetFameValue(FameLocation, "Slut") < 50
				return True
			EndIf
		ElseIf PlayerRef.WornHasKeyword(Mods.DD_VaginalPiercing) || PlayerRef.WornHasKeyword(SLSF_Reloaded_VaginalPiercing)
			If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 && Data.GetFameValue(FameLocation, "Slut") < 75
				return True
			EndIf
		EndIf
	ElseIf Mods.IsDDInstalled == False && Mods.IsANDInstalled == True
		If PlayerRef.WornHasKeyword(SLSF_Reloaded_NipplePiercing) && PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 && Data.GetFameValue(FameLocation, "Slut") < 50
			return True
		ElseIf PlayerRef.WornHasKeyword(SLSF_Reloaded_VaginalPiercing) && PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 && Data.GetFameValue(FameLocation, "Slut") < 75
			return True
		EndIf
	EndIf
	
	If VisibilityManager.IsVaginalCumVisible() == True
		If Sexlab.CountCumVaginal(PlayerRef) > 2
			return True
		ElseIf Sexlab.CountCumVaginal(PlayerRef) > 1 && Data.GetFameValue(FameLocation, "Slut") < 100
			return True
		ElseIf Sexlab.CountCumVaginal(PlayerRef) > 0 && Data.GetFameValue(FameLocation, "Slut") < 50
			return True
		EndIf
	EndIf
	return False
EndFunction

Bool Function CanGainExhibitionistFame(String FameLocation)
	;Check Exhibitionist Fame
	If Mods.IsANDInstalled == True
		If PlayerRef.GetFactionRank(Mods.AND_Nude) == 1
			return True
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Topless) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bottomless) == 1
			If Data.GetFameValue(FameLocation, "Exhibitionist") < 100
				return True
			EndIf
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1
			If Data.GetFameValue(FameLocation, "Exhibitionist") < 75
				return True
			EndIf
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Ass) == 1
			If Data.GetFameValue(FameLocation, "Exhibitionist") < 50
				return True
			EndIf
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear)  == 1
			If Data.GetFameValue(FameLocation, "Exhibitionist") < 25
				return True
			EndIf
		EndIf
	Else
		If PlayerRef.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	return False
EndFunction

Bool Function CanGainOralFame(String FameLocation)
	;Check Oral Fame
	If VisibilityManager.IsOralCumVisible() == False
		return False
	EndIf
	
	Int OralCumCount = Sexlab.CountCumOral(PlayerRef)
	If OralCumCount > 0
		If OralCumCount > 2
			return True
		ElseIf OralCumCount == 2 && Data.GetFameValue(FameLocation, "Oral") < 100
			return True
		ElseIf Data.GetFameValue(FameLocation, "Oral") < 50
			return True
		EndIf
	EndIf
	return False
EndFunction

Bool Function CanGainAnalFame(String FameLocation)
	;Check Anal Fame
	
	If Mods.IsANDInstalled == True
		If PlayerRef.GetFactionRank(Mods.AND_Ass) == 1 && PlayerRef.WornHasKeyword(Mods.DD_AnalPlug)
			return True
		EndIf
	Else
		If PlayerRef.GetEquippedArmorInSlot(32) == None && PlayerRef.WornHasKeyword(Mods.DD_AnalPlug)
			return True
		EndIf
	EndIf
	
	If VisibilityManager.IsAssCumVisible() == False
		return False
	EndIf
	
	Int AssCumCount = Sexlab.CountCumAnal(PlayerRef)
	If AssCumCount > 0
		If AssCumCount > 2
			return True
		ElseIf AssCumCount == 2 && Data.GetFameValue(FameLocation, "Anal") < 100
			return True
		ElseIf Data.GetFameValue(FameLocation, "Anal") < 50
			return True
		EndIf
	EndIf
	return False
EndFunction

Bool Function CanGainNastyFame(String FameLocation)
	;Check Nasty Fame
	If VisibilityManager.IsAssCumVisible() == False && VisibilityManager.IsVaginalCumVisible() == False && VisibilityManager.IsOralCumVisible() == False
		return False
	EndIf
	
	Int CumCount = Sexlab.CountCum(PlayerRef)
	If CumCount > 3
		return True
	ElseIf CumCount > 1 && Data.GetFameValue(FameLocation, "Nasty") < 75
		return True
	EndIf
	return False
EndFunction

Bool Function CanGainPregnantFame(String FameLocation)
	;Check Pregnant Fame
	Int FertilityFactionRank = PlayerRef.GetFactionRank(Mods.FertilityFaction)
	Int HentaiPregFactionRank = PlayerRef.GetFactionRank(Mods.HentaiPregFaction)
	Int CurrentPregFame = Data.GetFameValue(FameLocation, "Pregnant")
	
	If FertilityFactionRank > 30 && FertilityFactionRank <= 60 && CurrentPregFame < 50
		return True
	ElseIf HentaiPregFactionRank == 2 && CurrentPregFame < 50
		return True
	ElseIf FertilityFactionRank > 60 || HentaiPregFactionRank == 3 || Mods.IsECPregnant(PlayerRef) || Mods.IsESPregnant(PlayerRef)
		return True
	EndIf
	
	return False
EndFunction
	
Bool Function CanGainBoundFame()
	;Check Bound Fame
	VisibilityManager.CheckBondage()
	
	If IsVisiblyBound.GetValue() == 1
		return True
	EndIf
	
	return False
EndFunction

Bool Function CanGainTattooFame(String FameLocation)
	;Check Tattoo Fame
	If Mods.IsSlaveTatsInstalled == True
		VisibilityManager.CheckAppliedTattoos()
		
		Int TattooFame = Data.GetFameValue(FameLocation, "Tattoo")
		Int TotalTattoos = VisibilityManager.CountVisibleTattoos()
		Int BodyTattoos = VisibilityManager.VisibleBodyTats
		
		If TotalTattoos > 10 || BodyTattoos < 5
			return True
		ElseIf (TotalTattoos > 8 || BodyTattoos == 5) && TattooFame < 125
			return True
		ElseIf (TotalTattoos > 6 || BodyTattoos == 4) && TattooFame < 100
			return True
		ElseIf (TotalTattoos > 4 || BodyTattoos == 3) && TattooFame < 75
			return True
		ElseIf (TotalTattoos > 2 || BodyTattoos == 2) && TattooFame < 50
			return True
		ElseIf TotalTattoos > 0 && TattooFame < 25
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function CanGainCumDumpFame()
	;Check Cum Dump Fame
	If Mods.GetFHUInflation(PlayerRef) > 2
		return True
	ElseIf	PlayerRef.GetFactionRank(Mods.HentaiPregFaction) == 1
		return True
	EndIf
	return False
EndFunction

Bool Function CheckTattooExtraFame(String ExtraFame)
	Int TattooSlot = 0
	While TattooSlot < Config.TattooSlots
		If VisibilityManager.IsBodyTattooVisible(TattooSlot) == True && VisibilityManager.BodyTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		
		If VisibilityManager.IsFaceTattooVisible(TattooSlot) == True && VisibilityManager.FaceTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		
		If VisibilityManager.IsHandTattooVisible(TattooSlot) == True && VisibilityManager.HandTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		
		If VisibilityManager.IsFootTattooVisible(TattooSlot) == True && VisibilityManager.FootTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		TattooSlot += 1
	EndWhile
	return False
EndFunction

Function FameGainRoll(String FameLocation, Bool CalledExternally = False)
	If LocationManager.IsLocationValid(FameLocation) == False
		If CalledExternally == True
			Debug.Trace("SLSF Reloaded - External FameGainRoll - Location is Invalid")
		Else
			Debug.Trace("SLSF Reloaded - FameGainRoll Function - Location is Invalid")
		EndIf
		return
	EndIf
	
	If VisibilityManager.IsPlayerAnonymous() == True
		Debug.Trace("SLSF Reloaded - FameGainRoll Function - Player is Anonymous")
		return
	EndIf
	
	Int PossibleFameCount = 0
	PossibleFameArray = New String[24]
	
	CheckExternalFlags()
	
	If CanGainAnalFame(FameLocation) == True || CheckTattooExtraFame("Anal") == True || ExternalAnalFlag == True
		PossibleFameArray[PossibleFameCount] = "Anal"
		PossibleFameCount += 1
	EndIf
	
	If CanGainBoundFame() == True || CheckTattooExtraFame("Bound") == True || ExternalBoundFlag == True
		PossibleFameArray[PossibleFameCount] = "Bound"
		PossibleFameCount += 1
	EndIf
	
	If CanGainCumDumpFame() == True || CheckTattooExtraFame("Cum Dump") == True || ExternalCumDumpFlag == True
		PossibleFameArray[PossibleFameCount] = "Cum Dump"
		PossibleFameCount += 1
	EndIf
	
	If CanGainExhibitionistFame(FameLocation) == True || CheckTattooExtraFame("Exhibitionist") == True || ExternalExhibitionistFlag == True
		PossibleFameArray[PossibleFameCount] = "Exhibitionist"
		PossibleFameCount += 1
	EndIf
	
	If CanGainNastyFame(FameLocation) == True || CheckTattooExtraFame("Nasty") == True || ExternalNastyFlag == True
		PossibleFameArray[PossibleFameCount] = "Nasty"
		PossibleFameCount += 1
	EndIf
	
	If CanGainOralFame(FameLocation) == True || CheckTattooExtraFame("Oral") == True || ExternalOralFlag == True
		PossibleFameArray[PossibleFameCount] = "Oral"
		PossibleFameCount += 1
	EndIf
	
	If CanGainPregnantFame(FameLocation) == True || CheckTattooExtraFame("Pregnant") == True || ExternalPregnantFlag == True
		PossibleFameArray[PossibleFameCount] = "Pregnant"
		PossibleFameCount += 1
	EndIf
	
	If CanGainSlutFame(FameLocation) == True || CheckTattooExtraFame("Slut") == True || ExternalSlutFlag == True
		PossibleFameArray[PossibleFameCount] = "Slut"
		PossibleFameCount += 1
	EndIf
	
	If CanGainTattooFame(FameLocation) == True || ExternalTattooFlag == True
		PossibleFameArray[PossibleFameCount] = "Tattoo"
		PossibleFameCount += 1
	EndIf
	
	If CanGainWhoreFame() == True || CheckTattooExtraFame("Whore") == True || ExternalWhoreFlag == True
		PossibleFameArray[PossibleFameCount] = "Whore"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Dominant") == True || ExternalDominantFlag == True
		PossibleFameArray[PossibleFameCount] = "Dominant"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Submissive") == True || ExternalSubmissiveFlag == True
		PossibleFameArray[PossibleFameCount] = "Submissive"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Sadist") == True || ExternalSadistFlag == True
		PossibleFameArray[PossibleFameCount] = "Sadist"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Masochist") == True || ExternalMasochistFlag == True
		PossibleFameArray[PossibleFameCount] = "Masochist"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Gentle") == True || ExternalGentleFlag == True
		PossibleFameArray[PossibleFameCount] = "Gentle"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Men") == True || ExternalLikesMenFlag == True
		PossibleFameArray[PossibleFameCount] = "Likes Men"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Women") == True || ExternalLikesWomenFlag == True
		PossibleFameArray[PossibleFameCount] = "Likes Women"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Orc") == True || ExternalLikesOrcFlag == True
		PossibleFameArray[PossibleFameCount] = "Likes Orc"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Khajiit") == True || ExternalLikesKhajiitFlag == True
		PossibleFameArray[PossibleFameCount] = "Likes Khajiit"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Argonian") == True || ExternalLikesArgonianFlag == True
		PossibleFameArray[PossibleFameCount] = "Likes Argonian"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Bestiality") == True || ExternalBestialityFlag == True
		PossibleFameArray[PossibleFameCount] = "Bestiality"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Group") == True || ExternalGroupFlag == True
		PossibleFameArray[PossibleFameCount] = "Group"
		PossibleFameCount += 1
	EndIf
	
	If Mods.IsFameCommentsInstalled == True
		If CheckTattooExtraFame("Unfaithful") == True || ExternalUnfaithfulFlag == True
			PossibleFameArray[PossibleFameCount] = "Unfaithful"
			PossibleFameCount += 1
		EndIf
		
		If CheckTattooExtraFame("Cuck") == True || ExternalCuckFlag == True
			PossibleFameArray[PossibleFameCount] = "Cuck"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If Mods.IsBimbosInstalled == True
		If CheckTattooExtraFame("Airhead") == True || ExternalAirheadFlag == True
			PossibleFameArray[PossibleFameCount] = "Airhead"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If PossibleFameCount == 0
		Debug.Trace("SLSF Reloaded - FameGainRoll Function - PossibleFameCount is Zero")
		return ;If none of the above categories are possible, end function
	EndIf

	Int GainedFameCount = 0
	If PossibleFameCount > 1
		GainedFameCount = Utility.RandomInt(1, PossibleFameCount) ;Randomly Determine how many fame categories are increased
	Else
		GainFame(PossibleFameArray[0], FameLocation, False) ;If there is only one fame category to gain, apply it and end function
		return
	EndIf
	
	;Apply Fame Step
	Int AppliedFameCount = 0
	If GainedFameCount == PossibleFameCount ;If we gain fame in every possible category, send all increases
		While AppliedFameCount < GainedFameCount
			GainFame(PossibleFameArray[AppliedFameCount], FameLocation, False)
			AppliedFameCount += 1
		EndWhile
		return ;end function after applying all fame
	EndIf
	
	String[] RolledCategory = Utility.CreateStringArray(GainedFameCount) ;Store which fame categories we roll and check against them to prevent duplicates
	Int CategoryRoll = 0
	Int TimesRolled = 0
	Int PreviousRoll = 0
	Bool DuplicateFameRolls = False
	While AppliedFameCount < GainedFameCount ;AppliedFameCount becomes our Index for the RolledCategory array
		CategoryRoll = Utility.RandomInt(0, (PossibleFameCount - 1)) ;We've already determined that PossibleFameCount is higher than 1, so the maximum will be at least 1. CategoryRoll becomes our PossibleFameArray Index
		TimesRolled += 1
		RolledCategory[AppliedFameCount] = PossibleFameArray[CategoryRoll]
		If TimesRolled > 1 ;If this isn't our first fame roll, check for duplicates
			While PreviousRoll < TimesRolled
				If RolledCategory[AppliedFameCount] == RolledCategory[PreviousRoll] ;Check previous rolls for matching results
					DuplicateFameRolls = True
				EndIf
				PreviousRoll += 1
			EndWhile
			PreviousRoll = 0
		EndIf
		
		If DuplicateFameRolls == False
			;If there are no duplicates, apply our rolled fame.
			GainFame(RolledCategory[AppliedFameCount], FameLocation, False)
			AppliedFameCount += 1
		Else
			TimesRolled -= 1 ;If there is a duplicate, reduce roll to prevent run-away index checks
			DuplicateFameRolls = False
		EndIf
	EndWhile
EndFunction

Function GainFame(String Category, String LocationName, Bool IsForeplay)
	If LocationName == "Eastmarch"
		LocationName = "Windhelm"
	ElseIf LocationName == "Haafingar"
		LocationName = "Solitude"
	ElseIf LocationName == "Hjaalmarch"
		LocationName = "Morthal"
	ElseIf LocationName == "the Reach"
		LocationName = "Markarth"
	ElseIf LocationName == "the Pale"
		LocationName = "Dawnstar"
	ElseIf LocationName == "the Rift"
		LocationName = "Riften"
	EndIf
	
	Int FameGained = 0
	Float FameMultiplier = Config.FameChangeMultiplier
	
	If Config.UseGlobalFameMultiplier == False
		Int TypeIndex = FameType.Find(Category)
		FameMultiplier = Config.FameCategoryMultiplier[TypeIndex]
	EndIf
	
	Float Hour = (Utility.GetCurrentGameTime() - Math.Floor(Utility.GetCurrentGameTime())) * 24
	
	If ((Hour > Config.NightStart || Hour < Config.NightEnd) && Config.ReduceFameAtNight == True) || IsForeplay == True
		FameMultiplier = FameMultiplier / 2 ;Half Fame Gains at night
	EndIf
	
	Int PreviousFame = Data.GetFameValue(LocationName, Category)
	
	If PreviousFame >= 100
		FameGained = ((Utility.RandomInt(1,2) * FameMultiplier) as Int) * IterationMultiplier
	ElseIf PreviousFame >= 75
		FameGained = ((Utility.RandomInt(1,4) * FameMultiplier) as Int) * IterationMultiplier
	ElseIf PreviousFame >= 50
		FameGained = ((Utility.RandomInt(1,6) * FameMultiplier) as Int) * IterationMultiplier
	ElseIf PreviousFame >= 25
		FameGained = ((Utility.RandomInt(1,8) * FameMultiplier) as Int) * IterationMultiplier
	Else
		FameGained = ((Utility.RandomInt(1,10) * FameMultiplier) as Int) * IterationMultiplier
	EndIf
	
	If FameGained < 1
		FameGained = 1
	EndIf
	
	Int NewFame = PreviousFame + FameGained
	
	If NewFame > 150
		NewFame = 150
	EndIf
	
	Data.SetFameValue(LocationName, Category, NewFame)
	
	;Location Decay is paused when fame increases. Find location index, apply pause, and reset timer.
	Int LocationIndex = 0
	Bool LocationFound = False
	While LocationFound == False && LocationIndex < LocationManager.DefaultLocation.Length
		If LocationName == LocationManager.DefaultLocation[LocationIndex]
			LocationFound = True
			DefaultLocationCanDecay[LocationIndex] = False
			DefaultLocationDecayPauseTimer[LocationIndex] = (Config.DecayTimeNeeded) as Int
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	While LocationFound == False && LocationIndex < CustomLocations
		If LocationFound == False && LocationIndex < SLSF_Reloaded_CustomLocationCount.GetValue()
			If LocationName == LocationManager.CustomLocation[LocationIndex]
				LocationFound = True
				CustomLocationCanDecay[LocationIndex] = False
				CustomLocationDecayPauseTimer[LocationIndex] = (Config.DecayTimeNeeded) as Int
			EndIf
		EndIf
		LocationIndex += 1
	EndWhile
	
	If LocationFound == False
		Debug.MessageBox("SLSF Reloaded - ERROR: Could not find Fame Gain Location to pause decay.")
	EndIf
	
	If Config.NotifyFameIncrease == True
		FameGainNotification()
	EndIf
EndFunction

Function DecayFame()
	Int FameDecay = 0
	Int LocationIndex = 0
	Int TypeIndex = 0
	Float FameMultiplier = Config.FameChangeMultiplier
	Bool DecayNotificationMakesSense = False
	Int NewFame = 0
	Int PreviousFame = 0
	
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationCanDecay[LocationIndex] == True
			While TypeIndex < FameType.Length
				PreviousFame = Data.GetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex])
				
				If Config.UseGlobalFameMultiplier == False
					FameMultiplier = Config.FameCategoryMultiplier[TypeIndex]
				EndIf
				
				If PreviousFame > 0
					If PreviousFame >= 100
						FameDecay = ((-1 * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 75
						FameDecay = ((Utility.RandomInt(-2,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 50
						FameDecay = ((Utility.RandomInt(-3,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 25
						FameDecay = ((Utility.RandomInt(-4,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					Else
						FameDecay = ((Utility.RandomInt(-5,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					EndIf
				EndIf
				
				If Data.GetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex]) < 0
					Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], 0)
				EndIf
				TypeIndex += 1
			EndWhile
		EndIf
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	TypeIndex = 0
	LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	While LocationIndex < CustomLocations
		If CustomLocationCanDecay[LocationIndex] == True
			While TypeIndex < FameType.Length
				PreviousFame = Data.GetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex])
				
				If Config.UseGlobalFameMultiplier == False
					FameMultiplier = Config.FameCategoryMultiplier[TypeIndex]
				EndIf
				
				If PreviousFame > 0
					If PreviousFame >= 100
						FameDecay = ((-1 * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 75
						FameDecay = ((Utility.RandomInt(-2,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 50
						FameDecay = ((Utility.RandomInt(-3,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 25
						FameDecay = ((Utility.RandomInt(-4,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					Else
						FameDecay = ((Utility.RandomInt(-5,-1) * FameMultiplier) as Int) * IterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					EndIf
				EndIf
				
				If Data.GetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex]) < 0
					Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], 0)
				EndIf
				TypeIndex += 1
			EndWhile
		EndIf
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	If Config.NotifyFameDecay == True && DecayNotificationMakesSense == True
		FameDecayNotification()
	EndIf
EndFunction

Function SpreadFameRoll()
	Int FameSpreadRoll = 0
	Int SpreadChance = 0
	
	;Check if Fame Spread is not Paused, and perform spread operations if not.
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationCanSpread[LocationIndex] == True
			If Config.HasFameAtDefaultLocation[LocationIndex] == True
				SpreadChance = Config.DefaultLocationSpreadChance[LocationIndex]
				If SpreadChance == 0
					Config.DefaultLocationSpreadChance[LocationIndex] = (Config.DefaultLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease) as Int
				ElseIf SpreadChance == 100
					SpreadFame(LocationManager.DefaultLocation[LocationIndex])
					Config.DefaultLocationSpreadChance[LocationIndex] = (Config.DefaultLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction) as Int
				ElseIf SpreadChance > 100 || SpreadChance < 0
					Debug.MessageBox("SLSF Reloaded: ERROR - Fame Spread Chance for " + LocationManager.DefaultLocation[LocationIndex] + " is not valid!")
				Else
					FameSpreadRoll = Utility.RandomInt(1, 100)
					If FameSpreadRoll <= SpreadChance
						SpreadFame(LocationManager.DefaultLocation[LocationIndex])
						Config.DefaultLocationSpreadChance[LocationIndex] = (Config.DefaultLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction) as Int
					Else
						Config.DefaultLocationSpreadChance[LocationIndex] = (Config.DefaultLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease) as Int
					EndIf
				EndIf
				
				If Config.DefaultLocationSpreadChance[LocationIndex] < 0
					Config.DefaultLocationSpreadChance[LocationIndex] = 0
				EndIf
				
				If Config.DefaultLocationSpreadChance[LocationIndex] > 100
					Config.DefaultLocationSpreadChance[LocationIndex] = 100
				EndIf
			EndIf
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	While LocationIndex < CustomLocations
		If CustomLocationCanSpread[LocationIndex] == True
			If Config.HasFameAtCustomLocation[LocationIndex] == True
				SpreadChance = Config.CustomLocationSpreadChance[LocationIndex]
				If SpreadChance == 0
					Config.CustomLocationSpreadChance[LocationIndex] = (Config.CustomLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease) as Int
				ElseIf SpreadChance == 100
					SpreadFame(LocationManager.CustomLocation[LocationIndex])
					Config.CustomLocationSpreadChance[LocationIndex] = (Config.CustomLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction) as Int
				ElseIf SpreadChance > 100 || SpreadChance < 0
					Debug.MessageBox("SLSF Reloaded: ERROR - Fame Spread Chance for " + LocationManager.CustomLocation[LocationIndex] + " is not valid!")
				Else
					FameSpreadRoll = Utility.RandomInt(1, 100)
					If FameSpreadRoll <= SpreadChance
						SpreadFame(LocationManager.CustomLocation[LocationIndex])
						Config.CustomLocationSpreadChance[LocationIndex] = (Config.CustomLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction) as Int
					Else
						Config.CustomLocationSpreadChance[LocationIndex] = (Config.CustomLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease) as Int
					EndIf
				EndIf
				
				If Config.CustomLocationSpreadChance[LocationIndex] < 0
					Config.CustomLocationSpreadChance[LocationIndex] = 0
				EndIf
				
				If Config.CustomLocationSpreadChance[LocationIndex] > 100
					Config.CustomLocationSpreadChance[LocationIndex] = 100
				EndIf
			EndIf
		EndIf
		LocationIndex += 1
	EndWhile
EndFunction

Function SpreadFame(String SpreadFromLocation)

	;Grab all fame values above the configured threshold from the source Location. If none exist, cancel fame spread operation
	Int SpreadableFame = 0
	Int PossibleFameSpreadCategories = 0
	Int PossibleFameSpreadIndex = 0
	PossibleSpreadCategories = New String[1] ;Set Default array size to 1 | resize as necessary
	
	;Count possible categories & fill array
	While PossibleFameSpreadIndex < FameType.Length
		SpreadableFame = Data.GetFameValue(SpreadFromLocation, FameType[PossibleFameSpreadIndex])
		
		If SpreadableFame >= Config.MinimumFameToSpread
			PossibleFameSpreadCategories += 1
			If PossibleFameSpreadCategories > 1
				Utility.ResizeStringArray(PossibleSpreadCategories, PossibleFameSpreadCategories)
			EndIf
			PossibleSpreadCategories[(PossibleFameSpreadCategories - 1)] = FameType[PossibleFameSpreadIndex]
		EndIf
		
		PossibleFameSpreadIndex += 1
	EndWhile
	
	If PossibleFameSpreadCategories == 0
		return
	EndIf
	
	;Get possible fame spread targets
	Int DefaultLocations = LocationManager.DefaultLocation.Length
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	Int TotalLocations = DefaultLocations + CustomLocations
	
	PossibleSpreadTargets = Utility.CreateStringArray(TotalLocations)
	
	;Fill array with possible targets
	Int PossibleLocationIndex = 0
	Int DefaultLocationIndex = 0
	Int CustomLocationIndex = 0
	
	While PossibleLocationIndex < TotalLocations
		If DefaultLocationIndex < DefaultLocations
			PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.DefaultLocation[DefaultLocationIndex]
			DefaultLocationIndex += 1
		ElseIf CustomLocationIndex < CustomLocations
			PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.CustomLocation[CustomLocationIndex]
			CustomLocationIndex += 1
		EndIf
		PossibleLocationIndex += 1
	EndWhile
	
	;Roll Target location index based on number of total locations
	Int TargetLocationIndex = 0
	Bool TargetLocationValid = False
	
	While TargetLocationValid == False
		TargetLocationIndex = Utility.RandomInt(0, TotalLocations)
		If SpreadFromLocation != PossibleSpreadTargets[TargetLocationIndex] ;ensure we are not trying to spread to the original location
			TargetLocationValid = True
		EndIf
	EndWhile
	
	Debug.Trace("Fame Spread Target: " + PossibleSpreadTargets[TargetLocationIndex])
	
	;When valid target is found, randomize how many fame categories are spread and by how much, based on config values.
	Int NumberOfCategoriesToSpread = 0
	Float CategorySpreadPercentage = 0.0
	
	If Config.MaximumSpreadCategories > 1 && PossibleFameSpreadCategories > 1
		If Config.MaximumSpreadCategories <= PossibleFameSpreadCategories
			NumberOfCategoriesToSpread = Utility.RandomInt(1, (Config.MaximumSpreadCategories as Int))
		Else
			NumberOfCategoriesToSpread = Utility.RandomInt(1, PossibleFameSpreadCategories)
		EndIf
	Else
		NumberOfCategoriesToSpread = 1
	EndIf
	
	;Randomly pick which valid categories are spread
	Int TargetFameValue = 0
	Int FromFameValue = 0
	Int NewFame = 0
	Int SuccessfulFameSpreads = 0
	Int CategoryRoll = 0
	
	If PossibleFameSpreadCategories == 1
		TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[0])
		
		FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleSpreadCategories[0])
		;Fame spread is in steps of 10%, which is why we divide the MaximumSpreadPercentage by 10 and then divide the RandomInt by 10 again to total the overall division by 100, which gives us a percentage
		
		NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
		
		If NewFame > 150
			NewFame = 150
		EndIf
		
		Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[0], NewFame)
	ElseIf NumberOfCategoriesToSpread == 1
		CategoryRoll = Utility.RandomInt(0, (PossibleFameSpreadCategories - 1))
		
		TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[CategoryRoll])
		
		FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleSpreadCategories[0])
		
		NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
		
		If NewFame > 150
			NewFame = 150
		EndIf
		
		Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[CategoryRoll], NewFame)
	ElseIf NumberOfCategoriesToSpread == PossibleFameSpreadCategories
		While SuccessfulFameSpreads < PossibleFameSpreadCategories
			TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[SuccessfulFameSpreads])
			
			FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleSpreadCategories[SuccessfulFameSpreads])
			
			NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
			
			If NewFame > 150
				NewFame = 150
			EndIf
			
			Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[SuccessfulFameSpreads], NewFame)
			
			SuccessfulFameSpreads += 1
		EndWhile
	Else
		Int TimesRolled = 0
		Int PreviousRoll = 0
		Bool DuplicateFameRolls = False
		String[] RolledCategory = Utility.CreateStringArray(NumberOfCategoriesToSpread)
		
		While SuccessfulFameSpreads < NumberOfCategoriesToSpread
			CategoryRoll = Utility.RandomInt(0, (PossibleFameSpreadCategories - 1))
			TimesRolled += 1
			RolledCategory[SuccessfulFameSpreads] = PossibleSpreadCategories[CategoryRoll]
			If TimesRolled > 1 ;If this isn't our first fame roll, check for duplicates
				While PreviousRoll < TimesRolled && DuplicateFameRolls == False
					If RolledCategory[SuccessfulFameSpreads] == RolledCategory[PreviousRoll] ;Check previous rolls for matching results
						DuplicateFameRolls = True
					EndIf
					PreviousRoll += 1
				EndWhile
				PreviousRoll = 0
			EndIf
			
			If DuplicateFameRolls == False
				;If there are no duplicates, apply our rolled fame.
				TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[CategoryRoll])
				
				FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleSpreadCategories[CategoryRoll])
				
				NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
				
				If NewFame > 150
					NewFame = 150
				EndIf
				
				Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleSpreadCategories[CategoryRoll], NewFame)
				
				SuccessfulFameSpreads += 1
			Else
				TimesRolled -= 1 ;If there is a duplicate, reduce roll to prevent run-away index checks
				DuplicateFameRolls = False
			EndIf
		EndWhile
	EndIf
	
	;Enable Spread Pause for Location
	Int PauseIndex = PossibleSpreadTargets.Find(SpreadFromLocation)
	
	If PauseIndex < LocationManager.DefaultLocation.Length
		DefaultLocationCanSpread[PauseIndex] = False
		DefaultLocationSpreadPauseTimer[PauseIndex] = Config.SpreadTimeNeeded as Int
	Else
		CustomLocationCanSpread[(PauseIndex - (LocationManager.DefaultLocation.Length))] = False
		CustomLocationSpreadPauseTimer[(PauseIndex - 21)] = Config.SpreadTimeNeeded as Int
	EndIf
	
	If Config.NotifyFameSpread == True
		FameSpreadNotification()
	EndIf
EndFunction

Function FameGainNotification()
	;Placeholder - Will be refined after testing
	Debug.Notification("SLSF Realoaded - Your fame has increased")
EndFunction

Function FameDecayNotification()
	;Placeholder - Will be refined after testing
	Debug.Notification("SLSF Realoaded - Your fame has decayed")
EndFunction

Int Function CalculateFameSpread(Int FromFame, Int TargetFame)
	Int MaxRoll = (Config.MaximumSpreadPercentage as Int) / 10 ;Result should be 1, 2, 3, 4, or 5
	Float SpreadRoll = 1.0
	
	If MaxRoll > 1 ;If MaxRoll is 1, then roll doesn't matter
		SpreadRoll = Utility.RandomInt(1, MaxRoll) as Float
	EndIf
	
	Float fPrevious = FromFame as Float
	Float fPercentage = (SpreadRoll / 10) as Float ;Result should be 0.1, 0.2, 0.3, 0.4, or 0.5 (10%, 20%, 30%, 40%, or 50%) based on roll
	Float fSpreadValue = fPrevious * fPercentage ;Result should be a percentage of fame from the spreading location, minimum being 1
	Int FinalFame = (TargetFame + fSpreadValue) as Int
	
	return FinalFame
EndFunction

Function FameSpreadNotification()
	;Placeholder - Will be refined after testing
	Debug.Notification("SLSF Realoaded - Your fame has spread")
EndFunction

Function ClearFame(String LocationToClear)
	Int TypeIndex = 0
	While TypeIndex < FameType.Length
		Data.SetFameValue(LocationToClear, FameType[TypeIndex], 0)
		TypeIndex += 1
	EndWhile
	Debug.MessageBox(LocationToClear + " fame has been cleared.")
EndFunction

Function ClearAllFame()
	Int TypeIndex = 0
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		While TypeIndex < FameType.Length
			Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], 0)
			TypeIndex += 1
		EndWhile
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	TypeIndex = 0
	LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	While LocationIndex < CustomLocations
		While TypeIndex < FameType.Length
			Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], 0)
			TypeIndex += 1
		EndWhile
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	WhoreGlobal.SetValue(0)
	SlutGlobal.SetValue(0)
	ExhibGlobal.SetValue(0)
	OralGlobal.SetValue(0)
	AnalGlobal.SetValue(0)
	NastyGlobal.SetValue(0)
	PregGlobal.SetValue(0)
	DomGlobal.SetValue(0)
	SubGlobal.SetValue(0)
	SadistGlobal.SetValue(0)
	MasochistGlobal.SetValue(0)
	GentleGlobal.SetValue(0)
	MenGlobal.SetValue(0)
	WomenGlobal.SetValue(0)
	KhajiitGlobal.SetValue(0)
	OrcGlobal.SetValue(0)
	ArgonianGlobal.SetValue(0)
	BeastGlobal.SetValue(0)
	GroupGlobal.SetValue(0)
	BoundGlobal.SetValue(0)
	TattooGlobal.SetValue(0)
	CumDumpGlobal.SetValue(0)
	CheatGlobal.SetValue(0)
	CuckGlobal.SetValue(0)
	
	Debug.MessageBox("All fame has been cleared.")
EndFunction

Function UpdateGlobals()
	String LocationName = LocationManager.CurrentLocationName()
	
	If LocationManager.IsLocationValid(LocationName) == False
		WhoreGlobal.SetValue(0)
		SlutGlobal.SetValue(0)
		ExhibGlobal.SetValue(0)
		OralGlobal.SetValue(0)
		AnalGlobal.SetValue(0)
		NastyGlobal.SetValue(0)
		PregGlobal.SetValue(0)
		DomGlobal.SetValue(0)
		SubGlobal.SetValue(0)
		SadistGlobal.SetValue(0)
		MasochistGlobal.SetValue(0)
		GentleGlobal.SetValue(0)
		MenGlobal.SetValue(0)
		WomenGlobal.SetValue(0)
		KhajiitGlobal.SetValue(0)
		OrcGlobal.SetValue(0)
		ArgonianGlobal.SetValue(0)
		BeastGlobal.SetValue(0)
		GroupGlobal.SetValue(0)
		BoundGlobal.SetValue(0)
		TattooGlobal.SetValue(0)
		CumDumpGlobal.SetValue(0)
		CheatGlobal.SetValue(0)
		CuckGlobal.SetValue(0)
		AirheadGlobal.SetValue(0)
	Else
		WhoreGlobal.SetValue(Data.GetFameValue(LocationName, "Whore"))
		SlutGlobal.SetValue(Data.GetFameValue(LocationName, "Slut"))
		ExhibGlobal.SetValue(Data.GetFameValue(LocationName, "Exhibitionist"))
		OralGlobal.SetValue(Data.GetFameValue(LocationName, "Oral"))
		AnalGlobal.SetValue(Data.GetFameValue(LocationName, "Anal"))
		NastyGlobal.SetValue(Data.GetFameValue(LocationName, "Nasty"))
		PregGlobal.SetValue(Data.GetFameValue(LocationName, "Pregnant"))
		DomGlobal.SetValue(Data.GetFameValue(LocationName, "Dominant"))
		SubGlobal.SetValue(Data.GetFameValue(LocationName, "Submissive"))
		SadistGlobal.SetValue(Data.GetFameValue(LocationName, "Sadist"))
		MasochistGlobal.SetValue(Data.GetFameValue(LocationName, "Masochist"))
		GentleGlobal.SetValue(Data.GetFameValue(LocationName, "Gentle"))
		MenGlobal.SetValue(Data.GetFameValue(LocationName, "Likes Men"))
		WomenGlobal.SetValue(Data.GetFameValue(LocationName, "Likes Women"))
		KhajiitGlobal.SetValue(Data.GetFameValue(LocationName, "Likes Khajiit"))
		OrcGlobal.SetValue(Data.GetFameValue(LocationName, "Likes Orc"))
		ArgonianGlobal.SetValue(Data.GetFameValue(LocationName, "Likes Argonian"))
		BeastGlobal.SetValue(Data.GetFameValue(LocationName, "Bestiality"))
		GroupGlobal.SetValue(Data.GetFameValue(LocationName, "Group"))
		BoundGlobal.SetValue(Data.GetFameValue(LocationName, "Bound"))
		TattooGlobal.SetValue(Data.GetFameValue(LocationName, "Tattoo"))
		CumDumpGlobal.SetValue(Data.GetFameValue(LocationName, "Cum Dump"))
		CheatGlobal.SetValue(Data.GetFameValue(LocationName, "Unfaithful"))
		CuckGlobal.SetValue(Data.GetFameValue(LocationName, "Cuck"))
		AirheadGlobal.SetValue(Data.GetFameValue(LocationName, "Airhead"))
	EndIf
EndFunction