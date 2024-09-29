;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname PW__SF_PW_SadisticBeating_0A0436EC Extends Scene Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SadisticThief.clear()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Debug.MessageBox("You're shoved to the ground, and the beating begins.")
Game.DisablePlayerControls()
Game.SetPlayerAIDriven()
Game.GetPlayer().PlayIdle(KneelEnter)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property KneelEnter  Auto  

ReferenceAlias Property SadisticThief  Auto  

Idle Property Shove  Auto  
