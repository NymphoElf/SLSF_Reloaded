;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 19
Scriptname PW__SF_PW_SQ_BanditDistractio_040663DD Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(22)
GetOwningQuest().SetObjectiveDisplayed(22, false)
GetOwningQuest().SetObjectiveDisplayed(23, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
(GetOwningQuest() as PW_SQ_BanditsScript).DistractionSceneCYA()
TurncoatBandit.GetActorReference().SetCriticalStage(TurncoatBandit.GetActorReference().CritStage_DisintegrateEnd)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
(GetOwningQuest() as PW_SQ_BanditsScript).StartGangbang()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.GetPlayer().RemoveSpell(DistractSpell)
(GetOwningQuest() as PW_SQ_BanditsScript).distractionEventGiven = true
(GetOwningQuest() as PW_SQ_BanditsScript).distractionEventActive = false
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property DistractSpell  Auto  

ObjectReference Property CrowdActivator  Auto  

ReferenceAlias Property TurncoatBandit  Auto  
