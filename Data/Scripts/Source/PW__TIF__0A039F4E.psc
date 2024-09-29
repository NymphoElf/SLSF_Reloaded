;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A039F4E Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as PW_WRIQScript).incrementAssisted()
(GetOwningQuest() as PW_WRIQScript).adrianneStage = 3
GetOwningQuest().SetObjectiveCompleted(34)
GetOwningQuest().SetObjectiveCompleted(37)
GetOwningQuest().SetObjectiveDisplayed(37, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
