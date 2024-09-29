;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname PW_QF_PW_SQ_Giant_04080147 Extends Quest Hidden

;BEGIN ALIAS PROPERTY GiantLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_GiantLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Location
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Location Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LocationCenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LocationCenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GiantSlave
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GiantSlave Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY giant
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_giant Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(10)
Game.GetPlayer().AddToFaction(GiantFaction)

if PlayerFollower.GetActorRef() != none
  PlayerFollower.GetActorRef().AddToFaction(GiantFaction)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property GiantFaction  Auto  

ReferenceAlias Property PlayerFollower  Auto  
