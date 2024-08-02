ScriptName SLSF_Reloaded_ModIntegration extends Quest

Bool Property IsANDInstalled Auto Hidden
Bool Property IsDDInstalled Auto Hidden
Bool Property IsECInstalled Auto Hidden
Bool Property IsESInstalled Auto Hidden
Bool Property IsPWInstalled Auto Hidden
Bool Property IsFMInstalled Auto Hidden
Bool Property IsFHUInstalled Auto Hidden
Bool Property IsSlaveTatsInstalled Auto Hidden
Bool Property IsSLSInstalled Auto Hidden

Keyword Property DD_Lockable Auto Hidden
Keyword Property DD_Collar Auto Hidden
Keyword Property DD_VaginalPiercing Auto Hidden
Keyword Property DD_NipplePiercing Auto Hidden
Keyword Property DD_VaginalPlug Auto Hidden
Keyword Property DD_AnalPlug Auto Hidden
Keyword Property DD_Hood Auto Hidden

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

MagicEffect Property FM_2ndTrimester Auto Hidden
MagicEffect Property FM_3rdTrimester Auto Hidden

Event OnInit()
	CheckInstalledMods()
EndEvent

Event OnPlayerLoadGame()
	CheckInstalledMods()
EndEvent

Function CheckInstalledMods()
	If Game.GetModByName("Advanced Nudity Detection.esp" != 255)
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
	
	If Game.GetModByName("Devious Devices - Assets.esm" != 255)
		IsDDInstalled = True
		DD_Lockable = Game.GetFormFromFile(0x3894, "Devious Devices - Assets.esm") as Keyword
		DD_Collar = Game.GetFormFromFile(0x3DF7, "Devious Devices - Assets.esm") as Keyword
		DD_NipplePiercing = Game.GetFormFromFile(0xCA39, "Devious Devices - Assets.esm") as Keyword
		DD_VaginalPiercing = Game.GetFormFromFile(0x23E70, "Devious Devices - Assets.esm") as Keyword
		DD_VaginalPlug = Game.GetFormFromFile(0x1DD7C, "Devious Devices - Assets.esm") as Keyword
		DD_AnalPlug = Game.GetFormFromFile(0x1DD7D, "Devious Devices - Assets.esm") as Keyword
		DD_Hood = Game.GetFormFromFile(0x2AFA2, "Devious Devices - Assets.esm") as Keyword
	Else
		IsDDInstalled = False
		DD_Lockable = None
		DD_Collar = None
		DD_NipplePiercing = None
		DD_VaginalPiercing = None
		DD_VaginalPlug = None
		DD_AnalPlug = None
	EndIf
	
	If Game.GetModByName("EstrusChaurus.esp" != 255)
		IsECInstalled = True
		ChaurusBreeder = Game.GetFormFromFile(0x160A9, "EstrusChaurus.esp") as Faction
	Else
		IsECInstalled = False
		ChaurusBreeder = None
	EndIf
	
	If Game.GetModByName("EstrusSpider.esp" != 255)
		IsESInstalled = True
		SpiderBreeder = Game.GetFormFromFile(0x4E258, "EstrusSpider.esp") as Faction
	Else
		IsESInstalled = False
		SpiderBreeder = None
	EndIf
	
	If Game.GetModByName("Public Whore.esp" != 255)
		IsPWInstalled = True
	Else
		IsPWInstalled = False
	EndIf
	
	If Game.GetModByName("Fertility Mode.esm" != 255)
		IsFMInstalled = True
		FM_2ndTrimester = Game.GetFormFromFile(0x1B814, "Fertility Mode.esp") as MagicEffect
		FM_3rdTrimester = Game.GetFormFromFile(0x1B815, "Fertility Mode.esp") as MagicEffect
	Else
		IsFMInstalled = False
		FM_2ndTrimester = None
		FM_3rdTrimester = None
	EndIf
	
	If Game.GetModByName("sr_FillHerUp.esp" != 255)
		IsFHUInstalled = True
	Else
		IsFHUInstalled = False
	EndIf
	
	If Game.GetModByName("SlaveTats.esp" != 255)
		IsSlaveTatsInstalled = True
	Else
		IsSlaveTatsInstalled = False
	EndIf
	
	If Game.GetModByName("SL Survival.esp" != 255)
		IsSLSInstalled = True
		SLS_BikiniArmor = Game.GetFormFromFile(0x49867, "SL Survival.esp") as Keyword
	Else
		IsSLSInstalled = False
		SLS_BikiniArmor = None
	EndIf
EndFunction

sr_InflateQuest Function GetFHUData() Global
	return Game.GetFormFromFile(0xD63, "sr_FillherUp.esp") as sr_InflateQuest
EndFunction

PW_MainLoopScript Function GetPWData() Global
	return Game.GetFormFromFile(0xD63, "Public Whore.esp") as PW_MainLoopScript
EndFunction

Bool Function IsFMPregnant(Actor actorRef)
	If actorRef.HasMagicEffect(FM_2ndTrimester) || actorRef.HasMagicEffect(FM_3rdTrimester)
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
	PW_MainLoopScript PublicWhore = GetPWData()
	If IsPWInstalled == True && PublicWhore.isWhoreNow == True
		return True
	EndIf
	return False
EndFunction

Int Function GetFHUInflation(Actor actorRef)
	sr_InflateQuest FillHerUp = GetFHUData()
	If IsFHUInstalled == True
		return FillHerUp.GetInflation(actorRef) as Int
	EndIf
	return 0
EndFunction