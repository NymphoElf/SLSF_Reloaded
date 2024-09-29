;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PW__TIF__0A015196 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(Gold001, PW_BribeGold.GetValue() as int)
Punish.decreaseScore(Punish.rulesIncreaseScore)
punish.RuleBreakGuard.clear()
punish.guardApproaching = false
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold001  Auto  


GlobalVariable Property PW_BribeGold  Auto  

PW_PunishmentScript Property Punish  Auto  
