;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0904CFEE Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("They hand you a sack of gold, before open your barmaid's outfit, fully exposing your breasts. There's a cheer from the inn, and they pull off the rest of your outfit, leaving you in nothing but your shoes.")
Game.GetPlayer().RemoveItem(barkeepClothes)
Game.GetPlayer().AddItem(Gold001, 500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property barkeepclothes  Auto  

MiscObject Property Gold001  Auto  
