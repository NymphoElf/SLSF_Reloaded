ScriptName SLSF_Reloaded_DataManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_MCM Property Config Auto

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

Bool[] Property WhiterunSpreadFlags Auto
Bool[] Property WinterholdSpreadFlags Auto
Bool[] Property WindhelmSpreadFlags Auto
Bool[] Property SolitudeSpreadFlags Auto
Bool[] Property RiftenSpreadFlags Auto
Bool[] Property MarkarthSpreadFlags Auto
Bool[] Property MorthalSpreadFlags Auto
Bool[] Property DawnstarSpreadFlags Auto
Bool[] Property FalkreathSpreadFlags Auto
Bool[] Property RavenRockSpreadFlags Auto
Bool[] Property RiverwoodSpreadFlags Auto
Bool[] Property RoriksteadSpreadFlags Auto
Bool[] Property IvarsteadSpreadFlags Auto
Bool[] Property ShorsStoneSpreadFlags Auto
Bool[] Property DragonBridgeSpreadFlags Auto
Bool[] Property KarthwastenSpreadFlags Auto
Bool[] Property SkaalVillageSpreadFlags Auto
Bool[] Property LargashburSpreadFlags Auto
Bool[] Property DushnikhYalSpreadFlags Auto
Bool[] Property MorKhazgurSpreadFlags Auto
Bool[] Property NarzulburSpreadFlags Auto

Bool[] Property DefaultLocationDynamicAnonymityFlag Auto
Bool[] Property CustomLocationDynamicAnonymityFlag Auto

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
Int[] Property CustomLocation21Fame Auto

Bool[] Property CustomLocation1SpreadFlags Auto
Bool[] Property CustomLocation2SpreadFlags Auto
Bool[] Property CustomLocation3SpreadFlags Auto
Bool[] Property CustomLocation4SpreadFlags Auto
Bool[] Property CustomLocation5SpreadFlags Auto
Bool[] Property CustomLocation6SpreadFlags Auto
Bool[] Property CustomLocation7SpreadFlags Auto
Bool[] Property CustomLocation8SpreadFlags Auto
Bool[] Property CustomLocation9SpreadFlags Auto
Bool[] Property CustomLocation10SpreadFlags Auto
Bool[] Property CustomLocation11SpreadFlags Auto
Bool[] Property CustomLocation12SpreadFlags Auto
Bool[] Property CustomLocation13SpreadFlags Auto
Bool[] Property CustomLocation14SpreadFlags Auto
Bool[] Property CustomLocation15SpreadFlags Auto
Bool[] Property CustomLocation16SpreadFlags Auto
Bool[] Property CustomLocation17SpreadFlags Auto
Bool[] Property CustomLocation18SpreadFlags Auto
Bool[] Property CustomLocation19SpreadFlags Auto
Bool[] Property CustomLocation20SpreadFlags Auto
Bool[] Property CustomLocation21SpreadFlags Auto 

Bool[] Property DefaultLocationHasSpreadableFame Auto
Bool[] Property CustomLocationHasSpreadableFame Auto

Bool[] Property ExternalFlags Auto

String[] Property ExternalMods Auto Hidden

Bool[] Property SlutFlags Auto Hidden
Bool[] Property WhoreFlags Auto Hidden
Bool[] Property ExhibitionistFlags Auto Hidden
Bool[] Property OralFlags Auto Hidden
Bool[] Property AnalFlags Auto Hidden
Bool[] Property NastyFlags Auto Hidden
Bool[] Property PregnantFlags Auto Hidden
Bool[] Property DominantFlags Auto Hidden
Bool[] Property SubmissiveFlags Auto Hidden
Bool[] Property SadistFlags Auto Hidden
Bool[] Property MasochistFlags Auto Hidden
Bool[] Property GentleFlags Auto Hidden
Bool[] Property LikesMenFlags Auto Hidden
Bool[] Property LikesWomenFlags Auto Hidden
Bool[] Property LikesOrcFlags Auto Hidden
Bool[] Property LikesKhajiitFlags Auto Hidden
Bool[] Property LikesArgonianFlags Auto Hidden
Bool[] Property BestialityFlags Auto Hidden
Bool[] Property GroupFlags Auto Hidden
Bool[] Property BoundFlags Auto Hidden
Bool[] Property TattooFlags Auto Hidden
Bool[] Property CumDumpFlags Auto Hidden
Bool[] Property UnfaithfulFlags Auto Hidden
Bool[] Property CuckFlags Auto Hidden
Bool[] Property AirheadFlags Auto Hidden
Bool[] Property SexWorkerFlags Auto Hidden

Event OnInit()
	SetDefaults()
EndEvent

Function FameCheck()
	FameOverviewCheck()
	CheckSpreadableFame()
EndFunction

