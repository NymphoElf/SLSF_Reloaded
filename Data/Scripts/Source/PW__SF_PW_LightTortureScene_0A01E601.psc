;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 140
Scriptname PW__SF_PW_LightTortureScene_0A01E601 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
Torturer.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
Punish.sceneStage = 1
Punish.messageBoxStory(false)
Game.EnablePlayerControls()
Punish.ZazFurniture.Activate(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_111
Function Fragment_111()
;BEGIN CODE
punish.SendToNextScene()
Punish.incrementDebuff()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_116
Function Fragment_116()
;BEGIN CODE
if(Punish.getNextPunishment() == 4)
Punish.pwDgConLightIntoHeavy = true
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_130
Function Fragment_130()
;BEGIN CODE
game.disablePlayerControls()
FadeToBlack.ApplyCrossFade()
Game.GetPlayer().MoveTo(Torturer.GetActorRef())
Punish.addZaz("xcross")
Utility.Wait(2.0)
while(Game.GetPlayer().GetSitState() == 0)
Punish.ZaZFurniture.Activate(Game.GetPlayer())
Utility.Wait(3.0)
endWhile
Game.DisablePlayerControls()
Punish.messageBoxStory(false)
FadeToBlack.Remove()
Game.DisablePlayercontrols()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Torturer  Auto  

ImageSpaceModifier Property FadeToBlack  Auto  

PW_PunishmentScript Property Punish  Auto  

ReferenceAlias Property ReturnMarker  Auto  

PW_ModIntegrationsScript property Mods Auto

Bool Property ChoseRape  Auto  
