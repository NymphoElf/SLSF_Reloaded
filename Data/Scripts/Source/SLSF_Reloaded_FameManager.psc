ScriptName SLSF_Reloaded_FameManager extends Quest

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_ModEventListener Property ExternalListener Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_MCM Property Config Auto
SexlabFramework Property Sexlab Auto
SLSF_Reloaded_LegacyOverwrite Property LegacyOverwrite Auto

Bool[] Property DefaultLocationCanDecay Auto 
Bool[] Property CustomLocationCanDecay Auto 

String[] Property FameType Auto

Int[] Property DefaultLocationDecayPauseTimer Auto 
Int[] Property CustomLocationDecayPauseTimer Auto 
Int Property DecayCountdown Auto Hidden
Int Property SpreadCountdown Auto Hidden
Int Property GainIterationMultiplier Auto Hidden
Int Property DecayIterationMultiplier Auto Hidden

Keyword Property SLSF_Reloaded_NipplePiercing Auto
Keyword Property SLSF_Reloaded_VaginalPiercing Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto
GlobalVariable Property IsVisiblyBound Auto
GlobalVariable Property IsHeavilyBound Auto
GlobalVariable Property IsLightlyBound Auto

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
Bool Property FameGainNotifyCooldown Auto Hidden

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

Bool Property CumDumpFameCleared Auto Hidden
Bool Property CuckFameCleared Auto Hidden
Bool Property UnfaithfulFameCleared Auto Hidden
Bool Property AirheadFameCleared Auto Hidden

Bool Property SLSFCFameTypesCleared Auto Hidden ;DEPRECATED

Event OnInit()
	Startup()
EndEvent

Function Startup()
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		DefaultLocationCanDecay[LocationIndex] = True
		DefaultLocationDecayPauseTimer[LocationIndex] = 0
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < LocationManager.CustomLocation.Length
		CustomLocationCanDecay[LocationIndex] = False
		CustomLocationDecayPauseTimer[LocationIndex] = 0
		LocationIndex += 1
	EndWhile
	
	DecayCountdown = 24
	SpreadCountdown = 48
	GainIterationMultiplier = 1
	DecayIterationMultiplier = 1
EndFunction

Function UpdateFame(Int CountdownChange)
	;Update countdown timers
	DecayCountdown -= CountdownChange
	SpreadCountdown -= CountdownChange
	
	Int DecayIterations = 0
	While DecayCountdown <= 0
		DecayCountdown += (Config.DecayTimeNeeded) as Int ;Increase decay timer by time needed. Maintains carry-over time
		DecayIterations += 1
	EndWhile
	
	If DecayIterations >= 1
		DecayIterationMultiplier = DecayIterations
		DecayFame()
	Else
		DecayIterationMultiplier = 1
	EndIf
	
	If SpreadCountdown <= 0
		SpreadCountdown += (Config.SpreadTimeNeeded) as Int ;Increase spread timer by time needed. Maintains carry-over time
		SpreadFameRoll()
	EndIf
	
	;Multiply Fame Gains by the number of times NPC Scanning should have happened normally
	GainIterationMultiplier = CountdownChange
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded Fame Manager - Anonymous Status: " + VisibilityManager.IsPlayerAnonymous())
	EndIf
	
	If VisibilityManager.IsPlayerAnonymous() == False
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded Fame Manager - Run NPC Detect")
		EndIf
		PlayerScript.RunNPCDetect()
	EndIf
	
	;Reset Multipliers - Required to not improperly multiply other events
	If GainIterationMultiplier != 1
		GainIterationMultiplier = 1
	EndIf
	
	If DecayIterationMultiplier != 1
		DecayIterationMultiplier = 1
	EndIf
	
	;Update Individual Decay Pause Timers
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationDecayPauseTimer[LocationIndex] > 0 && DefaultLocationCanDecay[LocationIndex] == False
			Int CurrentDecayTimer = DefaultLocationDecayPauseTimer[LocationIndex]
			Int NewDecayTimer = (CurrentDecayTimer - CountdownChange) as Int
			DefaultLocationDecayPauseTimer[LocationIndex] = NewDecayTimer
		EndIf
		If DefaultLocationDecayPauseTimer[LocationIndex] <= 0
			DefaultLocationDecayPauseTimer[LocationIndex] = 0
			DefaultLocationCanDecay[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	While LocationIndex < SLSF_Reloaded_CustomLocationCount.GetValue()
		If CustomLocationDecayPauseTimer[LocationIndex] > 0 && CustomLocationCanDecay[LocationIndex] == False
			Int CurrentDecayTimer = CustomLocationDecayPauseTimer[LocationIndex]
			Int NewDecayTimer = (CurrentDecayTimer - CountdownChange) as Int
			CustomLocationDecayPauseTimer[LocationIndex] = NewDecayTimer
		EndIf
		If CustomLocationDecayPauseTimer[LocationIndex] <= 0
			CustomLocationDecayPauseTimer[LocationIndex] = 0
			CustomLocationCanDecay[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	If Mods.IsFHUInstalled == False && CumDumpFameCleared == False && Data.DisplayFameFlags[0] == False
		WipeCumDumpFame()
		CumDumpFameCleared = True
	ElseIf Mods.IsFHUInstalled == True || Data.DisplayFameFlags[0] == True
		CumDumpFameCleared = False
	EndIf
	
	If Mods.IsFameCommentsInstalled == False && CuckFameCleared == False && Data.DisplayFameFlags[1] == False
		WipeCuckFame()
		CuckFameCleared = True
	ElseIf Mods.IsFameCommentsInstalled == True || Data.DisplayFameFlags[1] == True
		CuckFameCleared = False
	EndIf
	
	If Mods.IsFameCommentsInstalled == False && UnfaithfulFameCleared == False && Data.DisplayFameFlags[2] == False
		WipeUnfaithfulFame()
		UnfaithfulFameCleared = True
	ElseIf Mods.IsFameCommentsInstalled == True || Data.DisplayFameFlags[2] == True
		UnfaithfulFameCleared = False
	EndIf
	
	If Mods.IsBimbosInstalled == False && AirheadFameCleared == False && Data.DisplayFameFlags[3] == False
		WipeAirheadFame()
		AirheadFameCleared = True
	ElseIf Mods.IsBimbosInstalled == True || Data.DisplayFameFlags[3] == True
		AirheadFameCleared = False
	EndIf
	
	Data.FameCheck()
EndFunction

Function WipeCuckFame()
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], "Cuck", 0)
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < SLSF_Reloaded_CustomLocationCount.GetValue()
		Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], "Cuck", 0)
		LocationIndex += 1
	EndWhile
EndFunction

Function WipeUnfaithfulFame()
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], "Unfaithful", 0)
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < SLSF_Reloaded_CustomLocationCount.GetValue()
		Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], "Unfaithful", 0)
		LocationIndex += 1
	EndWhile
EndFunction

Function WipeAirheadFame()
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], "Airhead", 0)
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < SLSF_Reloaded_CustomLocationCount.GetValue()
		Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], "Airhead", 0)
		LocationIndex += 1
	EndWhile
EndFunction

Function WipeCumDumpFame()
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], "Cum Dump", 0)
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < SLSF_Reloaded_CustomLocationCount.GetValue()
		Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], "Cum Dump", 0)
		LocationIndex += 1
	EndWhile
EndFunction

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
	
	If Data.GetExternalFlags("Likes Khajiit") == True
		ExternalLikesKhajiitFlag = True
	Else
		ExternalLikesKhajiitFlag = False
	EndIf
	
	If Data.GetExternalFlags("Likes Argonian") == True
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
	return Mods.IsPublicWhore()
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
	If Sexlab.IsActorActive(PlayerRef) == True
		return True
	EndIf
	
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
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1
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
	
	Int CumCount = 0
	
	CumCount = Sexlab.CountCum(PlayerRef)
	
	If CumCount > 3
		return True
	ElseIf CumCount > 1 && Data.GetFameValue(FameLocation, "Nasty") < 75
		return True
	EndIf
	return False