Function SetDefaults()
	ExternalMods = New String[100]
	SlutFlags = New Bool[100]
	WhoreFlags = New Bool[100]
	ExhibitionistFlags = New Bool[100]
	OralFlags = New Bool[100]
	AnalFlags = New Bool[100]
	NastyFlags = New Bool[100]
	PregnantFlags = New Bool[100]
	DominantFlags = New Bool[100]
	SubmissiveFlags = New Bool[100]
	SadistFlags = New Bool[100]
	MasochistFlags = New Bool[100]
	GentleFlags = New Bool[100]
	LikesMenFlags = New Bool[100]
	LikesWomenFlags = New Bool[100]
	LikesOrcFlags = New Bool[100]
	LikesKhajiitFlags = New Bool[100]
	LikesArgonianFlags = New Bool[100]
	BestialityFlags = New Bool[100]
	GroupFlags = New Bool[100]
	BoundFlags = New Bool[100]
	TattooFlags = New Bool[100]
	CumDumpFlags = New Bool[100]
	UnfaithfulFlags = New Bool[100]
	CuckFlags = New Bool[100]
	AirheadFlags = New Bool[100]
	SexWorkerFlags = New Bool[100]
	
	Int ExternalModIndex = 0
	While ExternalModIndex < ExternalMods.Length
		ExternalMods[ExternalModIndex] = "-EMPTY-"
		ExternalModIndex += 1
	EndWhile
	
	Int LocationIndex = 0
	While LocationIndex < LocationManager.DefaultLocation.Length
		Config.HasFameAtDefaultLocation[LocationIndex] = False
		Config.DefaultLocationSpreadChance[LocationIndex] = 30
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	While LocationIndex < LocationManager.CustomLocation.Length
		Config.HasFameAtCustomLocation[LocationIndex] = False
		Config.CustomLocationSpreadChance[LocationIndex] = 30
		LocationIndex += 1
	EndWhile
	
EndFunction

Function CheckSpreadableFame()
	Int LocationIndex = 0
	Bool SpreadableFameFound = False
	
	While LocationIndex < DefaultLocationHasSpreadableFame.Length
		If LocationIndex == 0 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If WhiterunSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 1 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If WinterholdSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 2 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If WindhelmSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 3 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If SolitudeSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 4 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If RiftenSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 5 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If MarkarthSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 6 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If MorthalSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 7 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If DawnstarSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 8 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If FalkreathSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 9 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If RavenRockSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 10 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If RiverwoodSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 11 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If RoriksteadSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 12 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If IvarsteadSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 13 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If ShorsStoneSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 14 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If DragonBridgeSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 15 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If KarthwastenSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 16 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If SkaalVillageSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 17 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If LargashburSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 18 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If DushnikhYalSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 19 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If MorKhazgurSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 20 && Config.HasFameAtDefaultLocation[LocationIndex] == True
			If NarzulburSpreadFlags.Find(True) >= 0
				DefaultLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		EndIf
		
		If SpreadableFameFound == False
			DefaultLocationHasSpreadableFame[LocationIndex] = False
		EndIf
		
		SpreadableFameFound = False
		LocationIndex += 1
	EndWhile
		
	LocationIndex = 0
	SpreadableFameFound = False
		
	While LocationIndex < CustomLocationHasSpreadableFame.Length
		If LocationIndex == 0 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation1SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 1 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation2SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 2 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation3SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 3 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation4SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 4 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation5SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 5 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation6SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 6 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation7SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 7 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation8SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 8 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation9SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 9 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation10SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 10 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation11SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 11 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation12SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 12 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation13SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 13 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation14SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 14 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation15SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 15 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation16SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 16 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation17SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 17 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation18SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 18 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation19SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 19 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation20SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		ElseIf LocationIndex == 20 && Config.HasFameAtCustomLocation[LocationIndex] == True
			If CustomLocation21SpreadFlags.Find(True) >= 0
				CustomLocationHasSpreadableFame[LocationIndex] = True
				SpreadableFameFound = True
			EndIf
		EndIf
		
		If SpreadableFameFound == False
			CustomLocationHasSpreadableFame[LocationIndex] = False
		EndIf
		
		SpreadableFameFound = False
		LocationIndex += 1
	EndWhile
EndFunction

Int Function GetFameValue(String LocationName, String FameCategory)
	Int CustomLocationIndex = 0
	Int FameIndex = FameManager.FameType.Find(FameCategory)
	
	If FameIndex < 0
		Debug.MessageBox("SLSF Reloaded - Error: Fame Category " + FameCategory + " invalid")
		return 0
	EndIf
	
	If LocationName == "Whiterun"
		return WhiterunFame[FameIndex]
	ElseIf LocationName == "Windhelm" || LocationName == "Eastmarch"
		return WindhelmFame[FameIndex]
	ElseIf LocationName == "Winterhold"
		return WinterholdFame[FameIndex]
	ElseIf LocationName == "Solitude" || LocationName == "Haafingar"
		return SolitudeFame[FameIndex]
	ElseIf LocationName == "Riften" || LocationName == "the Rift"
		return RiftenFame[FameIndex]
	ElseIf LocationName == "Markarth" || LocationName == "the Reach"
		return MarkarthFame[FameIndex]
	ElseIf LocationName == "Morthal" || LocationName == "Hjaalmarch"
		return MorthalFame[FameIndex]
	ElseIf LocationName == "Dawnstar" || LocationName == "the Pale"
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
	ElseIf LocationName == "Shor's Stone"
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
		ElseIf CustomLocationIndex == 20
			return CustomLocation21Fame[FameIndex]
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Fame Value for " + LocationName + " not found!")
		EndIf
	EndIf
	return 0
