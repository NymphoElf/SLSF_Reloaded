;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 28
Scriptname PW__SF_PW_ArrestTorture_0A0257C9 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
Punish.TorturerRef.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
FadeToBlack.ApplyCrossFade()
Punish.addZaZ("")    ;addZaZ clears any existing furniture, and this arg doesn't spawn one
Game.GetPlayer().MoveTo(TortureRoomMarker)
Utility.Wait(1.0)
Weapon paddle = Mods.getZaZWeapon("Paddle")
Punish.TorturerRef.GetActorRef().AddItem(paddle, 1)
Punish.messageBoxStory(false)
Game.disablePlayerControls(0, 1, 0, 0, 0, 0, 0, 0, 0)
FadeToBlack.Remove()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish  Auto  

ImageSpaceModifier Property FadeToBlack  Auto  

ObjectReference Property TortureRoomMarker  Auto  

SPELL Property Paralysis  Auto  

PW_ModIntegrationsScript Property Mods  Auto  
