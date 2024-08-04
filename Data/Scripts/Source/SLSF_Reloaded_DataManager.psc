ScriptName SLSF_Reloaded_DataManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto

Int[] Property WhiterunFame Auto
Int[] Property WindhelmFame Auto
Int[] Property WinterholdFame Auto
Int[] Property SolitudeFame Auto
Int[] Property RiftenFame Auto
Int[] Property MarkarthFame Auto
Int[] Property MorthalFame Auto
Int[] Property DawnstarFame Auto
Int[] Property FalkreathFame Auto
Int[] Property RavenRockFame Auto
Int[] Property RiverwoodFame Auto
Int[] Property RoriksteadFame Auto
Int[] Property IvarsteadFame Auto
Int[] Property ShorsStoneFame Auto
Int[] Property DragonBridgeFame Auto
Int[] Property KarthwastenFame Auto
Int[] Property SkaalVillageFame Auto
Int[] Property LargashburFame Auto
Int[] Property DushnikhYalFame Auto
Int[] Property MorKhazgurFame Auto
Int[] Property NarzulburFame Auto

Int[] Property CustomLocation1Fame Auto
Int[] Property CustomLocation2Fame Auto
Int[] Property CustomLocation3Fame Auto
Int[] Property CustomLocation4Fame Auto
Int[] Property CustomLocation5Fame Auto
Int[] Property CustomLocation6Fame Auto
Int[] Property CustomLocation7Fame Auto
Int[] Property CustomLocation8Fame Auto
Int[] Property CustomLocation9Fame Auto
Int[] Property CustomLocation10Fame Auto
Int[] Property CustomLocation11Fame Auto
Int[] Property CustomLocation12Fame Auto
Int[] Property CustomLocation13Fame Auto
Int[] Property CustomLocation14Fame Auto
Int[] Property CustomLocation15Fame Auto
Int[] Property CustomLocation16Fame Auto
Int[] Property CustomLocation17Fame Auto
Int[] Property CustomLocation18Fame Auto
Int[] Property CustomLocation19Fame Auto
Int[] Property CustomLocation20Fame Auto

Bool[] Property ExternalFlags Auto

String[] Property ExternalMods Auto

Bool[] Property SlutFlags Auto
Bool[] Property WhoreFlags Auto
Bool[] Property ExhibitionistFlags Auto
Bool[] Property OralFlags Auto
Bool[] Property AnalFlags Auto
Bool[] Property NastyFlags Auto
Bool[] Property PregnantFlags Auto
Bool[] Property DominantFlags Auto
Bool[] Property SubmissiveFlags Auto
Bool[] Property SadistFlags Auto
Bool[] Property MasochistFlags Auto
Bool[] Property GentleFlags Auto
Bool[] Property LikesMenFlags Auto
Bool[] Property LikesWomenFlags Auto
Bool[] Property LikesOrcFlags Auto
Bool[] Property LikesKhajiitFlags Auto
Bool[] Property LikesArgonianFlags Auto
Bool[] Property BestialityFlags Auto
Bool[] Property GroupFlags Auto
Bool[] Property BoundFlags Auto
Bool[] Property TattooFlags Auto
Bool[] Property CumDumpFlags Auto

Event OnInit()
	Utility.ResizeStringArray(ExternalMods, 128)
	Utility.ResizeBoolArray(SlutFlags, 128)
	Utility.ResizeBoolArray(Whoreflags, 128)
	Utility.ResizeBoolArray(ExhibitionistFlags, 128)
	Utility.ResizeBoolArray(OralFlags, 128)
	Utility.ResizeBoolArray(AnalFlags, 128)
	Utility.ResizeBoolArray(NastyFlags, 128)
	Utility.ResizeBoolArray(PregnantFlags, 128)
	Utility.ResizeBoolArray(DominantFlags, 128)
	Utility.ResizeBoolArray(SubmissiveFlags, 128)
	Utility.ResizeBoolArray(SadistFlags, 128)
	Utility.ResizeBoolArray(MasochistFlags, 128)
	Utility.ResizeBoolArray(GentleFlags, 128)
	Utility.ResizeBoolArray(LikesMenFlags, 128)
	Utility.ResizeBoolArray(LikesWomenFlags, 128)
	Utility.ResizeBoolArray(LikesOrcFlags, 128)
	Utility.ResizeBoolArray(LikesKhajiitFlags, 128)
	Utility.ResizeBoolArray(LikesArgonianFlags, 128)
	Utility.ResizeBoolArray(BestialityFlags, 128)
	Utility.ResizeBoolArray(GroupFlags, 128)
	Utility.ResizeBoolArray(BoundFlags, 128)
	Utility.ResizeBoolArray(TattooFlags, 128)
	Utility.ResizeBoolArray(CumDumpFlags, 128)
