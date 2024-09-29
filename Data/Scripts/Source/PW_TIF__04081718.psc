;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_TIF__04081718 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
integrity.mod(3)
queue.Enqueue(akSpeaker, isRape=true)
(GetOwningQuest() as PW_WHMIQ_Script).Stage40IncrementGuestsTended()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_SexQueueScript property queue Auto

GlobalVariable Property integrity  Auto  
