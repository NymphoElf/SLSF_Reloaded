ScriptName SLSF_Reloaded_NPCScan extends ActiveMagicEffect

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_MCM Property Config Auto

Actor Property PlayerRef Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	String CurrentLocation = ""
	If LocationManager.CurrentLocation != None
		CurrentLocation = LocationManager.CurrentLocationName()
	Else
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
		FameChance = Config.FameChanceByEnemy
	ElseIf Relationship == 0 ;Neutral
		FameChance = Config.FameChanceByNeutral
	ElseIf Relationship >= 1 && Relationship < 4 ;Friend
		FameChance = Config.FameChanceByFriend
	Else ;Relationship == 4 ;Lover
		FameChance = Config.FameChanceByLover
	EndIf
	
	If Utility.RandomInt(1, 100) <= FameChance
		FameManager.FameGainRoll(CurrentLocation)
	EndIf
EndEvent