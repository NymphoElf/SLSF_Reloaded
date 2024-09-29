;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__0406B519 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(Gold001, quotaMgr.calculatePay() * 2)
quotaMgr.incrementClients(quotaMgr.tracker.currentLocIndex)
quotaMgr.incrementClients(quotaMgr.tracker.currentLocIndex)
SexLab.QuickStart(Game.GetPlayer(), akSpeaker, Third.GetActorReference())
GetOwningQuest().SetStage(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


PW_QuotaManagerScript property quotaMgr Auto
MiscObject Property Gold001  Auto  

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property Third  Auto  