EndFunction

Bool Function CanGainPregnantFame(String FameLocation)
	;Check Pregnant Fame
	Int FertilityFactionRank = 0
	Int HentaiPregFactionRank = 0
	
	If Mods.IsFMInstalled == True
		FertilityFactionRank = PlayerRef.GetFactionRank(Mods.FertilityFaction)
	EndIf
	
	If Mods.IsHentaiPregInstalled == True
		HentaiPregFactionRank = PlayerRef.GetFactionRank(Mods.HentaiPregFaction)
	EndIf
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
	
Bool Function CanGainBoundFame(String FameLocation)
	;Check Bound Fame
	VisibilityManager.CheckBondage()
	
	Int BondagePoints = 0
	Int BondageFame = Data.GetFameValue(FameLocation, "Bound")
	
	If VisibilityManager.DD_CollarVisible == True && Config.AllowCollarBoundFame == True
		BondagePoints += 1
	EndIf
	
	If VisibilityManager.DD_BraVisible == True || PlayerRef.WornHasKeyword(Mods.DD_Corset)
		BondagePoints += 2
	EndIf
	
	If VisibilityManager.DD_BeltVisible == True
		BondagePoints += 2
	EndIf
	
	If VisibilityManager.DD_HarnessVisible == True || PlayerRef.WornHasKeyword(Mods.DD_Suit)
		BondagePoints += 3
	EndIf
	
	If PlayerRef.WornHasKeyword(Mods.DD_ArmCuffs) || PlayerRef.WornHasKeyword(Mods.DD_ArmCuffsFront) || PlayerRef.WornHasKeyword(Mods.DD_Armbinder) || PlayerRef.WornHasKeyword(Mods.DD_ArmbinderElbow) || PlayerRef.WornHasKeyword(Mods.DD_Gloves)
		BondagePoints += 2
	EndIf
	
	If PlayerRef.WornHasKeyword(Mods.DD_LegCuffs) || PlayerRef.WornHasKeyword(Mods.DD_Boots)
		BondagePoints += 2
	EndIf
	
	If PlayerRef.WornHasKeyword(Mods.DD_Blindfold)
		BondagePoints += 1
	EndIf
	
	If PlayerRef.WornHasKeyword(Mods.DD_Gag) || PlayerRef.WornHasKeyword(Mods.DD_GagPanel) 
		BondagePoints += 1
	EndIf
	
	If PlayerRef.WornHasKeyword(Mods.DD_Hood)
		BondagePoints += 1
	EndIf
	
	If IsVisiblyBound.GetValue() == 1
		If IsHeavilyBound.GetValue() == 1 || BondagePoints > 8
			return True
		ElseIf IsLightlyBound.GetValue() == 1
			If BondagePoints == 1 && BondageFame < 15
				return True
			ElseIf BondagePoints == 2 && BondageFame < 30
				return True
			ElseIf BondagePoints == 3 && BondageFame < 45
				return True
			ElseIf BondagePoints == 4 && BondageFame < 60
				return True
			ElseIf BondagePoints == 5 && BondageFame < 75
				return True
			ElseIf BondagePoints == 6 && BondageFame < 90
				return True
			ElseIf BondagePoints == 7 && BondageFame < 105
				return True
			ElseIf BondagePoints == 8 && BondageFame < 120
				return True
			EndIf
		EndIf
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
		
		If TotalTattoos > 10 || BodyTattoos > 5
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
	If Mods.IsFHUInstalled == True && Mods.GetFHUInflation(PlayerRef) >= Config.CumDumpFHUReq
		return True
	EndIf
	return False
EndFunction

Bool Function CheckTattooExtraFame(String ExtraFame)
	Int TattooSlot = 0
	While TattooSlot < Config.BodyTattooSlots
		If VisibilityManager.IsBodyTattooVisible(TattooSlot) == True && VisibilityManager.BodyTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		TattooSlot += 1
	EndWhile
		
	TattooSlot = 0
	While TattooSlot < Config.FaceTattooSlots
		If VisibilityManager.IsFaceTattooVisible(TattooSlot) == True && VisibilityManager.FaceTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		TattooSlot += 1
	EndWhile
	
	TattooSlot = 0
	While TattooSlot < Config.HandTattooSlots
		If VisibilityManager.IsHandTattooVisible(TattooSlot) == True && VisibilityManager.HandTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		TattooSlot += 1
	EndWhile
	
	TattooSlot = 0
	While TattooSlot < Config.FootTattooSlots
		If VisibilityManager.IsFootTattooVisible(TattooSlot) == True && VisibilityManager.FootTattooExtraFameType[TattooSlot] == ExtraFame
			return True
		EndIf
		TattooSlot += 1
	EndWhile
	return False
EndFunction

