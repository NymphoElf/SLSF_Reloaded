;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__040663DB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
TurncoatBandit.ForceRefTo(akSpeaker)
GetOwningQuest().SetObjectiveDisplayed(22)
GetOwningQuest().SetObjectiveDisplayed(23)
(GetOwningQuest() as PW_SQ_BanditsScript).distractionEventGiven = true
(GetOwningQuest() as PW_SQ_BanditsScript).distractionEventActive = true
Game.GetPlayer().AddSpell(DistractSpell)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property TurncoatBandit  Auto  

SPELL Property DistractSpell  Auto  
