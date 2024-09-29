;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__04065E66 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Game.GetPlayer().RemoveAllItems(itemChest, abKeepOwnership=true, abRemoveQuestItems=false)
PW_Utility.SendFormEvent("PW_RemoveItems", itemChest)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property PW_SQ_ItemChest  Auto  

ObjectReference Property itemChest  Auto  
