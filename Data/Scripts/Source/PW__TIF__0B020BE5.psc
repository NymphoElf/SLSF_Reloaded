;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0B020BE5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Punish.pwPunishStartSex(Torturer.GetActorRef(), Punish.pwDgConLTChoseRape, true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish  Auto  

ReferenceAlias Property Torturer  Auto  
