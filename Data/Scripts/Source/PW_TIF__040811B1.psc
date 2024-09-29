;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__040811B1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
integrity.mod(-1)
queue.Enqueue(akSpeaker, aksAnimTags="Blowjob")
(GetOwningQuest() as PW_WHMIQ_Script).Stage40IncrementGuestsTended()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_SexQueueScript Property queue  Auto  

GlobalVariable Property integrity  Auto  
