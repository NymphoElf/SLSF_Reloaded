;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname PW_F15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PayingNpc.clear()

if(!Main.paymentDispensed)
Main.paymentDispensed = true
Game.GetPlayer().AddItem(Gold001, Main.currentClientPay)
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property PayingNpc  Auto  

MiscObject Property Gold001  Auto  

PW_MainLoopScript Property Main  Auto  
