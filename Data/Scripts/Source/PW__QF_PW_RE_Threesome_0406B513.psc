;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname PW__QF_PW_RE_Threesome_0406B513 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Third
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Third Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Requester
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Requester Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;Third found, returned, player payed
Alias_Requester.clear()
Alias_Third.clear()
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;Finding third
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE PW_RE_ThreesomeScript
Quest __temp = self as Quest
PW_RE_ThreesomeScript kmyQuest = __temp as PW_RE_ThreesomeScript
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(0)
Alias_Requester.ForceRefTo(MainApproacher.GetActorReference())
kmyQuest.questLocIndex = Tracker.lastLocIndex
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property MainApproacher  Auto  

PW_TrackerScript Property Tracker  Auto  
