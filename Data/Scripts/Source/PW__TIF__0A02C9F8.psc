;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A02C9F8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(Gold, QuotaMgr.calculatePay(true))
akSpeaker.RemoveFromFaction(PW_UnpaidFaction)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property PW_UnpaidFaction  Auto  

PW_QuotaManagerScript Property QuotaMgr Auto

MiscObject Property Gold  Auto  