Function FameGainRoll(String FameLocation, Bool CalledExternally = False, Bool FameFromFriend = False, Bool FameFromLover = False)
	If LocationManager.IsLocationValid(FameLocation) == False
		If Config.EnableTracing == True
			If CalledExternally == True
				Debug.Trace("SLSF Reloaded - External FameGainRoll - Location is Invalid")
			Else
				Debug.Trace("SLSF Reloaded - FameGainRoll Function - Location is Invalid")
			EndIf
		EndIf
		return
	EndIf
	
	If VisibilityManager.IsPlayerAnonymous() == True
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - FameGainRoll Function - Player is Anonymous")
		EndIf
		return
	EndIf
	
	Int FriendLoverBetrayRoll = Utility.RandomInt(1, 100)
	Int BetrayRollModifier = 0
	
	Int PossibleFameCount = 0
	String[] PossibleFameGain = New String[25]
	
	CheckExternalFlags()
	
	If CanGainWhoreFame() == True || CheckTattooExtraFame("Whore") == True || ExternalWhoreFlag == True
		Int WhoreFame = Data.GetFameValue(FameLocation, "Whore")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && WhoreFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = WhoreFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && WhoreFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = WhoreFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[0] == False) || (FameFromLover == True && Config.FameForbiddenByLover[0] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[0] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[0] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
		
			PossibleFameGain[PossibleFameCount] = "Whore"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainSlutFame(FameLocation) == True || CheckTattooExtraFame("Slut") == True || ExternalSlutFlag == True
		Int SlutFame = Data.GetFameValue(FameLocation, "Slut")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && SlutFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = SlutFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && SlutFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = SlutFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[1] == False) || (FameFromLover == True && Config.FameForbiddenByLover[1] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[1] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[1] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Slut"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainExhibitionistFame(FameLocation) == True || CheckTattooExtraFame("Exhibitionist") == True || ExternalExhibitionistFlag == True
		Int ExhibitionistFame = Data.GetFameValue(FameLocation, "Exhibitionist")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && ExhibitionistFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = ExhibitionistFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && ExhibitionistFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = ExhibitionistFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[2] == False) || (FameFromLover == True && Config.FameForbiddenByLover[2] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[2] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[2] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Exhibitionist"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainOralFame(FameLocation) == True || CheckTattooExtraFame("Oral") == True || ExternalOralFlag == True
		Int OralFame = Data.GetFameValue(FameLocation, "Oral")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && OralFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = OralFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && OralFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = OralFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[3] == False) || (FameFromLover == True && Config.FameForbiddenByLover[3] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[3] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[3] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Oral"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainAnalFame(FameLocation) == True || CheckTattooExtraFame("Anal") == True || ExternalAnalFlag == True
		Int AnalFame = Data.GetFameValue(FameLocation, "Anal")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && AnalFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = AnalFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && AnalFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = AnalFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[4] == False) || (FameFromLover == True && Config.FameForbiddenByLover[4] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[4] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[4] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Anal"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainNastyFame(FameLocation) == True || CheckTattooExtraFame("Nasty") == True || ExternalNastyFlag == True
		Int NastyFame = Data.GetFameValue(FameLocation, "Nasty")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && NastyFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = NastyFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && NastyFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = NastyFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[5] == False) || (FameFromLover == True && Config.FameForbiddenByLover[5] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[5] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[5] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Nasty"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainPregnantFame(FameLocation) == True || CheckTattooExtraFame("Pregnant") == True || ExternalPregnantFlag == True
		Int PregnantFame = Data.GetFameValue(FameLocation, "Pregnant")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && PregnantFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = PregnantFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && PregnantFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = PregnantFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[6] == False) || (FameFromLover == True && Config.FameForbiddenByLover[6] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[6] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[6] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Pregnant"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Dominant") == True || ExternalDominantFlag == True
		Int DominantFame = Data.GetFameValue(FameLocation, "Dominant")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && DominantFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = DominantFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && DominantFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = DominantFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[7] == False) || (FameFromLover == True && Config.FameForbiddenByLover[7] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[7] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[7] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Dominant"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Submissive") == True || ExternalSubmissiveFlag == True
		Int SubmissiveFame = Data.GetFameValue(FameLocation, "Submissive")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && SubmissiveFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = SubmissiveFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && SubmissiveFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = SubmissiveFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[8] == False) || (FameFromLover == True && Config.FameForbiddenByLover[8] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[8] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[8] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Submissive"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Sadist") == True || ExternalSadistFlag == True
		Int SadistFame = Data.GetFameValue(FameLocation, "Sadist")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && SadistFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = SadistFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && SadistFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = SadistFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[9] == False) || (FameFromLover == True && Config.FameForbiddenByLover[9] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[9] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[9] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Sadist"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Masochist") == True || ExternalMasochistFlag == True
		Int MasochistFame = Data.GetFameValue(FameLocation, "Masochist")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && MasochistFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = MasochistFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && MasochistFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = MasochistFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[10] == False) || (FameFromLover == True && Config.FameForbiddenByLover[10] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[10] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[10] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Masochist"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Gentle") == True || ExternalGentleFlag == True
		Int GentleFame = Data.GetFameValue(FameLocation, "Gentle")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && GentleFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = GentleFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && GentleFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = GentleFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[11] == False) || (FameFromLover == True && Config.FameForbiddenByLover[11] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[11] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[11] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Gentle"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Likes Men") == True || ExternalLikesMenFlag == True
		Int LikesMenFame = Data.GetFameValue(FameLocation, "Likes Men")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && LikesMenFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = LikesMenFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && LikesMenFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = LikesMenFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[12] == False) || (FameFromLover == True && Config.FameForbiddenByLover[12] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[12] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[12] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Likes Men"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Likes Women") == True || ExternalLikesWomenFlag == True
		Int LikesWomenFame = Data.GetFameValue(FameLocation, "Likes Women")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && LikesWomenFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = LikesWomenFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && LikesWomenFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = LikesWomenFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[13] == False) || (FameFromLover == True && Config.FameForbiddenByLover[13] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[13] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[13] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
		
			PossibleFameGain[PossibleFameCount] = "Likes Women"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Likes Orc") == True || ExternalLikesOrcFlag == True
		Int LikesOrcFame = Data.GetFameValue(FameLocation, "Likes Orc")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && LikesOrcFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = LikesOrcFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && LikesOrcFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = LikesOrcFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[14] == False) || (FameFromLover == True && Config.FameForbiddenByLover[14] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[14] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[14] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Likes Orc"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Likes Khajiit") == True || ExternalLikesKhajiitFlag == True
		Int LikesKhajiitFame = Data.GetFameValue(FameLocation, "Likes Khajiit")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && LikesKhajiitFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = LikesKhajiitFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && LikesKhajiitFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = LikesKhajiitFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[15] == False) || (FameFromLover == True && Config.FameForbiddenByLover[15] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[15] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[15] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Likes Khajiit"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Likes Argonian") == True || ExternalLikesArgonianFlag == True
		Int LikesArgonianFame = Data.GetFameValue(FameLocation, "Likes Argonian")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && LikesArgonianFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = LikesArgonianFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && LikesArgonianFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = LikesArgonianFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[16] == False) || (FameFromLover == True && Config.FameForbiddenByLover[16] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[16] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[16] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Likes Argonian"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Bestiality") == True || ExternalBestialityFlag == True
		Int BestialityFame = Data.GetFameValue(FameLocation, "Bestiality")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && BestialityFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = BestialityFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && BestialityFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = BestialityFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[17] == False) || (FameFromLover == True && Config.FameForbiddenByLover[17] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[17] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[17] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Bestiality"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CheckTattooExtraFame("Group") == True || ExternalGroupFlag == True
		Int GroupFame = Data.GetFameValue(FameLocation, "Group")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && GroupFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = GroupFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && GroupFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = GroupFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[18] == False) || (FameFromLover == True && Config.FameForbiddenByLover[18] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[18] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[18] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Group"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainBoundFame(FameLocation) == True || CheckTattooExtraFame("Bound") == True || ExternalBoundFlag == True
		Int BoundFame = Data.GetFameValue(FameLocation, "Bound")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && BoundFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = BoundFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && BoundFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = BoundFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[19] == False) || (FameFromLover == True && Config.FameForbiddenByLover[19] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[19] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[19] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Bound"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainTattooFame(FameLocation) == True || ExternalTattooFlag == True
		Int TattooFame = Data.GetFameValue(FameLocation, "Tattoo")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && TattooFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = TattooFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && TattooFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = TattooFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[20] == False) || (FameFromLover == True && Config.FameForbiddenByLover[20] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[20] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[20] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Tattoo"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If CanGainCumDumpFame() == True || CheckTattooExtraFame("Cum Dump") == True || ExternalCumDumpFlag == True
		Int CumDumpFame = Data.GetFameValue(FameLocation, "Cum Dump")
		If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && CumDumpFame >= Config.FriendHighFameThreshold
			BetrayRollModifier = CumDumpFame / 2
		ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && CumDumpFame >= Config.LoverHighFameThreshold
			BetrayRollModifier = CumDumpFame / 4
		EndIf
		
		If (FameFromFriend == True && Config.FameForbiddenByFriend[21] == False) || (FameFromLover == True && Config.FameForbiddenByLover[21] == False) \
		|| ((FameFromFriend == True && Config.FameForbiddenByFriend[21] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
		|| ((FameFromLover == True && Config.FameForbiddenByLover[21] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
		|| (FameFromFriend == False && FameFromLover == False)
			
			PossibleFameGain[PossibleFameCount] = "Cum Dump"
			PossibleFameCount += 1
		EndIf
	EndIf
	
	If Mods.IsFameCommentsInstalled == True
		If CheckTattooExtraFame("Unfaithful") == True || ExternalUnfaithfulFlag == True
			Int UnfaithfulFame = Data.GetFameValue(FameLocation, "Unfaithful")
			If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && UnfaithfulFame >= Config.FriendHighFameThreshold
				BetrayRollModifier = UnfaithfulFame / 2
			ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && UnfaithfulFame >= Config.LoverHighFameThreshold
				BetrayRollModifier = UnfaithfulFame / 4
			EndIf
			
			If (FameFromFriend == True && Config.FameForbiddenByFriend[22] == False) || (FameFromLover == True && Config.FameForbiddenByLover[22] == False) \
			|| ((FameFromFriend == True && Config.FameForbiddenByFriend[22] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
			|| ((FameFromLover == True && Config.FameForbiddenByLover[22] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
			|| (FameFromFriend == False && FameFromLover == False)
				
				PossibleFameGain[PossibleFameCount] = "Unfaithful"
				PossibleFameCount += 1
			EndIf
		EndIf
		
		If CheckTattooExtraFame("Cuck") == True || ExternalCuckFlag == True
			Int CuckFame = Data.GetFameValue(FameLocation, "Cuck")
			If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && CuckFame >= Config.FriendHighFameThreshold
				BetrayRollModifier = CuckFame / 2
			ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && CuckFame >= Config.LoverHighFameThreshold
				BetrayRollModifier = CuckFame / 4
			EndIf
			
			If (FameFromFriend == True && Config.FameForbiddenByFriend[23] == False) || (FameFromLover == True && Config.FameForbiddenByLover[23] == False) \
			|| ((FameFromFriend == True && Config.FameForbiddenByFriend[23] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
			|| ((FameFromLover == True && Config.FameForbiddenByLover[23] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
			|| (FameFromFriend == False && FameFromLover == False)
				
				PossibleFameGain[PossibleFameCount] = "Cuck"
				PossibleFameCount += 1
			EndIf
		EndIf
	EndIf
	
	If Mods.IsBimbosInstalled == True
		If CheckTattooExtraFame("Airhead") == True || ExternalAirheadFlag == True
			Int AirheadFame = Data.GetFameValue(FameLocation, "Airhead")
			If FameFromFriend == True && Config.FriendsBetrayFromHighFame == True && AirheadFame >= Config.FriendHighFameThreshold
				BetrayRollModifier = AirheadFame / 2
			ElseIf FameFromLover == True && Config.LoversBetrayFromHighFame == True && AirheadFame >= Config.LoverHighFameThreshold
				BetrayRollModifier = AirheadFame / 4
			EndIf
			
			If (FameFromFriend == True && Config.FameForbiddenByFriend[24] == False) || (FameFromLover == True && Config.FameForbiddenByLover[24] == False) \
			|| ((FameFromFriend == True && Config.FameForbiddenByFriend[24] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.FriendBetrayChance) \
			|| ((FameFromLover == True && Config.FameForbiddenByLover[24] == True) && (FriendLoverBetrayRoll - BetrayRollModifier) <= Config.LoverBetrayChance) \
			|| (FameFromFriend == False && FameFromLover == False)
				
				PossibleFameGain[PossibleFameCount] = "Airhead"
				PossibleFameCount += 1
			EndIf
		EndIf
	EndIf
	
	If PossibleFameCount == 0
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - FameGainRoll Function - PossibleFameCount is Zero")
		EndIf
		return ;If none of the above categories are possible, end function
	EndIf

	Int GainedFameCount = 0
	If PossibleFameCount > 1
		GainedFameCount = Utility.RandomInt(1, PossibleFameCount) ;Randomly Determine how many fame categories are increased
	Else
		GainFame(PossibleFameGain[0], FameLocation, False) ;If there is only one fame category to gain, apply it and end function
		return
	EndIf
	
	;Apply Fame Step
	Int AppliedFameCount = 0
	If GainedFameCount == PossibleFameCount ;If we gain fame in every possible category, send all increases
		While AppliedFameCount < GainedFameCount
			GainFame(PossibleFameGain[AppliedFameCount], FameLocation, False)
			AppliedFameCount += 1
		EndWhile
		return ;end function after applying all fame
	EndIf
	
	String[] RolledCategory = New String[25] ;Store which fame categories we roll in another array and check against them to prevent duplicate increases
	Int CategoryRoll = 0
	Int TimesRolled = 0
	Bool FirstRoll = True
	Bool DuplicateFameRolls = False
	
	While AppliedFameCount < GainedFameCount && TimesRolled < 50 ;AppliedFameCount becomes our Index for the RolledCategory array. Sanity check of 50 maximum attempts to prevent script lag
		CategoryRoll = Utility.RandomInt(0, (PossibleFameCount - 1)) ;We've already determined that PossibleFameCount is higher than 1, so the maximum will be at least 1. CategoryRoll becomes our PossibleFameGain Index
		TimesRolled += 1
		
		String CurrentlyRolledCategory = PossibleFameGain[CategoryRoll]
		
		If AppliedFameCount > 0
			FirstRoll = False
		EndIf
		
		If FirstRoll == False
			Int DuplicateIndex = RolledCategory.Find(CurrentlyRolledCategory)
			
			If DuplicateIndex >= 0
				DuplicateFameRolls = True
			EndIf
		EndIf
		
		If DuplicateFameRolls == False
			;If there are no duplicates, store and apply our rolled fame.
			RolledCategory[AppliedFameCount] = CurrentlyRolledCategory
			GainFame(RolledCategory[AppliedFameCount], FameLocation, False)
			AppliedFameCount += 1
		Else
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
	
	Int GainVeryHigh = Config.MaxVHighFameGain
	Int GainHigh = Config.MaxHighFameGain
	Int GainMedium = Config.MaxMedFameGain
	Int GainLow = Config.MaxLowFameGain
	Int GainVeryLow = Config.MaxVLowFameGain
	
	If Config.UseGlobalFameMultiplier == False
		Int TypeIndex = FameType.Find(Category)
		FameMultiplier = Config.FameCategoryMultiplier[TypeIndex]
	EndIf
	
	Float Hour = (Utility.GetCurrentGameTime() - Math.Floor(Utility.GetCurrentGameTime())) * 24
	
	If ((Hour > Config.NightStart || Hour < Config.NightEnd) && Config.ReduceFameAtNight == True) || IsForeplay == True
		FameMultiplier = FameMultiplier / 2 ;Half Fame Gains at night or if it is from a Foreplay Event
	EndIf
	
	Int PreviousFame = Data.GetFameValue(LocationName, Category)
	
	If PreviousFame >= 100
		FameGained = ((Utility.RandomInt(1,GainVeryHigh) * FameMultiplier) as Int) * GainIterationMultiplier
	ElseIf PreviousFame >= 75
		FameGained = ((Utility.RandomInt(1,GainHigh) * FameMultiplier) as Int) * GainIterationMultiplier
	ElseIf PreviousFame >= 50
		FameGained = ((Utility.RandomInt(1,GainMedium) * FameMultiplier) as Int) * GainIterationMultiplier
	ElseIf PreviousFame >= 25
		FameGained = ((Utility.RandomInt(1,GainLow) * FameMultiplier) as Int) * GainIterationMultiplier
	Else
		FameGained = ((Utility.RandomInt(1,GainVeryLow) * FameMultiplier) as Int) * GainIterationMultiplier
	EndIf
	
	If FameGained < 1
		FameGained = 1
	EndIf
	
	Int NewFame = PreviousFame + FameGained
	
	If NewFame > 150
		NewFame = 150
	EndIf
	
	Data.SetFameValue(LocationName, Category, NewFame)
	
	Int LocationIndex = LocationManager.DefaultLocation.Find(LocationName)
	
	If LocationIndex < 0
		;Couldn't find Location Index from Default locations, so try Custom Locations
		LocationIndex = LocationManager.CustomLocation.Find(LocationName)
		
		If LocationIndex < 0
			;Still could not find Location Index. Location must not exist.
			Debug.MessageBox("SLSF Reloaded - ERROR: Could not find " + LocationName + " in Default or Custom Location lists!")
			Debug.Trace("SLSF Reloaded - ERROR: Could not find " + LocationName + " in Default or Custom Location lists!")
			return
		Else
			CustomLocationCanDecay[LocationIndex] = False
			CustomLocationDecayPauseTimer[LocationIndex] = (Config.DecayTimeNeeded) as Int
		EndIf
	Else
		DefaultLocationCanDecay[LocationIndex] = False
		DefaultLocationDecayPauseTimer[LocationIndex] = (Config.DecayTimeNeeded) as Int
	EndIf
	
	If Config.NotifyFameIncrease == True && FameGainNotifyCooldown == False
		FameGainNotification()
	EndIf
	
	If Config.AllowLegacyOverwrite == True
		LegacyOverwrite.OverwriteLegacyFame()
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
	
	Int DecayVeryHigh = 0 - Config.MaxVHighFameDecay
	Int DecayHigh = 0 - Config.MaxHighFameDecay
	Int DecayMedium = 0 - Config.MaxMedFameDecay
	Int DecayLow = 0 - Config.MaxLowFameDecay
	Int DecayVeryLow = 0 - Config.MaxVLowFameDecay
	
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationCanDecay[LocationIndex] == True && Config.HasFameAtDefaultLocation[LocationIndex] == True
			While TypeIndex < FameType.Length
				PreviousFame = Data.GetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex])
				
				If Config.UseGlobalFameMultiplier == False
					FameMultiplier = Config.FameCategoryMultiplier[TypeIndex]
				EndIf
				
				If PreviousFame > 0
					If PreviousFame >= 100
						FameDecay = ((Utility.RandomInt(DecayVeryHigh,-1)* FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 75
						FameDecay = ((Utility.RandomInt(DecayHigh,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 50
						FameDecay = ((Utility.RandomInt(DecayMedium,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 25
						FameDecay = ((Utility.RandomInt(DecayLow,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.DefaultLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					Else
						FameDecay = ((Utility.RandomInt(DecayVeryLow,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
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
		Data.DecayDynamicAnonymityCheck(LocationIndex, True)
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	TypeIndex = 0
	LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	While LocationIndex < CustomLocations
		If CustomLocationCanDecay[LocationIndex] == True && Config.HasFameAtCustomLocation[LocationIndex] == True
			While TypeIndex < FameType.Length
				PreviousFame = Data.GetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex])
				
				If Config.UseGlobalFameMultiplier == False
					FameMultiplier = Config.FameCategoryMultiplier[TypeIndex]
				EndIf
				
				If PreviousFame > 0
					If PreviousFame >= 100
						FameDecay = ((-1 * FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 75
						FameDecay = ((Utility.RandomInt(-2,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 50
						FameDecay = ((Utility.RandomInt(-3,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					ElseIf PreviousFame >= 25
						FameDecay = ((Utility.RandomInt(-4,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
						If FameDecay > -1
							FameDecay = -1
						EndIf
						NewFame = PreviousFame + FameDecay
						Data.SetFameValue(LocationManager.CustomLocation[LocationIndex], FameType[TypeIndex], NewFame)
						DecayNotificationMakesSense = True
					Else
						FameDecay = ((Utility.RandomInt(-5,-1) * FameMultiplier) as Int) * DecayIterationMultiplier
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
		Data.DecayDynamicAnonymityCheck(LocationIndex, False)
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	If Config.NotifyFameDecay == True && DecayNotificationMakesSense == True
		FameDecayNotification()
	EndIf
	
	If Config.AllowLegacyOverwrite == True
		LegacyOverwrite.OverwriteLegacyFame()
	EndIf
EndFunction

Function SpreadFameRoll()
	Int FameSpreadRoll = 0
	Int SpreadChance = 0
	Int LocationIndex = 0
	
	While LocationIndex < LocationManager.DefaultLocation.Length
		If Data.DefaultLocationHasSpreadableFame[LocationIndex] == True
			SpreadChance = Config.DefaultLocationSpreadChance[LocationIndex]
			If SpreadChance == 0
				Config.DefaultLocationSpreadChance[LocationIndex] = (Config.DefaultLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease) as Int
			ElseIf SpreadChance == 100
				SpreadFame(LocationManager.DefaultLocation[LocationIndex])
				Config.DefaultLocationSpreadChance[LocationIndex] = (Config.DefaultLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction) as Int
			ElseIf SpreadChance > 100 || SpreadChance < 0
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded: WARNING - Fame Spread Chance for " + LocationManager.DefaultLocation[LocationIndex] + " is outside valid range (0-100). It will be reset to 30.")
				EndIf
				Config.DefaultLocationSpreadChance[LocationIndex] = 30
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
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	While LocationIndex < CustomLocations
		If Data.CustomLocationHasSpreadableFame[LocationIndex] == True
			SpreadChance = Config.CustomLocationSpreadChance[LocationIndex]
			If SpreadChance == 0
				Config.CustomLocationSpreadChance[LocationIndex] = (Config.CustomLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease) as Int
			ElseIf SpreadChance == 100
				SpreadFame(LocationManager.CustomLocation[LocationIndex])
				Config.CustomLocationSpreadChance[LocationIndex] = (Config.CustomLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction) as Int
			ElseIf SpreadChance > 100 || SpreadChance < 0
				Debug.Trace("SLSF Reloaded: WARNING - Fame Spread Chance for " + LocationManager.CustomLocation[LocationIndex] + " is outside valid range (0-100). It will be reset to 30.")
				Config.CustomLocationSpreadChance[LocationIndex] = 30
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
		LocationIndex += 1
	EndWhile
EndFunction

Function SpreadFame(String SpreadFromLocation)
	If Config.EnableTracing == True
		Debug.Trace("Fame Spread From: " + SpreadFromLocation)
	EndIf
	
	;Grab all fame values above the configured threshold from the source Location. If none exist, cancel fame spread operation
	Int SpreadableFame = 0
	Int PossibleFameSpreadCategories = 0
	Int PossibleFameSpreadIndex = 0
	String[] PossibleCategoryList = New String[25]
	
	;Count possible categories & fill array
	While PossibleFameSpreadIndex < FameType.Length
		SpreadableFame = Data.GetFameValue(SpreadFromLocation, FameType[PossibleFameSpreadIndex])
		
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Checking " + FameType[PossibleFameSpreadIndex] + " Fame. Fame Value is: " + SpreadableFame)
			Debug.Trace("SLSF Reloaded - Fame value requirement is: " + Config.MinimumFameToSpread)
		EndIf
		
		If SpreadableFame >= Config.MinimumFameToSpread
			PossibleFameSpreadCategories += 1
			PossibleCategoryList[(PossibleFameSpreadCategories - 1)] = FameType[PossibleFameSpreadIndex]
			
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Possible Spread Category: " + PossibleCategoryList[(PossibleFameSpreadCategories - 1)] + " added to list.")
			EndIf
		EndIf
		PossibleFameSpreadIndex += 1
	EndWhile
	
	If PossibleFameSpreadCategories == 0
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - No Spreadable Categories found for " + SpreadFromLocation + ". Fame Spread Skipped.")
		EndIf
		return
	EndIf
	
	;Get possible fame spread targets
	Int DefaultLocations = LocationManager.DefaultLocation.Length
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	Int TotalLocations = 0
	
	String[] PossibleSpreadTargets = New String[42] ;21 default + 21 custom locations
	
	;Fill array with possible targets
	Int PossibleLocationIndex = 0
	Int DefaultLocationIndex = 0
	Int CustomLocationIndex = 0
	Int FillIndex = 0
	
	Int TargetLocationIndex = 0
	Bool TargetLocationValid = False
	Bool SpreadingFromUndefinedLocation = False
	
	If Config.FameSpreadRestrictions == True
	
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Fame Spread Restrictions Enabled")
		EndIf
		
		If SpreadFromLocation == "Whiterun"
			
			PossibleSpreadTargets[0] = "Dawnstar"
			PossibleSpreadTargets[1] = "Windhelm"
			PossibleSpreadTargets[2] = "Riverwood"
			PossibleSpreadTargets[3] = "Rorikstead"
			PossibleSpreadTargets[4] = "Ivarstead"
			PossibleSpreadTargets[5] = "Falkreath"
			
			PossibleLocationIndex = 6
			
			While FillIndex < LocationManager.WhiterunLocationList.Length
				If LocationManager.WhiterunLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.WhiterunLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Winterhold"
			PossibleSpreadTargets[0] = "Dawnstar"
			PossibleSpreadTargets[1] = "Windhelm"
			
			PossibleLocationIndex = 2
			
			While FillIndex < LocationManager.WinterholdLocationList.Length
				If LocationManager.WinterholdLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.WinterholdLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Windhelm"
			PossibleSpreadTargets[0] = "Whiterun"
			PossibleSpreadTargets[1] = "Winterhold"
			PossibleSpreadTargets[2] = "Shor's Stone"
			PossibleSpreadTargets[3] = "Narzulbur"
			PossibleSpreadTargets[4] = "Raven Rock"
			
			PossibleLocationIndex = 5
			
			While FillIndex < LocationManager.EastmarchLocationList.Length
				If LocationManager.EastmarchLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.EastmarchLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Solitude"
			PossibleSpreadTargets[0] = "Dragon Bridge"
			PossibleSpreadTargets[1] = "Morthal"
			PossibleSpreadTargets[2] = "Dawnstar"
			
			PossibleLocationIndex = 3
			
			While FillIndex < LocationManager.HaafingarLocationList.Length
				If LocationManager.HaafingarLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.HaafingarLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Riften"
			PossibleSpreadTargets[0] = "Shor's Stone"
			PossibleSpreadTargets[1] = "Ivarstead"
			PossibleSpreadTargets[2] = "Largashbur"
			
			PossibleLocationIndex = 3
			
			While FillIndex < LocationManager.RiftLocationList.Length
				If LocationManager.RiftLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.RiftLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Markarth"
			PossibleSpreadTargets[0] = "Karthwasten"
			PossibleSpreadTargets[1] = "Rorikstead"
			PossibleSpreadTargets[2] = "Dushnikh Yal"
			PossibleSpreadTargets[3] = "Falkreath"
			
			PossibleLocationIndex = 4
			
			While FillIndex < LocationManager.ReachLocationList.Length
				If LocationManager.ReachLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.ReachLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Morthal"
			PossibleSpreadTargets[0] = "Dawnstar"
			PossibleSpreadTargets[1] = "Solitude"
			PossibleSpreadTargets[2] = "Dragon Bridge"
			PossibleSpreadTargets[3] = "Rorikstead"
			
			PossibleLocationIndex = 4
			
			While FillIndex < LocationManager.HjaalmarchLocationList.Length
				If LocationManager.HjaalmarchLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.HjaalmarchLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Dawnstar"
			PossibleSpreadTargets[0] = "Morthal"
			PossibleSpreadTargets[1] = "Solitude"
			PossibleSpreadTargets[2] = "Winterhold"
			PossibleSpreadTargets[3] = "Whiterun"
			
			PossibleLocationIndex = 4
			
			While FillIndex < LocationManager.PaleLocationList.Length
				If LocationManager.PaleLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.PaleLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Falkreath"
			PossibleSpreadTargets[0] = "Whiterun"
			PossibleSpreadTargets[1] = "Riverwood"
			PossibleSpreadTargets[2] = "Ivarstead"
			PossibleSpreadTargets[3] = "Rorikstead"
			PossibleSpreadTargets[4] = "Markarth"
			
			PossibleLocationIndex = 5
			
			While FillIndex < LocationManager.FalkreathLocationList.Length
				If LocationManager.FalkreathLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.FalkreathLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Raven Rock"
			PossibleSpreadTargets[0] = "Windhelm"
			PossibleSpreadTargets[1] = "Skaal Village"
			
			PossibleLocationIndex = 2
			
			While FillIndex < LocationManager.SolstheimLocationList.Length
				If LocationManager.SolstheimLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.SolstheimLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Riverwood"
			PossibleSpreadTargets[0] = "Whiterun"
			PossibleSpreadTargets[1] = "Falkreath"
			PossibleSpreadTargets[2] = "Rorikstead"
			PossibleSpreadTargets[3] = "Ivarstead"
			
			PossibleLocationIndex = 4
			
			While FillIndex < LocationManager.WhiterunLocationList.Length
				If LocationManager.WhiterunLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.WhiterunLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Rorikstead"
			PossibleSpreadTargets[0] = "Whiterun"
			PossibleSpreadTargets[1] = "Riverwood"
			PossibleSpreadTargets[2] = "Falkreath"
			PossibleSpreadTargets[3] = "Dushnikh Yal"
			PossibleSpreadTargets[4] = "Markarth"
			PossibleSpreadTargets[5] = "Karthwasten"
			PossibleSpreadTargets[6] = "Dragon Bridge"
			PossibleSpreadTargets[7] = "Morthal"
			
			PossibleLocationIndex = 8
			
			While FillIndex < LocationManager.WhiterunLocationList.Length
				If LocationManager.WhiterunLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.WhiterunLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Ivarstead"
			PossibleSpreadTargets[0] = "Riften"
			PossibleSpreadTargets[1] = "Shor's Stone"
			PossibleSpreadTargets[2] = "Whiterun"
			PossibleSpreadTargets[3] = "Riverwood"
			PossibleSpreadTargets[4] = "Falkreath"
			PossibleSpreadTargets[5] = "Largashbur"
			
			PossibleLocationIndex = 6
			
			While FillIndex < LocationManager.RiftLocationList.Length
				If LocationManager.RiftLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.RiftLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Shor's Stone"
			PossibleSpreadTargets[0] = "Riften"
			PossibleSpreadTargets[1] = "Ivarstead"
			PossibleSpreadTargets[2] = "Windhelm"
			PossibleSpreadTargets[3] = "Narzulbur"
			
			PossibleLocationIndex = 4
			
			While FillIndex < LocationManager.RiftLocationList.Length
				If LocationManager.RiftLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.RiftLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Dragon Bridge"
			PossibleSpreadTargets[0] = "Solitude"
			PossibleSpreadTargets[1] = "Morthal"
			PossibleSpreadTargets[2] = "Karthwasten"
			PossibleSpreadTargets[3] = "Rorikstead"
			PossibleSpreadTargets[4] = "Mor Khazgur"
			
			PossibleLocationIndex = 5
			
			While FillIndex < LocationManager.HaafingarLocationList.Length
				If LocationManager.HaafingarLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.HaafingarLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Karthwasten"
			PossibleSpreadTargets[0] = "Markarth"
			PossibleSpreadTargets[1] = "Dragon Bridge"
			PossibleSpreadTargets[2] = "Rorikstead"
			PossibleSpreadTargets[3] = "Mor Khazgur"
			
			PossibleLocationIndex = 4
			
			While FillIndex < LocationManager.ReachLocationList.Length
				If LocationManager.ReachLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.ReachLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Skaal Village"
			PossibleSpreadTargets[0] = "Raven Rock"
			
			PossibleLocationIndex = 1
			
			While FillIndex < LocationManager.SolstheimLocationList.Length
				If LocationManager.SolstheimLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.SolstheimLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Largashbur"
			PossibleSpreadTargets[0] = "Riften"
			PossibleSpreadTargets[1] = "Ivarstead"
			
			PossibleLocationIndex = 2
			
			While FillIndex < LocationManager.RiftLocationList.Length
				If LocationManager.RiftLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.RiftLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Dushnikh Yal"
			PossibleSpreadTargets[0] = "Markarth"
			PossibleSpreadTargets[1] = "Rorikstead"
			
			PossibleLocationIndex = 2
			
			While FillIndex < LocationManager.ReachLocationList.Length
				If LocationManager.ReachLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.ReachLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Mor Khazgur"
			PossibleSpreadTargets[0] = "Dragon Bridge"
			PossibleSpreadTargets[1] = "Karthwasten"
			
			PossibleLocationIndex = 2
			
			While FillIndex < LocationManager.HaafingarLocationList.Length
				If LocationManager.HaafingarLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.HaafingarLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		ElseIf SpreadFromLocation == "Narzulbur"
			PossibleSpreadTargets[0] = "Windhelm"
			PossibleSpreadTargets[1] = "Shor's Stone"
			
			PossibleLocationIndex = 2
			
			While FillIndex < LocationManager.EastmarchLocationList.Length
				If LocationManager.EastmarchLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.EastmarchLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			FillIndex = 0
			While FillIndex < LocationManager.UndefinedLocationList.Length
				If LocationManager.UndefinedLocationList[FillIndex] != "---"
					PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
					PossibleLocationIndex += 1
				EndIf
				FillIndex += 1
			EndWhile
			
			TotalLocations = PossibleLocationIndex
		Else
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Spreading Fame From Custom Location")
			EndIf
			
			If LocationManager.WhiterunLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Whiterun"
				PossibleSpreadTargets[1] = "Rorikstead"
				PossibleSpreadTargets[2] = "Riverwood"
				
				PossibleLocationIndex = 3
				
				While FillIndex < LocationManager.WhiterunLocationList.Length
					If LocationManager.WhiterunLocationList[FillIndex] != "---" && LocationManager.WhiterunLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.WhiterunLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.WinterholdLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Winterhold"
				
				PossibleLocationIndex = 1
				
				While FillIndex < LocationManager.WinterholdLocationList.Length
					If LocationManager.WinterholdLocationList[FillIndex] != "---" && LocationManager.WinterholdLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.WinterholdLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.EastmarchLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Windhelm"
				PossibleSpreadTargets[1] = "Narzulbur"
				
				PossibleLocationIndex = 2
				
				While FillIndex < LocationManager.EastmarchLocationList.Length
					If LocationManager.EastmarchLocationList[FillIndex] != "---" && LocationManager.EastmarchLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.EastmarchLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.HaafingarLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Solitude"
				PossibleSpreadTargets[1] = "Dragon Bridge"
				PossibleSpreadTargets[2] = "Mor Khazgur"
				
				PossibleLocationIndex = 3
				
				While FillIndex < LocationManager.HaafingarLocationList.Length
					If LocationManager.HaafingarLocationList[FillIndex] != "---" && LocationManager.HaafingarLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.HaafingarLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.HjaalmarchLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Morthal"
				
				PossibleLocationIndex = 1
				
				While FillIndex < LocationManager.HjaalmarchLocationList.Length
					If LocationManager.HjaalmarchLocationList[FillIndex] != "---" && LocationManager.HjaalmarchLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.HjaalmarchLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.RiftLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Riften"
				PossibleSpreadTargets[1] = "Ivarstead"
				PossibleSpreadTargets[2] = "Shor's Stone"
				PossibleSpreadTargets[3] = "Largashbur"
				
				PossibleLocationIndex = 4
				
				While FillIndex < LocationManager.RiftLocationList.Length
					If LocationManager.RiftLocationList[FillIndex] != "---" && LocationManager.RiftLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.RiftLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.ReachLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Markarth"
				PossibleSpreadTargets[1] = "Karthwasten"
				PossibleSpreadTargets[2] = "Dushnikh Yal"
				
				PossibleLocationIndex = 3
				
				While FillIndex < LocationManager.ReachLocationList.Length
					If LocationManager.ReachLocationList[FillIndex] != "---" && LocationManager.ReachLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.ReachLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.PaleLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Dawnstar"
				
				PossibleLocationIndex = 1
				
				While FillIndex < LocationManager.PaleLocationList.Length
					If LocationManager.PaleLocationList[FillIndex] != "---" && LocationManager.PaleLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.PaleLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			ElseIf LocationManager.SolstheimLocationList.Find(SpreadFromLocation) >= 0
				PossibleSpreadTargets[0] = "Raven Rock"
				PossibleSpreadTargets[1] = "Skaal Village"
				
				PossibleLocationIndex = 2
				
				While FillIndex < LocationManager.SolstheimLocationList.Length
					If LocationManager.SolstheimLocationList[FillIndex] != "---" && LocationManager.SolstheimLocationList[FillIndex] != SpreadFromLocation
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.SolstheimLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				FillIndex = 0
				While FillIndex < LocationManager.UndefinedLocationList.Length
					If LocationManager.UndefinedLocationList[FillIndex] != "---"
						PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.UndefinedLocationList[FillIndex]
						PossibleLocationIndex += 1
					EndIf
					FillIndex += 1
				EndWhile
				
				TotalLocations = PossibleLocationIndex
			Else
				SpreadingFromUndefinedLocation = True
				
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - Custom Location is UNDEFINED. Falling back to default Fame Spread method")
				EndIf
			EndIf
		EndIf
	EndIf
	
	If Config.FameSpreadRestrictions == False || SpreadingFromUndefinedLocation == True
		TotalLocations = DefaultLocations + CustomLocations
		While PossibleLocationIndex < TotalLocations
			If DefaultLocationIndex < DefaultLocations
				PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.DefaultLocation[DefaultLocationIndex]
				DefaultLocationIndex += 1
			ElseIf CustomLocationIndex < CustomLocations
				PossibleSpreadTargets[PossibleLocationIndex] = LocationManager.CustomLocation[CustomLocationIndex]
				CustomLocationIndex += 1
			EndIf
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - PossibleSpreadTargets[" + PossibleLocationIndex + "]: " + PossibleSpreadTargets[PossibleLocationIndex])
			EndIf
			PossibleLocationIndex += 1
		EndWhile
	EndIf
	
	;Roll Target location index based on number of total locations
	While TargetLocationValid == False
		TargetLocationIndex = Utility.RandomInt(0, (TotalLocations - 1))
		
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Target Location Roll (Index): " + TargetLocationIndex)
			Debug.Trace("SLSF Reloaded - Target Location: " + PossibleSpreadTargets[TargetLocationIndex])
		EndIf
		
		If SpreadFromLocation != PossibleSpreadTargets[TargetLocationIndex] ;ensure we are not trying to spread to the original location
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Target Location Valid!")
			EndIf
			TargetLocationValid = True
		Else
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Target Location NOT Valid. Rolling again...")
			EndIf
		EndIf
	EndWhile
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Fame Spread Target: " + PossibleSpreadTargets[TargetLocationIndex])
	EndIf
	
	;When valid target is found, randomize how many fame categories are spread and by how much, based on config values.
	Int NumberOfCategoriesToSpread = 0
	;Float CategorySpreadPercentage = 0.0
	
	If Config.MaximumSpreadCategories > 1 && PossibleFameSpreadCategories > 1
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - More than 1 category can be spread.")
		EndIf
		
		If Config.MaximumSpreadCategories < PossibleFameSpreadCategories
			NumberOfCategoriesToSpread = Utility.RandomInt(1, (Config.MaximumSpreadCategories as Int))
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - More categories can be spread than allowed. Allowed: " + Config.MaximumSpreadCategories + ". Possible: " + PossibleFameSpreadCategories)
				Debug.Trace("SLSF Reloaded - Chose to spread " + NumberOfCategoriesToSpread + " categories.")
			EndIf
		Else
			NumberOfCategoriesToSpread = Utility.RandomInt(1, PossibleFameSpreadCategories)
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Fewer or equal categories can be spread than allowed. Allowed: " + Config.MaximumSpreadCategories + ". Possible: " + PossibleFameSpreadCategories)
				Debug.Trace("SLSF Reloaded - Chose to spread " + NumberOfCategoriesToSpread + " categories.")
			EndIf
		EndIf
	Else
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Only 1 category can be spread. Allowed: " + Config.MaximumSpreadCategories + ". Possible: " + PossibleFameSpreadCategories)
		EndIf
		NumberOfCategoriesToSpread = 1
	EndIf
	
	;Randomly pick which valid categories are spread
	Int TargetFameValue = 0
	Int FromFameValue = 0
	Int NewFame = 0
	Int SuccessfulFameSpreads = 0
	Int CategoryRoll = 0
	
	If PossibleFameSpreadCategories == 1
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Only 1 possible fame spread category: " + PossibleCategoryList[0])
		EndIf
		TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[0])
		
		FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleCategoryList[0])
		;Fame spread is in steps of 10%, which is why we divide the MaximumSpreadPercentage by 10 and then divide the RandomInt by 10 again to total the overall division by 100, which gives us a percentage
		
		NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
		
		If NewFame > 150
			NewFame = 150
		EndIf
		
		If Config.EnableTracing == True
			Debug.Trace("Set Fame: " + PossibleSpreadTargets[TargetLocationIndex] + ", " + PossibleCategoryList[CategoryRoll] + ", " + NewFame)
		EndIf
		Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[0], NewFame)
	ElseIf NumberOfCategoriesToSpread == 1
		CategoryRoll = Utility.RandomInt(0, (PossibleFameSpreadCategories - 1))
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Only chose to spread 1 category. Chose: " + PossibleCategoryList[CategoryRoll] + " from the possible list.")
		EndIf
		
		TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[CategoryRoll])
		
		FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleCategoryList[CategoryRoll])
		
		NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
		
		If NewFame > 150
			NewFame = 150
		EndIf
		
		If Config.EnableTracing == True
			Debug.Trace("Set Fame: " + PossibleSpreadTargets[TargetLocationIndex] + ", " + PossibleCategoryList[CategoryRoll] + ", " + NewFame)
		EndIf
		Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[CategoryRoll], NewFame)
	ElseIf NumberOfCategoriesToSpread == Config.MaximumSpreadCategories
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded - Chose to spread maximum possible categories. Maximum is: " + Config.MaximumSpreadCategories)
		EndIf
		
		Int TimesRolled = 0
		Bool FirstRoll = True
		Bool DuplicateFameRolls = False
		String[] RolledCategory = New String[10] ;Hard Maximum of 10 categories
		
		While (SuccessfulFameSpreads < NumberOfCategoriesToSpread) && (TimesRolled < 50)
			CategoryRoll = Utility.RandomInt(0, (PossibleFameSpreadCategories - 1))
			TimesRolled += 1
			
			String CurrentlyRolledCategory = PossibleCategoryList[CategoryRoll]
			
			If SuccessfulFameSpreads > 0
				FirstRoll = False
			EndIf
			
			If FirstRoll == False
				Int DuplicateIndex = RolledCategory.Find(CurrentlyRolledCategory)
			
				If DuplicateIndex >= 0
					DuplicateFameRolls = True
				EndIf
			EndIf
			
			If DuplicateFameRolls == False
				;If there are no duplicates, store and apply our rolled fame.
				RolledCategory[SuccessfulFameSpreads] = CurrentlyRolledCategory
				
				TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[CategoryRoll])
				
				FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleCategoryList[CategoryRoll])
				
				NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
				
				If NewFame > 150
					NewFame = 150
				EndIf
				
				If Config.EnableTracing == True
					Debug.Trace("Set Fame: " + PossibleSpreadTargets[TargetLocationIndex] + ", " + PossibleCategoryList[CategoryRoll] + ", " + NewFame)
				EndIf
				Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[CategoryRoll], NewFame)
				
				SuccessfulFameSpreads += 1
			Else
				DuplicateFameRolls = False
			EndIf
		EndWhile
	Else
		Int TimesRolled = 0
		Bool FirstRoll = True
		Bool DuplicateFameRolls = False
		String[] RolledCategory = New String[10] ;Hard Maximum of 10 categories
		
		While (SuccessfulFameSpreads < NumberOfCategoriesToSpread) && (TimesRolled < 50) ;Sanity check of 50 maximum attempts to prevent script lag
			CategoryRoll = Utility.RandomInt(0, (PossibleFameSpreadCategories - 1))
			TimesRolled += 1
			
			String CurrentlyRolledCategory = PossibleCategoryList[CategoryRoll]
			
			If SuccessfulFameSpreads > 0
				FirstRoll = False
			EndIf
			
			If FirstRoll == False
				Int DuplicateIndex = RolledCategory.Find(CurrentlyRolledCategory)
			
				If DuplicateIndex >= 0
					DuplicateFameRolls = True
				EndIf
			EndIf
			
			If DuplicateFameRolls == False
				;If there are no duplicates, store and apply our rolled fame.
				RolledCategory[SuccessfulFameSpreads] = CurrentlyRolledCategory
				
				TargetFameValue = Data.GetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[CategoryRoll])
				
				FromFameValue = Data.GetFameValue(SpreadFromLocation, PossibleCategoryList[CategoryRoll])
				
				NewFame = CalculateFameSpread(FromFameValue, TargetFameValue)
				
				If NewFame > 150
					NewFame = 150
				EndIf
				
				If Config.EnableTracing == True
					Debug.Trace("Set Fame: " + PossibleSpreadTargets[TargetLocationIndex] + ", " + PossibleCategoryList[CategoryRoll] + ", " + NewFame)
				EndIf
				Data.SetFameValue(PossibleSpreadTargets[TargetLocationIndex], PossibleCategoryList[CategoryRoll], NewFame)
				
				SuccessfulFameSpreads += 1
			Else
				DuplicateFameRolls = False
			EndIf
		EndWhile
	EndIf
	
	If Config.NotifyFameSpread == True
		FameSpreadNotification()
	EndIf
	
	If Config.AllowLegacyOverwrite == True
		LegacyOverwrite.OverwriteLegacyFame()
	EndIf
	
	;Update pause timers because we treat fame spreads as a "gain"
	DefaultLocationCanDecay[TargetLocationIndex] = False
	DefaultLocationDecayPauseTimer[TargetLocationIndex] = (Config.DecayTimeNeeded as Int)
EndFunction

Function FameGainNotification()
	Debug.Notification("$FameIncreaseMSG")
	FameGainNotifyCooldown = True
	Utility.WaitMenuMode(30.0)
	FameGainNotifyCooldown = False
EndFunction

Function FameDecayNotification()
	Debug.Notification("$FameDecayMSG")
EndFunction

Int Function CalculateFameSpread(Float FromFame, Float TargetFame) ;These must be floats for calculation purposes
	Int MaxRoll = (Config.MaximumSpreadPercentage as Int) / 10 ;Result should be 1, 2, 3, 4, or 5
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded Fame Spread Calculation - Max Roll is: " + MaxRoll)
	EndIf
	Int SpreadRoll = 1
	
	If MaxRoll > 1 ;If MaxRoll is 1, then roll doesn't matter
		SpreadRoll = Utility.RandomInt(1, MaxRoll)
	EndIf
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded Fame Spread Calculation - Spread Roll is: " + SpreadRoll)
	EndIf
	
	Float Percentage = ((SpreadRoll as Float) / 10) ;Result should be 0.1, 0.2, 0.3, 0.4, or 0.5 (10%, 20%, 30%, 40%, or 50%) based on roll. Must cast SpreadRoll as Float for calculation purposes
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded Fame Spread Calculation - Percentage is: " + Percentage)
	EndIf
	Float SpreadValue = (FromFame * Percentage) ;Result should be a percentage of fame from the spreading location. Minimum should be 1
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded Fame Spread Calculation - From Fame is: " + FromFame + ". Spread Value is: " + SpreadValue)
	EndIf
	Int FinalFame = (TargetFame + SpreadValue) as Int
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded Fame Spread Calculation - Target Fame is: " + TargetFame + ". Final Fame is: " + FinalFame)
	EndIf
	
	return FinalFame
EndFunction

Function FameSpreadNotification()
	Debug.Notification("$FameSpreadMSG")
EndFunction

Function ClearFame(String LocationToClear)
	Int TypeIndex = 0
	While TypeIndex < FameType.Length
		Data.SetFameValue(LocationToClear, FameType[TypeIndex], 0)
		TypeIndex += 1
	EndWhile
	Debug.Trace(LocationToClear + " fame has been cleared.")
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
	
	If Config.AllowLegacyOverwrite == True
		LegacyOverwrite.OverwriteLegacyFame()
	EndIf
	
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