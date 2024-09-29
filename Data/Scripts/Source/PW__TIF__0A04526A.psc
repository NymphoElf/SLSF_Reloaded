;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A04526A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
FadeToBlack.Apply()
Utility.Wait(1.0)
Debug.MessageBox("You wait mindlessly for morning.")
Utility.Wait(1.0)
FadeToBlack.Remove()
pwUtil.advanceTimeToNext(11)
FarengarDemoScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property FadeToBlack  Auto  

PW_Utility Property pwUtil  Auto  

Scene Property FarengarDemoScene  Auto  
