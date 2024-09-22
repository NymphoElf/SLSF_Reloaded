ScriptName SLSF_Reloaded_ModIntegration extends Quest

Bool Property IsSexlabPlusInstalled Auto Hidden
Bool Property IsANDInstalled Auto Hidden
Bool Property IsDDInstalled Auto Hidden
Bool Property IsECInstalled Auto Hidden
Bool Property IsESInstalled Auto Hidden
Bool Property IsPWInstalled Auto Hidden
Bool Property IsFMInstalled Auto Hidden
Bool Property IsFHUInstalled Auto Hidden
Bool Property IsSlaveTatsInstalled Auto Hidden
Bool Property IsSLSInstalled Auto Hidden
Bool Property IsFameCommentsInstalled Auto Hidden
Bool Property IsBimbosInstalled Auto Hidden
Bool Property IsSexlabApproachInstalled Auto Hidden

Keyword Property DD_Lockable Auto Hidden
Keyword Property DD_Collar Auto Hidden
Keyword Property DD_VaginalPiercing Auto Hidden
Keyword Property DD_NipplePiercing Auto Hidden
Keyword Property DD_VaginalPlug Auto Hidden
Keyword Property DD_AnalPlug Auto Hidden
Keyword Property DD_Hood Auto Hidden
Keyword Property DD_Harness Auto Hidden
Keyword Property DD_Belt Auto Hidden
Keyword Property DD_Bra Auto Hidden
Keyword Property DD_HeavyBondage Auto Hidden

Keyword Property SLS_BikiniArmor Auto Hidden

Faction Property AND_Nude Auto Hidden
Faction Property AND_Topless Auto Hidden
Faction Property AND_Bottomless Auto Hidden
Faction Property AND_Chest Auto Hidden
Faction Property AND_Bra Auto Hidden
Faction Property AND_Genitals Auto Hidden
Faction Property AND_Ass Auto Hidden
Faction Property AND_Underwear Auto Hidden

Faction Property ChaurusBreeder Auto Hidden
Faction Property SpiderBreeder Auto Hidden

Faction Property FertilityFaction Auto Hidden