EndFunction

Function SetFameValue(String LocationName, String FameCategory, Int FameValue)	
	Int CustomLocationIndex = 0
	Int FameIndex = FameManager.FameType.Find(FameCategory)
	If LocationName == "Whiterun"
		WhiterunFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			WhiterunSpreadFlags[FameIndex] = True
		Else
			WhiterunSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[0] = False
		EndIf
	ElseIf LocationName == "Winterhold"
		WinterholdFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			WinterholdSpreadFlags[FameIndex] = True
		Else
			WinterholdSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[1] = False
		EndIf
	ElseIf LocationName == "Windhelm" || LocationName == "Eastmarch"
		WindhelmFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			WindhelmSpreadFlags[FameIndex] = True
		Else
			WindhelmSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[2] = False
		EndIf
	ElseIf LocationName == "Solitude" || LocationName == "Haafingar"
		SolitudeFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			SolitudeSpreadFlags[FameIndex] = True
		Else
			SolitudeSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[3] = False
		EndIf
	ElseIf LocationName == "Riften" || LocationName == "the Rift"
		RiftenFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			RiftenSpreadFlags[FameIndex] = True
		Else
			RiftenSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[4] = False
		EndIf
	ElseIf LocationName == "Markarth" || LocationName == "the Reach"
		MarkarthFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			MarkarthSpreadFlags[FameIndex] = True
		Else
			MarkarthSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[5] = False
		EndIf
	ElseIf LocationName == "Morthal" || LocationName == "Hjaalmarch"
		MorthalFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			MorthalSpreadFlags[FameIndex] = True
		Else
			MorthalSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[6] = False
		EndIf
	ElseIf LocationName == "Dawnstar" || LocationName == "the Pale"
		DawnstarFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			DawnstarSpreadFlags[FameIndex] = True
		Else
			DawnstarSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[7] = False
		EndIf
	ElseIf LocationName == "Falkreath"
		FalkreathFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			FalkreathSpreadFlags[FameIndex] = True
		Else
			FalkreathSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[8] = False
		EndIf
	ElseIf LocationName == "Raven Rock"
		RavenRockFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			RavenRockSpreadFlags[FameIndex] = True
		Else
			RavenRockSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[9] = False
		EndIf
	ElseIf LocationName == "Riverwood"
		RiverwoodFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			RiverwoodSpreadFlags[FameIndex] = True
		Else
			RiverwoodSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[10] = False
		EndIf
	ElseIf LocationName == "Rorikstead"
		RoriksteadFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			RoriksteadSpreadFlags[FameIndex] = True
		Else
			RoriksteadSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[11] = False
		EndIf
	ElseIf LocationName == "Ivarstead"
		IvarsteadFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			IvarsteadSpreadFlags[FameIndex] = True
		Else
			IvarsteadSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[12] = False
		EndIf
	ElseIf LocationName == "Shor's Stone"
		ShorsStoneFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			ShorsStoneSpreadFlags[FameIndex] = True
		Else
			ShorsStoneSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[13] = False
		EndIf
	ElseIf LocationName == "Dragon Bridge"
		DragonBridgeFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			DragonBridgeSpreadFlags[FameIndex] = True
		Else
			DragonBridgeSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[14] = False
		EndIf
	ElseIf LocationName == "Karthwasten"
		KarthwastenFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			KarthwastenSpreadFlags[FameIndex] = True
		Else
			KarthwastenSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[15] = False
		EndIf
	ElseIf LocationName == "Skaal Village"
		SkaalVillageFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			SkaalVillageSpreadFlags[FameIndex] = True
		Else
			SkaalVillageSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[16] = False
		EndIf
	ElseIf LocationName == "Largashbur"
		LargashburFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			LargashburSpreadFlags[FameIndex] = True
		Else
			LargashburSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[17] = False
		EndIf
	ElseIf LocationName == "Dushnikh Yal"
		DushnikhYalFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			DushnikhYalSpreadFlags[FameIndex] = True
		Else
			DushnikhYalSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[18] = False
		EndIf
	ElseIf LocationName == "Mor Khazgur"
		MorKhazgurFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			MorKhazgurSpreadFlags[FameIndex] = True
		Else
			MorKhazgurSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[19] = False
		EndIf
	ElseIf LocationName == "Narzulbur"
		NarzulburFame[FameIndex] = FameValue
		If FameValue >= Config.MinimumFameToSpread
			NarzulburSpreadFlags[FameIndex] = True
		Else
			NarzulburSpreadFlags[FameIndex] = False
		EndIf
		
		If FameValue >= Config.DynamicAnonymityFameCutoff
			DefaultLocationDynamicAnonymityFlag[20] = False
		EndIf
	Else
		CustomLocationIndex = LocationManager.CustomLocation.Find(LocationName)
		If CustomLocationIndex == 0
			CustomLocation1Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation1SpreadFlags[FameIndex] = True
			Else
				CustomLocation1SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[0] = False
			EndIf
		ElseIf CustomLocationIndex == 1
			CustomLocation2Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation2SpreadFlags[FameIndex] = True
			Else
				CustomLocation2SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[1] = False
			EndIf
		ElseIf CustomLocationIndex == 2
			CustomLocation3Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation3SpreadFlags[FameIndex] = True
			Else
				CustomLocation3SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[2] = False
			EndIf
		ElseIf CustomLocationIndex == 3
			CustomLocation4Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation4SpreadFlags[FameIndex] = True
			Else
				CustomLocation4SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[3] = False
			EndIf
		ElseIf CustomLocationIndex == 4
			CustomLocation5Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation5SpreadFlags[FameIndex] = True
			Else
				CustomLocation5SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[4] = False
			EndIf
		ElseIf CustomLocationIndex == 5
			CustomLocation6Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation6SpreadFlags[FameIndex] = True
			Else
				CustomLocation6SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[5] = False
			EndIf
		ElseIf CustomLocationIndex == 6
			CustomLocation7Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation7SpreadFlags[FameIndex] = True
			Else
				CustomLocation7SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[6] = False
			EndIf
		ElseIf CustomLocationIndex == 7
			CustomLocation8Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation8SpreadFlags[FameIndex] = True
			Else
				CustomLocation8SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[7] = False
			EndIf
		ElseIf CustomLocationIndex == 8
			CustomLocation9Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation9SpreadFlags[FameIndex] = True
			Else
				CustomLocation9SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[8] = False
			EndIf
		ElseIf CustomLocationIndex == 9
			CustomLocation10Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation10SpreadFlags[FameIndex] = True
			Else
				CustomLocation10SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[9] = False
			EndIf
		ElseIf CustomLocationIndex == 10
			CustomLocation11Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation11SpreadFlags[FameIndex] = True
			Else
				CustomLocation11SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[10] = False
			EndIf
		ElseIf CustomLocationIndex == 11
			CustomLocation12Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation12SpreadFlags[FameIndex] = True
			Else
				CustomLocation12SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[11] = False
			EndIf
		ElseIf CustomLocationIndex == 12
			CustomLocation13Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation13SpreadFlags[FameIndex] = True
			Else
				CustomLocation13SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[12] = False
			EndIf
		ElseIf CustomLocationIndex == 13
			CustomLocation14Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation14SpreadFlags[FameIndex] = True
			Else
				CustomLocation14SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[13] = False
			EndIf
		ElseIf CustomLocationIndex == 14
			CustomLocation15Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation15SpreadFlags[FameIndex] = True
			Else
				CustomLocation15SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[14] = False
			EndIf
		ElseIf CustomLocationIndex == 15
			CustomLocation16Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation16SpreadFlags[FameIndex] = True
			Else
				CustomLocation16SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[15] = False
			EndIf
		ElseIf CustomLocationIndex == 16
			CustomLocation17Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation17SpreadFlags[FameIndex] = True
			Else
				CustomLocation17SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[16] = False
			EndIf
		ElseIf CustomLocationIndex == 17
			CustomLocation18Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation18SpreadFlags[FameIndex] = True
			Else
				CustomLocation18SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[17] = False
			EndIf
		ElseIf CustomLocationIndex == 18
			CustomLocation19Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation19SpreadFlags[FameIndex] = True
			Else
				CustomLocation19SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[18] = False
			EndIf
		ElseIf CustomLocationIndex == 19
			CustomLocation20Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation20SpreadFlags[FameIndex] = True
			Else
				CustomLocation20SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[19] = False
			EndIf
		ElseIf CustomLocationIndex == 20
			CustomLocation21Fame[FameIndex] = FameValue
			If FameValue >= Config.MinimumFameToSpread
				CustomLocation21SpreadFlags[FameIndex] = True
			Else
				CustomLocation21SpreadFlags[FameIndex] = False
			EndIf
			
			If FameValue >= Config.DynamicAnonymityFameCutoff
				CustomLocationDynamicAnonymityFlag[20] = False
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Could not set Fame Value for " + LocationName + "!")
			return
		EndIf
	EndIf
