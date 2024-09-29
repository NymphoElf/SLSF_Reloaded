;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__040817DC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(mammothMeat, 1)
lookingForEarlsFood.SetValue(0)
GetOwningQuest().SetObjectiveCompleted(41)
GetOwningQuest().SetObjectiveDisplayed(42)
GetOwningQuest().SetObjectiveDisplayed(42, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
  

Potion Property mammothMeat  Auto  

GlobalVariable Property lookingForEarlsFood  Auto  
