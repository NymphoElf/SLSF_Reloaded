ScriptName SLSF_Reloaded_ModIntegration extends Quest

SLSF_Reloaded_LegacyOverwrite Property LegacyOverwrite Auto
SLSF_Reloaded_MCM Property Config Auto

Bool Property IsANDInstalled Auto Hidden
Bool Property IsDDInstalled Auto Hidden
Bool Property IsECInstalled Auto Hidden
Bool Property IsESInstalled Auto Hidden
Bool Property IsPWInstalled Auto Hidden
Bool Property IsFMInstalled Auto Hidden
Bool Property IsFHUInstalled Auto Hidden
Bool Property IsHentaiPregInstalled Auto Hidden
Bool Property IsSlaveTatsInstalled Auto Hidden
Bool Property IsSLSInstalled Auto Hidden
Bool Property IsFameCommentsInstalled Auto Hidden
Bool Property IsBimbosInstalled Auto Hidden
Bool Property IsSexlabApproachInstalled Auto Hidden
Bool Property IsLegacySLSFInstalled Auto Hidden

sr_InflateQuest Property FHU Auto Hidden
PW_TrackerScript Property PW_Tracker Auto Hidden
SLSF_Configuration Property LegacyConfig Auto Hidden

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
Keyword Property DD_ArmCuffs Auto Hidden
Keyword Property DD_ArmCuffsFront Auto Hidden
Keyword Property DD_Armbinder Auto Hidden
Keyword Property DD_ArmbinderElbow Auto Hidden
Keyword Property DD_Gloves Auto Hidden
Keyword Property DD_LegCuffs Auto Hidden
Keyword Property DD_Boots Auto Hidden
Keyword Property DD_Gag Auto Hidden
Keyword Property DD_GagPanel Auto Hidden
Keyword Property DD_Suit Auto Hidden
Keyword Property DD_Corset Auto Hidden
Keyword Property DD_Blindfold Auto Hidden

Keyword Property SLS_BikiniArmor Auto Hidden
MagicEffect Property SLS_CollarCurse Auto Hidden

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

Faction Property HentaiPregFaction Auto Hidden

GlobalVariable Property SLSF_Reloaded_CommentFrequency Auto

GlobalVariable Property SLSF_CurrentFamePCLocation_Anal Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Argonian Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Beast Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Dom_Mas Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Exh_Exp Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_GentleL Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Group Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Khajiit Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_LikeMan Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_LikeWoman Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Masoc Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Nasty Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Oral Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Orc Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Pregna Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Sadic Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_SkoomaUse Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Slut Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Sub_Slave Auto Hidden
GlobalVariable Property SLSF_CurrentFamePCLocation_Whore Auto Hidden

