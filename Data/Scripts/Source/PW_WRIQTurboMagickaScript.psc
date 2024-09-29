Scriptname PW_WRIQTurboMagickaScript extends activemagiceffect  

ImageSpaceModifier Property TurboBlue Auto
PW_WRIQScript Property WRIQ Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	WRIQ.arcadiaStage = 2
	TurboBlue.ApplyCrossFade(2.0)
endEvent

event OnEffectEnd(Actor akTarget, Actor akCaster)
	ImageSpaceModifier.RemoveCrossFade()
endEvent