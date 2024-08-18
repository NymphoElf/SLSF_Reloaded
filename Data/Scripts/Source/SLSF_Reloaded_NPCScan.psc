ScriptName SLSF_Reloaded_NPCScan extends ActiveMagicEffect

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_MCM Property Config Auto
SexlabFramework Property Sexlab Auto

Actor Property PlayerRef Auto
GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	String CurrentLocation = ""
	If LocationManager.CurrentLocation != None
		CurrentLocation = LocationManager.CurrentLocationName()
	Else
		return
	EndIf
	
	If Sexlab.IsActorActive(akTarget) == True
		return
	EndIf
	
	If LocationManager.IsLocationValid(CurrentLocation) == False
		return
	EndIf
	
	If Config.NPCNeedsLOS && !akTarget.HasLOS(PlayerRef)
		If akTarget.GetDistance(PlayerRef) > Config.MinimumNPCLOSDistance
			return
		EndIf
	EndIf
	
	Int FameChance = 0
	Int Relationship = akTarget.GetRelationshipRank(PlayerRef)

	If Relationship < 0	;Enemy
		FameChance = Config.FameChanceByEnemy as Int
	ElseIf Relationship == 0 ;Neutral
		FameChance = Config.FameChanceByNeutral as Int
	ElseIf Relationship >= 1 && Relationship < 4 ;Friend
		FameChance = Config.FameChanceByFriend as Int
	Else ;Relationship == 4 ;Lover
		FameChance = Config.FameChanceByLover as Int
	EndIf
	
	If Utility.RandomInt(1, 100) <= FameChance && SLSF_Reloaded_NPCScanSucess.GetValue() == 0
		SLSF_Reloaded_NPCScanSucess.SetValue(1)
		FameManager.FameGainRoll(CurrentLocation)
	EndIf
EndEvent