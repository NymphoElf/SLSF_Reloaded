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

Bool[] Property HasSpreadableFame Auto ;0-20 = Default Locations, 21-41 = Custom Locations

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
Bool[] Property WhoreEventFlags Auto Hidden

Int SpreadableFameCheckDelay = 12

Event OnInit()
	SetDefaults()
EndEvent

Function FameCheck()
	FameOverviewCheck()
	
	SpreadableFameCheckDelay -= 1
	
	If SpreadableFameCheckDelay <= 0
		CheckSpreadableFame()
		SpreadableFameCheckDelay = (Config.SpreadTimeNeeded / 4) as Int
	EndIf
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
	WhoreEventFlags = New Bool[100]
	
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
	Int FameIndex = 0
	Int LocationIndex = 0
	Bool SpreadableFameFound = False
	
	While LocationIndex < HasSpreadableFame.Length
		FameIndex = 0
		While SpreadableFameFound == False && FameIndex < FameManager.FameType.Length
			If LocationIndex == 0 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If WhiterunFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 1 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If WinterholdFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 2 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If WindhelmFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 3 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If SolitudeFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 4 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If RiftenFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 5 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If MarkarthFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 6 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If MorthalFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 7 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If DawnstarFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 8 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If FalkreathFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 9 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If RavenRockFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 10 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If RiverwoodFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 11 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If RoriksteadFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 12 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If IvarsteadFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 13 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If ShorsStoneFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 14 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If DragonBridgeFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 15 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If KarthwastenFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 16 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If SkaalVillageFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 17 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If LargashburFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 18 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If DushnikhYalFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 19 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If MorKhazgurFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 20 && Config.HasFameAtDefaultLocation[LocationIndex] == True && FameManager.DefaultLocationCanSpread[LocationIndex] == True
				If NarzulburFame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 21 && Config.HasFameAtCustomLocation[0] == True && FameManager.CustomLocationCanSpread[0] == True
				If CustomLocation1Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 22 && Config.HasFameAtCustomLocation[1] == True && FameManager.CustomLocationCanSpread[1] == True
				If CustomLocation2Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 23 && Config.HasFameAtCustomLocation[2] == True && FameManager.CustomLocationCanSpread[2] == True
				If CustomLocation3Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 24 && Config.HasFameAtCustomLocation[3] == True && FameManager.CustomLocationCanSpread[3] == True
				If CustomLocation4Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 25 && Config.HasFameAtCustomLocation[4] == True && FameManager.CustomLocationCanSpread[4] == True
				If CustomLocation5Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 26 && Config.HasFameAtCustomLocation[5] == True && FameManager.CustomLocationCanSpread[5] == True
				If CustomLocation6Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 27 && Config.HasFameAtCustomLocation[6] == True && FameManager.CustomLocationCanSpread[6] == True
				If CustomLocation7Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 28 && Config.HasFameAtCustomLocation[7] == True && FameManager.CustomLocationCanSpread[7] == True
				If CustomLocation8Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 29 && Config.HasFameAtCustomLocation[8] == True && FameManager.CustomLocationCanSpread[8] == True
				If CustomLocation9Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 30 && Config.HasFameAtCustomLocation[9] == True && FameManager.CustomLocationCanSpread[9] == True
				If CustomLocation10Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 31 && Config.HasFameAtCustomLocation[10] == True && FameManager.CustomLocationCanSpread[10] == True
				If CustomLocation11Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 32 && Config.HasFameAtCustomLocation[11] == True && FameManager.CustomLocationCanSpread[11] == True
				If CustomLocation12Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 33 && Config.HasFameAtCustomLocation[12] == True && FameManager.CustomLocationCanSpread[12] == True
				If CustomLocation13Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 34 && Config.HasFameAtCustomLocation[13] == True && FameManager.CustomLocationCanSpread[13] == True
				If CustomLocation14Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 35 && Config.HasFameAtCustomLocation[14] == True && FameManager.CustomLocationCanSpread[14] == True
				If CustomLocation15Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 36 && Config.HasFameAtCustomLocation[15] == True && FameManager.CustomLocationCanSpread[15] == True
				If CustomLocation16Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 37 && Config.HasFameAtCustomLocation[16] == True && FameManager.CustomLocationCanSpread[16] == True
				If CustomLocation17Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 38 && Config.HasFameAtCustomLocation[17] == True && FameManager.CustomLocationCanSpread[17] == True
				If CustomLocation18Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 39 && Config.HasFameAtCustomLocation[18] == True && FameManager.CustomLocationCanSpread[18] == True
				If CustomLocation19Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 40 && Config.HasFameAtCustomLocation[19] == True && FameManager.CustomLocationCanSpread[19] == True
				If CustomLocation20Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			ElseIf LocationIndex == 41 && Config.HasFameAtCustomLocation[20] == True && FameManager.CustomLocationCanSpread[20] == True
				If CustomLocation21Fame[FameIndex] >= Config.MinimumFameToSpread
					HasSpreadableFame[LocationIndex] = True
					SpreadableFameFound = True
				EndIf
			EndIf
			
			FameIndex += 1
		EndWhile
		
		If SpreadableFameFound == False
			HasSpreadableFame[LocationIndex] = False
		EndIf
		
		SpreadableFameFound = False
		LocationIndex += 1
	EndWhile
