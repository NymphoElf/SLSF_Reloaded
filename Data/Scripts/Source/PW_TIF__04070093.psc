;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname PW_TIF__04070093 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(Gold001, quotaMgr.calculatePay() * 2)
quotaMgr.incrementClients(quotaMgr.tracker.currentLocIndex)
quotaMgr.incrementClients(quotaMgr.tracker.currentLocIndex)
SexLab.QuickStart(Game.GetPlayer(), Requester.GetActorReference(), Third.GetActorReference())
GetOwningQuest().SetStage(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


PW_QuotaManagerScript property quotaMgr Auto
MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property Third  Auto  

ReferenceAlias Property Requester  Auto  
