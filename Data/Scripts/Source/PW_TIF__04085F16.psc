;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PW_TIF__04085F16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
tracker.AddBountyLocal(bountyGlobal.GetValue() as int, violent=true)
akSpeaker.SetPlayerResistingArrest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_TrackerScript Property Tracker  Auto  

GlobalVariable Property bountyGlobal  Auto  
