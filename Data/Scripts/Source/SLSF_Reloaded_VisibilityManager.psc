ScriptName SLSF_Reloaded_VisibilityManager extends Quest

SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DynamicAnonymity Property DynamicAnonymityScript Auto

SexlabFramework Property Sexlab Auto

Bool[] Property BodyTattooApplied Auto Hidden
Bool[] Property BodyTattooVisible Auto Hidden
Bool[] Property BodyTattooExcluded Auto Hidden
Bool[] Property FaceTattooApplied Auto Hidden
Bool[] Property FaceTattooVisible Auto Hidden
Bool[] Property FaceTattooExcluded Auto Hidden
Bool[] Property HandTattooApplied Auto Hidden
Bool[] Property HandTattooVisible Auto Hidden
Bool[] Property HandTattooExcluded Auto Hidden
Bool[] Property FootTattooApplied Auto Hidden
Bool[] Property FootTattooVisible Auto Hidden
Bool[] Property FootTattooExcluded Auto Hidden

Bool Property DD_BraVisible Auto Hidden
Bool Property DD_BeltVisible Auto Hidden
Bool Property DD_HarnessVisible Auto Hidden
Bool Property DD_CollarVisible Auto Hidden
Bool Property IsWearingUnhideable Auto Hidden
Bool Property UpdateRunning Auto Hidden

String[] Property BodyTattooSubcategory Auto Hidden ;Filled by MCM settings | Chest, Pelvis, Ass, Back, None
String[] Property BodyTattooExtraFameType Auto Hidden ;Filled by MCM settings
String[] Property FaceTattooExtraFameType Auto Hidden
String[] Property HandTattooExtraFameType Auto Hidden
String[] Property FootTattooExtraFameType Auto Hidden

Int Property VisibleBodyTats Auto Hidden

Keyword Property SLSF_Reloaded_HidesIdentity Auto
Keyword Property SLSF_Reloaded_DoesNotHideIdentity Auto
Keyword Property SLSF_Reloaded_CoversHands Auto
Keyword Property SLSF_Reloaded_CoversFeet Auto
Keyword Property SLSF_Reloaded_CoversBack Auto
Keyword Property SLSF_Reloaded_DoesNotCoverHands Auto
Keyword Property SLSF_Reloaded_DoesNotCoverFeet Auto
Keyword Property SLSF_Reloaded_DoesNotCoverBack Auto

Actor Property PlayerRef Auto

GlobalVariable Property OralCumGlobal Auto
GlobalVariable Property AnalCumGlobal Auto
GlobalVariable Property VaginalCumGlobal Auto
GlobalVariable Property IsVisiblyBound Auto
GlobalVariable Property IsHeavilyBound Auto
GlobalVariable Property IsLightlyBound Auto
GlobalVariable Property IsBelted Auto
GlobalVariable Property IsCollared Auto

Event OnInit()
	Startup()
	UpdateTattooSlots()
EndEvent

Function Startup()
	UpdateRunning = False
	
	BodyTattooApplied = New Bool[40]
	BodyTattooVisible = New Bool[40]
	BodyTattooExcluded = New Bool[40]
	
	FaceTattooApplied = New Bool[20]
	FaceTattooVisible = New Bool[20]
	FaceTattooExcluded = New Bool[20]
	
	HandTattooApplied = New Bool[20]
	HandTattooVisible = New Bool[20]
	HandTattooExcluded = New Bool[20]
	
	FootTattooApplied = New Bool[20]
	FootTattooVisible = New Bool[20]
	FootTattooExcluded = New Bool[20]
	
	BodyTattooSubcategory = New String[40]
	BodyTattooExtraFameType = New String[40]
	FaceTattooExtraFameType = New String[20]
	HandTattooExtraFameType = New String[20]
	FootTattooExtraFameType = New String[20]
	
	VisibleBodyTats = 0
	
	Int BodySlotIndex = 0
	While BodySlotIndex < BodyTattooSubcategory.Length
		BodyTattooSubcategory[BodySlotIndex] = "-NONE-"
		BodySlotIndex += 1
	EndWhile
EndFunction

