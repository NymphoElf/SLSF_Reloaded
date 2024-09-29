;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__04081D52 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("The cook lays a steaming dish of salmon and potatoes on your bare belly. The Jarl eats everything with his mouth, rubbing between your legs in the process, drawing cheers from the other lords. Between the burning pain and the pleasure you find your muscles contracting in climax a couple times before he's done, all the while  trying your best to remain still.")
integrity.mod(-4)
(GetOwningQuest() as PW_WHMIQ_Script).Stage40IncrementGuestsTended()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property integrity  Auto  