EndFunction

Int Function GetFameValue(String LocationName, String FameCategory)
	Int CustomLocationIndex = 0
	Int FameIndex = FameManager.FameType.Find(FameCategory)
	
	If FameIndex < 0 || FameIndex > FameManager.FameType.Length
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
	ElseIf LocationName == "Windhelm" || LocationName == "Eastmarch"
		WindhelmFame[FameIndex] = FameValue
	ElseIf LocationName == "Winterhold"
		WinterholdFame[FameIndex] = FameValue
	ElseIf LocationName == "Solitude" || LocationName == "Haafingar"
		SolitudeFame[FameIndex] = FameValue
	ElseIf LocationName == "Riften" || LocationName == "the Rift"
		RiftenFame[FameIndex] = FameValue
	ElseIf LocationName == "Markarth" || LocationName == "the Reach"
		MarkarthFame[FameIndex] = FameValue
	ElseIf LocationName == "Morthal" || LocationName == "Hjaalmarch"
		MorthalFame[FameIndex] = FameValue
	ElseIf LocationName == "Dawnstar" || LocationName == "the Pale"
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
	ElseIf LocationName == "Shor's Stone"
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
		ElseIf CustomLocationIndex == 20
			CustomLocation21Fame[FameIndex] = FameValue
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
	
	If ModIndex < 0 || ModIndex > ExternalMods.Length
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
	
	If ModIndex < 0 || ModIndex > ExternalMods.Length
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
		WhoreEventFlags[ModIndex] = False
	EndIf
EndFunction

Bool Function GetModFlagState(String ModName, String FlagName)
	Int ModIndex = ExternalMods.Find(ModName)
	
	If ModIndex < 0 || ModIndex > ExternalMods.Length
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
	
	If ModIndex < 0 || ModIndex > ExternalMods.Length
		return False
	Else
		return True
	EndIf
EndFunction

Function SetExternalFlags(String ModName, String FlagName, Bool FlagValue)
	Int ModIndex = ExternalMods.Find(ModName)
	
	If ModIndex < 0 || ModIndex > ExternalMods.Length
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
	ElseIf FlagName == "Whore Event"
		WhoreEventFlags[ModIndex] = FlagValue
	Else
		Debug.MessageBox("SLSF Reloaded - ERROR: External mod category " + FlagName + " is not valid!")
	EndIf
	
	CheckFlags()
EndFunction

