;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_TIF__040822E7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
knifeEnding.SetValue(1)
ftb.ApplyCrossFade(0.2)
Utility.Wait(0.3)
Debug.MessageBox("In his arrogant confidence, Enrensen does not see the kitchen knife come rushing up to his neck, and it cuts deep before he manages to grasp your wrist and pull it away.")
Debug.MessageBox("There's a shocked murmur from the guests as their suspicions are confirmed.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("Enrensen clutches his throat, falling to one knee as you stagger away from him.")
Utility.Wait(1.0)
Debug.MessageBox("You're given a cloak to cover yourself, while the noblemen berate the Jarl for this stunt.")
Utility.Wait(1.0)
Debug.MessageBox("The Jarl concedes defeat on the matter, and has your items returned to you and lets you leave.")

ImageSpaceModifier.RemoveCrossFade(1.0)
Utility.Wait(1.1)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property ftb  Auto  

GlobalVariable Property knifeEnding  Auto  
