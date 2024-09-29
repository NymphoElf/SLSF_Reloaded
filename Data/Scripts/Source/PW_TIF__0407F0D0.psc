;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PW_TIF__0407F0D0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Debug.MessageBox("He pushes the gag back into your mouth and locks it.")
;mods.GagPlayer()
integrity.mod(2)
getowningquest().setstage(40)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
PW_ModIntegrationsScript property mods Auto
GlobalVariable property integrity Auto
