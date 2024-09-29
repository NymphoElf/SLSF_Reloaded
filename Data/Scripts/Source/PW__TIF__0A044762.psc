;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A044762 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(41)
GetOwningQuest().SetObjectiveDisplayed(41, false)
GetOwningQuest().SetObjectiveCompleted(31)
(GetOwningQuest() as PW_WRIQScript).arcadiaStage = 99
(GetOwningQuest() as PW_WRIQScript).incrementAssisted()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
