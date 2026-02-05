ScriptName SLSF_Reloaded_NPCScan extends ActiveMagicEffect

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_Logger Property Logger Auto
SexlabFramework Property Sexlab Auto

Actor Property PlayerRef Auto
GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto
String Property CurrentLocation Auto Hidden

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] <NPC Scan> [OnEffectStart] Target is: " + akTarget)
	CurrentLocation = LocationManager.CurrentLocationName()
	
	If LocationManager.IsLocationValid(CurrentLocation) == False
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Location: " + CurrentLocation + " is invalid")
		return
	EndIf
	
	If akTarget.IsDead()
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " (" + akTarget.GetName() + ") is Dead")
		return
	EndIf
	
	If akTarget.IsInCombat()
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " (" + akTarget.GetName() + ") is in Combat")
		return
	EndIf
	
	If Sexlab.IsActorActive(akTarget) == True
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " (" + akTarget.GetName() + ") is active in Sexlab")
		return
	EndIf
	
	If Config.NPCNeedsLOS == True
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] NPCs require LOS")
		If !akTarget.HasLOS(PlayerRef)
			SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " (" + akTarget.GetName() + ") does NOT have LOS.")
			If akTarget.GetDistance(PlayerRef) > Config.MinimumNPCLOSDistance
				SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " (" + akTarget.GetName() + ") is beyond Minimum LOS Distance: " + Config.MinimumNPCLOSDistance)
				SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " (" + akTarget.GetName() + ") distance is: " + akTarget.GetDistance(PlayerRef))
				return
			EndIf
		ElseIf !PlayerRef.IsDetectedBy(akTarget)
			SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " (" + akTarget.GetName() + ") DOES have LOS but is not detecting player.")
			return
		EndIf
	EndIf
	
	Int FameChance = 0
	Int Relationship = akTarget.GetRelationshipRank(PlayerRef)
	Int FameRoll = Utility.RandomInt(1, 100)
	Bool IsFriend = False
	Bool IsLover = False

	If Relationship < 0	;Enemy
		FameChance = Config.FameChanceByEnemy as Int
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " reltionship is ENEMY. Value: " + Relationship)
	ElseIf Relationship == 0 ;Neutral
		FameChance = Config.FameChanceByNeutral as Int
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " reltionship is NEUTRAL. Value: " + Relationship)
	ElseIf Relationship > 0 && Relationship < 4 ;Friend
		FameChance = Config.FameChanceByFriend as Int
		IsFriend = True
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " reltionship is FRIEND. Value: " + Relationship)
	Else ;Relationship == 4 ;Lover
		FameChance = Config.FameChanceByLover as Int
		IsLover = True
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " reltionship is LOVER. Value: " + Relationship)
	EndIf
	
	If FameRoll <= FameChance && SLSF_Reloaded_NPCScanSucess.GetValue() == 0
		SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " succeeded fame gain roll. Fame Roll was: " + FameRoll + ". Needed to be equal or lower than: " + FameChance)
		SLSF_Reloaded_NPCScanSucess.SetValue(1)
		FameManager.FameGainRoll(CurrentLocation, False, IsFriend, IsLover)
	Else
		If SLSF_Reloaded_NPCScanSucess.GetValue() == 0
			SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " failed fame gain roll. Fame Roll was: " + FameRoll + ". Needed to be equal or lower than: " + FameChance)
		Else
			SLSF_Reloaded_Logger.Log("<NPC Scan> [OnEffectStart] Target " + akTarget + " failed fame gain roll because a previously checked NPC already succeeded.")
		EndIf
	EndIf
EndEvent