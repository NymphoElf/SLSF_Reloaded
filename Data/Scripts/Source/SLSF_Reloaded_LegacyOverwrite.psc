ScriptName SLSF_Reloaded_LegacyOverwrite extends Quest

SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_ModIntegration Property Mods Auto

Function OverwriteLegacyFame()
	Mods.OverwriteLegacyConfig()
	
	Int LocationIndex = 0 ;The Location Index from Legacy SLSF
	Int FameValue = 0 ;What we will set Legacy SLSF's Fame to
	Int FameIndex = 0 ;The Fame Index from Legacy SLSF
	String LocationName = "-EMPTY-" ;The Location Name for SLSF Reloaded
	String FameType = "-EMPTY-" ;The Fame Category for SLSF Reloaded
	String LegacyString = "-EMPTY-" ;The Storage Util string we need to set for overwriting Legacy SLSF
	
	While LocationIndex < 24
		If LocationIndex == 0
			LocationName = "Dawnstar"
		ElseIf LocationIndex == 1
			LocationName = "Falkreath"
		ElseIf LocationIndex == 2
			LocationName = "Markarth"
		ElseIf LocationIndex == 3
			LocationName = "Morthal"
		ElseIf LocationIndex == 4
			LocationName = "Riften"
		ElseIf LocationIndex == 5
			LocationName = "Solitude"
		ElseIf LocationIndex == 6
			LocationName = "Whiterun"
		ElseIf LocationIndex == 7
			LocationName = "Windhelm"
		ElseIf LocationIndex == 8
			LocationName = "Winterhold"
		ElseIf LocationIndex == 9
			LocationName = "Dragon Bridge"
		ElseIf LocationIndex == 10
			LocationName = "Ivarstead"
		ElseIf LocationIndex == 11
			LocationName = "Karthwasten"
		ElseIf LocationIndex == 12
			LocationName = "Riverwood"
		ElseIf LocationIndex == 13
			LocationName = "Rorikstead"
		ElseIf LocationIndex == 14
			LocationName = "Shor's Stone"
		ElseIf LocationIndex == 15
			;Winterhold College isn't used by SLSF Reloaded
		ElseIf LocationIndex == 16
			LocationName = "Dushnikh Yal"
		ElseIf LocationIndex == 17
			LocationName = "Largashbur"
		ElseIf LocationIndex == 18
			LocationName = "Mor Khazgur"
		ElseIf LocationIndex == 19
			LocationName = "Narzulbur"
		ElseIf LocationIndex == 22
			LocationName = "Skaal Village"
		ElseIf LocationIndex == 23
			LocationName = "Raven Rock"
		EndIf
		
		While FameIndex < 20
			If FameIndex == 0
				FameType = "Anal"
				LegacyString = "SLSF.LocationsFame.PC.Anal"
			ElseIf FameIndex == 1
				FameType = "Likes Argonian"
				LegacyString = "SLSF.LocationsFame.PC.Argonian"
			ElseIf FameIndex == 2
				FameType = "Bestiality"
				LegacyString = "SLSF.LocationsFame.PC.Beastiality"
			ElseIf FameIndex == 3
				FameType = "Dominant"
				LegacyString = "SLSF.LocationsFame.PC.Dominant/Master"
			ElseIf FameIndex == 4
				FameType = "Exhibitionist"
				LegacyString = "SLSF.LocationsFame.PC.Exhibitionist/Exposed"
			ElseIf FameIndex == 5
				FameType = "Gentle"
				LegacyString = "SLSF.LocationsFame.PC.GentleLover"
			ElseIf FameIndex == 6
				FameType = "Group"
				LegacyString = "SLSF.LocationsFame.PC.Group"
			ElseIf FameIndex == 7
				FameType = "Likes Khajiit"
				LegacyString = "SLSF.LocationsFame.PC.Khajiit"
			ElseIf FameIndex == 8
				FameType = "Likes Men"
				LegacyString = "SLSF.LocationsFame.PC.LikeMan"
			ElseIf FameIndex == 9
				FameType = "Likes Women"
				LegacyString = "SLSF.LocationsFame.PC.LikeWoman"
			ElseIf FameIndex == 10
				FameType = "Masochist"
				LegacyString = "SLSF.LocationsFame.PC.Masochist"
			ElseIf FameIndex == 11
				FameType = "Nasty"
				LegacyString = "SLSF.LocationsFame.PC.Nasty"
			ElseIf FameIndex == 12
				FameType = "Oral"
				LegacyString = "SLSF.LocationsFame.PC.Oral"
			ElseIf FameIndex == 13
				FameType = "Likes Orc"
				LegacyString = "SLSF.LocationsFame.PC.Orc"
			ElseIf FameIndex == 14
				FameType = "Pregnant"
				LegacyString = "SLSF.LocationsFame.PC.Pregnant"
			ElseIf FameIndex == 15
				FameType = "Sadist"
				LegacyString = "SLSF.LocationsFame.PC.Sadic"
			ElseIf FameIndex == 16
				;Skooma Fame is removed in SLSF Reloaded
				LegacyString = "SLSF.LocationsFame.PC.SkoomaUser"
			ElseIf FameIndex == 17
				FameType = "Slut"
				LegacyString = "SLSF.LocationsFame.PC.Slut"
			ElseIf FameIndex == 18
				FameType = "Submissive"
				LegacyString = "SLSF.LocationsFame.PC.Submissive/Slave"
			ElseIf FameIndex == 19
				FameType = "Whore"
				LegacyString = "SLSF.LocationsFame.PC.Whore"
			EndIf
			
			If LocationIndex == 21 || LocationIndex == 20 || LocationIndex == 15 || FameIndex == 16
				FameValue = 0
			Else
				FameValue = Data.GetFameValue(LocationName, FameType)
			EndIf
			
			StorageUtil.IntListSet(None, LegacyString, LocationIndex, FameValue)
			
			FameIndex += 1
		EndWhile
		FameIndex = 0
		LocationIndex += 1
	EndWhile
EndFunction