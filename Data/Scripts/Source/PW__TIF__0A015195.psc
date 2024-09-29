;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PW__TIF__0A015195 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PW_PunishmentScript punish = GetOwningQuest() as PW_PunishmentScript
punish.increaseScore((punish.rulesIncreaseScore * 1.5) as int)
punish.RuleBreakGuard.clear()
punish.guardApproaching = false
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