EndFunction

Function DecayDynamicAnonymityCheck(Int LocationIndex, Bool IsDefaultLocation)
	Int FameIndex = 0
	Bool CanBeAnonymous = True
	
	If IsDefaultLocation == True
		If LocationIndex == 0 ;Whiterun
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If WhiterunFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 1
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If WinterholdFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 2
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If WindhelmFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 3
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If SolitudeFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 4
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If RiftenFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 5
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If MarkarthFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 6
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If MorthalFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 7
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If DawnstarFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 8
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If FalkreathFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 9
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If RavenRockFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 10
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If RiverwoodFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 11
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If RoriksteadFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 12
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If IvarsteadFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 13
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If ShorsStoneFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 14
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If DragonBridgeFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 15
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If KarthwastenFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 16
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If SkaalVillageFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 17
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If LargashburFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 18
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If DushnikhYalFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 19
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If MorKhazgurFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 20
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If NarzulburFame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			DefaultLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		EndIf
	Else
		If LocationIndex == 0
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation1Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 1
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation2Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 2
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation3Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 3
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation4Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 4
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation5Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 5
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation6Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 6
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation7Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 7
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation8Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 8
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation9Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 9
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation10Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 10
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation11Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 11
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation12Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 12
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation13Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 13
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation14Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 14
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation15Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 15
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation16Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 16
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation17Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 17
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation18Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 18
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation19Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 19
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation20Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
		ElseIf LocationIndex == 20
			While FameIndex < FameManager.FameType.Length && CanBeAnonymous == True
				If CustomLocation21Fame[FameIndex] >= Config.DynamicAnonymityFameCutoff
					CanBeAnonymous = False
				EndIf
				FameIndex += 1
			EndWhile
			
			CustomLocationDynamicAnonymityFlag[LocationIndex] = CanBeAnonymous
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
	ElseIf FlagName == "Unfaithful"
		return ExternalFlags[22]
	ElseIf FlagName == "Cuck"
		return ExternalFlags[23]
	ElseIf FlagName == "Airhead"
		return ExternalFlags[24]
	Else
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded Get External Flags: Flag Name " + FlagName + " not found.")
		EndIf
		return False
	EndIf
