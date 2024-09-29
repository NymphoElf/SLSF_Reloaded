;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__040822E9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ftb.ApplyCrossFade(1.0)
Utility.Wait(1.1)
Debug.MessageBox("It seems the guests do believe your story, though, and begin interrogating the Jarl and Thane about their stunt.")
Utility.Wait(1.0)
Debug.MessageBox("The nobles see to it that your items are returned to you, and escort you out of the palace.")
ImageSpaceModifier.RemoveCrossFade(1.0)
Utility.Wait(1.1)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property ftb  Auto  