Function UpdateTattooSlots()
	If Config.TattooLimitUnlocked == False
		If Mods.IsSlaveTatsInstalled == True
			Int SlotCount = 0
			SlotCount = SlaveTats.SLOTS("Body")
			If SlotCount > 20
				SlotCount = 20
			EndIf
			Config.BodyTattooSlots = SlotCount
			
			SlotCount = SlaveTats.SLOTS("Face")
			If SlotCount > 10
				SlotCount = 10
			EndIf
			Config.FaceTattooSlots = SlotCount
			
			SlotCount = SlaveTats.SLOTS("Hands")
			If SlotCount > 10
				SlotCount = 10
			EndIf
			Config.HandTattooSlots = SlotCount
			
			SlotCount = SlaveTats.SLOTS("Feet")
			If SlotCount > 10
				SlotCount = 10
			EndIf
			Config.FootTattooSlots = SlotCount
		EndIf
	Else
		If Mods.IsSlaveTatsInstalled == True
			Int SlotCount = 0
			SlotCount = SlaveTats.SLOTS("Body")
			If SlotCount > Config.BodyTattooLimit
				SlotCount = Config.BodyTattooLimit
			EndIf
			Config.BodyTattooSlots = SlotCount
			
			SlotCount = SlaveTats.SLOTS("Face")
			If SlotCount > Config.FaceTattooLimit
				SlotCount = Config.FaceTattooLimit
			EndIf
			Config.FaceTattooSlots = SlotCount
			
			SlotCount = SlaveTats.SLOTS("Hands")
			If SlotCount > Config.HandTattooLimit
				SlotCount = Config.HandTattooLimit
			EndIf
			Config.HandTattooSlots = SlotCount
			
			SlotCount = SlaveTats.SLOTS("Feet")
			If SlotCount > Config.FootTattooLimit
				SlotCount = Config.FootTattooLimit
			EndIf
			Config.FootTattooSlots = SlotCount
		EndIf
	EndIf
EndFunction

Event OnUpdate()
	UpdateRunning = True
	
	If Config.TattooLimitUnlocked == True
		Debug.Trace("SLSF RELOADED TATTOO LIMIT IS UNLOCKED!!! STACK DUMP REPORTS ARE NOW INVALID!!!")
	EndIf
	
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
	
	UpdateRunning = False
EndEvent

Bool Function IsPlayerAnonymous()
	If Config.AnonymityEnabled == False
		return False
	EndIf
	
	If Config.DynamicAnonymity == True
		return DynamicAnonymityScript.IsAnonymous
	Else
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
	EndIf
	return False
EndFunction