EndEvent

Int Function GetFameValue(String LocationName, String FameCategory, Bool ExternalRequest = False)
	Int CustomLocationIndex = 0
	Int FameIndex = FameManager.FameType.Find(FameCategory)
	
	If FameIndex < 0 || FameIndex > FameManager.FameType.Length
		If ExternalRequest == False
			Debug.MessageBox("SLSF Reloaded - Error: Fame Category " + FameCategory + " is not valid!")
		Else
			Debug.MessageBox("SLSF Reloaded - Error: External Fame Request Category invalid")
		EndIf
		return 0
	EndIf
	
	If LocationName == "Whiterun"
		return WhiterunFame[FameIndex]
	ElseIf LocationName == "Windhelm"
		return WindhelmFame[FameIndex]
	ElseIf LocationName == "Winterhold"
		return WinterholdFame[FameIndex]
	ElseIf LocationName == "Solitude"
		return SolitudeFame[FameIndex]
	ElseIf LocationName == "Riften"
		return RiftenFame[FameIndex]
	ElseIf LocationName == "Markarth"
		return MarkarthFame[FameIndex]
	ElseIf LocationName == "Morthal"
		return MorthalFame[FameIndex]
	ElseIf LocationName == "Dawnstar"
		return DawnstarFame[FameIndex]
	ElseIf LocationName == "Falkreath"
		return FalkreathFame[FameIndex]
	ElseIf LocationName == "Raven Rock"
		return RavenRockFame[FameIndex]
	ElseIf LocationName == "Riverwood"
		return RiverwoodFame[FameIndex]
	ElseIf LocationName == "Rorikstead"
		return RoriksteadFame[FameIndex]
	ElseIf LocationName == "Ivarstead"
		return IvarsteadFame[FameIndex]
	ElseIf LocationName == "Shors Stone"
		return ShorsStoneFame[FameIndex]
	ElseIf LocationName == "Dragon Bridge"
		return DragonBridgeFame[FameIndex]
	ElseIf LocationName == "Karthwasten"
		return KarthwastenFame[FameIndex]
	ElseIf LocationName == "Skaal Village"
		return SkaalVillageFame[FameIndex]
	ElseIf LocationName == "Largashbur"
		return LargashburFame[FameIndex]
	ElseIf LocationName == "Dushnikh Yal"
		return DushnikhYalFame[FameIndex]
	ElseIf LocationName == "Mor Khazgur"
		return MorKhazgurFame[FameIndex]
	ElseIf LocationName == "Narzulbur"
		return NarzulburFame[FameIndex]
	Else
		CustomLocationIndex = LocationManager.CustomLocation.Find(LocationName)
		If CustomLocationIndex == 0
			return CustomLocation1Fame[FameIndex]
		ElseIf CustomLocationIndex == 1
			return CustomLocation2Fame[FameIndex]
		ElseIf CustomLocationIndex == 2
			return CustomLocation3Fame[FameIndex]
		ElseIf CustomLocationIndex == 3
			return CustomLocation4Fame[FameIndex]
		ElseIf CustomLocationIndex == 4
			return CustomLocation5Fame[FameIndex]
		ElseIf CustomLocationIndex == 5
			return CustomLocation6Fame[FameIndex]
		ElseIf CustomLocationIndex == 6
			return CustomLocation7Fame[FameIndex]
		ElseIf CustomLocationIndex == 7
			return CustomLocation8Fame[FameIndex]
		ElseIf CustomLocationIndex == 8
			return CustomLocation9Fame[FameIndex]
		ElseIf CustomLocationIndex == 9
			return CustomLocation10Fame[FameIndex]
		ElseIf CustomLocationIndex == 10
			return CustomLocation11Fame[FameIndex]
		ElseIf CustomLocationIndex == 11
			return CustomLocation12Fame[FameIndex]
		ElseIf CustomLocationIndex == 12
			return CustomLocation13Fame[FameIndex]
		ElseIf CustomLocationIndex == 13
			return CustomLocation14Fame[FameIndex]
		ElseIf CustomLocationIndex == 14
			return CustomLocation15Fame[FameIndex]
		ElseIf CustomLocationIndex == 15
			return CustomLocation16Fame[FameIndex]
		ElseIf CustomLocationIndex == 16
			return CustomLocation17Fame[FameIndex]
		ElseIf CustomLocationIndex == 17
			return CustomLocation18Fame[FameIndex]
		ElseIf CustomLocationIndex == 18
			return CustomLocation19Fame[FameIndex]
		ElseIf CustomLocationIndex == 19
			return CustomLocation20Fame[FameIndex]
		Else
			If ExternalRequest == False
				Debug.MessageBox("SLSF Reloaded - ERROR: Fame Value for " + LocationName + " not found!")
			Else
				Debug.MessageBox("SLSF Reloaded - ERROR: External Fame Request Location " + LocationName + " not found!")
			EndIf
		EndIf
	EndIf
	return 0
