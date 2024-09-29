;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__0904CFE7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int choice = GropeMsg.Show()
if(choice == 0)
Debug.MessageBox("You pour him another ale while he pulls you in closer, his hand exploring your waist and buttocks as you do. When you've finished pouring he gives you a light push away from him and returns to his drink.")
elseIf(choice == 1)
Debug.MessageBox("You try to push his hand away but his grip is too strong to fight off with the pitcher in one hand. He grabs your other wrist and makes you pour him another glass, before finally letting go to drink once more.")
else
Debug.Messagebox("You allow him to feel you up, not pouring yet so he can play with your body longer. Eventually he guides your hand to pour him another ale, and then returns to his drink.")
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold001  Auto  

Message Property GropeMsg  Auto  
