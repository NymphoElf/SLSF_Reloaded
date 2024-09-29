;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__09052BCA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(Gold001, PW_EarlyBuyout.GetValue() as int)
PW_Utility.sendIntEvent("PW_ClearStatus", Tracker.currentLocIndex)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_TrackerScript Property Tracker Auto

GlobalVariable Property PW_EarlyBuyout  Auto  

MiscObject Property Gold001  Auto  
