ScriptName SLSF_Reloaded_FameManager extends Quest

Import JsonUtil

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_MCM Property Config Auto
SexlabFramework Property Sexlab Auto

Bool Property FamePaused Auto
Bool[] Property DefaultLocationCanSpread Auto 
Bool[] Property CustomLocationCanSpread Auto 
Bool[] Property DefaultLocationCanDecay Auto 
Bool[] Property CustomLocationCanDecay Auto 

String Property JsonFileString Auto Hidden
String[] Property FameType Auto
String[] Property PossibleFameArray Auto Hidden
String[] Property PossibleSpreadTargets Auto Hidden
String[] Property PossibleSpreadCategories Auto Hidden

Int[] Property DefaultLocationSpreadPauseTimer Auto
Int[] Property CustomLocationSpreadPauseTimer Auto
Int[] Property DefaultLocationDecayPauseTimer Auto 
Int[] Property CustomLocationDecayPauseTimer Auto 
Int Property DecayCountdown Auto 
Int Property SpreadCountdown Auto 

Armor[] Property ArmorSlots Auto Hidden

Keyword[] Property DD_Keywords Auto Hidden
Keyword Property SLSF_Reloaded_NipplePiercing Auto
Keyword Property SLSF_Reloaded_VaginalPiercing Auto

GlobalVariable Property SLSF_Reloaded_CustomLocationCount Auto

Actor Property PlayerRef Auto ;= PlayerScript.PlayerRef

;/
NOTE TO SELF - UTILIZE ARRAY 'FIND' FUNCTION TO FURTHER OPTIMIZE CODE?
/;

;/
---Originals---
[0] Whore
[1] Slut
[2] Exhibitionist

[3] Oral
[4] Anal
[5] Nasty
[6] Pregnant

[7] Dominant
[8] Submissive
[9] Sadist
[10] Masochist
[11] Gentle

[12] Likes Men
[13] Likes Women
[14] Likes Orc
[15] Likes Khajiit
[16] Likes Argonian
[17] Bestiality
[18] Group

---New---
[19] Bound
[20] Tattoo
[21] Cum Dump
/;

Event OnInit()
	Startup()
EndEvent

Function Startup()
	FamePaused = False
	
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation[LocationIndex]
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
EndFunction

