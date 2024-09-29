;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A04475D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("Like an animal, they pounce on you and pin you to the ground. You have no ability to resist under the force of an incredible strength that has suddenly overtaken them.")
Sexlab.QuickStart(Game.GetPlayer(), akSpeaker, victim = Game.GetPlayer())
(GetOwningQuest() as PW_WRIQScript).arcadiaStage = 8
GetOwningQuest().SetObjectiveCompleted(40)
GetOwningQuest().SetObjectiveDisplayed(40, false)
GetOwningQuest().SetObjectiveDisplayed(41)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  
