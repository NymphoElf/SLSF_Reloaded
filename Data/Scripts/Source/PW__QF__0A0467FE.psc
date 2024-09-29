;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname PW__QF__0A0467FE Extends Quest Hidden

;BEGIN ALIAS PROPERTY Thane
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thane Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE PW_HoldQuestScript
Quest __temp = self as Quest
PW_HoldQuestScript kmyQuest = __temp as PW_HoldQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Setup()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
