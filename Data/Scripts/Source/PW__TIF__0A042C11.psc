;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A042C11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("You raise your fists but before you can throw a punch, he kicks you hard in the womanhood, causing you to double over in pain. He grabs your hair from behind and kicks your legs apart.")
Sexlab.Quickstart(Game.GetPlayer(), akSpeaker, victim = Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  