Function CheckAppliedTattoos()
	If Mods.IsSlaveTatsInstalled == False
		return
	EndIf
	Int CheckedSlot = 0
	
	While CheckedSlot < Config.BodyTattooSlots
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Body", CheckedSlot) != 0 && BodyTattooExcluded[CheckedSlot] == False
			BodyTattooApplied[CheckedSlot] = True
		Else
			BodyTattooApplied[CheckedSlot] = False
		EndIf
		CheckedSlot += 1
	EndWhile
	
	CheckedSlot = 0
	While CheckedSlot < Config.FaceTattooSlots
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Face", CheckedSlot) != 0 && FaceTattooExcluded[CheckedSlot] == False
			FaceTattooApplied[CheckedSlot] = True
		Else
			FaceTattooApplied[CheckedSlot] = False
		EndIf
		CheckedSlot += 1
	EndWhile
	
	CheckedSlot = 0
	While CheckedSlot < Config.HandTattooSlots
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Hands", CheckedSlot) != 0 && HandTattooExcluded[CheckedSlot] == False
			HandTattooApplied[CheckedSlot] = True
		Else
			HandTattooApplied[CheckedSlot] = False
		EndIf
		CheckedSlot += 1
	EndWhile
	
	CheckedSlot = 0
	While CheckedSlot < Config.FootTattooSlots
		If SlaveTats.get_applied_tattoo_in_slot(PlayerRef, "Feet", CheckedSlot) != 0 && FootTattooExcluded[CheckedSlot] == False
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
	Int TotalSlots = 0
	
	If TattooArea == "Body"
		TotalSlots = Config.BodyTattooSlots
	ElseIf TattooArea == "Face"
		TotalSlots = Config.FaceTattooSlots
	ElseIf TattooArea == "Hands"
		TotalSlots = Config.HandTattooSlots
	ElseIf TattooArea == "Feet"
		TotalSlots = Config.FootTattooSlots
	EndIf
	
	While CountedIndex < TotalSlots
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
	
	While SlotIndex < Config.BodyTattooSlots
		If IsBodyTattooVisible(SlotIndex) == True
			BodyTattooVisible[SlotIndex] = True
			VisibleTattoos += 1
			VisibleBodyTats += 1
		Else
			BodyTattooVisible[SlotIndex] = False
		EndIf
		SlotIndex += 1
	EndWhile
	
	SlotIndex = 0
	While SlotIndex < Config.HandTattooSlots
		If IsHandTattooVisible(SlotIndex) == True
			HandTattooVisible[SlotIndex] = True
			VisibleTattoos += 1
		Else
			HandTattooVisible[SlotIndex] = False
		EndIf
		SlotIndex += 1
	EndWhile
	
	SlotIndex = 0
	While SlotIndex < Config.FaceTattooSlots
		If IsFaceTattooVisible(SlotIndex) == True
			FaceTattooVisible[SlotIndex] = True
			VisibleTattoos += 1
		Else
			FaceTattooVisible[SlotIndex] = False
		EndIf
		SlotIndex += 1
	EndWhile
	
	SlotIndex = 0
	While SlotIndex < Config.FootTattooSlots
		If IsFootTattooVisible(SlotIndex) == True
			FootTattooVisible[SlotIndex] = True
			VisibleTattoos += 1
		Else
			FootTattooVisible[SlotIndex] = False
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
		If BodyTattooSubcategory[SlotNumber] == "-NONE-"
			If PlayerRef.GetEquippedArmorInSlot(32) != None
				If PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 \
				|| PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1
					return True
				EndIf
			Else
				If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1
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
							If PlayerRef.GetEquippedArmorInSlot(46).HasKeyword(Mods.SLS_BikiniArmor) && (PlayerRef.GetEquippedArmorInSlot(47) == None || PlayerRef.GetEquippedArmorInSlot(47).HasKeyword(SLSF_Reloaded_DoesNotCoverBack))
								return True
							EndIf
						ElseIf PlayerRef.GetEquippedArmorInSlot(47) == None || PlayerRef.GetEquippedArmorInSlot(47).HasKeyword(SLSF_Reloaded_DoesNotCoverBack)
							return True
						EndIf
					EndIf
				Else
					If PlayerRef.GetEquippedArmorInSlot(46) != None 
						If PlayerRef.GetEquippedArmorInSlot(46).HasKeyword(Mods.SLS_BikiniArmor) && (PlayerRef.GetEquippedArmorInSlot(47) == None || PlayerRef.GetEquippedArmorInSlot(47).HasKeyword(SLSF_Reloaded_DoesNotCoverBack))
							return True
						EndIf
					ElseIf PlayerRef.GetEquippedArmorInSlot(47) == None || PlayerRef.GetEquippedArmorInSlot(47).HasKeyword(SLSF_Reloaded_DoesNotCoverBack)
						return True
					EndIf
				EndIf
			Else
				return False
			EndIf
		ElseIf BodyTattooSubcategory[SlotNumber] == "Thigh"
			If PlayerRef.GetEquippedArmorInSlot(53) != None || (PlayerRef.GetEquippedArmorInSlot(32) != None && !PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor))
				return False
			EndIf
			return True
		ElseIf BodyTattooSubcategory[SlotNumber] == "Calves"
			If PlayerRef.GetEquippedArmorInSlot(37) != None || PlayerRef.GetEquippedArmorInSlot(54) != None
				return False
			EndIf
			return True
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Body Tattoo Subcategory is invalid.")
		EndIf
	ElseIf Mods.IsSLSInstalled == False && Mods.IsANDInstalled == True
		If BodyTattooSubcategory[SlotNumber] == "-NONE-"
			If PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1 || PlayerRef.GetFactionRank(Mods.AND_Underwear) == 1
				return True
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
			If !PlayerRef.WornHasKeyword(SLSF_Reloaded_CoversBack) && (PlayerRef.GetFactionRank(Mods.AND_Chest) == 1 || PlayerRef.GetFactionRank(Mods.AND_Bra) == 1)
				If (PlayerRef.GetEquippedArmorInSlot(46) == None || PlayerRef.GetEquippedArmorInSlot(46).HasKeyword(SLSF_Reloaded_DoesNotCoverBack)) && (PlayerRef.GetEquippedArmorInSlot(47) == None || PlayerRef.GetEquippedArmorInSlot(47).HasKeyword(SLSF_Reloaded_DoesNotCoverBack))
					return True
				EndIf
			EndIf
		Else
			Debug.MessageBox("SLSF Reloaded - ERROR: Body Tattoo Subcategory is invalid.")
		EndIf
	ElseIf Mods.IsSLSInstalled == True && Mods.IsANDInstalled == False
		If PlayerRef.GetEquippedArmorInSlot(32) == None || PlayerRef.GetEquippedArmorInSlot(32).HasKeyword(Mods.SLS_BikiniArmor)
			If (PlayerRef.GetEquippedArmorInSlot(46) == None || PlayerRef.GetEquippedArmorInSlot(46).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetEquippedArmorInSlot(46).HasKeyword(SLSF_Reloaded_DoesNotCoverBack)) && (PlayerRef.GetEquippedArmorInSlot(47) == None || PlayerRef.GetEquippedArmorInSlot(47).HasKeyword(SLSF_Reloaded_DoesNotCoverBack))
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

