;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname PW__QF_PW_SolitudeStart_09054C27 Extends Quest Hidden

;BEGIN ALIAS PROPERTY WaitXMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WaitXMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Vedia
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Vedia Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Rainen
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Rainen Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Elisif
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Elisif Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY VediaStandStill
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_VediaStandStill Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;Rainen distracted, player didn't learn of plot
SetObjectiveCompleted(1)
SetObjectiveDisplayed(1, false)
Alias_Vedia.GetActorReference().MoveTo(VediaJarlMarker)
Alias_VediaStandStill.ForceRefTo(Alias_Vedia.GetActorReference())
SetObjectiveDisplayed(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE PW_SIQScript
Quest __temp = self as Quest
PW_SIQScript kmyQuest = __temp as PW_SIQScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.questLocIndex = 5
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;Rainen distracted, player learned of plot
SetObjectiveCompleted(1)
SetObjectiveDisplayed(1, false)
Alias_Vedia.GetActorReference().MoveTo(VediaJarlMarker)
Alias_VediaStandStill.ForceRefTo(Alias_Vedia.GetActorReference())
SetObjectiveDisplayed(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE PW_SIQScript
Quest __temp = self as Quest
PW_SIQScript kmyQuest = __temp as PW_SIQScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.RegisterForSingleUpdateGameTime(pwUtil.getHoursToNext(9))
SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
FailAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(2)
SetObjectiveDisplayed(2, false)
SetObjectiveDisplayed(3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_Utility Property pwUtil  Auto  

ObjectReference Property VediaJarlMarker  Auto  
