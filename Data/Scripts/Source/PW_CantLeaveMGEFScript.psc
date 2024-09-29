Scriptname PW_CantLeaveMGEFScript extends activemagiceffect  

PW_PlayerScript property playerScript Auto
PW_TrackerScript property Tracker Auto

event OnEffectStart(actor akTarget, actor akCaster)
	playerScript.cantLeaveIndex = Tracker.lastLocIndex
endEvent

event OnEffectFinish(actor akTarget, actor akCaster)
	playerScript.cantLeaveIndex = -1
endEvent