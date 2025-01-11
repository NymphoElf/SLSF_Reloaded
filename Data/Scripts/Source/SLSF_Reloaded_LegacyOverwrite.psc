ScriptName SLSF_Reloaded_LegacyOverwrite extends Quest

SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto

Function OverwriteLegacyFame()
	Bool ResetLegacyWarningDisplayed = False
	
	Mods.OverwriteLegacyConfig()
	
	Int LocationIndex = 0 ;The Location Index from Legacy SLSF
	Int FameValue = 0 ;What we will set Legacy SLSF's Fame to
	Int FameIndex = 0 ;The Fame Index from Legacy SLSF
	String LocationName = "-EMPTY-" ;The Location Name for SLSF Reloaded
	String FameType = "-EMPTY-" ;The Fame Category for SLSF Reloaded
	String LegacyString = "-EMPTY-" ;The Storage Util string we need to set for overwriting Legacy SLSF
	
	String PlayerLocation = LocationManager.CurrentLocationName()
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Legacy Overwrite: Grabbed Player Location is " + PlayerLocation)
	EndIf
	If	PlayerLocation == "Haafingar"
		PlayerLocation = "Solitude"
	ElseIf PlayerLocation == "Eastmarch"
		PlayerLocation = "Windhelm"
	ElseIf PlayerLocation == "the Pale"
		PlayerLocation = "Dawnstar"
	ElseIf PlayerLocation == "the Reach"
		PlayerLocation = "Markarth"
	ElseIf PlayerLocation == "the Rift"
		PlayerLocation = "Riften"
	EndIf
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded - Legacy Overwrite: Converted Player Location is " + PlayerLocation)
	EndIf
	
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
			
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Legacy Overwrite: Fame Type = " + FameType)
			EndIf
			
			If LocationIndex == 21 || LocationIndex == 20 || LocationIndex == 15 || FameIndex == 16
				FameValue = 0
				If Config.EnableTracing == True
					If FameIndex == 16
						Debug.Trace("SLSF Reloaded - Legacy Overwrite: Unused Legacy Fame (Skooma). Returning Fame Value of 0.")
					Else
						Debug.Trace("SLSF Reloaded - Legacy Overwrite: Unused Legacy Location. Returning Fame Value of 0.")
					EndIf
				EndIf
			Else
				FameValue = Data.GetFameValue(LocationName, FameType)
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded - Legacy Overwrite: Location = " + LocationName)
					Debug.Trace("SLSF Reloaded - Legacy Overwrite: Grabbed Fame Value = " + FameValue)
				EndIf
			EndIf
			
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Legacy Overwrite: IntListSet: Legacy String = " + LegacyString)
				Debug.Trace("SLSF Reloaded - Legacy Overwrite: IntListSet: LocationIndex = " + LocationIndex + " (Location Name Comparison = " + LocationName +")")
				Debug.Trace("SLSF Reloaded - Legacy Overwrite: IntListSet: Fame Value = " + FameValue)
			EndIf
			StorageUtil.IntListSet(None, LegacyString, LocationIndex, FameValue)
			
			Int DebugInt = StorageUtil.IntListGet(None, LegacyString, LocationIndex)
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded - Legacy Overwrite: Debug Int List: Returned Value of Set Int = " + DebugInt)
			EndIf
			
			If FameValue > 0 && DebugInt == 0 && ResetLegacyWarningDisplayed == False
				Debug.MessageBox("SLSF Reloaded WARNING: Your Fame did not properly overwrite. You must reset Legacy SLSF Papyrus Storage. Legacy Overwrite will not work until you do!")
				Utility.Wait(0.5)
				Debug.MessageBox("SLSF Reloaded MESSAGE: Reset Legacy SLSF Papyrus Storage in Legacy SLSF's MCM, then Save and Quit to Desktop. Then load your game.")
				ResetLegacyWarningDisplayed = True
			EndIf
			
			If LocationName == PlayerLocation
				If FameType == "Anal"
					Mods.SLSF_CurrentFamePCLocation_Anal.SetValue(FameValue)
				ElseIf FameType == "Likes Argonian"
					Mods.SLSF_CurrentFamePCLocation_Argonian.SetValue(FameValue)
				ElseIf FameType == "Bestiality"
					Mods.SLSF_CurrentFamePCLocation_Beast.SetValue(FameValue)
				ElseIf FameType == "Dominant"
					Mods.SLSF_CurrentFamePCLocation_Dom_Mas.SetValue(FameValue)
				ElseIf FameType == "Exhibitionist"
					Mods.SLSF_CurrentFamePCLocation_Exh_Exp.SetValue(FameValue)
				ElseIf FameType == "Gentle"
					Mods.SLSF_CurrentFamePCLocation_GentleL.SetValue(FameValue)
				ElseIf FameType == "Group"
					Mods.SLSF_CurrentFamePCLocation_Group.SetValue(FameValue)
				ElseIf FameType == "Likes Khajiit"
					Mods.SLSF_CurrentFamePCLocation_Khajiit.SetValue(FameValue)
				ElseIf FameType == "Likes Men"
					Mods.SLSF_CurrentFamePCLocation_LikeMan.SetValue(FameValue)
				ElseIf FameType == "Likes Women"
					Mods.SLSF_CurrentFamePCLocation_LikeWoman.SetValue(FameValue)
				ElseIf FameType == "Masochist"
					Mods.SLSF_CurrentFamePCLocation_Masoc.SetValue(FameValue)
				ElseIf FameType == "Nasty"
					Mods.SLSF_CurrentFamePCLocation_Nasty.SetValue(FameValue)
				ElseIf FameType == "Oral"
					Mods.SLSF_CurrentFamePCLocation_Oral.SetValue(FameValue)
				ElseIf FameType == "Likes Orc"
					Mods.SLSF_CurrentFamePCLocation_Orc.SetValue(FameValue)
				ElseIf FameType == "Pregnant"
					Mods.SLSF_CurrentFamePCLocation_Pregna.SetValue(FameValue)
				ElseIf FameType == "Sadist"
					Mods.SLSF_CurrentFamePCLocation_Sadic.SetValue(FameValue)
				ElseIf FameIndex == 16 ;Skooma
					Mods.SLSF_CurrentFamePCLocation_SkoomaUse.SetValue(FameValue)
				ElseIf FameType == "Slut"
					Mods.SLSF_CurrentFamePCLocation_Slut.SetValue(FameValue)
				ElseIf FameType == "Submissive"
					Mods.SLSF_CurrentFamePCLocation_Sub_Slave.SetValue(FameValue)
				ElseIf FameType == "Whore"
					Mods.SLSF_CurrentFamePCLocation_Whore.SetValue(FameValue)
				EndIf
			EndIf
			
			FameIndex += 1
		EndWhile
		FameIndex = 0
		LocationIndex += 1
	EndWhile
EndFunction