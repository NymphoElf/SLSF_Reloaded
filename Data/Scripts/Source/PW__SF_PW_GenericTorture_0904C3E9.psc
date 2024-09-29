;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname PW__SF_PW_GenericTorture_0904C3E9 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
;WARNING: Unable to load fragment source from function Fragment_1 in script PW__SF_PW_GenericTorture_0904C3E9
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
game.disablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
Game.EnablePlayerControls()
Punish.sceneStage = 1
Punish.messageBoxStory()
Punish.incrementDebuff()
Punish.sendToNextScene()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
FadeToBlack.Apply()
Punish.addZaZ("xcross")
Punish.messageBoxStory(false)
Game.disablePlayerControls()
Game.GetPlayer().MoveTo(Punish.ZaZFurniture)
while(Game.GetPlayer().GetSitState() == 0)
  Punish.ZaZFurniture.Activate(Game.GetPlayer())
  Utility.Wait(3.0)
endWhile
FadeToBlack.Remove()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_ModIntegrationsScript property Mods Auto
PW_PunishmentScript Property Punish  Auto  

ReferenceAlias Property Torturer  Auto  

ImageSpaceModifier Property FadeToBlack  Auto  

PW_TrackerScript Property Tracker  Auto  

PW_IntroDetectionScript Property Intro  Auto  
