;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 24
Scriptname PW__QF_PW_SQ_Bandits_04065397 Extends Quest Hidden

;BEGIN ALIAS PROPERTY DistractedBandit7
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit7 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TurncoatBandit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TurncoatBandit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DistractedBandit5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PWThane
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PWThane Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DistractedBandit6
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit6 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DistractedBandit4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Location
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Location Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY JobLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_JobLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BeerFetchBandit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BeerFetchBandit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DistractedBandit1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DistractedBandit2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DistractedBandit3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BanditBoss
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BanditBoss Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DistractedBandit8
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DistractedBandit8 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SQItemChest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SQItemChest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LocationCenterMaker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LocationCenterMaker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE PW_SQ_BanditsScript
Quest __temp = self as Quest
PW_SQ_BanditsScript kmyQuest = __temp as PW_SQ_BanditsScript
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(10)
Alias_MapMarker.GetReference().AddToMap()
Game.GetPlayer().AddToFaction(BanditFaction)
Game.GetPlayersLastRiddenHorse().AddToFaction(BanditFaction)
Game.GetPlayer().AddToFaction(blackbloodFaction)
Game.GetPlayersLastRiddenHorse().AddToFaction(blackbloodFaction)

if(PlayerFollower.GetActorReference() != none)
PlayerFollower.GetActorReference().AddToFaction(BanditFaction)
PlayerFollower.GetActorReference().AddToFaction(blackbloodFaction)

endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
;Completed but sold
PW_Utility.SendEvent("PW_ClearAllStatuses")
SendModEvent("SSLV Entry")
Utility.Wait(15.0)
Game.GetPlayer().RemoveFromFaction(BanditFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(BanditFaction)
Game.GetPlayer().RemoveFromFaction(blackbloodFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(blackbloodFaction)

if(PlayerFollower.GetActorReference() != none)
PlayerFollower.GetActorReference().RemoveFromFaction(BanditFaction)
PlayerFollower.GetActorReference().RemoveFromFaction(blackbloodFaction)
endIf

CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
;Angered the bandits, being sold
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
;Did too well, being kept now
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
;Hit Quota
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN AUTOCAST TYPE PW_SQ_BanditsScript
Quest __temp = self as Quest
PW_SQ_BanditsScript kmyQuest = __temp as PW_SQ_BanditsScript
;END AUTOCAST
;BEGIN CODE
;Opt out at Thane
FailAllObjectives()
Game.GetPlayer().RemoveFromFaction(BanditFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(BanditFaction)
Game.GetPlayer().RemoveFromFaction(blackbloodFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(blackbloodFaction)

if(PlayerFollower.GetActorReference() != none)
PlayerFollower.GetActorReference().RemoveFromFaction(BanditFaction)
PlayerFollower.GetActorReference().RemoveFromFaction(blackbloodFaction)
endIf

Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
;Quest Completed
SendModEvent("PW_SideQuestCompleted", "bandits", Tracker.GetLocIndexFromLocation(Alias_Hold.GetLocation()))
Game.GetPlayer().RemoveFromFaction(BanditFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(BanditFaction)
Game.GetPlayer().RemoveFromFaction(blackbloodFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(blackbloodFaction)

if(PlayerFollower.GetActorReference() != none)
PlayerFollower.GetActorReference().RemoveFromFaction(BanditFaction)
PlayerFollower.GetActorReference().RemoveFromFaction(blackbloodFaction)
endIf

CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
;Report back to thane normally
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Bandit leader died
SendModEvent("PW_SideQuestFailed", "bandits", Tracker.GetLocIndexFromLocation(Alias_Hold.GetLocation()))
FailAllObjectives()

Game.GetPlayer().RemoveFromFaction(BanditFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(BanditFaction)
Game.GetPlayer().RemoveFromFaction(blackbloodFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(blackbloodFaction)

if(PlayerFollower.GetActorReference() != none)
PlayerFollower.GetActorReference().RemoveFromFaction(BanditFaction)
PlayerFollower.GetActorReference().RemoveFromFaction(blackbloodFaction)
endIf


Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE PW_SQ_BanditsScript
Quest __temp = self as Quest
PW_SQ_BanditsScript kmyQuest = __temp as PW_SQ_BanditsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.RegisterForEvents()
kmyQuest.PW_SQ_BanditsCount.SetValue(0)
kmyQuest.distractionEventGiven = false
kmyQuest.distractedBanditCount = 0
kmyQuest.banditList = new Actor[10]
kmyQuest.sceneConditionStartGangBang  = false
kmyQuest.questLocIndex = tracker.lastLocIndex
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
;Completed without reward (kept, or thane is pissed)
Game.GetPlayer().RemoveFromFaction(BanditFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(BanditFaction)
Game.GetPlayer().RemoveFromFaction(blackbloodFaction)
Game.GetPlayersLastRiddenHorse().RemoveFromFaction(blackbloodFaction)

if(PlayerFollower.GetActorReference() != none)
PlayerFollower.GetActorReference().RemoveFromFaction(BanditFaction)
PlayerFollower.GetActorReference().RemoveFromFaction(blackbloodFaction)
endIf


CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property BanditFaction  Auto  

GlobalVariable Property PW_SQ_BanditsCount  Auto  


PW_TrackerScript Property Tracker  Auto  

Faction Property PlayerFaction  Auto  

ReferenceAlias Property PlayerFollower  Auto  

Faction Property blackbloodFaction  Auto  
