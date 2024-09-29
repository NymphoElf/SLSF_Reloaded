Scriptname PW_ModIntegrationsScript extends PW_ScriptComponent Conditional

import PW_Utility


;Install Flags
bool property isSLAInstalled = false Auto
bool property isSLSFInstalled = false Auto
bool property isDDInstalled  = false Auto
bool property isSlaveTatsInstalled = false Auto
bool property isFadeTattoosInstalled = false Auto
bool property isZaZInstalled = false Auto
bool property isSTAInstalled = false Auto
bool property isSDPlusInstalled = false Auto
bool property isSLTRInstalled = false Auto
bool property isSimpleSlaveryInstalled = false Auto
bool Property isANDInstalled = false Auto

;Use Toggle Flags
bool property usingSLA = true Auto Conditional
bool property usingSLSF = true Auto Conditional
bool property usingDD = true Auto Conditional
bool property usingSlaveTats = true Auto Conditional
;No usingFadeTattoos flag
bool property usingZaZ = true Auto Conditional
;No usingSTA flag
bool property usingSDPlus = true Auto Conditional
bool property usingSLTR = true Auto Conditional
bool property usingSimpleSlavery = true Auto Conditional

Actor property TorturerM Auto
Actor property TorturerF Auto

int property tattooMode = 0 Auto


bool enslavedSDPlus = false
bool enslavedSLTR = false

armor property zbfWristLeatherBinds Auto
armor property zbfGag Auto

function Initialize()
		
	enslavedSDPlus = PW_StorageUtilBridge.isPlayerSDEnslaved()
	
	Quest qLolaMQ = Quest.GetQuest("vkjMQ")
	if(qLolaMQ != none)
		enslavedSLTR = qLolaMQ.isRunning()
	endIf
	
endFunction

function Startup()
	
	isSLAInstalled = checkModInstalled("SexlabAroused.esm")
	isSLSFInstalled = checkModInstalled("SexLab - Sexual Fame [SLSF].esm" )
	isDDInstalled = checkModInstalled("Devious Devices - Integration.esm")
	isSlaveTatsInstalled = checkModInstalled("SlaveTats.esp")
	isFadeTattoosInstalled = checkModInstalled("FadeTattoos.esp")
	isZaZInstalled = checkModInstalled("ZaZAnimationPack.esm")
	isSTAInstalled = checkModInstalled("Spank That Ass.esp")
	isSDPlusInstalled = checkModInstalled("sanguinesDebauchery.esp")
	isSLTRInstalled = checkModInstalled("submissivelola_est.esp")
	isSimpleSlaveryInstalled = checkModInstalled("SimpleSlavery.esp")
	isANDInstalled = checkModInstalled("Advanced Nudity Detection.esp")
	
	usingSLA = (usingSLA && isSLAInstalled)
	usingSLSF = (usingSLSF && isSLSFInstalled)
	usingDD = (usingDD && isDDInstalled)
	usingSlaveTats = (usingSlaveTats && isSlaveTatsInstalled)
	usingZaZ = (usingZaZ && isZaZInstalled)
	;
	usingSDPlus = (usingSDPlus && isSDPlusInstalled)
	;
	usingSLTR = (usingSLTR && isSLTRInstalled)
	usingSimpleSlavery = (usingSimpleSlavery && isSimpleSlaveryInstalled)

	if(isSTAInstalled)
		Faction neverSpankFaction = Game.GetFormFromFile(0x09017E5A, "Spank That Ass.esp") as Faction
		if(neverSpankFaction != none)
			TorturerM.AddToFaction(neverSpankFaction)
			TorturerF.AddToFaction(neverSpankFaction)
		endIf
	endIf
	
	
	RegisterForModEvent("PW_CheckTimeComponents", "CheckTimeComponents")
	RegisterForModEvent("SDEnslavedStart", "SDSlaveryStarted")
	
	if(usingSLTR)
		RegisterForModEvent("SDEnslavedStop", "SDSlaveryStopped") 
	endIf
	
endFunction

event OnPlayerLoadGame()
	isANDInstalled = checkModInstalled("Advanced Nudity Detection.esp")
endEvent

event CheckTimeComponents()
	Quest qLolaMQ = Quest.GetQuest("vkjMQ")
	if(qLolaMQ != none)
		enslavedSLTR = qLolaMQ.isRunning()
	endIf
endEvent

bool function checkModInstalled(string pluginName)	;Checks a plugin by esp name, returns whether the esp is installed
	
	if(Game.GetModByName(pluginName) != 255)
		return true
	else
		return false
	endIf

endFunction


;||||||||||||Mod Interfacing Functions|||||||||||||

function collarPlayer()
	if(isDDInstalled && usingDD)
		PW_DD.collarPlayer()
	elseIf(isZaZInstalled && usingZaZ)
		armor collar = Game.GetFormFromFile(0x04003004, "ZaZAnimationPack.esm") as Armor
		if(collar != none)
			Game.GetPlayer().AddItem(collar, 1, true)
			Game.GetPlayer().EquipItem(collar)
		endIf
	endIf
	return
endFunction

function removeCollar()
	if(isDDInstalled && usingDD)
		;PW_DD.removeCollar()
	elseIf(isZaZInstalled && usingZaZ)
	endIf

	return
endFunction

function RemoveRestraints(armor which)	;NOT WORKING
	;if(which.HasKeywordString("zad_Lockable") && isDDInstalled && usingDD)
		;PW_DD.removeDD(which)
	;elseIf(which.HasKeyWordString("zbfWornDevice" && isZaZInstalled && usingZaZ))
		;		;to my knowledge no special procedure is required to remove ZaZ restraints
	;endIf

	return
