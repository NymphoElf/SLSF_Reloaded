;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PW__TIF__040663E6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if(Game.GetPlayer().GetLeveledActorBase().GetSex() == 1)
  Debug.MessageBox("The bandit practically attacks you, punching you in the stomach a few times, before pulling you up by your hair, spitting on you and then slapping your tits and your face for several minutes. The camp laughs as you nearly lose consciousness from the abuse, and when you become aware of your surroundings again, you're being fucked hard.")
elseIf(Game.GetPlayer().GetLeveledActorBase().GetSex() == 0)
   Debug.MessageBox("The bandit practically attacks you, punching you in the stomach a few times, before pulling you up by your hair, spitting on you and then alternating between slapping your dick  and your face for several minutes. The camp laughs as you nearly lose consciousness from the abuse, and when you become aware of your surroundings again, you're being fucked hard.")
endIf

Punish.damagePlayer(120, guaranteeScream = true, lethal = false)

Sexlab.QuickStart(Game.GetPlayer(), akSpeaker, victim = Game.GetPlayer())

(GetOwningQuest() as PW_SQ_BanditsScript).IncreaseBanditFavor()
(GetOwningQuest() as PW_SQ_BanditsScript).IncrementBanditsFucked()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

PW_PunishmentScript Property Punish  Auto  
