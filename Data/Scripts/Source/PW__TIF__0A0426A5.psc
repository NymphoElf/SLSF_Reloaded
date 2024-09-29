;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A0426A5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("She whistles, and a dog runs towards her, as she points to you. The dog knocks you to the ground and begins to fuck you.")
Actor doggers = Game.GetPlayer().PlaceAtMe(Dog, 1) as actor
REDog.ForceRefTo(doggers)
Sexlab.QuickStart(Game.GetPlayer(), doggers, victim = Game.GetPlayer(), hook = "REDogSex")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ActorBase Property Dog  Auto  

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property REDog  Auto  