EndFunction

Function RegisterExternalMod(String ModName)
	Int ModIndex = ExternalMods.Find(ModName)
	Int EmptyModIndex = ExternalMods.Find("-EMPTY-")
	Bool PluginFound = False
	
	If Game.GetModByName(ModName) != 255
		PluginFound = True
	EndIf
	
	If PluginFound == False
		Debug.MessageBox("SLSF Reloaded External Mod Register Error: Plugin " + ModName + " not found. Mod not registered!")
		return
	EndIf
	
	If ModIndex < 0
		If EmptyModIndex >= 0
			ExternalMods[EmptyModIndex] = ModName
		Else
			If Config.EnableTracing == True
				Debug.Trace("Cannot Add " + ModName + " to External Mod List. External Mod List full.")
			EndIf
			return
		EndIf
	Else
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded External Mod Register: Mod " + ModName + " already registered. Skipping register function...")
		EndIf
	EndIf
EndFunction

Int Function CountExternalMods()
	Int ModCount = 0
	Int ModIndex = 0
	
	While ModIndex < ExternalMods.Length
		If ExternalMods[ModIndex] != "-EMPTY-"
			ModCount += 1
		EndIf
		ModIndex += 1
	EndWhile
	
	return ModCount
EndFunction

Function CleanExternalModList()
	Int ModIndex = 0
	Bool ModFound = False
	
	While ModIndex < ExternalMods.Length
		If ExternalMods[ModIndex] != "-EMPTY-"
			If Game.GetModByName(ExternalMods[ModIndex]) != 255
				ModFound = True
			EndIf
			
			If ModFound == False
				UnregisterExternalMod(ExternalMods[ModIndex])
			EndIf
		EndIf
		ModIndex += 1
	EndWhile
EndFunction

Function UnregisterExternalMod(String ModName)
	Int ModIndex = ExternalMods.Find(ModName)
	
	If ModIndex < 0
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded External Mod Unregister Error: Mod " + ModName + " not found in External Mod List. Mod unregister skipped...")
		EndIf
		return
	Else
		ExternalMods[ModIndex] = "-EMPTY-"
		WhoreFlags[ModIndex] = False
		SlutFlags[ModIndex] = False
		ExhibitionistFlags[ModIndex] = False
		OralFlags[ModIndex] = False
		AnalFlags[ModIndex] = False
		NastyFlags[ModIndex] = False
		PregnantFlags[ModIndex] = False
		DominantFlags[ModIndex] = False
		SubmissiveFlags[ModIndex] = False
		SadistFlags[ModIndex] = False
		MasochistFlags[ModIndex] = False
		GentleFlags[ModIndex] = False
		LikesMenFlags[ModIndex] = False
		LikesWomenFlags[ModIndex] = False
		LikesOrcFlags[ModIndex] = False
		LikesKhajiitFlags[ModIndex] = False
		LikesArgonianFlags[ModIndex] = False
		BestialityFlags[ModIndex] = False
		GroupFlags[ModIndex] = False
		BoundFlags[ModIndex] = False
		TattooFlags[ModIndex] = False
		CumDumpFlags[ModIndex] = False
		UnfaithfulFlags[ModIndex] = False
		CuckFlags[ModIndex] = False
		AirheadFlags[ModIndex] = False
		;WhoreEventFlags[ModIndex] = False
		SexWorkerFlags[ModIndex] = False
	EndIf
