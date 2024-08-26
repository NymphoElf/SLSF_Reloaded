ScriptName SLSF_Reloaded_VisibilityManager extends Quest

SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_MCM Property Config Auto

SexlabFramework Property Sexlab Auto

;SlaveTats Property SlaveTatsScript Auto

Bool[] Property BodyTattooApplied Auto Hidden
Bool[] Property FaceTattooApplied Auto Hidden
Bool[] Property HandTattooApplied Auto Hidden
Bool[] Property FootTattooApplied Auto Hidden

String[] Property BodyTattooSubcategory Auto ;Size = 6, Default = None. Filled by MCM settings | Chest, Pelvis, Ass, Back, None
String[] Property BodyTattooExtraFameType Auto ;Size = 6, Default = None. Filled by MCM settings
String[] Property FaceTattooExtraFameType Auto
String[] Property HandTattooExtraFameType Auto
String[] Property FootTattooExtraFameType Auto

Int Property VisibleBodyTats Auto

Keyword Property SLSF_Reloaded_HidesIdentity Auto
Keyword Property SLSF_Reloaded_DoesNotHideIdentity Auto
Keyword Property SLSF_Reloaded_CoversHands Auto
Keyword Property SLSF_Reloaded_CoversFeet Auto
Keyword Property SLSF_Reloaded_CoversBack Auto

Actor Property PlayerRef Auto ; = PlayerScript.PlayerRef

GlobalVariable Property OralCumGlobal Auto
GlobalVariable Property AnalCumGlobal Auto
GlobalVariable Property VaginalCumGlobal Auto
GlobalVariable Property IsVisiblyBound Auto
GlobalVariable Property IsHeavilyBound Auto
GlobalVariable Property IsLightlyBound Auto

Event OnInit()
	Startup()
EndEvent

Function Startup()
	BodyTattooApplied = New Bool[6]
	FaceTattooApplied = New Bool[6]
	HandTattooApplied = New Bool[6]
	FootTattooApplied = New Bool[6]
	
	VisibleBodyTats = 0
	
	Int BodySlotIndex = 0
	While BodySlotIndex < BodyTattooSubcategory.Length
		BodyTattooSubcategory[BodySlotIndex] = "(None)"
		BodySlotIndex += 1
	EndWhile
EndFunction

Event OnUpdate()
	If IsOralCumVisible() == True
		OralCumGlobal.SetValue(1)
	Else
		OralCumGlobal.SetValue(0)
	EndIf
	
	If IsAssCumVisible() == True
		AnalCumGlobal.SetValue(1)
	Else
		AnalCumGlobal.SetValue(0)
	EndIf
	
	If IsVaginalCumVisible() == True
		VaginalCumGlobal.SetValue(1)
	Else
		VaginalCumGlobal.SetValue(0)
	EndIf
	
	CheckAppliedTattoos()
	CountVisibleTattoos()
	CheckBondage()
EndEvent

Bool Function IsPlayerAnonymous()
	If Config.AnonymityEnabled == False
		return False
	EndIf

	If PlayerRef.WornHasKeyword(SLSF_Reloaded_HidesIdentity)
		return True
	EndIf
	
	If Mods.IsDDInstalled == True
		If PlayerRef.WornHasKeyword(Mods.DD_Hood)
			return True
		EndIf
	EndIf
	
	If PlayerRef.GetEquippedArmorInSlot(31) != None
		If PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(SLSF_Reloaded_DoesNotHideIdentity)
			return False
		Else
			return True
		EndIf
	EndIf
	return False
EndFunction

Function CheckAppliedTattoos()
	If Mods.IsSlaveTatsInstalled == False
		return
	EndIf
	Int CheckedSlot = 0
	
	While CheckedSlot < 6
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Body", CheckedSlot) != 0
			BodyTattooApplied[CheckedSlot] = True
		Else
			BodyTattooApplied[CheckedSlot] = False
		EndIf
		
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Face", CheckedSlot) != 0
			FaceTattooApplied[CheckedSlot] = True
		Else
			FaceTattooApplied[CheckedSlot] = False
		EndIf
		
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Hands", CheckedSlot) != 0
			HandTattooApplied[CheckedSlot] = True
		Else
			HandTattooApplied[CheckedSlot] = False
		EndIf
		
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Feet", CheckedSlot) != 0
			FootTattooApplied[CheckedSlot] = True
		Else
			FootTattooApplied[CheckedSlot] = False
		EndIf
		CheckedSlot += 1
	EndWhile
EndFunction