Function CheckInstalledMods()
	If SexlabUtil.GetVersion() > 20000
		IsSexlabPlusInstalled = True
	Else
		IsSexlabPlusInstalled = False
	EndIf
	
	If Game.GetModByName("Advanced Nudity Detection.esp") != 255
		IsANDInstalled = True
		AND_Nude = Game.GetFormFromFile(0x831, "Advanced Nudity Detection.esp") as Faction
		AND_Topless = Game.GetFormFromFile(0x832, "Advanced Nudity Detection.esp") as Faction
		AND_Bottomless = Game.GetFormFromFile(0x833, "Advanced Nudity Detection.esp") as Faction
		AND_Bra = Game.GetFormFromFile(0x834, "Advanced Nudity Detection.esp") as Faction
		AND_Chest = Game.GetFormFromFile(0x82F, "Advanced Nudity Detection.esp") as Faction
		AND_Underwear = Game.GetFormFromFile(0x835, "Advanced Nudity Detection.esp") as Faction
		AND_Genitals = Game.GetFormFromFile(0x830, "Advanced Nudity Detection.esp") as Faction
		AND_Ass = Game.GetFormFromFile(0x82E, "Advanced Nudity Detection.esp") as Faction
	Else
		IsANDInstalled = False
		AND_Nude = None
		AND_Topless = None
		AND_Bottomless = None
		AND_Bra = None
		AND_Chest = None
		AND_Underwear = None
		AND_Genitals = None
		AND_Ass = None
	EndIf
	
	If Game.GetModByName("Devious Devices - Assets.esm") != 255
		IsDDInstalled = True
		DD_Lockable = Game.GetFormFromFile(0x00003894, "Devious Devices - Assets.esm") as Keyword
		DD_Collar = Game.GetFormFromFile(0x00003DF7, "Devious Devices - Assets.esm") as Keyword
		DD_NipplePiercing = Game.GetFormFromFile(0x0000CA39, "Devious Devices - Assets.esm") as Keyword
		DD_VaginalPiercing = Game.GetFormFromFile(0x00023E70, "Devious Devices - Assets.esm") as Keyword
		DD_VaginalPlug = Game.GetFormFromFile(0x0001DD7C, "Devious Devices - Assets.esm") as Keyword
		DD_AnalPlug = Game.GetFormFromFile(0x0001DD7D, "Devious Devices - Assets.esm") as Keyword
		DD_Hood = Game.GetFormFromFile(0x0002AFA2, "Devious Devices - Assets.esm") as Keyword
		DD_Harness = Game.GetFormFromFile(0x00017C43, "Devious Devices - Assets.esm") as Keyword
		DD_Belt = Game.GetFormFromFile(0x00003330, "Devious Devices - Assets.esm") as Keyword
		DD_Bra = Game.GetFormFromFile(0x00003DFA, "Devious Devices - Assets.esm") as Keyword
	Else
		IsDDInstalled = False
		DD_Lockable = None
		DD_Collar = None
		DD_NipplePiercing = None
		DD_VaginalPiercing = None
		DD_VaginalPlug = None
		DD_AnalPlug = None
		DD_Hood = None
		DD_Harness = None
		DD_Belt = None
		DD_Bra = None
	EndIf
	
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		DD_HeavyBondage = Game.GetFormFromFile(0x0005226C, "Devious Devices - Integration.esm") as Keyword
	Else
		DD_HeavyBondage = None
	EndIf
	
	If Game.GetModByName("EstrusChaurus.esp") != 255
		IsECInstalled = True
		ChaurusBreeder = Game.GetFormFromFile(0x000160A9, "EstrusChaurus.esp") as Faction
	Else
		IsECInstalled = False
		ChaurusBreeder = None
	EndIf
	
	If Game.GetModByName("EstrusSpider.esp") != 255
		IsESInstalled = True
		SpiderBreeder = Game.GetFormFromFile(0x0004E258, "EstrusSpider.esp") as Faction
	Else
		IsESInstalled = False
		SpiderBreeder = None
	EndIf
	
	If Game.GetModByName("Public Whore.esp") != 255
		IsPWInstalled = True
	Else
		IsPWInstalled = False
	EndIf
	
	If Game.GetModByName("Fertility Mode 3 Fixes and Updates.esp") != 255
		IsFMInstalled = True
		FertilityFaction = Game.GetFormFromFile(0x862, "Fertility Mode 3 Fixes and Updates.esp") as Faction
	Else
		IsFMInstalled = False
		FertilityFaction = None
	EndIf
	
	If Game.GetModByName("sr_FillHerUp.esp") != 255
		IsFHUInstalled = True
	Else
		IsFHUInstalled = False
	EndIf
	
	If Game.GetModByName("SlaveTats.esp") != 255
		IsSlaveTatsInstalled = True
	Else
		IsSlaveTatsInstalled = False
	EndIf
	
	If Game.GetModByName("SL Survival.esp") != 255
		IsSLSInstalled = True
		SLS_BikiniArmor = Game.GetFormFromFile(0x00049867, "SL Survival.esp") as Keyword
	Else
		IsSLSInstalled = False
		SLS_BikiniArmor = None
	EndIf
	
	If Game.GetModByName("SLSFFameComments.esp") != 255
		IsFameCommentsInstalled = True
	Else
		IsFameCommentsInstalled = False
	EndIf
	
	If Game.GetModByName("CustomComments.esp") != 255
		IsBimbosInstalled = True
	Else
		IsBimbosInstalled = False
	EndIf
EndFunction

sr_InflateQuest Function GetFHUData() Global
	return Game.GetFormFromFile(0xD63, "sr_FillherUp.esp") as sr_InflateQuest
EndFunction

PW_MainLoopScript Function GetPWData() Global
	return Game.GetFormFromFile(0xD63, "Public Whore.esp") as PW_MainLoopScript
EndFunction

Bool Function IsFMPregnant(Actor actorRef)
	If actorRef.GetFactionRank(FertilityFaction) > 30
		return True
	EndIf
	return False
EndFunction

Bool Function IsECPregnant(Actor actorRef)
	If IsECInstalled == True && actorRef.IsInFaction(ChaurusBreeder)
		return True
	EndIf
	return False
EndFunction

Bool Function IsESPregnant(Actor actorRef)
	If IsESInstalled == True && actorRef.IsInFaction(SpiderBreeder)
		return True
	EndIf
	return False
EndFunction

Bool Function IsPublicWhore(Actor actorRef)
	If IsPWInstalled == True
		PW_MainLoopScript PublicWhore = GetPWData()
		If PublicWhore.isWhoreNow == True
			return True
		EndIf
	EndIf
	return False
EndFunction

Int Function GetFHUInflation(Actor actorRef)
	If IsFHUInstalled == True
		sr_InflateQuest FillHerUp = GetFHUData()
		return FillHerUp.GetInflation(actorRef) as Int
	EndIf
	return 0
EndFunction