EndFunction

Function SetFameValue(String LocationName, String FameCategory, Int FameValue)
	Int CustomLocationIndex = 0
	Int FameIndex = FameManager.FameType.Find(FameCategory)
	If LocationName == "Whiterun"
		WhiterunFame[FameIndex] = FameValue
	ElseIf LocationName == "Windhelm"
		WindhelmFame[FameIndex] = FameValue
	ElseIf LocationName == "Winterhold"
		WinterholdFame[FameIndex] = FameValue
	ElseIf LocationName == "Solitude"
		SolitudeFame[FameIndex] = FameValue
	ElseIf LocationName == "Riften"
		RiftenFame[FameIndex] = FameValue
	ElseIf LocationName == "Markarth"
		MarkarthFame[FameIndex] = FameValue
	ElseIf LocationName == "Morthal"
		MorthalFame[FameIndex] = FameValue
	ElseIf LocationName == "Dawnstar"
		DawnstarFame[FameIndex] = FameValue
	ElseIf LocationName == "Falkreath"
		FalkreathFame[FameIndex] = FameValue
	ElseIf LocationName == "Raven Rock"
		RavenRockFame[FameIndex] = FameValue
	ElseIf LocationName == "Riverwood"
		RiverwoodFame[FameIndex] = FameValue
	ElseIf LocationName == "Rorikstead"
		RoriksteadFame[FameIndex] = FameValue
	ElseIf LocationName == "Ivarstead"
		IvarsteadFame[FameIndex] = FameValue
	ElseIf LocationName == "Shors Stone"
		ShorsStoneFame[FameIndex] = FameValue
	ElseIf LocationName == "Dragon Bridge"
		DragonBridgeFame[FameIndex] = FameValue
	ElseIf LocationName == "Karthwasten"
		KarthwastenFame[FameIndex] = FameValue
	ElseIf LocationName == "Skaal Village"
		SkaalVillageFame[FameIndex] = FameValue
	ElseIf LocationName == "Largashbur"
		LargashburFame[FameIndex] = FameValue
	ElseIf LocationName == "Dushnikh Yal"
		DushnikhYalFame[FameIndex] = FameValue
	ElseIf LocationName == "Mor Khazgur"
		MorKhazgurFame[FameIndex] = FameValue
	ElseIf LocationName == "Narzulbur"
		NarzulburFame[FameIndex] = FameValue
	Else
		CustomLocationIndex = LocationManager.CustomLocation.Find(LocationName)
		If CustomLocationIndex == 0
			CustomLocation1Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 1
			CustomLocation2Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 2
			CustomLocation3Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 3
			CustomLocation4Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 4
			CustomLocation5Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 5
			CustomLocation6Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 6
			CustomLocation7Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 7
			CustomLocation8Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 8
			CustomLocation9Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 9
			CustomLocation10Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 10
			CustomLocation11Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 11
			CustomLocation12Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 12
			CustomLocation13Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 13
			CustomLocation14Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 14
			CustomLocation15Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 15
			CustomLocation16Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 16
			CustomLocation17Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 17
			CustomLocation18Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 18
			CustomLocation19Fame[FameIndex] = FameValue
		ElseIf CustomLocationIndex == 19
			CustomLocation20Fame[FameIndex] = FameValue
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Could not set Fame Value for " + LocationName + "!")
		EndIf
	EndIf
EndFunction

