;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__040663E4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if(akSpeaker.GetLeveledActorBase().GetSex() == 0)
  Debug.MessageBox("He knees you in the gut, knocking the wind out of you. Your gasps for air are met with several hard slaps across the face. The entire camp laughs as he grabs you by the hair and has his way with you.")
elseIf(akSpeaker.GetLeveledActorBase().GetSex() == 1)
  Debug.MessageBox("She knees you in the gut, knocking the wind out of you. Your gasps for air are met with several hard slaps across the face. The entire camp laughs as she grabs you by the hair and has her way with you.")
endIf

Punish.damagePlayer(60, guaranteeScream = true, lethal = false)

Sexlab.QuickStart(Game.GetPlayer(), akSpeaker, victim = Game.GetPlayer())

(GetOwningQuest() as PW_SQ_BanditsScript).DecreaseBanditFavor()
(GetOwningQuest() as PW_SQ_BanditsScript).IncrementBanditsFucked()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish  Auto  

SexLabFramework Property SexLab  Auto  
