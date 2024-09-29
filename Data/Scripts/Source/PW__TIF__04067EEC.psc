;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__04067EEC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PW_Utility.sendEvent("PW_ClearAllStatuses")
akSpeaker.SendModEvent("PCSubEnslave")
GetOwningQuest().SetObjectiveCompleted(30)
GetOwningQuest().SetObjectiveDisplayed(30, false)
GetOwningQuest().SetStage(101)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
