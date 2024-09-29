Scriptname PW_SlaveTats   

bool function addSlaveTat(string section, string name) Global
	return SlaveTats.simple_add_tattoo(Game.GetPlayer(), section, name)
endFunction

function removeSlaveTat(string section, string name) Global
	SlaveTats.simple_remove_tattoo(Game.GetPlayer(), section, name)
	return
endFunction