ScriptName SLSF_Reloaded_VisibilityManager extends Quest

SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_MCM Property Config Auto

SexlabFramework Property Sexlab Auto

SlaveTats Property SlaveTatsScript Auto

Bool[] Property BodyTattooApplied Auto Hidden
Bool[] Property FaceTattooApplied Auto Hidden
Bool[] Property HandTattooApplied Auto Hidden
Bool[] Property FootTattooApplied Auto Hidden

String[] Property BodyTattooSubcategory Auto ;Chest, Pelvis, Ass, Back, None
String[] Property BodyTattooExtraFameType Auto ;Matches Fame Manager Fame Types, except Tattoo Fame which is "None". Size = 6, Default = None
String[] Property FaceTattooExtraFameType Auto
String[] Property HandTattooExtraFameType Auto
String[] Property FootTattooExtraFameType Auto

Keyword Property SLSF_Reloaded_HidesIdentity Auto
Keyword Property SLSF_Reloaded_CoversHands Auto
Keyword Property SLSF_Reloaded_CoversFeet Auto

Actor Player = PlayerScript.PlayerRef

Event OnInit()
	BodyTattooApplied = New Bool[6]
	FaceTattooApplied = New Bool[6]
	HandTattooApplied = New Bool[6]
	FootTattooApplied = New Bool[6]
EndEvent

Bool Function IsPlayerAnonymous()
	If Config.AnonymityEnabled == False
		return False
	EndIf

	If Player.WornHasKeyword(SLSF_Reloaded_HidesIdentity)
		return True
	EndIf
	
	If Mods.IsDDInstalled == True
		If Player.WornHasKeyword(Mods.DD_Hood)
			return True
		EndIf
	EndIf
	
	If Player.GetEquippedArmorInSlot(31).HasKeyword(Mods.SLS_BikiniArmor)
		return False
	ElseIf Player.GetEquippedArmorInSlot(31) != None
		return True
	EndIf
	return False
EndFunction

Int Function CountAppliedTattoos(String TattooArea)
	Int AppliedCount = 0
	Int CountedSlot = 1
	
	While CountedSlot <= 6
		If SlaveTatsScript.get_applied_tattoo_in_slot(Player, TattooArea, CountedSlot) != 0
			If TattooArea == "Body"
				BodyTattooApplied[CountedSlot - 1] = True
			ElseIf TattooArea == "Face"
				FaceTattooApplied[CountedSlot - 1] = True
			ElseIf TattooArea == "Hands"
				HandTattooApplied[CountedSlot - 1] = True
			ElseIf TattooArea == "Feet"
				FootTattooApplied[CountedSlot - 1] = True
			EndIf
			AppliedCount += 1
		Else
			If TattooArea == "Body"
				BodyTattooApplied[CountedSlot - 1] = False
			ElseIf TattooArea == "Face"
				FaceTattooApplied[CountedSlot - 1] = False
			ElseIf TattooArea == "Hands"
				HandTattooApplied[CountedSlot - 1] = False
			ElseIf TattooArea == "Feet"
				FootTattooApplied[CountedSlot - 1] = False
			EndIf
		EndIf
		CountedSlot += 1
	EndWhile
	
	return AppliedCount
EndFunction

Int Function CountVisibleTattoos()
	Int VisibleTattoos = 0
	Int SlotIndex = 0
	While SlotIndex < 6
		If IsBodyTattooVisible(SlotIndex) == True
			VisibleTattoos += 1
		EndIf
		If IsHandTattooVisible(SlotIndex) == True
			VisibleTattoos += 1
		EndIf
		If IsFaceTattooVisible(SlotIndex) == True
			VisibleTattoos += 1
		EndIf
		If IsFootTattooVisible(SlotIndex) == True
			VisibleTattoos += 1
		EndIf
		SlotIndex += 1
	EndWhile
	return VisibleTattoos
EndFunction

