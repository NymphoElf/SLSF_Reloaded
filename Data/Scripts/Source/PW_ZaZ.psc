Scriptname PW_ZaZ   
{Script with global functions for Public Whore to interface with ZaZ}

Weapon function getZaZWeapon(string which) global
	if(which == "Crop")
		Weapon crop = Game.GetFormFromFile(0x04006001, "ZaZAnimationPack.esm") as Weapon
		return crop
	elseIf(which == "Paddle")
		return (Game.GetFormFromFile(0x04006002, "ZaZAnimationPack.esm") as Weapon)
	endIf
endfunction

Furniture function getZaZFurniture(string which) global
	Furniture furn
	if(which == "XCross" || which == "xcross")
		furn = (Game.GetFormFromFile(0x0400D7E0, "ZaZAnimationPack.esm") as Furniture)
	elseIf(which == "Garotte")
		furn = (Game.GetFormFromFile(0x0404CA31, "ZaZAnimationPack.esm") as Furniture)
	elseIf(which == "Rack" || which == "rack")
		furn = (Game.GetFormFromFile(0x0400E2BF, "ZaZAnimationPack.esm") as Furniture)
	elseIf(which == "Pillory")
		furn = (Game.GetFormFromFile(0x0404142B, "ZaZAnimationPack.esm") as Furniture)
	elseIf(which == "Gallows" || which == "gallows")
		furn = (Game.GetFormFromFile(0x0405DD69, "ZaZAnimationPack.esm") as Furniture)
	endIf
	return furn
endFunction

function zazTest(string teststring) global
Debug.MessageBox(teststring)
return
endFunction


;A relic of pre-ZaZ dependency
function attachZbfToGallowScript(objectReference gallowFurn)	global
	PW_GallowFurnScriptShort gallowScript = gallowFurn as PW_GallowFurnScriptShort
	gallowScript.zbf = Game.GetFormFromFile(0x040137E6, "ZaZAnimationPack.esm") as zbfBondageShell
	return
endFunction



ObjectReference function placeZaZFurniture(ObjectReference atWhat, string zbfFurnString) global
	Furniture zbfFurn = getZaZFurniture(zbfFurnString)
	ObjectReference returnFurn = atWhat.PlaceAtMe(zbfFurn, 1)
	return returnFurn
endFunction