EndFunction

Bool Function GetModFlagState(String ModName, String FlagName)
	Int ModIndex = ExternalMods.Find(ModName)
	
	If ModIndex < 0
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded Get Mod Flag State: Mod " + ModName + " not found.")
		EndIf
		return False
	EndIf
	
	If FlagName == "Whore"
		return WhoreFlags[ModIndex]
	ElseIf FlagName == "Slut"
		return SlutFlags[ModIndex]
	ElseIf FlagName == "Exhibitionist"
		return ExhibitionistFlags[ModIndex]
	ElseIf FlagName == "Oral"
		return OralFlags[ModIndex]
	ElseIf FlagName == "Anal"
		return AnalFlags[ModIndex]
	ElseIf FlagName == "Nasty"
		return NastyFlags[ModIndex]
	ElseIf FlagName == "Pregnant"
		return PregnantFlags[ModIndex]
	ElseIf FlagName == "Dominant"
		return DominantFlags[ModIndex]
	ElseIf FlagName == "Submissive"
		return SubmissiveFlags[ModIndex]
	ElseIf FlagName == "Sadist"
		return SadistFlags[ModIndex]
	ElseIf FlagName == "Masochist"
		return MasochistFlags[ModIndex]
	ElseIf FlagName == "Gentle"
		return GentleFlags[ModIndex]
	ElseIf FlagName == "Likes Men"
		return LikesMenFlags[ModIndex]
	ElseIf FlagName == "Likes Women"
		return LikesWomenFlags[ModIndex]
	ElseIf FlagName == "Likes Orc"
		return LikesOrcFlags[ModIndex]
	ElseIf FlagName == "Likes Khajiit"
		return LikesKhajiitFlags[ModIndex]
	ElseIf FlagName == "Likes Argonian"
		return LikesArgonianFlags[ModIndex]
	ElseIf FlagName == "Bestiality"
		return BestialityFlags[ModIndex]
	ElseIf FlagName == "Group"
		return GroupFlags[ModIndex]
	ElseIf FlagName == "Bound"
		return BoundFlags[ModIndex]
	ElseIf FlagName == "Tattoo"
		return TattooFlags[ModIndex]
	ElseIf FlagName == "Cum Dump"
		return CumDumpFlags[ModIndex]
	ElseIf FlagName == "Unfaithful"
		return UnfaithfulFlags[ModIndex]
	ElseIf FlagName == "Cuck"
		return CuckFlags[ModIndex]
	ElseIf FlagName == "Airhead"
		return AirheadFlags[ModIndex]
	ElseIf FlagName == "Whore Event" || FlagName == "Sex Worker"
		return SexWorkerFlags[ModIndex]
	Else
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded Get Mod Flag State: Flag Name " + FlagName + " not found.")
		EndIf
		return False
	EndIf
EndFunction

String Function DoesFlagExist(String FlagName)
	If FlagName == "Whore"
		return "Yes"
	ElseIf FlagName == "Slut"
		return "Yes"
	ElseIf FlagName == "Exhibitionist"
		return "Yes"
	ElseIf FlagName == "Oral"
		return "Yes"
	ElseIf FlagName == "Anal"
		return "Yes"
	ElseIf FlagName == "Nasty"
		return "Yes"
	ElseIf FlagName == "Pregnant"
		return "Yes"
	ElseIf FlagName == "Dominant"
		return "Yes"
	ElseIf FlagName == "Submissive"
		return "Yes"
	ElseIf FlagName == "Sadist"
		return "Yes"
	ElseIf FlagName == "Masochist"
		return "Yes"
	ElseIf FlagName == "Gentle"
		return "Yes"
	ElseIf FlagName == "Likes Men"
		return "Yes"
	ElseIf FlagName == "Likes Women"
		return "Yes"
	ElseIf FlagName == "Likes Orc"
		return "Yes"
	ElseIf FlagName == "Likes Khajiit"
		return "Yes"
	ElseIf FlagName == "Likes Argonian"
		return "Yes"
	ElseIf FlagName == "Bestiality"
		return "Yes"
	ElseIf FlagName == "Group"
		return "Yes"
	ElseIf FlagName == "Bound"
		return "Yes"
	ElseIf FlagName == "Tattoo"
		return "Yes"
	ElseIf FlagName == "Cum Dump"
		return "Yes"
	ElseIf FlagName == "Unfaithful"
		return "Yes"
	ElseIf FlagName == "Cuck"
		return "Yes"
	ElseIf FlagName == "Airhead"
		return "Yes"
	Else
		return "No"
	EndIf
