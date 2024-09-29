;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname PW__SF_PW_VediaPreparationSce_09054CA7 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Main.stripPlayer()
Debug.MessageBox("Vedia removes your equipment, handling you like an object and out-maneuvering your attempts to break free, as though she had practiced stripping people against their will.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
Mods.addSlaveTat(5)
Debug.MessageBox("She draws a Solitude symbol on your exposed asscheek.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Mods.collarPlayer()
Debug.MessageBox("As you turn to Vedia in disbelief, she gives you a subtly mocking smile and locks a collar shut around your neck.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
GetOwningQuest().SetStage(100)
PW_Utility.sendIntEvent("PW_MakePublicWhore", 5)
Rainen.GetActorReference().Delete()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_ModIntegrationsScript property Mods Auto
PW_MainLoopScript Property Main  Auto  

PW_TrackerScript Property Tracker  Auto  

ReferenceAlias Property VediaStandStill  Auto  

ReferenceAlias Property Rainen  Auto  
