;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__04081D56 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ftb.ApplyCrossFade(2.0)
Utility.Wait(3.0)
Debug.MessageBox(akSpeaker.GetLeveledActorBase().GetName() + " turns to Thane Enrensen and the Jarl and begins shouting, somewhat incoherently due to the alcohol, but generally to the point of how bad of a fuck-up it was to try to trick an adventurer like this.")
Utility.Wait(1.0)
Debug.MessageBox("The other noblemen look on with curiosity and begin to probe you for your version of events. You tell them the truth of what happened..")
Utility.Wait(1.0)
Debug.MessageBox("Understanding the political ramifications of continuing this stunt, the Jarl returns your items to you, and allows you to go on your way.")
Utility.Wait(1.0)
ImageSpaceModifier.RemoveCrossFade(3.0)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property ftb  Auto  