EndFunction

Bool Function IsModRegistered(String ModName)
	Int ModIndex = ExternalMods.Find(ModName)
	
	If ModIndex < 0
		return False
	Else
		return True
	EndIf
EndFunction

Function SetExternalFlags(String ModName, String FlagName, Bool FlagValue)
	Int ModIndex = ExternalMods.Find(ModName)
	
	If ModIndex < 0
		Debug.MessageBox("SLSF Reloaded External Flags Error: Cannot Set " + FlagName + " for " + ModName + ". " + ModName + " is not Registered with SLSF Reloaded.")
		return
	EndIf
	
	If FlagName == "Whore"
		WhoreFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Slut"
		SlutFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Exhibitionist"
		ExhibitionistFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Oral"
		OralFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Anal"
		AnalFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Nasty"
		NastyFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Pregnant"
		PregnantFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Dominant"
		DominantFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Submissive"
		SubmissiveFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Sadist"
		SadistFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Masochist"
		MasochistFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Gentle"
		GentleFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Likes Men"
		LikesMenFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Likes Women"
		LikesWomenFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Likes Orc"
		LikesOrcFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Likes Khajiit"
		LikesKhajiitFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Likes Argonian"
		LikesArgonianFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Bestiality"
		BestialityFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Group"
		GroupFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Bound"
		BoundFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Tattoo"
		TattooFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Cum Dump"
		CumDumpFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Unfaithful"
		UnfaithfulFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Cuck"
		CuckFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Airhead"
		AirheadFlags[ModIndex] = FlagValue
	ElseIf FlagName == "Sex Worker"
		SexWorkerFlags[ModIndex] = FlagValue
	Else
		Debug.MessageBox("SLSF Reloaded - ERROR: External mod category " + FlagName + " is not valid!")
	EndIf
	
	CheckFlags()
EndFunction

Bool Function CheckSexWorker()
	Int SexWorkerIndex = SexWorkerFlags.Find(True)
	
	If SexWorkerIndex < 0
		return False
	EndIf
	
	return True
EndFunction

