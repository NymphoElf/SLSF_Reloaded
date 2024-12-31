ScriptName SLSF_Reloaded_NPCScan extends ActiveMagicEffect

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_MCM Property Config Auto
SexlabFramework Property Sexlab Auto

Actor Property PlayerRef Auto
GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto
String Property CurrentLocation Auto Hidden

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded NPC Scanner - Target is: " + akTarget)
	EndIf
	CurrentLocation = LocationManager.CurrentLocationName()
	
	If LocationManager.IsLocationValid(CurrentLocation) == False
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - Location: " + CurrentLocation + " is invalid")
		EndIf
		return
	EndIf
	
	If Sexlab.IsActorActive(akTarget) == True
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " is active in Sexlab")
		EndIf
		return
	EndIf
	
	If Config.NPCNeedsLOS == True
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - NPCs require LOS")
		EndIf
		If !akTarget.HasLOS(PlayerRef)
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " does NOT have LOS.")
			EndIf
			If akTarget.GetDistance(PlayerRef) > Config.MinimumNPCLOSDistance
				If Config.EnableTracing == True
					Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " is beyond Minimum LOS Distance: " + Config.MinimumNPCLOSDistance)
					Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " distance is: " + akTarget.GetDistance(PlayerRef))
				EndIf
				return
			EndIf
		ElseIf !PlayerRef.IsDetectedBy(akTarget)
			If Config.EnableTracing == True
				Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " DOES have LOS but is not detecting player.")
			EndIf
			return
		EndIf
	EndIf
	
	Int FameChance = 0
	Int Relationship = akTarget.GetRelationshipRank(PlayerRef)
	Int FameRoll = Utility.RandomInt(1, 100)

	If Relationship < 0	;Enemy
		FameChance = Config.FameChanceByEnemy as Int
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " reltionship is ENEMY. Value: " + Relationship)
		EndIf
	ElseIf Relationship == 0 ;Neutral
		FameChance = Config.FameChanceByNeutral as Int
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " reltionship is NEUTRAL. Value: " + Relationship)
		EndIf
	ElseIf Relationship >= 1 && Relationship < 4 ;Friend
		FameChance = Config.FameChanceByFriend as Int
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " reltionship is FRIEND. Value: " + Relationship)
		EndIf
	Else ;Relationship == 4 ;Lover
		FameChance = Config.FameChanceByLover as Int
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " reltionship is LOVER. Value: " + Relationship)
		EndIf
	EndIf
	
	If FameRoll <= FameChance && SLSF_Reloaded_NPCScanSucess.GetValue() == 0
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " succeeded fame gain roll. Fame Roll was: " + FameRoll + ". Needed to be equal or lower than: " + FameChance)
		EndIf
		SLSF_Reloaded_NPCScanSucess.SetValue(1)
		FameManager.FameGainRoll(CurrentLocation)
	Else
		If Config.EnableTracing == True
			If SLSF_Reloaded_NPCScanSucess.GetValue() == 0
				Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " failed fame gain roll. Fame Roll was: " + FameRoll + ". Needed to be equal or lower than: " + FameChance)
			Else
				Debug.Trace("SLSF Reloaded NPC Scanner - Target " + akTarget + " failed fame gain roll because a previously checked NPC already succeeded.")
			EndIf
		EndIf
	EndIf
EndEvent