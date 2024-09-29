;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__0A015191 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Sexlab.QuickStart(Game.GetPlayer(), akSpeaker)
Punish.decreaseScore(Punish.rulesIncreaseScore)
punish.RuleBreakGuard.clear()
punish.guardApproaching = false
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

PW_PunishmentScript Property Punish  Auto  
