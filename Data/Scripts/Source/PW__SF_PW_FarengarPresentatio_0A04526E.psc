;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname PW__SF_PW_FarengarPresentatio_0A04526E Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
game.disablePlayerControls()
Game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
Game.GetPlayer().DispelSpell(FarengarHypnosis)
Debug.MessageBox("You suddenly realize you don't know what's going on. You find yourself fully exposed in front of the Jarl, who is looking at you curiously. The last thing you remember is that you were going to help Farengar, though you can't remember what he said.")
GetOwningQuest().SetObjectiveDisplayed(42)
WRIQ.farengarStage = 2
actor farengarActor = FarengarStandStill.GetActorReference()
FarengarStandStill.clear()
Farengar.ForceRefTo(farengarActor)
farengarActor.evaluatePackage()
Game.SetPlayerAIDriven(False)
Game.EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
WRIQ.FarSceneSexComplete = false
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
Game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_WRIQScript Property WRIQ  Auto  

SPELL Property FarengarHypnosis  Auto  

ReferenceAlias Property FarengarStandStill  Auto  

ReferenceAlias Property Farengar  Auto  
