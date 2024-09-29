;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__0A030567 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ImageSpaceModifier.RemoveCrossFade()
Punish.sceneStage = 1
Utility.Wait(3.0)
Punish.messageBoxStory(true)
Punish.sceneStage = 2
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property Red  Auto  

PW_PunishmentScript Property Punish  Auto  

ImageSpaceModifier Property FadeToBlack  Auto  