Bool Function CheckWhoreEvent()
	Int WhoreEventIndex = WhoreEventFlags.Find(True)
	
	If WhoreEventIndex < 0
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
	
	If WhoreFlagIndex < 0 || WhoreFlagIndex > 127
		ExternalFlags[0] = False
	Else
		ExternalFlags[0] = True
	EndIf
	
	If SlutFlagIndex < 0 || SlutFlagIndex > 127
		ExternalFlags[1] = False
	Else
		ExternalFlags[1] = True
	EndIf
	
	If ExhibitionistFlagIndex < 0 || ExhibitionistFlagIndex > 127
		ExternalFlags[2] = False
	Else
		ExternalFlags[2] = True
	EndIf
	
	If OralFlagIndex < 0 || OralFlagIndex > 127
		ExternalFlags[3] = False
	Else
		ExternalFlags[3] = True
	EndIf
	
	If AnalFlagIndex < 0 || AnalFlagIndex > 127
		ExternalFlags[4] = False
	Else
		ExternalFlags[4] = True
	EndIf
	
	If NastyFlagIndex < 0 || NastyFlagIndex > 127
		ExternalFlags[5] = False
	Else
		ExternalFlags[5] = True
	EndIf
	
	If PregnantFlagIndex < 0 || PregnantFlagIndex > 127
		ExternalFlags[6] = False
	Else
		ExternalFlags[6] = True
	EndIf
	
	If DominantFlagIndex < 0 || DominantFlagIndex > 127
		ExternalFlags[7] = False
	Else
		ExternalFlags[7] = True
	EndIf
	
	If SubmissiveFlagIndex < 0 || SubmissiveFlagIndex > 127
		ExternalFlags[8] = False
	Else
		ExternalFlags[8] = True
	EndIf
	
	If SadistFlagIndex < 0 || SadistFlagIndex > 127
		ExternalFlags[9] = False
	Else
		ExternalFlags[9] = True
	EndIf
	
	If MasochistFlagIndex < 0 || MasochistFlagIndex > 127
		ExternalFlags[10] = False
	Else
		ExternalFlags[10] = True
	EndIf
	
	If GentleFlagIndex < 0 || GentleFlagIndex > 127
		ExternalFlags[11] = False
	Else
		ExternalFlags[11] = True
	EndIf
	
	If MenFlagIndex < 0 || MenFlagIndex > 127
		ExternalFlags[12] = False
	Else
		ExternalFlags[12] = True
	EndIf
	
	If WomenFlagIndex < 0 || WomenFlagIndex > 127
		ExternalFlags[13] = False
	Else
		ExternalFlags[13] = True
	EndIf
	
	If OrcFlagIndex < 0 || OrcFlagIndex > 127
		ExternalFlags[14] = False
	Else
		ExternalFlags[14] = True
	EndIf
	
	If KhajiitFlagIndex < 0 || KhajiitFlagIndex > 127
		ExternalFlags[15] = False
	Else
		ExternalFlags[15] = True
	EndIf
	
	If ArgonianFlagIndex < 0 || ArgonianFlagIndex > 127
		ExternalFlags[16] = False
	Else
		ExternalFlags[16] = True
	EndIf
	
	If BestialityFlagIndex < 0 || BestialityFlagIndex > 127
		ExternalFlags[17] = False
	Else
		ExternalFlags[17] = True
	EndIf
	
	If GroupFlagIndex < 0 || GroupFlagIndex > 127
		ExternalFlags[18] = False
	Else
		ExternalFlags[18] = True
	EndIf
	
	If BoundFlagIndex < 0 || BoundFlagIndex > 127
		ExternalFlags[19] = False
	Else
		ExternalFlags[19] = True
	EndIf
	
	If TattooFlagIndex < 0 || TattooFlagIndex > 127
		ExternalFlags[20] = False
	Else
		ExternalFlags[20] = True
	EndIf
	
	If CumDumpFlagIndex < 0 || CumDumpFlagIndex > 127
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