Bool Function IsFaceTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Face") == 0 || FaceTattooApplied[SlotNumber] == False
			return False
		EndIf
		
		If Config.AnonymityEnabled == True && Config.DynamicAnonymity == False
			If IsPlayerAnonymous() == True
				return False
			EndIf
		Else
			If PlayerRef.WornHasKeyword(SLSF_Reloaded_HidesIdentity)
				return False
			EndIf
			
			If Mods.IsDDInstalled == True
				If PlayerRef.WornHasKeyword(Mods.DD_Hood)
					return False
				EndIf
			EndIf
			
			If PlayerRef.GetEquippedArmorInSlot(31) != None
				If PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(SLSF_Reloaded_DoesNotHideIdentity)
					return True
				Else
					return False
				EndIf
			EndIf
		EndIf
	EndIf
	return True
EndFunction

Bool Function IsHandTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Hands") == 0 || HandTattooApplied[SlotNumber] == False || PlayerRef.WornHasKeyword(SLSF_Reloaded_CoversHands)
			return False
		ElseIf PlayerRef.GetEquippedArmorInSlot(33) != None && PlayerRef.GetEquippedArmorInSlot(33).HasKeyword(SLSF_Reloaded_DoesNotCoverHands) == False
			return False
		EndIf
	EndIf
	return True
EndFunction

Bool Function IsFootTattooVisible(Int SlotNumber)
	If Mods.IsSlaveTatsInstalled == False
		return False
	Else
		If CountAppliedTattoos("Feet") == 0 || FootTattooApplied[SlotNumber] == False || PlayerRef.WornHasKeyword(SLSF_Reloaded_CoversFeet)
			return False
		ElseIf PlayerRef.GetEquippedArmorInSlot(37) != None && PlayerRef.GetEquippedArmorInSlot(37).HasKeyword(SLSF_Reloaded_DoesNotCoverFeet) == False
			return False
		EndIf
	EndIf
	return True
EndFunction

Bool Function IsAssCumVisible()
	If Mods.IsSLACSInstalled == True
		If Mods.SLACS.CountCumAnal(PlayerRef) > 0
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
	Else
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
	EndIf
	
	return False
EndFunction

Bool Function IsVaginalCumVisible()
	If PlayerRef.GetActorBase().GetSex() == 0 ;Exclude Males
		return False
	EndIf
	
	If Mods.IsSLACSInstalled == True
		If Mods.SLACS.CountCumVaginal(PlayerRef) > 0
			If Mods.IsANDInstalled == True
				If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1
					return True
				EndIf
			ElseIf PlayerRef.GetEquippedArmorInSlot(32) == None
				return True
			EndIf
		EndIf
	Else
		If Sexlab.CountCumVaginal(PlayerRef) > 0
			If Mods.IsANDInstalled == True
				If PlayerRef.GetFactionRank(Mods.AND_Genitals) == 1
					return True
				EndIf
			ElseIf PlayerRef.GetEquippedArmorInSlot(32) == None
				return True
			EndIf
		EndIf
	EndIf
	
	return False
EndFunction

