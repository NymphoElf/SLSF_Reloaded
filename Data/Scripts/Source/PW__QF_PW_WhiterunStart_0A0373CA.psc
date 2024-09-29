;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname PW__QF_PW_WhiterunStart_0A0373CA Extends Quest Hidden

;BEGIN ALIAS PROPERTY WhiterunJarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WhiterunJarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Adrianne
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Adrianne Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Arcadia
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Arcadia Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Belethor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Belethor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Customer2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Customer2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Farengar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Farengar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hulda
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hulda Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Customer1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Customer1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ThaneFausus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ThaneFausus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FarengarStandStill
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FarengarStandStill Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE PW_WRIQScript
Quest __temp = self as Quest
PW_WRIQScript kmyQuest = __temp as PW_WRIQScript
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE PW_WRIQScript
Quest __temp = self as Quest
PW_WRIQScript kmyQuest = __temp as PW_WRIQScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.questLocIndex = 6
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
CompleteAllObjectives()
CompleteQuest()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
setObjectiveDisplayed(30)
SetObjectiveDisplayed(31)
SetObjectiveDisplayed(32)
if(playerGenderPref.GetValue() as int == 1)
SetObjectiveDisplayed(33)
endIf
SetObjectiveDisplayed(34)
;SetObjectiveDisplayed(35)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(25)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
setObjectiveDisplayed(30, false)
SetObjectiveDisplayed(31, false)
SetObjectiveDisplayed(32, false)
SetObjectiveDisplayed(33, false)
SetObjectiveDisplayed(34, false)
SetObjectiveDisplayed(35, false)
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_MainLoopScript Property Main  Auto  

GlobalVariable Property playerGenderPref  Auto  
