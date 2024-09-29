;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW_QF_PW_WindhelmStart_PostQu_040838DA Extends Quest Hidden

;BEGIN ALIAS PROPERTY JarlWhiterun
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlWhiterun Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnslavedCook
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnslavedCook Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY jarlFalkreath
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_jarlFalkreath Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Raloof
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Raloof Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayersPlace
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayersPlace Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY jarlMarkarth
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_jarlMarkarth Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY master
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_master Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_Raloof.GetActorReference().Enable()
Alias_PlayersPlace.GetReference().Enable()
LItemBookClutter.AddForm(BookJarlAndTheHarlot, 1, 1)
(raloofScript as PW_RaloofPostQuestScript).OnDailyUpdate()
(raloofScript as PW_RaloofPostQuestScript).RegisterEvents()

if knifeEnding.GetValue() == 1
Alias_EnslavedCook.GetActorReference().Enable()
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property BookJarlAndTheHarlot  Auto  

LeveledItem Property LItemBookClutter  Auto  

ReferenceAlias property raloofScript Auto

GlobalVariable Property knifeEnding  Auto  
