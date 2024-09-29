;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_TIF__040817E6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
integrity.mod(3)
sexqueue.Enqueue(akSpeaker, isRape=true)
(GetOwningQuest() as PW_WHMIQ_Script).Stage40IncrementGuestsTended()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_SexQueueScript property sexqueue Auto

GlobalVariable Property integrity  Auto  