Function CheckFlags()
	Int WhoreFlagIndex = WhoreFlags.Find(True)
	Int SlutFlagIndex = SlutFlags.Find(True)
	Int ExhibitionistFlagIndex = ExhibitionistFlags.Find(True)
	Int OralFlagIndex = OralFlags.Find(True)
	Int AnalFlagIndex = AnalFlags.Find(True)
	Int NastyFlagIndex = NastyFlags.Find(True)
	Int PregnantFlagIndex = PregnantFlags.Find(True)
	Int DominantFlagIndex = DominantFlags.Find(True)
	Int SubmissiveFlagIndex = SubmissiveFlags.Find(True)
	Int SadistFlagIndex = SadistFlags.Find(True)
	Int MasochistFlagIndex = MasochistFlags.Find(True)
	Int GentleFlagIndex = GentleFlags.Find(True)
	Int MenFlagIndex = LikesMenFlags.Find(True)
	Int WomenFlagIndex = LikesWomenFlags.Find(True)
	Int OrcFlagIndex = LikesOrcFlags.Find(True)
	Int KhajiitFlagIndex = LikesKhajiitFlags.Find(True)
	Int ArgonianFlagIndex = LikesArgonianFlags.Find(True)
	Int BestialityFlagIndex = BestialityFlags.Find(True)
	Int GroupFlagIndex = GroupFlags.Find(True)
	Int BoundFlagIndex = BoundFlags.Find(True)
	Int TattooFlagIndex = TattooFlags.Find(True)
	Int CumDumpFlagIndex = CumDumpFlags.Find(True)
	Int UnfaithfulFlagIndex = UnfaithfulFlags.Find(True)
	Int CuckFlagIndex = CuckFlags.Find(True)
	Int AirheadFlagIndex = AirheadFlags.Find(True)
	
	If WhoreFlagIndex < 0
		ExternalFlags[0] = False
	Else
		ExternalFlags[0] = True
	EndIf
	
	If SlutFlagIndex < 0
		ExternalFlags[1] = False
	Else
		ExternalFlags[1] = True
	EndIf
	
	If ExhibitionistFlagIndex < 0
		ExternalFlags[2] = False
	Else
		ExternalFlags[2] = True
	EndIf
	
	If OralFlagIndex < 0
		ExternalFlags[3] = False
	Else
		ExternalFlags[3] = True
	EndIf
	
	If AnalFlagIndex < 0
		ExternalFlags[4] = False
	Else
		ExternalFlags[4] = True
	EndIf
	
	If NastyFlagIndex < 0
		ExternalFlags[5] = False
	Else
		ExternalFlags[5] = True
	EndIf
	
	If PregnantFlagIndex < 0
		ExternalFlags[6] = False
	Else
		ExternalFlags[6] = True
	EndIf
	
	If DominantFlagIndex < 0
		ExternalFlags[7] = False
	Else
		ExternalFlags[7] = True
	EndIf
	
	If SubmissiveFlagIndex < 0
		ExternalFlags[8] = False
	Else
		ExternalFlags[8] = True
	EndIf
	
	If SadistFlagIndex < 0
		ExternalFlags[9] = False
	Else
		ExternalFlags[9] = True
	EndIf
	
	If MasochistFlagIndex < 0
		ExternalFlags[10] = False
	Else
		ExternalFlags[10] = True
	EndIf
	
	If GentleFlagIndex < 0
		ExternalFlags[11] = False
	Else
		ExternalFlags[11] = True
	EndIf
	
	If MenFlagIndex < 0
		ExternalFlags[12] = False
	Else
		ExternalFlags[12] = True
	EndIf
	
	If WomenFlagIndex < 0
		ExternalFlags[13] = False
	Else
		ExternalFlags[13] = True
	EndIf
	
	If OrcFlagIndex < 0
		ExternalFlags[14] = False
	Else
		ExternalFlags[14] = True
	EndIf
	
	If KhajiitFlagIndex < 0
		ExternalFlags[15] = False
	Else
		ExternalFlags[15] = True
	EndIf
	
	If ArgonianFlagIndex < 0
		ExternalFlags[16] = False
	Else
		ExternalFlags[16] = True
	EndIf
	
	If BestialityFlagIndex < 0
		ExternalFlags[17] = False
	Else
		ExternalFlags[17] = True
	EndIf
	
	If GroupFlagIndex < 0
		ExternalFlags[18] = False
	Else
		ExternalFlags[18] = True
	EndIf
	
	If BoundFlagIndex < 0
		ExternalFlags[19] = False
	Else
		ExternalFlags[19] = True
	EndIf
	
	If TattooFlagIndex < 0
		ExternalFlags[20] = False
	Else
		ExternalFlags[20] = True
	EndIf
	
	If CumDumpFlagIndex < 0
		ExternalFlags[21] = False
	Else
		ExternalFlags[21] = True
	EndIf
	
	If UnfaithfulFlagIndex < 0
		ExternalFlags[22] = False
	Else
		ExternalFlags[22] = True
	EndIf
	
	If CuckFlagIndex < 0
		ExternalFlags[23] = False
	Else
		ExternalFlags[23] = True
	EndIf
	
	If AirheadFlagIndex < 0
		ExternalFlags[24] = False
	Else
		ExternalFlags[24] = True
	EndIf
EndFunction

Function FameOverviewCheck()
	Int LocationIndex = 0
	Int TypeIndex = 0
	Bool HasFameInLocation = False
	While LocationIndex < LocationManager.DefaultLocation.Length
		If Config.EnableTracing == True
			Debug.Trace("FameOverviewCheck - Location: " + LocationManager.DefaultLocation[LocationIndex])
		EndIf
		While TypeIndex < FameManager.FameType.Length && HasFameInLocation == False
			If Config.EnableTracing == True
				Debug.Trace("FameOverviewCheck - Fame Type: " + FameManager.FameType[TypeIndex])
			EndIf
			If GetFameValue(LocationManager.DefaultLocation[LocationIndex], FameManager.FameType[TypeIndex]) > 0
				HasFameInLocation = True
				Config.HasFameAtDefaultLocation[LocationIndex] = True
			EndIf
			TypeIndex += 1
		EndWhile
		
		If HasFameInLocation == False
			Config.HasFameAtDefaultLocation[LocationIndex] = False
		EndIf
		
		HasFameInLocation = False
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
	
	LocationIndex = 0
	TypeIndex = 0
	HasFameInLocation = False
	
	While LocationIndex < LocationManager.CustomLocation.Length
		If Config.EnableTracing == True
			Debug.Trace("FameOverviewCheck - Location: " + LocationManager.CustomLocation[LocationIndex])
		EndIf
		
		While TypeIndex < FameManager.FameType.Length && HasFameInLocation == False
			If Config.EnableTracing == True
				Debug.Trace("FameOverviewCheck - Fame Type: " + FameManager.FameType[TypeIndex])
			EndIf
			If GetFameValue(LocationManager.CustomLocation[LocationIndex], FameManager.FameType[TypeIndex]) > 0
				HasFameInLocation = True
				Config.HasFameAtCustomLocation[LocationIndex] = True
			EndIf
			TypeIndex += 1
		EndWhile
		
		If HasFameInLocation == False
			Config.HasFameAtCustomLocation[LocationIndex] = False
		EndIf
		
		HasFameInLocation = False
		TypeIndex = 0
		LocationIndex += 1
	EndWhile
EndFunction