Bool Function GetExternalFlags(String FlagName)
	If FlagName == "Whore"
		return ExternalFlags[0]
	ElseIf FlagName == "Slut"
		return ExternalFlags[1]
	ElseIf FlagName == "Exhibitionist"
		return ExternalFlags[2]
	ElseIf FlagName == "Oral"
		return ExternalFlags[3]
	ElseIf FlagName == "Anal"
		return ExternalFlags[4]
	ElseIf FlagName == "Nasty"
		return ExternalFlags[5]
	ElseIf FlagName == "Pregnant"
		return ExternalFlags[6]
	ElseIf FlagName == "Dominant"
		return ExternalFlags[7]
	ElseIf FlagName == "Submissive"
		return ExternalFlags[8]
	ElseIf FlagName == "Sadist"
		return ExternalFlags[9]
	ElseIf FlagName == "Masochist"
		return ExternalFlags[10]
	ElseIf FlagName == "Gentle"
		return ExternalFlags[11]
	ElseIf FlagName == "Likes Men"
		return ExternalFlags[12]
	ElseIf FlagName == "Likes Women"
		return ExternalFlags[13]
	ElseIf FlagName == "Likes Orc"
		return ExternalFlags[14]
	ElseIf FlagName == "Likes Khajiit"
		return ExternalFlags[15]
	ElseIf FlagName == "Likes Argonian"
		return ExternalFlags[16]
	ElseIf FlagName == "Bestiality"
		return ExternalFlags[17]
	ElseIf FlagName == "Group"
		return ExternalFlags[18]
	ElseIf FlagName == "Bound"
		return ExternalFlags[19]
	ElseIf FlagName == "Tattoo"
		return ExternalFlags[20]
	ElseIf FlagName == "Cum Dump"
		return ExternalFlags[21]
	EndIf
EndFunction

Function SetExternalFlags(String ModName, String FlagName, Bool FlagValue)
	If ExternalMods.Find(ModName) == -1
		Int EmptyIndex = ExternalMods.Find(None)
		If EmptyIndex == -1 || EmptyIndex > 127
			Debug.MessageBox("Cannot Add " + ModName + " to External Mod List. External Mod List full.")
		Else
			ExternalMods[EmptyIndex] = ModName
		EndIf
	EndIf
	
	Int ModIndex = ExternalMods.Find(ModName)
	
	If FlagName == "Whore"
		WhoreFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Slut"
		SlutFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Exhibitionist"
		ExhibitionistFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Oral"
		OralFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Anal"
		AnalFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Nasty"
		NastyFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Pregnant"
		PregnantFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Dominant"
		DominantFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Submissive"
		SubmissiveFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Sadist"
		SadistFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Masochist"
		MasochistFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Gentle"
		GentleFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Likes Men"
		LikesMenFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Likes Women"
		LikesWomenFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Likes Orc"
		LikesOrcFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Likes Khajiit"
		LikesKhajiitFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Likes Argonian"
		LikesArgonianFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Bestiality"
		BestialityFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Group"
		GroupFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Bound"
		BoundFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Tattoo"
		TattooFlags[ModIndex] = FlagValue as Int
	ElseIf FlagName == "Cum Dump"
		CumDumpFlags[ModIndex] = FlagValue as Int
	Else
		Debug.MessageBox("SLSF Reloaded - ERROR: External mod category " + FlagName + " is not valid!")
	EndIf
	
	CountFlags()
EndFunction

