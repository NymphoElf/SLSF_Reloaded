;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0406694B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
TurncoatBandit.GetActorReference().RemoveFromFaction(BanditFaction)
akSpeaker.startCombat(TurncoatBandit.GetActorReference())
(GetOwningQuest() as PW_SQ_BanditsScript).distractionEventActive = false

(GetOwningQuest() as PW_SQ_BanditsScript).IncreaseBanditFavor()
GetOwningQuest().SetObjectiveCompleted(23)
GetOwningQuest().SetObjectiveDisplayed(22, false)
GetOwningQuest().SetObjectiveDisplayed(23, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property TurncoatBandit  Auto  

Faction Property BanditFaction  Auto  