Bool Function IsOralCumVisible()
	If Mods.IsSLACSInstalled == True
		If Mods.SLACS.CountCumOral(PlayerRef) > 0
			If PlayerRef.WornHasKeyword(SLSF_Reloaded_HidesIdentity)
				return False
			EndIf
			
			If Mods.IsDDInstalled == True
				If PlayerRef.WornHasKeyword(Mods.DD_Hood)
					return False
				EndIf
			EndIf
			
			If PlayerRef.GetEquippedArmorInSlot(31) != None
				If PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(SLSF_Reloaded_DoesNotHideIdentity)
					return True
				Else
					return False
				EndIf
			EndIf
			return True
		EndIf
	Else
		If Sexlab.CountCumOral(PlayerRef) > 0
			If PlayerRef.WornHasKeyword(SLSF_Reloaded_HidesIdentity)
				return False
			EndIf
			
			If Mods.IsDDInstalled == True
				If PlayerRef.WornHasKeyword(Mods.DD_Hood)
					return False
				EndIf
			EndIf
			
			If PlayerRef.GetEquippedArmorInSlot(31) != None
				If PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(Mods.SLS_BikiniArmor) || PlayerRef.GetEquippedArmorInSlot(31).HasKeyword(SLSF_Reloaded_DoesNotHideIdentity)
					return True
				Else
					return False
				EndIf
			EndIf
			return True
		EndIf
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
	Armor DD_CollarSlot = PlayerRef.GetEquippedArmorInSlot(45)
	
	DD_BraVisible = False
	DD_BeltVisible = False
	DD_HarnessVisible = False
	DD_CollarVisible = False
	IsWearingUnhideable = False
	
	If PlayerRef.WornHasKeyword(Mods.DD_HeavyBondage)
		IsLightlyBound.SetValue(0)
		IsHeavilyBound.SetValue(1)
		IsVisiblyBound.SetValue(1)
	ElseIf PlayerRef.WornHasKeyword(Mods.DD_Lockable) 
		If (DD_CollarSlot != None || DD_BraSlot != None || DD_BeltSlot != None || DD_HarnessSlot != None)
			;Collar Check
			;NOTE - I'm not aware of a good way to check if a collar is "hidden", therefore I'm assuming all collars are visible if worn
			If DD_CollarSlot != None
				If DD_CollarSlot.HasKeyword(Mods.DD_Collar)
					If Mods.IsSLSInstalled == True
						If Config.AllowCollarBoundFame == True
							If PlayerRef.HasMagicEffect(Mods.SLS_CollarCurse) == True && Config.AllowSLSCursedCollarBoundFame == True
								DD_CollarVisible = True
							ElseIf PlayerRef.HasMagicEffect(Mods.SLS_CollarCurse) == False
								DD_CollarVisible = True
							EndIf
						EndIf
					ElseIf Config.AllowCollarBoundFame == True
						DD_CollarVisible = True
					EndIf
				EndIf
			EndIf
			
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
			ElseIf DD_HarnessSlot != None
				If DD_HarnessSlot.HasKeyword(Mods.DD_Belt)
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
		EndIf
		
		If PlayerRef.WornHasKeyword(Mods.DD_Hood) || PlayerRef.WornHasKeyword(Mods.DD_Gag) || PlayerRef.WornHasKeyword(Mods.DD_GagPanel) || PlayerRef.WornHasKeyword(Mods.DD_ArmCuffs) \
		|| PlayerRef.WornHasKeyword(Mods.DD_ArmCuffsFront) || PlayerRef.WornHasKeyword(Mods.DD_Armbinder) || PlayerRef.WornHasKeyword(Mods.DD_ArmbinderElbow) || PlayerRef.WornHasKeyword(Mods.DD_Gloves) \
		|| PlayerRef.WornHasKeyword(Mods.DD_LegCuffs) || PlayerRef.WornHasKeyword(Mods.DD_Boots) || PlayerRef.WornHasKeyword(Mods.DD_Suit) || PlayerRef.WornHasKeyword(Mods.DD_Corset) || PlayerRef.WornHasKeyword(Mods.DD_Blindfold)
			IsWearingUnhideable = True
		EndIf
		
		If DD_CollarVisible == True || DD_BraVisible == True || DD_BeltVisible == True || DD_HarnessVisible == True || IsWearingUnhideable == True
			IsVisiblyBound.SetValue(1)
		Else
			IsVisiblyBound.SetValue(0)
		EndIf
		
		IsLightlyBound.SetValue(1)
		IsHeavilyBound.SetValue(0)
	Else
		IsVisiblyBound.SetValue(0)
		IsLightlyBound.SetValue(0)
		IsHeavilyBound.SetValue(0)
	EndIf
	
	If IsPlayerAnonymous() == True
		IsVisiblyBound.SetValue(0)
	EndIf
	
	If PlayerRef.WornHasKeyword(Mods.DD_Belt)
		IsBelted.SetValue(1) ;True
	Else
		IsBelted.SetValue(0) ;False
	EndIf
	
	If PlayerRef.WornHasKeyword(Mods.DD_Collar)
		IsCollared.SetValue(1) ;True
	Else
		IsCollared.SetValue(0) ;False
	EndIf
EndFunction