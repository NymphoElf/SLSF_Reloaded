;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A028E12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PW_ItemHolder.RemoveItem(Gold, PW_ItemHolder.GetItemCount(Gold), false, PW_GoldHolder)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PW_ItemHolder  Auto  

Actor Property PW_GoldHolder  Auto  

MiscObject Property Gold  Auto  