Event OnUpdate()
	Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
	
	;Update 'global' timers
	DecayCountdown -= 1
	SpreadCountdown -= 1
	
	If DecayCountdown <= 0 ;Minor sanity check in case it somehow goes below 0.
		DecayFame()
		DecayCountdown = 24
	EndIf
	
	If SpreadCountdown <= 0
		SpreadFameRoll()
		SpreadCountdown = 48
	EndIf
	
	;Update Individual Decay Pause Timers
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationDecayPauseTimer[LocationIndex] > 0 && DefaultLocationCanDecay[LocationIndex] == False
			DefaultLocationDecayPauseTimer[LocationIndex] = DefaultLocationDecayPauseTimer[LocationIndex] - 1 ;Apparently arrays do not like operators (+=, -=, etc). Can only assign with "=" and math afterwards
		EndIf
		If DefaultLocationDecayPauseTimer[LocationIndex] == 0
			DefaultLocationCanDecay[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < CustomLocations
		If CustomLocationDecayPauseTimer[LocationIndex] > 0 && CustomLocationCanDecay[LocationIndex] == False
			CustomLocationDecayPauseTimer[LocationIndex] = CustomLocationDecayPauseTimer[LocationIndex] - 1
		EndIf
		If CustomLocationDecayPauseTimer[LocationIndex] == 0
			CustomLocationCanDecay[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	;Update Individual Spread Pause Timers
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationSpreadPauseTimer[LocationIndex] > 0 && DefaultLocationCanSpread[LocationIndex] == False
			DefaultLocationSpreadPauseTimer[LocationIndex] = DefaultLocationSpreadPauseTimer[LocationIndex] - 1
		EndIf
		If DefaultLocationSpreadPauseTimer[LocationIndex] == 0
			DefaultLocationCanSpread[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	
	While LocationIndex < CustomLocations
		If CustomLocationSpreadPauseTimer[LocationIndex] > 0 && CustomLocationCanSpread[LocationIndex] == False
			CustomLocationSpreadPauseTimer[LocationIndex] = CustomLocationSpreadPauseTimer[LocationIndex] - 1
		EndIf
		If CustomLocationSpreadPauseTimer[LocationIndex] == 0
			CustomLocationCanSpread[LocationIndex] = True
		EndIf
		LocationIndex += 1
	EndWhile
EndEvent

Function SetJsonFileString(String PlayerName)
	JsonFileString = "../SLSF Reloaded/" + PlayerName + " Fame List"
EndFunction

Function CreateNewFameList()
	FamePaused = True
	Int LocationIndex = 0
	Int TypeIndex = 0
	Debug.Notification("SLSF Reloaded - Creating New Fame List. Please Wait.")
	While LocationIndex < LocationManager.DefaultLocation.Length
		While TypeIndex < FameType.Length
			SetIntValue(JsonFileString, FameType[TypeIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex], 0)
			TypeIndex += 1
		EndWhile
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	FamePaused = False
	Debug.Notification("New Fame List Finished!")
EndFunction

Function AddCustomLocation(String CustomLocationName)
	Int TypeIndex = 0
	While TypeIndex < FameType.Length
		SetIntValue(JsonFileString, FameType[TypeIndex] + " Fame: " + CustomLocationName, 0)
		TypeIndex += 1
	EndWhile
	Debug.Notification("Fame List added for " + CustomLocationName)
EndFunction

Function NameChangeHandler(String NewPlayerName)
	FamePaused = True
	Int LocationIndex = 0
	Int TypeIndex = 0
	String FameTypeAndLocation = ""
	String NewJsonPath = "../SLSF Reloaded/" + NewPlayerName + " Fame List" ;Build string once instead of multiple times
	
	Debug.Notification("SLSF Reloaded - Name Change Detected. Fame is Paused.")
	If JsonExists(NewJsonPath)
		Debug.Notification("SLSF Reloaded - Switched to " + NewPlayerName + " Fame List.")
	Else
		Debug.Notification("SLSF Reloaded - Transferring Fame to New List.")
		While LocationIndex < LocationManager.DefaultLocation.Length
			While TypeIndex < FameType.Length
				FameTypeAndLocation = FameType[TypeIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex] ;Build string once instead of multiple times
				SetIntValue(NewJsonPath, FameTypeAndLocation, GetIntValue(JsonFileString, FameTypeAndLocation))
				TypeIndex += 1
			EndWhile
			TypeIndex = 0
			LocationIndex += 1
		EndWhile
		
		LocationIndex = 0
		TypeIndex = 0
		Int CustomLocations = SLSF_Reloaded_CustomLocationCount.GetValue() as Int
		
		While LocationIndex < CustomLocations
			While TypeIndex < FameType.Length
				FameTypeAndLocation = FameType[TypeIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex]
				SetIntValue(NewJsonPath, FameTypeAndLocation, GetIntValue(JsonFileString, FameTypeAndLocation))
				TypeIndex += 1
			EndWhile
			TypeIndex = 0
			LocationIndex += 1
		EndWhile
	EndIf
	FamePaused = False
	Debug.Notification("SLSF Reloaded - Name Change Finished. Fame is Unpaused.")
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
		If PlayerRef.WornHasKeyword(Mods.DD_NipplePiercing) || PlayerRef.WornHasKeyword(Mods.DD_VaginalPiercing) || PlayerRef.WornHasKeyword(SLSF_Reloaded_NipplePiercing) || PlayerRef.WornHasKeyword(SLSF_Reloaded_VaginalPiercing)
			If PlayerRef.GetEquippedArmorInSlot(32) == None
				return True
			EndIf
		EndIf
	ElseIf Mods.IsDDInstalled == True && Mods.IsANDInstalled == True
		If PlayerRef.WornHasKeyword(Mods.DD_NipplePiercing) || PlayerRef.WornHasKeyword(SLSF_Reloaded_NipplePiercing)
			If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 && GetIntValue(JsonFileString, "Slut Fame: " + FameLocation) < 50
				return True
			EndIf
		ElseIf PlayerRef.WornHasKeyword(Mods.DD_VaginalPiercing) || PlayerRef.WornHasKeyword(SLSF_Reloaded_VaginalPiercing)
			If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 && GetIntValue(JsonFileString, "Slut Fame: " + FameLocation) < 75
				return True
			EndIf
		EndIf
	ElseIf Mods.IsDDInstalled == False && Mods.IsANDInstalled == True
		If PlayerRef.WornHasKeyword(SLSF_Reloaded_NipplePiercing) && PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 && GetIntValue(JsonFileString, "Slut Fame: " + FameLocation) < 50
			return True
		ElseIf PlayerRef.WornHasKeyword(SLSF_Reloaded_VaginalPiercing) && PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 && GetIntValue(JsonFileString, "Slut Fame: " + FameLocation) < 75
			return True
		EndIf
	EndIf
	
	If VisibilityManager.IsVaginalCumVisible() == True
		If Sexlab.CountCumVaginal(PlayerRef) > 2
			return True
		ElseIf Sexlab.CountCumVaginal(PlayerRef) > 1 && GetIntValue(JsonFileString, "Slut Fame: " + FameLocation) < 100
			return True
		ElseIf Sexlab.CountCumVaginal(PlayerRef) > 0 && GetIntValue(JsonFileString, "Slut Fame: " + FameLocation) < 50
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
			If GetIntValue(JsonFileString, "Exhibitionist Fame: " + FameLocation) < 100
				return True
			EndIf
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1
			If GetIntValue(JsonFileString, "Exhibitionist Fame: " + FameLocation) < 75
				return True
			EndIf
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Ass) == 1
			If GetIntValue(JsonFileString, "Exhibitionist Fame: " + FameLocation) < 50
				return True
			EndIf
		ElseIf PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear)  == 1
			If GetIntValue(JsonFileString, "Exhibitionist Fame: " + FameLocation) < 25
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
		ElseIf OralCumCount == 2 && GetIntValue(JsonFileString, "Oral Fame: " + FameLocation) < 100
			return True
		ElseIf GetIntValue(JsonFileString, "Oral Fame: " + FameLocation) < 50
			return True
		EndIf
	EndIf
	return False
EndFunction

Bool Function CanGainAnalFame(String FameLocation)
	;Check Anal Fame
	If VisibilityManager.IsAssCumVisible() == False
		return False
	EndIf
	
	Int AssCumCount = Sexlab.CountCumAnal(PlayerRef)
	If AssCumCount > 0
		If AssCumCount > 2
			return True
		ElseIf AssCumCount == 2 && GetIntValue(JsonFileString, "Anal Fame: " + FameLocation) < 100
			return True
		ElseIf GetIntValue(JsonFileString, "Anal Fame: " + FameLocation) < 50
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
	ElseIf CumCount > 1 && GetIntValue(JsonFileString, "Nasty Fame: " + FameLocation) < 75
		return True
	EndIf
	return False
EndFunction

Bool Function CanGainPregnantFame()
	;Check Pregnant Fame
	If Mods.IsFMPregnant(PlayerRef) || Mods.IsECPregnant(PlayerRef) || Mods.IsESPregnant(PlayerRef)
		return True
	EndIf
	return False
EndFunction
	
Bool Function CanGainBoundFame()
	;Check Bound Fame
	If Mods.IsDDInstalled == True && PlayerRef.WornHasKeyword(Mods.DD_Lockable)
		ArmorSlots = New Armor[28]
			ArmorSlots[0] = PlayerRef.GetEquippedArmorInSlot(31)
			ArmorSlots[1] = PlayerRef.GetEquippedArmorInSlot(32)
			ArmorSlots[2] = PlayerRef.GetEquippedArmorInSlot(33)
			ArmorSlots[3] = PlayerRef.GetEquippedArmorInSlot(34)
			ArmorSlots[4] = PlayerRef.GetEquippedArmorInSlot(35)
			ArmorSlots[5] = PlayerRef.GetEquippedArmorInSlot(36)
			ArmorSlots[6] = PlayerRef.GetEquippedArmorInSlot(37)
			ArmorSlots[7] = PlayerRef.GetEquippedArmorInSlot(38)
			ArmorSlots[8] = PlayerRef.GetEquippedArmorInSlot(39)
			ArmorSlots[9] = PlayerRef.GetEquippedArmorInSlot(40)
			ArmorSlots[10] = PlayerRef.GetEquippedArmorInSlot(41)
			ArmorSlots[11] = PlayerRef.GetEquippedArmorInSlot(42)
			ArmorSlots[12] = PlayerRef.GetEquippedArmorInSlot(43)
			ArmorSlots[13] = PlayerRef.GetEquippedArmorInSlot(44)
			ArmorSlots[14] = PlayerRef.GetEquippedArmorInSlot(45)
			ArmorSlots[15] = PlayerRef.GetEquippedArmorInSlot(46)
			ArmorSlots[16] = PlayerRef.GetEquippedArmorInSlot(47)
			ArmorSlots[17] = PlayerRef.GetEquippedArmorInSlot(48)
			ArmorSlots[18] = PlayerRef.GetEquippedArmorInSlot(49)
			ArmorSlots[19] = PlayerRef.GetEquippedArmorInSlot(52)
			ArmorSlots[20] = PlayerRef.GetEquippedArmorInSlot(53)
			ArmorSlots[21] = PlayerRef.GetEquippedArmorInSlot(54)
			ArmorSlots[22] = PlayerRef.GetEquippedArmorInSlot(55)
			ArmorSlots[23] = PlayerRef.GetEquippedArmorInSlot(56)
			ArmorSlots[24] = PlayerRef.GetEquippedArmorInSlot(57)
			ArmorSlots[25] = PlayerRef.GetEquippedArmorInSlot(58)
			ArmorSlots[26] = PlayerRef.GetEquippedArmorInSlot(59)
			ArmorSlots[27] = PlayerRef.GetEquippedArmorInSlot(60)
		
		DD_Keywords = New Keyword[5]
			DD_Keywords[0] = Mods.DD_Collar
			DD_Keywords[1] = Mods.DD_NipplePiercing
			DD_Keywords[2] = Mods.DD_VaginalPiercing
			DD_Keywords[3] = Mods.DD_VaginalPlug
			DD_Keywords[4] = Mods.DD_AnalPlug
		
		Int SlotIndex = 0
		Int KeywordIndex = 0
		While SlotIndex < ArmorSlots.Length
			While KeywordIndex < DD_Keywords.Length
				If ArmorSlots[SlotIndex].HasKeyword(Mods.DD_Lockable) && !ArmorSlots[SlotIndex].HasKeyword(DD_Keywords[KeywordIndex])
					return True
				EndIf
				KeywordIndex += 1
			EndWhile
			KeywordIndex = 0
			SlotIndex += 1
		EndWhile
	EndIf
	return False
EndFunction

Bool Function CanGainTattooFame(String FameLocation)
	;Check Tattoo Fame
	If Mods.IsSlaveTatsInstalled == True
		If VisibilityManager.CountVisibleTattoos() > 10
			return True
		ElseIf VisibilityManager.CountVisibleTattoos() > 8 && GetIntValue(JsonFileString, "Tattoo Fame: " + FameLocation) < 120
			return True
		ElseIf VisibilityManager.CountVisibleTattoos() > 6 && GetIntValue(JsonFileString, "Tattoo Fame: " + FameLocation) < 90
			return True
		ElseIf VisibilityManager.CountVisibleTattoos() > 4 && GetIntValue(JsonFileString, "Tattoo Fame: " + FameLocation) < 60
			return True
		ElseIf VisibilityManager.CountVisibleTattoos() > 2 && GetIntValue(JsonFileString, "Tattoo Fame: " + FameLocation) < 30
			return True
		ElseIf VisibilityManager.CountVisibleTattoos() > 0 && GetIntValue(JsonFileString, "Tattoo Fame: " + FameLocation) < 15
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function CanGainCumDumpFame()
	;Check Cum Dump Fame
	If Mods.GetFHUInflation(PlayerRef) > 2
		return True
	EndIf
	return False
EndFunction

Bool Function CheckTattooExtraFame(String ExtraFame)
	Int TattooSlot = 1
	While TattooSlot <= 6
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
	
	If FamePaused == True
		Debug.Trace("SLSF Reloaded - FameGainRoll Function - Fame is Paused")
		return
	EndIf
	
	Int PossibleFameCount = 0
	PossibleFameArray = New String[22]
	
	If CanGainAnalFame(FameLocation) == True || CheckTattooExtraFame("Anal") == True
		PossibleFameArray[PossibleFameCount] = "Anal"
		PossibleFameCount += 1
	EndIf
	
	If CanGainBoundFame() == True || CheckTattooExtraFame("Bound") == True
		PossibleFameArray[PossibleFameCount] = "Bound"
		PossibleFameCount += 1
	EndIf
	
	If CanGainCumDumpFame() == True || CheckTattooExtraFame("Cum Dump") == True
		PossibleFameArray[PossibleFameCount] = "Cum Dump"
		PossibleFameCount += 1
	EndIf
	
	If CanGainExhibitionistFame(FameLocation) == True || CheckTattooExtraFame("Exhibitionist") == True
		PossibleFameArray[PossibleFameCount] = "Exhibitionist"
		PossibleFameCount += 1
	EndIf
	
	If CanGainNastyFame(FameLocation) == True || CheckTattooExtraFame("Nasty") == True
		PossibleFameArray[PossibleFameCount] = "Nasty"
		PossibleFameCount += 1
	EndIf
	
	If CanGainOralFame(FameLocation) == True || CheckTattooExtraFame("Oral") == True
		PossibleFameArray[PossibleFameCount] = "Oral"
		PossibleFameCount += 1
	EndIf
	
	If CanGainPregnantFame() == True || CheckTattooExtraFame("Pregnant") == True
		PossibleFameArray[PossibleFameCount] = "Pregnant"
		PossibleFameCount += 1
	EndIf
	
	If CanGainSlutFame(FameLocation) == True || CheckTattooExtraFame("Slut") == True
		PossibleFameArray[PossibleFameCount] = "Slut"
		PossibleFameCount += 1
	EndIf
	
	If CanGainTattooFame(FameLocation) == True
		PossibleFameArray[PossibleFameCount] = "Tattoo"
		PossibleFameCount += 1
	EndIf
	
	If CanGainWhoreFame() == True || CheckTattooExtraFame("Whore") == True
		PossibleFameArray[PossibleFameCount] = "Whore"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Dominant") == True
		PossibleFameArray[PossibleFameCount] = "Dominant"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Submissive") == True
		PossibleFameArray[PossibleFameCount] = "Submissive"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Sadist") == True
		PossibleFameArray[PossibleFameCount] = "Sadist"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Masochist") == True
		PossibleFameArray[PossibleFameCount] = "Masochist"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Gentle") == True
		PossibleFameArray[PossibleFameCount] = "Gentle"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Men") == True
		PossibleFameArray[PossibleFameCount] = "Likes Men"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Women") == True
		PossibleFameArray[PossibleFameCount] = "Likes Women"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Orc") == True
		PossibleFameArray[PossibleFameCount] = "Likes Orc"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Khajiit") == True
		PossibleFameArray[PossibleFameCount] = "Likes Khajiit"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Likes Argonian") == True
		PossibleFameArray[PossibleFameCount] = "Likes Argonian"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Bestiality") == True
		PossibleFameArray[PossibleFameCount] = "Bestiality"
		PossibleFameCount += 1
	EndIf
	
	If CheckTattooExtraFame("Group") == True
		PossibleFameArray[PossibleFameCount] = "Group"
		PossibleFameCount += 1
	EndIf
	
	If PossibleFameCount == 0
		Debug.Trace("SLSF Reloaded - FameGainRoll Function - PossibleFameCount is Zero")
		return ;If none of the above categories are possible, end function
	EndIf

	Int GainedFameCount = 0
	If PossibleFameCount > 1
		GainedFameCount = Utility.RandomInt(1, PossibleFameCount) ;Randomly Determine how many fame categories are increased
	Else
		GainFame(PossibleFameArray[0], FameLocation) ;If there is only one fame category to gain, apply it and end function
		return
	EndIf
	
	;Apply Fame Step
	Int AppliedFameCount = 0
	If GainedFameCount == PossibleFameCount ;If we gain fame in every possible category, send all increases
		While AppliedFameCount < GainedFameCount
			GainFame(PossibleFameArray[AppliedFameCount], FameLocation)
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
			GainFame(RolledCategory[AppliedFameCount], FameLocation)
			AppliedFameCount += 1
		Else
			TimesRolled -= 1 ;If there is a duplicate, reduce roll to prevent run-away index checks
			DuplicateFameRolls = False
		EndIf
	EndWhile
EndFunction

Function GainFame(String Category, String LocationName)
	If FamePaused == True
		Debug.Trace("SLSF Reloaded - GainFame Function - Fame is Paused")
		return
	EndIf
	
	String FameTypeAndLocation = Category + " Fame: " + LocationName
	Int FameGained = 0
	Float FameMultiplier = Config.FameChangeMultiplier
	Float Hour = (Utility.GetCurrentGameTime() - Math.Floor(Utility.GetCurrentGameTime())) * 24
	
	If (Hour > Config.NightStart || Hour < Config.NightEnd) && Config.ReduceFameAtNight == True
		FameMultiplier = FameMultiplier / 2 ;Half Fame Gains at night
	EndIf
	
	Int PreviousFame = GetIntValue(JsonFileString, FameTypeAndLocation)
	
	If PreviousFame >= 100
		FameGained = Utility.RandomInt(1,2)
	ElseIf PreviousFame >= 75
		FameGained = Utility.RandomInt(1,4)
	ElseIf PreviousFame >= 50
		FameGained = Utility.RandomInt(1,6)
	ElseIf PreviousFame >= 25
		FameGained = Utility.RandomInt(1,8)
	Else
		FameGained = Utility.RandomInt(1,10)
	EndIf
	
	AdjustIntValue(JsonFileString, FameTypeAndLocation, (FameGained * FameMultiplier) as Int)
	
	If GetIntValue(JsonFileString, FameTypeAndLocation) > 150
		SetIntValue(JsonFileString, FameTypeAndLocation, 150)
	EndIf
	
	;Location Decay is paused when fame increases. Find location index, apply pause, and reset timer.
	Int LocationIndex = 0
	Bool LocationFound = False
	While LocationFound == False && LocationIndex < LocationManager.DefaultLocation.Length
		If LocationName == LocationManager.DefaultLocation[LocationIndex]
			LocationFound = True
			DefaultLocationCanDecay[LocationIndex] = False
			DefaultLocationDecayPauseTimer[LocationIndex] = (Config.DecayTimeNeeded)
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
				CustomLocationDecayPauseTimer[LocationIndex] = (Config.DecayTimeNeeded)
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
	String FameTypeAndLocation = ""
	Bool DecayNotificationMakesSense = False
	
	While LocationIndex < LocationManager.DefaultLocation.Length
		If DefaultLocationCanDecay[LocationIndex]
			While TypeIndex < FameType.Length
				FameTypeAndLocation = FameType[TypeIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex]
				
				If GetIntValue(JsonFileString, FameTypeAndLocation) >= 100
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (-1 * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) >= 75
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-2,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) >= 50
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-3,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) >= 25
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-4,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) > 0
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-5,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				EndIf
				
				If GetIntValue(JsonFileString, FameTypeAndLocation) < 0
					SetIntValue(JsonFileString, FameTypeAndLocation, 0)
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
		If CustomLocationCanDecay[LocationIndex]
			While TypeIndex < FameType.Length
				FameTypeAndLocation = FameType[TypeIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex]
				
				If GetIntValue(JsonFileString, FameTypeAndLocation) >= 100
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (-1 * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) >= 75
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-2,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) >= 50
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-3,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) >= 25
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-4,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				ElseIf GetIntValue(JsonFileString, FameTypeAndLocation) > 0
					AdjustIntValue(JsonFileString, FameTypeAndLocation, (Utility.RandomInt(-5,-1) * FameMultiplier) as Int)
					DecayNotificationMakesSense = True
				EndIf
				
				If GetIntValue(JsonFileString, FameTypeAndLocation) < 0
					SetIntValue(JsonFileString, FameTypeAndLocation, 0)
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
			SpreadChance = Config.DefaultLocationSpreadChance[LocationIndex]
			If SpreadChance == 0
				Config.DefaultLocationSpreadChance[LocationIndex] = Config.DefaultLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease
			ElseIf SpreadChance == 100
				SpreadFame(LocationManager.DefaultLocation[LocationIndex])
				Config.DefaultLocationSpreadChance[LocationIndex] = Config.DefaultLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction
			ElseIf SpreadChance > 100 || SpreadChance < 0
				Debug.MessageBox("SLSF Reloaded: ERROR - Fame Spread Chance for " + LocationManager.DefaultLocation[LocationIndex] + " is not valid!")
			Else
				FameSpreadRoll = Utility.RandomInt(1, 100)
				If FameSpreadRoll <= SpreadChance
					SpreadFame(LocationManager.DefaultLocation[LocationIndex])
					Config.DefaultLocationSpreadChance[LocationIndex] = Config.DefaultLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction
				Else
					Config.DefaultLocationSpreadChance[LocationIndex] = Config.DefaultLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease
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
		If CustomLocationCanSpread[LocationIndex] == True
			SpreadChance = Config.CustomLocationSpreadChance[LocationIndex]
			If SpreadChance == 0
				Config.CustomLocationSpreadChance[LocationIndex] = Config.CustomLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease
			ElseIf SpreadChance == 100
				SpreadFame(LocationManager.CustomLocation[LocationIndex])
				Config.CustomLocationSpreadChance[LocationIndex] = Config.CustomLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction
			ElseIf SpreadChance > 100 || SpreadChance < 0
				Debug.MessageBox("SLSF Reloaded: ERROR - Fame Spread Chance for " + LocationManager.CustomLocation[LocationIndex] + " is not valid!")
			Else
				FameSpreadRoll = Utility.RandomInt(1, 100)
				If FameSpreadRoll <= SpreadChance
					SpreadFame(LocationManager.CustomLocation[LocationIndex])
					Config.CustomLocationSpreadChance[LocationIndex] = Config.CustomLocationSpreadChance[LocationIndex] - Config.SuccessfulSpreadReduction
				Else
					Config.CustomLocationSpreadChance[LocationIndex] = Config.CustomLocationSpreadChance[LocationIndex] + Config.FailedSpreadIncrease
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
	;Grab all fame values above the configured threshold from the source Location. If none exist, cancel fame spread operation
	String FameTypeAndLocation = ""
	Int PossibleFameSpreadCategories = 0
	Int PossibleFameSpreadIndex = 0
	PossibleSpreadCategories = New String[1] ;Set Default array size to 1 | resize as necessary
	
	;Count possible categories & fill array
	While PossibleFameSpreadIndex < FameType.Length
		FameTypeAndLocation = FameType[PossibleFameSpreadIndex] + " Fame: " + SpreadFromLocation
		
		If GetIntValue(JsonFileString, FameTypeAndLocation) >= Config.MinimumFameToSpread
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
	
	;Roll Target location index based on number of total locations, and ensure we are not trying to spread to the original location
	Int TargetLocationIndex = 0
	Bool TargetLocationValid = False
	
	While TargetLocationValid == False
		TargetLocationIndex = Utility.RandomInt(0, (TotalLocations - 1)) ;Must reduce total locations by 1 in randomizer because Indexes start at 0
		If SpreadFromLocation != PossibleSpreadTargets[TargetLocationIndex]
			TargetLocationValid = True
		EndIf
	EndWhile
	
	;When valid target is found, randomize how many fame categories are spread and by how much, based on config values.
	Int NumberOfCategoriesToSpread = 0
	Float CategorySpreadPercentage = 0.0
	
	If Config.MaximumSpreadCategories > 1 && PossibleFameSpreadCategories > 1
		If Config.MaximumSpreadCategories <= PossibleFameSpreadCategories
			NumberOfCategoriesToSpread = Utility.RandomInt(1, Config.MaximumSpreadCategories)
		Else
			NumberOfCategoriesToSpread = Utility.RandomInt(1, PossibleFameSpreadCategories)
		EndIf
	EndIf
	
	;Randomly pick which valid categories are spread
	Int FameSpreadValue = 0
	Int SuccessfulFameSpreads = 0
	Int CategoryRoll = 0
	String OriginalFameTypeAndLocation = ""
	String TargetFameTypeAndLocation = ""
	
	If PossibleFameSpreadCategories == 1
		OriginalFameTypeAndLocation = PossibleSpreadCategories[0] + " Fame: " + SpreadFromLocation
		TargetFameTypeAndLocation = PossibleSpreadCategories[0] + " Fame: " + PossibleSpreadTargets[TargetLocationIndex]
		FameSpreadValue = (GetIntValue(JsonFileString, OriginalFameTypeAndLocation) * (Utility.RandomInt(1, (Config.MaximumSpreadPercentage / 10))/10)) as Int 
		;Fame spread is in steps of 10%, which is why we divide the MaximumSpreadPercentage by 10 and then divide the RandomInt by 10 again to total the overall division by 100, which gives us a percentage
		
		AdjustIntValue(JsonFileString, TargetFameTypeAndLocation, FameSpreadValue)
		
		If GetIntValue(JsonFileString, TargetFameTypeAndLocation) > 150
			SetIntValue(JsonFileString, TargetFameTypeAndLocation, 150)
		EndIf
	ElseIf NumberOfCategoriesToSpread == 1
		CategoryRoll = Utility.RandomInt(0, (PossibleFameSpreadCategories - 1))
		OriginalFameTypeAndLocation = PossibleSpreadCategories[CategoryRoll] + " Fame: " + SpreadFromLocation
		TargetFameTypeAndLocation = PossibleSpreadCategories[CategoryRoll] + " Fame: " + PossibleSpreadTargets[TargetLocationIndex]
		FameSpreadValue = (GetIntValue(JsonFileString, OriginalFameTypeAndLocation) * (Utility.RandomInt(1, (Config.MaximumSpreadPercentage / 10))/10)) as Int
		
		AdjustIntValue(JsonFileString, TargetFameTypeAndLocation, FameSpreadValue)
		
		If GetIntValue(JsonFileString, TargetFameTypeAndLocation) > 150
			SetIntValue(JsonFileString, TargetFameTypeAndLocation, 150)
		EndIf
	ElseIf NumberOfCategoriesToSpread == PossibleFameSpreadCategories
		
		While SuccessfulFameSpreads < PossibleFameSpreadCategories
			OriginalFameTypeAndLocation = PossibleSpreadCategories[SuccessfulFameSpreads] + " Fame: " + SpreadFromLocation
			TargetFameTypeAndLocation = PossibleSpreadCategories[SuccessfulFameSpreads] + " Fame: " + PossibleSpreadTargets[TargetLocationIndex]
			FameSpreadValue = (GetIntValue(JsonFileString, OriginalFameTypeAndLocation) * (Utility.RandomInt(1, (Config.MaximumSpreadPercentage / 10))/10)) as Int
			
			AdjustIntValue(JsonFileString, TargetFameTypeAndLocation, FameSpreadValue)
		
			If GetIntValue(JsonFileString, TargetFameTypeAndLocation) > 150
				SetIntValue(JsonFileString, TargetFameTypeAndLocation, 150)
			EndIf
			
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
				While PreviousRoll < TimesRolled
					If RolledCategory[SuccessfulFameSpreads] == RolledCategory[PreviousRoll] ;Check previous rolls for matching results
						DuplicateFameRolls = True
					EndIf
					PreviousRoll += 1
				EndWhile
				PreviousRoll = 0
			EndIf
			
			If DuplicateFameRolls == False
				;If there are no duplicates, apply our rolled fame.
				OriginalFameTypeAndLocation = PossibleSpreadCategories[CategoryRoll] + " Fame: " + SpreadFromLocation
				TargetFameTypeAndLocation = PossibleSpreadCategories[CategoryRoll] + " Fame: " + PossibleSpreadTargets[TargetLocationIndex]
				FameSpreadValue = (GetIntValue(JsonFileString, OriginalFameTypeAndLocation) * (Utility.RandomInt(1, (Config.MaximumSpreadPercentage / 10))/10)) as Int
				
				AdjustIntValue(JsonFileString, TargetFameTypeAndLocation, FameSpreadValue)
			
				If GetIntValue(JsonFileString, TargetFameTypeAndLocation) > 150
					SetIntValue(JsonFileString, TargetFameTypeAndLocation, 150)
				EndIf
				
				SuccessfulFameSpreads += 1
			Else
				TimesRolled -= 1 ;If there is a duplicate, reduce roll to prevent run-away index checks
				DuplicateFameRolls = False
			EndIf
		EndWhile
	EndIf
	
	;Enable Spread Pause for Location
	Int PauseIndex = PossibleSpreadTargets.Find(SpreadFromLocation)
	
	If PauseIndex < 21
		DefaultLocationCanSpread[PauseIndex] = False
		DefaultLocationSpreadPauseTimer[PauseIndex] = Config.SpreadTimeNeeded
	Else
		CustomLocationCanSpread[(PauseIndex - 21)] = False
		CustomLocationSpreadPauseTimer[(PauseIndex - 21)] = Config.SpreadTimeNeeded
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

Function FameSpreadNotification()
	;Placeholder - Will be refined after testing
	Debug.Notification("SLSF Realoaded - Your fame has spread")
EndFunction

Function ClearFame(String LocationToClear)
	Int TypeIndex = 0
	While TypeIndex < FameType.Length
		SetIntValue(JsonFileString, FameType[TypeIndex] + " Fame: " + LocationToClear, 0)
		TypeIndex += 1
	EndWhile
	Debug.MessageBox(LocationToClear + " fame has been cleared for " + PlayerScript.NewPlayerName)
EndFunction

Function ClearAllFame()
	Int TypeIndex = 0
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		While TypeIndex < FameType.Length
			SetIntValue(JsonFileString, FameType[TypeIndex] + " Fame: " + LocationManager.DefaultLocation[LocationIndex], 0)
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
			SetIntValue(JsonFileString, FameType[TypeIndex] + " Fame: " + LocationManager.CustomLocation[LocationIndex], 0)
			TypeIndex += 1
		EndWhile
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	Debug.MessageBox("All fame has been cleared for " + PlayerScript.NewPlayerName)
EndFunction