endFunction

function GagPlayer()
	if(isDDInstalled && usingDD)
		PW_DD.gagPlayer()
	else
		Game.GetPlayer().AddItem(zbfGag)
		Game.GetPlayer().EquipItem(zbfGag)
	endIf
	return
endFunction

function UnequipGag()
	if(isDDInstalled && usingDD)
		PW_DD.unequipGag()
	else
		Game.GetPlayer().UnequipItem(zbfGag)
		Game.GetPlayer().RemoveItem(zbfGag)
	endIf
endFunction

function EquipAnkleShackles()
	if(usingDD)
		PW_DD.equipAnkleShackles()
	elseIf(usingZaZ)
		armor shackles = Game.GetFormFromFile(0x04004005, "ZaZAnimationPack.esm") as armor
		Game.GetPlayer().AddItem(shackles, 1)
		Game.GetPlayer().EquipItem(shackles)
	endIf
	return
endFunction

function EquipYoke()
	if(usingDD)
		PW_DD.equipYoke()
	elseIf(usingZaZ)
		armor yoke = Game.GetFormFromFile(0x0402314C, "ZaZAnimationPack.esm") as armor
		Game.GetPlayer().AddItem(yoke, 1)
		Game.GetPlayer().EquipItem(yoke)
	endIf
	return
endFunction

function UnequipYoke()
	if(usingDD)
		PW_DD.unequipYoke()
	endIf
		armor yoke = Game.GetFormFromFile(0x0402314C, "ZaZAnimationPack.esm") as armor
		Game.GetPlayer().UnequipItem(yoke)
		Game.GetPlayer().RemoveItem(yoke, 1)
	return
endFunction

function EquipWristBinds()
	if(usingDD)
		;TODO implement
		PW_DD.EquipWristBinds()
	else
		Game.GetPlayer().AddItem(zbfWristLeatherBinds, 1)
		Game.GetPlayer().EquipItem(zbfWristLeatherBinds)
		;PW_ZaZ.equipWristBinds()
	endIf
endFunction

function EquipVaginalPiercing()
	if(usingDD)
		PW_DD.EquipVaginalPiercing()
	endIf
endFunction

function UnequipVaginalPiercing()
	if(usingDD)
		PW_DD.UnequipVaginalPiercing()
	endIf
endFunction

function UnequipWristBinds()
	if(usingDD)
		PW_DD.UnequipWristBinds()
	else
		;PW_ZaZ.equipWristBinds()
	endIf
endFunction

furniture function getZaZFurniture(string which)
	if(isZaZInstalled && usingZaZ)
		return PW_ZaZ.getZaZFurniture(which)
	endIf
	
	return none
endFunction

weapon function getZaZWeapon(string which)
	return PW_ZaZ.getZaZWeapon(which) 
endFunction

function initializeGallows(objectReference which)
{Deprecated}
	if(isZaZInstalled && usingZaZ)
		PW_ZaZ.attachZbfToGallowScript(which)
	endIf
	return
endFunction

function DisableDDGagDialogue(actor who)
	if usingDD
		PW_DD.AddToDisableDialogueFaction(who)
	endIf
endFunction

bool function addSlaveTat(int locIndex)

	if locIndex < 0 || locIndex > 8
		return false
	endIf

	string section
	string name

	if(tattooMode == 0)	;Symbols
		section = "City Whore Symbols"
	else
		section = "City Whore Labels"
	endIf

	name = PW_Constants.getCityName(locIndex)

	bool result = PW_SlaveTats.addSlaveTat(section, name)
	;PW_FadeTattoos line goes here to set duration
	return result
endFunction

function removeSlaveTat(int locIndex)

	if locIndex < 0 || locIndex > 8
		return
	endIf

	string name = PW_Constants.getCityName(locIndex)

	PW_SlaveTats.removeSlaveTat("City Whore Symbols", name)
	PW_SlaveTats.removeSlaveTat("City Whore Labels", name)
	return
endFunction

function unequipAllDD()
	if(isDDInstalled)
		PW_DD.unequipCollar()
		PW_DD.unequipYoke()
		PW_DD.unequipAnkleShackles()
	endIf
endFunction
	

;|||| SLAVERY |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
bool function isPlayerEnslaved()
	return enslavedSDPlus || enslavedSLTR
endFunction


;/		-- Sanguine's Debauchery --		/;
event SDSlaveryStarted(string eventName, string strArg, float numArg, Form sender)
	pwDebug(self, 3, "SD+ slavery started")
	enslavedSDPlus = true
endEvent

event SDSlaveryStopped(string eventName, string strArg, float numArg, Form sender)
	pwDebug(self, 3, "SD+ slavery stopped")
	enslavedSDPlus = false
endEvent


;/		-- Submissive Lola --			/;
bool function SendToSLTR()
    Quest qLolaStart = Quest.GetQuest("vkjPWSlaveStart")
    if qLolaStart != none
        Quest qLolaMQ = Quest.GetQuest("vkjMQ")
        if qLolaMQ.IsRunning()
			pwDebug(self, 4, "attempted to start Submissive Lola enslavement while already running")
            return false
        endif
		PW_Utility.SendEvent("PW_ClearStatusLocal")
        qLolaStart.Start(); Start Submissive Lola enslavement
		return true
    endif
	
	return false
endFunction