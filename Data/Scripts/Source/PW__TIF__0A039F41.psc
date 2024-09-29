;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__0A039F41 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(PW_WRIQAdrianneBlueprint, 1)
GetOwningQuest().SetObjectiveCompleted(36)
GetOwningQuest().SetObjectiveDisplayed(36, false)
GetOwningQuest().SetObjectiveDisplayed(37)
(GetOwningQuest() as PW_WRIQScript).adrianneStage = 2
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property PW_WRIQAdrianneBlueprint  Auto  
