Scriptname PW_ActorScanMGEFScript extends activemagiceffect  

PW_ActorManagerScript Property actorMgr  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	actorMgr.RegisterPowerScannedActor(akTarget)
EndEvent