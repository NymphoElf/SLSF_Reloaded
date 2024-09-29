;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__040689EB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Sexlab.QuickStart(Game.GetPlayer(), akSpeaker, victim = Game.GetPlayer())
Game.GetPlayer().AddItem(Skooma, 1)
Game.GetPlayer().EquipItem(Skooma, 1)
(GetOwningQuest() as PW_SQ_BanditsScript).IncrementBanditsFucked()
(GetOwningQuest() as PW_SQ_BanditsScript).DecreaseBanditFavor()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Skooma  Auto  

SexLabFramework Property SexLab  Auto  