Function CheckInstalledMods()
	
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
	
	Int DD_ModuleCount = 0
	
	If Game.GetModByName("Devious Devices - Assets.esm") != 255
		DD_ModuleCount += 1
	EndIf
	
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		DD_ModuleCount += 1
	EndIf
	
	If Game.GetModByName("Devious Devices - Expansion.esm") != 255
		DD_ModuleCount += 1
	EndIf
	
	If DD_ModuleCount == 3
		IsDDInstalled = True
	ElseIf DD_ModuleCount > 0 && DD_ModuleCount < 3
		Debug.MessageBox("$DDModulesMissingMSG")
		IsDDInstalled = False
	Else
		IsDDInstalled = False
	EndIf
	
	If IsDDInstalled == True
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
		DD_ArmCuffs = Game.GetFormFromFile(0x00003DF9, "Devious Devices - Assets.esm") as Keyword
		DD_Armbinder = Game.GetFormFromFile(0x0000CA3A, "Devious Devices - Assets.esm") as Keyword
		DD_Blindfold = Game.GetFormFromFile(0x00011B1A, "Devious Devices - Assets.esm") as Keyword
		DD_Boots = Game.GetFormFromFile(0x00027F29, "Devious Devices - Assets.esm") as Keyword
		DD_Corset = Game.GetFormFromFile(0x00027F28, "Devious Devices - Assets.esm") as Keyword
		DD_Gag = Game.GetFormFromFile(0x00007EB8, "Devious Devices - Assets.esm") as Keyword
		DD_GagPanel = Game.GetFormFromFile(0x0001F306, "Devious Devices - Assets.esm") as Keyword
		DD_Gloves = Game.GetFormFromFile(0x0002AFA1, "Devious Devices - Assets.esm") as Keyword
		DD_LegCuffs = Game.GetFormFromFile(0x00003DF8, "Devious Devices - Assets.esm") as Keyword
		DD_Suit = Game.GetFormFromFile(0x0002AFA3, "Devious Devices - Assets.esm") as Keyword
		
		DD_HeavyBondage = Game.GetFormFromFile(0x0005226C, "Devious Devices - Integration.esm") as Keyword
		DD_ArmCuffsFront = Game.GetFormFromFile(0x00063AD9, "Devious Devices - Integration.esm") as Keyword
		DD_ArmbinderElbow = Game.GetFormFromFile(0x00062539, "Devious Devices - Integration.esm") as Keyword
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
		DD_ArmCuffs = None
		DD_Armbinder = None
		DD_Blindfold = None
		DD_Boots = None
		DD_Corset = None
		DD_Gag = None
		DD_GagPanel = None
		DD_Gloves = None
		DD_LegCuffs = None
		DD_Suit = None
		
		DD_HeavyBondage = None
		DD_ArmCuffsFront = None
		DD_ArmbinderElbow = None
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
		PW_Tracker = Game.GetFormFromFile(0x00016C84, "Public Whore.esp") as PW_TrackerScript
	Else
		IsPWInstalled = False
		PW_Tracker = None
		Config.DisableNakedCommentsWhilePW = False
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
		FHU = GetFHUData()
	Else
		IsFHUInstalled = False
		FHU = None
	EndIf
	
	If Game.GetModByName("SlaveTats.esp") != 255
		IsSlaveTatsInstalled = True
	Else
		IsSlaveTatsInstalled = False
	EndIf
	
	If Game.GetModByName("SL Survival.esp") != 255
		IsSLSInstalled = True
		SLS_BikiniArmor = Game.GetFormFromFile(0x00049867, "SL Survival.esp") as Keyword
		SLS_CollarCurse = Game.GetFormFromFile(0x00045160, "SL Survival.esp") as MagicEffect
	Else
		IsSLSInstalled = False
		SLS_BikiniArmor = None
		SLS_CollarCurse = None
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
	
	If Game.GetModByName("HentaiPregnancy.esm") != 255
		IsHentaiPregInstalled = True
		HentaiPregFaction = Game.GetFormFromFile(0x00012085, "HentaiPregnancy.esm") as Faction
	Else
		IsHentaiPregInstalled = False
		HentaiPregFaction = None
	EndIf
	
	If Game.GetModByName("SexLab - Sexual Fame [SLSF].esm") != 255
		IsLegacySLSFInstalled = True
		LegacyConfig = GetLegacyConfig()
		
		SLSF_CurrentFamePCLocation_Anal = Game.GetFormFromFile(0x00024255, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Argonian = Game.GetFormFromFile(0x00024256, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Beast = Game.GetFormFromFile(0x00024257, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Dom_Mas = Game.GetFormFromFile(0x00024258, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Exh_Exp = Game.GetFormFromFile(0x00024259, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_GentleL = Game.GetFormFromFile(0x0002425A, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Group = Game.GetFormFromFile(0x0002425B, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Khajiit = Game.GetFormFromFile(0x0002425C, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_LikeMan = Game.GetFormFromFile(0x0002425D, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_LikeWoman = Game.GetFormFromFile(0x0002425E, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Masoc = Game.GetFormFromFile(0x0002425F, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Nasty = Game.GetFormFromFile(0x00024260, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Oral = Game.GetFormFromFile(0x00024261, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Orc = Game.GetFormFromFile(0x00024262, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Pregna = Game.GetFormFromFile(0x00024263, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Sadic = Game.GetFormFromFile(0x00024264, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_SkoomaUse = Game.GetFormFromFile(0x00024265, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Slut = Game.GetFormFromFile(0x00024266, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Sub_Slave = Game.GetFormFromFile(0x00024267, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
		SLSF_CurrentFamePCLocation_Whore = Game.GetFormFromFile(0x00024268, "SexLab - Sexual Fame [SLSF].esm") as GlobalVariable
	Else
		Config.AllowLegacyOverwrite = False
		IsLegacySLSFInstalled = False
		LegacyConfig = None
		
		SLSF_CurrentFamePCLocation_Anal = None
		SLSF_CurrentFamePCLocation_Argonian = None
		SLSF_CurrentFamePCLocation_Beast = None
		SLSF_CurrentFamePCLocation_Dom_Mas = None
		SLSF_CurrentFamePCLocation_Exh_Exp = None
		SLSF_CurrentFamePCLocation_GentleL = None
		SLSF_CurrentFamePCLocation_Group = None
		SLSF_CurrentFamePCLocation_Khajiit = None
		SLSF_CurrentFamePCLocation_LikeMan = None
		SLSF_CurrentFamePCLocation_LikeWoman = None
		SLSF_CurrentFamePCLocation_Masoc = None
		SLSF_CurrentFamePCLocation_Nasty = None
		SLSF_CurrentFamePCLocation_Oral = None
		SLSF_CurrentFamePCLocation_Orc = None
		SLSF_CurrentFamePCLocation_Pregna = None
		SLSF_CurrentFamePCLocation_Sadic = None
		SLSF_CurrentFamePCLocation_SkoomaUse = None
		SLSF_CurrentFamePCLocation_Slut = None
		SLSF_CurrentFamePCLocation_Sub_Slave = None
		SLSF_CurrentFamePCLocation_Whore = None
	EndIf
EndFunction

sr_InflateQuest Function GetFHUData() Global
	return Game.GetFormFromFile(0xD63, "sr_FillherUp.esp") as sr_InflateQuest
EndFunction

PW_MainLoopScript Function GetPWData() Global
	return Game.GetFormFromFile(0xD63, "Public Whore.esp") as PW_MainLoopScript
EndFunction

SLSF_Configuration Function GetLegacyConfig() Global
	return Game.GetFormFromFile(0x00016AB9, "SexLab - Sexual Fame [SLSF].esm") as SLSF_Configuration
EndFunction

Function OverwriteLegacyConfig()
	LegacyConfig.LocationFameModInc = 0
	LegacyConfig.LocationFameModDec = 0
	LegacyConfig.ContageMagnitudo = 0
	
	LegacyConfig.ChildRemover = False
	LegacyConfig.DisableTutorial = True
	LegacyConfig.NotificationIncrease = False
	LegacyConfig.AllowCommentProbability = (SLSF_Reloaded_CommentFrequency.GetValue() / 100)
	LegacyConfig.CommentProbabilityRepository = LegacyConfig.AllowCommentProbability
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

Bool Function IsHentaiPregnant(Actor actorRef)
	If IsHentaiPregInstalled == True && actorRef.GetFactionRank(HentaiPregFaction) > 1
		return True
	EndIf
	return False
EndFunction

Bool Function IsPublicWhore()
	If IsPWInstalled == True
		If PW_Tracker.GetCurrentStatus() == 2
			return True
		EndIf
	EndIf
	return False
EndFunction

Float Function GetFHUInflation(Actor actorRef)
	If IsFHUInstalled == True
		return FHU.GetInflation(actorRef)
	EndIf
	return 0
EndFunction