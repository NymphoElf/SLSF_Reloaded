;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_F16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Sexlab.QuickStart(Game.GetPlayer(), akSpeaker)

PayingNpc.clear()

Game.GetPlayer().AddItem(Gold001, Main.currentClientPay)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property PayingNpc  Auto  

PW_MainLoopScript Property Main  Auto  

MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  
