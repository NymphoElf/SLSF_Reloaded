;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A03AFAC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("Belethor briskly strides around the counter. His sheer confidence leaves you stunned, and within seconds he's effortlessly stripped you naked and pushed you into positon by the counter. Dazed by what just happened, you have little option but to play it cool, as the door begins to open.")
Main.stripPlayer()
BelethorScene.start()
(getowningquest() as PW_WRIQScript).belethorStage = 1
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property BelethorScene  Auto  

PW_MainLoopScript Property Main  Auto  
