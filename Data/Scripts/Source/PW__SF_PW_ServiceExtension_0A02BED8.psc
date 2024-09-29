;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__SF_PW_ServiceExtension_0A02BED8 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Punish.messageBoxStory(true)
QuotaMgr.appendQuota()
Utility.Wait(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Punish.sendToNextScene()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish Auto  
PW_QuotaManagerScript Property QuotaMgr Auto