Int Function CountAppliedTattoos(String TattooArea)
	If Mods.IsSlaveTatsInstalled == False
		return 0
	EndIf
	Int AppliedCount = 0
	Int CountedIndex = 0
	
	While CountedIndex < 6
		If TattooArea == "Body" && BodyTattooApplied[CountedIndex] == True
			AppliedCount += 1
		EndIf
		
		If TattooArea == "Face" && FaceTattooApplied[CountedIndex] == True
			AppliedCount += 1
		EndIf
		
		If TattooArea == "Hands" && HandTattooApplied[CountedIndex] == True
			AppliedCount += 1
		EndIf
		
		If TattooArea == "Feet" && FootTattooApplied[CountedIndex] == True
			AppliedCount += 1
		EndIf
		CountedIndex += 1
	EndWhile
	
	return AppliedCount
EndFunction

Int Function CountVisibleTattoos()
	If Mods.IsSlaveTatsInstalled == False
		VisibleBodyTats = 0
		return 0
	EndIf
	
	VisibleBodyTats = 0
	Int VisibleTattoos = 0
	Int SlotIndex = 0
	
	While SlotIndex < 6
		If IsBodyTattooVisible(SlotIndex) == True
			VisibleTattoos += 1
			VisibleBodyTats += 1
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
		If BodyTattooSubcategory[SlotNumber] == "(None)"
			If PlayerRef.GetEquippedArmorInSlot(32) != None
				If PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1
					return True
				EndIf
			Else
				If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1
					return True
				EndIf
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Chest"
			If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Pelvis"
			If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Ass"
			If PlayerRef.GetFactionRank(Mods.AND_Ass) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Back"
			If !PlayerRef.WornHasKeyword(SLSF_Reloaded_CoversBack)
				If PlayerRef.GetEquippedArmorInSlot(32) != None 
					If PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1
						If PlayerRef.GetEquippedArmorInSlot(46) != None 
							If PlayerRef.GetEquippedArmorInSlot(46).HasKeyword(Mods.SLS_BikiniArmor) && PlayerRef.GetEquippedArmorInSlot(47) == None
								return True
							EndIf
						ElseIf PlayerRef.GetEquippedArmorInSlot(47) == None
							return True
						EndIf
					EndIf
				EndIf
			Else
				return False
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Body Tattoo Subcategory is invalid.")
		EndIf
	ElseIf Mods.IsSLSInstalled == False && Mods.IsANDInstalled == True
		If BodyTattooSubcategory[SlotNumber] == "(None)" || BodyTattooSubcategory[SlotNumber] == "Chest"
			If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Pelvis"
			If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Ass"
			If PlayerRef.GetFactionRank(Mods.AND_Ass) == 1
				return True
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Back"
			If !PlayerRef.WornHasKeyword(SLSF_Reloaded_CoversBack) && (PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1)
				If PlayerRef.GetEquippedArmorInSlot(46) == None && PlayerRef.GetEquippedArmorInSlot(47) == None
					return True
				EndIf
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Body Tattoo Subcategory is invalid.")
		EndIf
	ElseIf Mods.IsSLSInstalled == True && Mods.IsANDInstalled == False
		If PlayerRef.GetEquippedArmorInSlot(32) == None || PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
			If (PlayerRef.GetEquippedArmorInSlot(46) == None || PlayerRef.GetEquippedArmorInSlot(46).HasKeyword(Mods.SLS_BikiniArmor)) && PlayerRef.GetEquippedArmorInSlot(47) == None
				return True
			EndIf
		EndIf
	Else
		If PlayerRef.GetEquippedArmorInSlot(32) == None
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
		If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1
			return True
		EndIf
	ElseIf Mods.IsSLSInstalled == True
		If PlayerRef.GetEquippedArmorInSlot(32) == None || PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
			return True
		EndIf
	Else
		If PlayerRef.GetEquippedArmorInSlot(32) == None
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
		If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1
			return True
		EndIf
	ElseIf Mods.IsSLSInstalled == True
		If PlayerRef.GetEquippedArmorInSlot(32) == None || PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
			return True
		EndIf
	Else
		If PlayerRef.GetEquippedArmorInSlot(32) == None
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
		If PlayerRef.GetFactionRank(Mods.AND_Ass) == 1
			return True
		EndIf
	ElseIf Mods.IsSLSInstalled == True
		If PlayerRef.GetEquippedArmorInSlot(32) == None || PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
			return True
		EndIf
	Else
		If PlayerRef.GetEquippedArmorInSlot(32) == None
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
	return True
EndFunction

Bool Function IsHandTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Hands") == 0 || HandTattooApplied[SlotNumber] == False || PlayerRef.WornHasKeyword(SLSF_Reloaded_CoversHands) || PlayerRef.GetEquippedArmorInSlot(33) != None
			return False
		EndIf
	EndIf
	return True
