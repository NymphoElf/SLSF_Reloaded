;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname PW__SF_PW_ServiceExtension_0A028E05 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Punish.completedServiceExtensionIntro = true
QuotaMgr.appendQuota()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
FadeToBlack.ApplyCrossFade()
actor thaneActor = LocalPWThane.GetActorReference()
actor player = Game.GetPlayer()
player.MoveTo(thaneActor, 120.0 * Math.Sin(thaneActor.GetAngleZ()), 120.0 * Math.Cos(thaneActor.GetAngleZ()))
player.setAngle(player.GetAngleX(), player.GetAngleY(), player.GetAngleZ() + player.GetHeadingAngle(thaneActor))
thaneActor.setAngle(thaneActor.GetAngleX(), thaneActor.GetAngleY(), thaneActor.GetAngleZ() + thaneActor.GetHeadingAngle(player))
Punish.messageBoxStory()

FadeToBlack.Remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property FadeToBlack  Auto  

ReferenceAlias Property LocalPWThane  Auto  

PW_PunishmentScript Property Punish  Auto  

PW_QuotaManagerScript Property QuotaMgr Auto
