Scriptname PW_SQ_BanditsDistractEffectScript extends ActiveMagicEffect  

PW_SQ_BanditsScript property questScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	questScript.RegisterDistractedBandit(akTarget)
EndEvent