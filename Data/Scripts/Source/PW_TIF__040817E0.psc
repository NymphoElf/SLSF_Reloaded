;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_TIF__040817E0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("He slaps you across the face. Defenseless as you are, the pain and humiliation of it are both magnified.")
Game.GetPlayer().DamageAV("Health", 20.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(mammothMeat, Game.GetPlayer().GetItemCount(mammothMeat))
GetOwningQuest().SetObjectiveCompleted(42)
GetOwningQuest().SetObjectiveDisplayed(42, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property mammothMeat  Auto  