Function CountFlags()
	Int CountIndex = 0
	
	Int WhoreFlagCount = 0
	Int SlutFlagCount = 0
	Int ExhibitionistFlagCount = 0
	Int OralFlagCount = 0
	Int AnalFlagCount = 0
	Int NastyFlagCount = 0
	Int PregnantFlagCount = 0
	Int DominantFlagCount = 0
	Int SubmissiveFlagCount = 0
	Int SadistFlagCount = 0
	Int MasochistFlagCount = 0
	Int GentleFlagCount = 0
	Int LikesMenFlagCount = 0
	Int LikesWomenFlagCount = 0
	Int LikesOrcFlagCount = 0
	Int LikesKhajiitFlagCount = 0
	Int LikesArgonianFlagCount = 0
	Int BestialityFlagCount = 0
	Int GroupFlagCount = 0
	Int BoundFlagCount = 0
	Int TattooFlagCount = 0
	Int CumDumpFlagCount = 0
	
	While CountIndex < 128
		If WhoreFlags[CountIndex] == True
			WhoreFlagCount += 1
		EndIf
		
		If SlutFlags[CountIndex] == True
			SlutFlagCount += 1
		EndIf
		
		If ExhibitionistFlags[CountIndex] == True
			ExhibitionistFlagCount += 1
		EndIf
		
		If OralFlags[CountIndex] == True
			OralFlagCount += 1
		EndIf
		
		If AnalFlags[CountIndex] == True
			AnalFlagCount += 1
		EndIf
		
		If NastyFlags[CountIndex] == True
			NastyFlagCount += 1
		EndIf
		
		If PregnantFlags[CountIndex] == True
			PregnantFlagCount += 1
		EndIf
		
		If DominantFlags[CountIndex] == True
			DominantFlagCount += 1
		EndIf
		
		If SubmissiveFlags[CountIndex] == True
			SubmissiveFlagCount += 1
		EndIf
		
		If SadistFlags[CountIndex] == True
			SadistFlagCount += 1
		EndIf
		
		If MasochistFlags[CountIndex] == True
			MasochistFlagCount += 1
		EndIf
		
		If GentleFlags[CountIndex] == True
			GentleFlagCount += 1
		EndIf
		
		If LikesMenFlags[CountIndex] == True
			LikesMenFlagCount += 1
		EndIf
		
		If LikesWomenFlags[CountIndex] == True
			LikesWomenFlagCount += 1
		EndIf
		
		If LikesOrcFlags[CountIndex] == True
			LikesOrcFlagCount += 1
		EndIf
		
		If LikesKhajiitFlags[CountIndex] == True
			LikesKhajiitFlagCount += 1
		EndIf
		
		If LikesArgonianFlags[CountIndex] == True
			LikesArgonianFlagCount += 1
		EndIf
		
		If BestialityFlags[CountIndex] == True
			BestialityFlagCount += 1
		EndIf
		
		If GroupFlags[CountIndex] == True
			GroupFlagCount += 1
		EndIf
		
		If BoundFlags[CountIndex] == True
			BoundFlagCount += 1
		EndIf
		
		If TattooFlags[CountIndex] == True
			TattooFlagCount += 1
		EndIf
		
		If CumDumpFlags[CountIndex] == True
			CumDumpFlagCount += 1
		EndIf
		
		CountIndex += 1
	EndWhile
	
	If WhoreFlagCount > 0
		ExternalFlags[0] = True
	Else
		ExternalFlags[0] = False
	EndIf
	
	If SlutFlagCount > 0
		ExternalFlags[1] = True
	Else
		ExternalFlags[1] = False
	EndIf
	
	If ExhibitionistFlagCount > 0
		ExternalFlags[2] = True
	Else
		ExternalFlags[2] = False
	EndIf
	
	If OralFlagCount > 0
		ExternalFlags[3] = True
	Else
		ExternalFlags[3] = False
	EndIf
	
	If AnalFlagCount > 0
		ExternalFlags[4] = True
	Else
		ExternalFlags[4] = False
	EndIf
	
	If NastyFlagCount > 0
		ExternalFlags[5] = True
	Else
		ExternalFlags[5] = False
	EndIf
	
	If PregnantFlagCount > 0
		ExternalFlags[6] = True
	Else
		ExternalFlags[6] = False
	EndIf
	
	If DominantFlagCount > 0
		ExternalFlags[7] = True
	Else
		ExternalFlags[7] = False
	EndIf
	
	If SubmissiveFlagCount > 0
		ExternalFlags[8] = True
	Else
		ExternalFlags[8] = False
	EndIf
	
	If SadistFlagCount > 0
		ExternalFlags[9] = True
	Else
		ExternalFlags[9] = False
	EndIf
	
	If MasochistFlagCount > 0
		ExternalFlags[10] = True
	Else
		ExternalFlags[10] = False
	EndIf
	
	If GentleFlagCount > 0
		ExternalFlags[11] = True
	Else
		ExternalFlags[11] = False
	EndIf
	
	If LikesMenFlagCount > 0
		ExternalFlags[12] = True
	Else
		ExternalFlags[12] = False
	EndIf
	
	If LikesWomenFlagCount > 0
		ExternalFlags[13] = True
	Else
		ExternalFlags[13] = False
	EndIf
	
	If LikesOrcFlagCount > 0
		ExternalFlags[14] = True
	Else
		ExternalFlags[14] = False
	EndIf
	
	If LikesKhajiitFlagCount > 0
		ExternalFlags[15] = True
	Else
		ExternalFlags[15] = False
	EndIf
	
	If LikesArgonianFlagCount > 0
		ExternalFlags[16] = True
	Else
		ExternalFlags[16] = False
	EndIf
	
	If BestialityFlagCount > 0
		ExternalFlags[17] = True
	Else
		ExternalFlags[17] = False
	EndIf
	
	If GroupFlagCount > 0
		ExternalFlags[18] = True
	Else
		ExternalFlags[18] = False
	EndIf
	
	If BoundFlagCount > 0
		ExternalFlags[19] = True
	Else
		ExternalFlags[19] = False
	EndIf
	
	If TattooFlagCount > 0
		ExternalFlags[20] = True
	Else
		ExternalFlags[20] = False
	EndIf
	
	If CumDumpFlagCount > 0
		ExternalFlags[21] = True
	Else
		ExternalFlags[21] = False
	EndIf
		
EndFunction