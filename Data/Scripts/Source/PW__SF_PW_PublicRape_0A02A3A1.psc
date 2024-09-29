;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 80
Scriptname PW__SF_PW_PublicRape_0A02A3A1 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_66
Function Fragment_66()
;BEGIN CODE
StandStill.clear()
Punish.incrementDebuff()
Punish.completedPublicRapeIntro = true
Punish.sendToNextScene(restoreLocation = false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_53
Function Fragment_53()
;BEGIN CODE
actor[] SceneSpectators = actorMgr.getValidActorArray(15)
int i = 0
while i < 8
if(SceneSpectators[i] != none)
  Punish.Spectators[i].forceRefTo(SceneSpectators[i])
endIf
i += 1
endWhile
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_58
Function Fragment_58()
;BEGIN CODE
Punish.chainRapeCompleted = false
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
FadeToBlack.ApplyCrossfade()
StandStill.ForceRefTo(Punish.LocalPWThane.GetActorRef())
Punish.messageBoxStory(false)
Punish.PublicRapePlayerXMarker.ForceRefTo(Punish.PublicRapePlayerXMarkers[Tracker.lastLocIndex])
Punish.PublicRapeThaneXMarker.ForceRefTo(Punish.PublicRapeThaneXMarkers[Tracker.lastLocIndex])
Game.GetPlayer().MoveTo(Punish.PublicRapePlayerXMarker.GetReference(), abMatchRotation = true)
Punish.LocalPWThane.GetActorRef().MoveTo(Punish.PublicRapeThaneXMarker.GetReference(), abMatchRotation = true)
pwUtil.advanceTimeToNext(9)
FadeToBlack.Remove()
Tracker.updateLocInfo()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
int i = 0
while i < 8
actor current = Punish.Spectators[i].GetActorReference()
Punish.Spectators[i].clear()
current.EvaluatePackage()
i += 1
endWhile
FadeToBlack.applyCrossFade(2.0)
Utility.wait(2.0)
Punish.messageBoxStory(false)
Punish.LocalPWThane.GetActorReference().MoveTo(Game.GetPlayer())
pwUtil.AdvanceTimeToNext(8)
FadeToBlack.Remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_71
Function Fragment_71()
;BEGIN CODE
Punish.chainRapeCompleted = false
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
Punish.sceneStage = 6
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish  Auto  

Quest Property PW_Punishment  Auto  

ImageSpaceModifier Property FadeToBlack  Auto  

PW_Utility Property pwUtil  Auto  

PW_TrackerScript Property Tracker  Auto  

Topic Property ThaneTopic1  Auto  

ReferenceAlias Property StandStill  Auto  

PW_MainLoopScript Property Main  Auto  

PW_ActorManagerScript Property actorMgr  Auto  
