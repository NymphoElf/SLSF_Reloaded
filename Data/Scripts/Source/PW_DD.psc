Scriptname PW_DD   
{File of global functions for Devious Device use
in Public Whore}

;Thank you to Tenri for showing me how to do this correctly

function AddToDisableDialogueFaction(actor who) Global
	Faction DisableDialogueFaction = Game.GetFormFromFile(0x0504653B, "Devious Devices - Integration.esm") as Faction
	who.AddToFaction(DisableDialogueFaction)
endFunction

armor function collarPlayer() Global
	
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor collar = libs.GetDeviceByTags(libs.zad_DeviousCollar, "short")
	libs.ManipulateGenericDevice(Game.GetPlayer(), collar, true, false, false)
	
	return collar
endFunction

function equipVaginalPiercing() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor piercing = libs.GetDeviceByTags(libs.zad_DeviousPiercingsVaginal, "vaginal")
	libs.ManipulateGenericDevice(Game.GetPlayer(), piercing, true, false, false)
	
	return
endFunction

function unequipVaginalPiercing() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor piercing = libs.GetDeviceByTags(libs.zad_DeviousPiercingsVaginal, "vaginal")
	libs.ManipulateGenericDevice(Game.GetPlayer(), piercing, false, false, false)
	
	return
endFunction


function gagPlayer() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	;armor gag = libs.GetDeviceByTags(libs.zad_DeviousGag, "ring")
	armor gag = libs.GetGenericDeviceByKeyword(libs.zad_DeviousGag)
	libs.ManipulateGenericDevice(Game.GetPlayer(), gag, true, false, false)
	
	return
endFunction

function equipAnkleShackles() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor ankleShackles = Game.GetFormFromFile(0x0803D2E8, "Devious Devices - Expansion.esm") as armor
	libs.ManipulateGenericDevice(Game.GetPlayer(), ankleShackles, true, false, false)
	return
endfunction

function equipYoke() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor yoke = Game.GetFormFromFile(0x0704F18C, "Devious Devices - Integration.esm") as armor
	libs.ManipulateGenericDevice(Game.GetPlayer(), yoke, true, false, false)
	return
endFunction

function unequipYoke() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor yoke = Game.GetFormFromFile(0x0704F18C, "Devious Devices - Integration.esm") as armor
	libs.ManipulateGenericDevice(Game.GetPlayer(), yoke, false, false, false)
	return
endFunction


function unequipCollar() Global

	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor collar = libs.GetWornDevice(Game.GetPlayer(), libs.zad_DeviousCollar)
	libs.ManipulateGenericDevice(Game.GetPlayer(), collar, false, false, false)
	
	return
endFunction


function unequipAnkleShackles() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor ankleShackles = Game.GetFormFromFile(0x0803D2E8, "Devious Devices - Expansion.esm") as armor
	libs.ManipulateGenericDevice(Game.GetPlayer(), ankleShackles, false, false, false)
	return
endfunction

function unequipGag() Global
	zadlibs libs = Game.GetFormFromFile(0x0700F624, "Devious Devices - Integration.esm") as zadlibs
	armor gag = libs.GetWornDevice(Game.GetPlayer(), libs.zad_DeviousGag)
	libs.ManipulateGenericDevice(Game.GetPlayer(), gag, false, false, false)
	return
endFunction

function EquipWristBinds() Global
endFunction

function UnequipWristBinds() Global
endFunction

;armor function getWornYoke() Global
	