EndFunction

Bool Function IsFootTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Feet") == 0 || FootTattooApplied[SlotNumber] == False || PlayerRef.WornHasKeyword(SLSF_Reloaded_CoversFeet) || PlayerRef.GetEquippedArmorInSlot(37) != None
			return False
		EndIf
	EndIf
	return True
EndFunction

Bool Function IsAssCumVisible()
	If Sexlab.CountCumAnal(PlayerRef) > 0
		If Mods.IsANDInstalled == True
			If PlayerRef.GetFactionRank(Mods.AND_Ass) == 1
				return True
			EndIf
		ElseIf Mods.IsSLSInstalled == True && PlayerRef.GetEquippedArmorInSlot(32) != None
			If PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
				return True
			EndIf
		ElseIf PlayerRef.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsVaginalCumVisible()
	If Sexlab.CountCumVaginal(PlayerRef) > 0
		If Mods.IsANDInstalled == True
			If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1
				return True
			EndIf
		ElseIf PlayerRef.GetEquippedArmorInSlot(32) == None
			return True
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsOralCumVisible()
	If Sexlab.CountCumOral(PlayerRef) > 0 && IsPlayerAnonymous() == False
		return True
	EndIf
	
	return False
EndFunction

Function CheckBondage()
	If Mods.IsDDInstalled == False
		If IsVisiblyBound.GetValue() != 0
			IsVisiblyBound.SetValue(0)
		EndIf
		
		If IsLightlyBound.GetValue() != 0
			IsLightlyBound.SetValue(0)
		EndIf
		
		If IsHeavilyBound.GetValue() != 0
			IsHeavilyBound.SetValue(0)
		EndIf
		
		return
	EndIf
	
	Armor BodySlot = PlayerRef.GetEquippedArmorInSlot(32)
	Armor DD_BraSlot = PlayerRef.GetEquippedArmorInSlot(56)
	Armor DD_BeltSlot = PlayerRef.GetEquippedArmorInSlot(49)
	Armor DD_HarnessSlot = PlayerRef.GetEquippedArmorInSlot(58)
	
	Bool DD_BraVisible = False
	Bool DD_BeltVisible = False
	Bool DD_HarnessVisible = False
	
	If PlayerRef.WornHasKeyword(Mods.DD_HeavyBondage)
		IsLightlyBound.SetValue(0)
		IsHeavilyBound.SetValue(1)
		IsVisiblyBound.SetValue(1)
	ElseIf PlayerRef.WornHasKeyword(Mods.DD_Lockable) && (DD_BraSlot != None || DD_BeltSlot != None || DD_HarnessSlot != None)
		IsLightlyBound.SetValue(1)
		IsHeavilyBound.SetValue(0)
		
		;Bra Check
		If DD_BraSlot != None
			If DD_BraSlot.HasKeyword(Mods.DD_Bra)
				If Mods.IsANDInstalled == True && (PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Chest) == 1)
					DD_BraVisible = True
				ElseIf BodySlot == None
					DD_BraVisible = True
				EndIf
			EndIf
		EndIf
		
		;Belt Check
		If DD_BeltSlot != None
			If DD_BeltSlot.HasKeyword(Mods.DD_Belt)
				If Mods.IsANDInstalled == True && (PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1 || PlayerRef.GetFactionRank(Mods.AND_Ass) == 1 || PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1)
					DD_BeltVisible = True
				ElseIf BodySlot == None
					DD_BeltVisible = True
				EndIf
			EndIf
		EndIf
		
		;Harness Check
		If DD_HarnessSlot != None
			If DD_HarnessSlot.HasKeyword(Mods.DD_Harness)
				If Mods.IsANDInstalled == True && (PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Chest) == 1)
					DD_HarnessVisible = True
				ElseIf BodySlot == None
					DD_HarnessVisible = True
				EndIf
			EndIf
		EndIf
		
		If DD_BraVisible == True || DD_BeltVisible == True || DD_HarnessVisible == True
			IsVisiblyBound.SetValue(1)
		Else
			IsVisiblyBound.SetValue(0)
		EndIf
	ElseIf PlayerRef.WornHasKeyword(Mods.DD_Hood) && Config.AnonymityEnabled == False
		IsHeavilyBound.SetValue(0)
		IsLightlyBound.SetValue(1)
		IsVisiblyBound.SetValue(1)
	Else
		IsVisiblyBound.SetValue(0)
		IsLightlyBound.SetValue(0)
		IsHeavilyBound.SetValue(0)
	EndIf
	
	If IsPlayerAnonymous() == True
		IsVisiblyBound.SetValue(0)
	EndIf
EndFunction