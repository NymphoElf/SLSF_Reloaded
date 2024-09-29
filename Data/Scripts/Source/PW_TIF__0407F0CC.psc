;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_TIF__0407F0CC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("He grabs you by one of your nipples and twists, forcing a humiliating yelp out of you and breaking your train of thought. You think you were talking about how the Jarl defeated you, but can't remember.")
integrity.mod(4)
getowningquest().setstage(40)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_ModIntegrationsScript property mods Auto

GlobalVariable Property integrity  Auto  
