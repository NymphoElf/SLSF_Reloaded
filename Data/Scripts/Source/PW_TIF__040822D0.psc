;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_TIF__040822D0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("You slash at Enrensen's throat with the knife, but he catches your wrist and crushes it in his iron grip. You watch helplessly as the knife falls out of your hand and into Enrensen's, before he pockets it away. He then slaps you hard across the face.")
Game.GetPlayer().RemoveItem(knife, 1)
Game.GetPlayer().DamageActorValue("Health", 20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("He lets you go, and you realize nobody was even paying attention. Frustration swells within you.")
integrity.mod(6)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property integrity  Auto  

MiscObject Property knife  Auto  
