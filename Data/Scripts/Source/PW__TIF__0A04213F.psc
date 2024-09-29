;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PW__TIF__0A04213F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(Gold, (PW_StandardPay.GetValue() as int) * 3)
Debug.MessageBox("With a whistle and a gesture, a dog come sprinting into sight and knocks you onto the ground, promptly mounting you.")
Actor doggers = Game.GetPlayer().PlaceAtMe(Dog, 1) as actor
REDog.ForceRefTo(doggers)
Sexlab.QuickStart(Game.GetPlayer(), doggers, hook = "REDogSex")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ActorBase Property Dog  Auto  

SexLabFramework Property Sexlab  Auto  

ReferenceAlias Property REDog  Auto  

MiscObject Property Gold  Auto  

GlobalVariable Property PW_StandardPay Auto
