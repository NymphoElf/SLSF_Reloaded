;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__040811AD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ftb.ApplyCrossFade(2.0)
Utility.Wait(3.0)
Debug.MessageBox("Duke Caro calls the other noblemen's attention to you, and they begin to realize that you aren't the willing slave you were presented as.")
Utility.Wait(1.0)
Debug.MessageBox("The Jarl and Thane attempt to dismiss these arguments, but eventually Thane Enrensen is pressured into unlocking your gag and allowing you to tell your side of the story.")
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
