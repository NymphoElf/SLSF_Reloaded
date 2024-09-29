;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 54
Scriptname PW__SF_PW_ArrestTortureCompli_0A0272D8 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
PlayerScript.ResetHits()
PlayerScript.startTrackingHits()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_53
Function Fragment_53()
;BEGIN CODE
FadeToBlack.ApplyCrossFade()
Utility.Wait(1.0)
Punish.messageBoxStory(false)
FadeToBlack.Remove()
Punish.endScene()
Punish.incrementDebuff()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
PlayerScript.checkHits()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish  Auto  

Book Property PW_TorturerLoveLetter  Auto  

PW_PunishmentPlayerScript property PlayerScript Auto

ImageSpaceModifier property FadeToBlack Auto
