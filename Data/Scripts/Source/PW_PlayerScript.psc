Scriptname PW_PlayerScript extends ReferenceAlias 
{Keeps track of game loads and equipment changes, requests locInfo updates on loc change} 

PW_MainLoopScript property Main Auto

Spell Property CantLeave Auto
MagicEffect Property CantLeaveMGEF Auto
ImageSpaceModifier property FadeToBlack Auto

int property cantLeaveIndex = -1 Auto


Event OnLocationChange(Location akOldLoc, location akNewLoc)

	PW_Utility.sendEvent("PW_UpdateLocInfo")

endEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if(Main.numExemptEquipment > 0)
		int index = 0
		while (index < Main.numExemptEquipment)
			if(akBaseObject == Main.exemptEquipment[index])
				Main.exemptEquipped(akBaseObject as armor)
				index = Main.numExemptEquipment
			endIf
			index += 1
		endWhile
	endIf
   	
	PW_Utility.SendEvent("PW_PlayerEquipmentChanged")
endEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if(Main.numExemptEquipment > 0)
		int index = 0
		while (index < Main.numExemptEquipment)
			if(akBaseObject == Main.exemptEquipment[index])
				Main.exemptUnequipped(akBaseObject as armor)
				index = Main.numExemptEquipment
			endIf
			index += 1
		endWhile
	endIf

	PW_Utility.SendEvent("PW_PlayerEquipmentChanged")
endEvent
