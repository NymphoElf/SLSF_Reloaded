Scriptname PW_WRIQSlownessPoisonScript extends activemagiceffect  

PW_WRIQScript property WRIQ Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	WRIQ.arcadiaStage = 4
	Debug.Notification("You suddenly feel sluggish")
endEvent

event OnEffectEnd(Actor akTarget, Actor akCaster)
	Debug.Notification("You regain your energy")
endEvent