Bool Function IsBodyTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Body") == 0 || BodyTattooApplied[SlotNumber] == False
			return False
		EndIf
	EndIf
	
	If Mods.IsSLSInstalled == True && Mods.IsANDInstalled == True
		If BodyTattooSubcategory[SlotNumber] == "None"
			If Player.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Chest"
			If Player.GetFactionRank(Mods.AND_Chest) == 1 || Player.GetFactionRank(Mods.AND_Bra) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Pelvis"
			If Player.GetFactionRank(Mods.AND_Genitals) == 1 || Player.GetFactionRank(Mods.AND_Underwear) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Ass"
			If Player.GetFactionRank(Mods.AND_Ass) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Back"
			If Player.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || Player.GetFactionRank(Mods.AND_Chest) == 1 || Player.GetFactionRank(Mods.AND_Bra) == 1
				If Player.GetEquippedArmorInSlot(46).HasKeyword(Mods.SLS_BikiniArmor) && Player.GetEquippedArmorInSlot(47) == None
					return True
				ElseIf Player.GetEquippedArmorInSlot(46) == None && Player.GetEquippedArmorInSlot(47) == None
					return True
				EndIf
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Body Tattoo Subcategory is invalid.")
		EndIf
	ElseIf Mods.IsSLSInstalled == False && Mods.IsANDInstalled == True
		If BodyTattooSubcategory[SlotNumber] == "None" || BodyTattooSubcategory[SlotNumber] == "Chest"
			If Player.GetFactionRank(Mods.AND_Chest) == 1 || Player.GetFactionRank(Mods.AND_Bra) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Pelvis"
			If Player.GetFactionRank(Mods.AND_Genitals) == 1 || Player.GetFactionRank(Mods.AND_Underwear) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Ass"
			If Player.GetFactionRank(Mods.AND_Ass) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Back"
			If Player.GetFactionRank(Mods.AND_Chest) == 1 || Player.GetFactionRank(Mods.AND_Bra) == 1
				If Player.GetEquippedArmorInSlot(46) == None && Player.GetEquippedArmorInSlot(47) == None
					return True
				EndIf
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Body Tattoo Subcategory is invalid.")
		EndIf
	ElseIf Mods.IsSLSInstalled == True && Mods.IsANDInstalled == False
		If Player.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || Player.GetEquippedArmorInSlot(32) == None
			If (Player.GetEquippedArmorInSlot(46).HasKeyword(Mods.SLS_BikiniArmor) || Player.GetEquippedArmorInSlot(46) == None) && Player.GetEquippedArmorInSlot(47) == None
				return True
			EndIf
		EndIf
	Else
		If Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsChestTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Body") == 0 || BodyTattooApplied[SlotNumber] == False || BodyTattooSubcategory[SlotNumber] != "Chest"
			return False
		EndIf
	EndIf
	
	If Mods.IsANDInstalled == True
		If Player.GetFactionRank(Mods.AND_Chest) == 1 || Player.GetFactionRank(Mods.AND_Bra) == 1
			return True
		EndIf
	ElseIf Mods.IsSLSInstalled == True
		If Player.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	Else
		If Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsPelvicTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Body") == 0 || BodyTattooApplied[SlotNumber] == False || BodyTattooSubcategory[SlotNumber] != "Pelvis"
			return False
		EndIf
	EndIf
	
	If Mods.IsANDInstalled == True
		If Player.GetFactionRank(Mods.AND_Genitals) == 1 || Player.GetFactionRank(Mods.AND_Underwear) == 1
			return True
		EndIf
	ElseIf Mods.IsSLSInstalled == True
		If Player.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	Else
		If Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsAssTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Body") == 0 || BodyTattooApplied[SlotNumber] == False || BodyTattooSubcategory[SlotNumber] != "Ass"
			return False
		EndIf
	EndIf
	
	If Mods.IsANDInstalled == True
		If Player.GetFactionRank(Mods.AND_Ass) == 1
			return True
		EndIf
	ElseIf Mods.IsSLSInstalled == True
		If Player.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	Else
		If Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsFaceTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Face") == 0 || FaceTattooApplied[SlotNumber] == False || IsPlayerAnonymous() == True
			return False
		EndIf
	EndIf
EndFunction

Bool Function IsHandTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Hands") == 0 || HandTattooApplied[SlotNumber] == False || Player.WornHasKeyword(SLSF_Reloaded_CoversHands) || Player.GetEquippedArmorInSlot(33) != None
			return False
		EndIf
	EndIf
EndFunction

Bool Function IsFootTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Feet") == 0 || FootTattooApplied[SlotNumber] == False || Player.WornHasKeyword(SLSF_Reloaded_CoversFeet) || Player.GetEquippedArmorInSlot(37) != None
			return False
		EndIf
	EndIf
EndFunction

Bool Function IsAssCumVisible()
	If Sexlab.CountCumAnal() > 0
		If Mods.IsANDInstalled == True && Player.GetFactionRank(Mods.AND_Ass) == 1
			return True
		ElseIf Mods.IsSLSInstalled == True && Player.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
			return True
		ElseIf Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsVaginalCumVisible()
	If Sexlab.CountCumVagina() > 0
		If Mods.IsANDInstalled == True && Player.GetFactionRank(Mods.AND_Genitals) == 1
			return True
		ElseIf Player.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsOralCumVisible()
	If Sexlab.CountCumOral() > 0 && IsPlayerAnonymous() == False
		return True
	EndIf
	
	return False
EndFunction