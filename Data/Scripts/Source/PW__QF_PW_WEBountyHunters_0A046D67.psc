;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname PW__QF_PW_WEBountyHunters_0A046D67 Extends Quest Hidden

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyHunter1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyHunter1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyHunter3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyHunter3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyHunter2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyHunter2 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;Debug.MessageBox("PW: Bounty Hunter event started!")
;Game.GetPlayer().MoveTo(Alias_BountyHunter1.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;Player did not surrender, begin combat
Alias_BountyHunter1.GetActorReference().startCombat(Game.GetPlayer())
Alias_BountyHunter2.GetActorReference().startCombat(Game.GetPlayer())
Alias_BountyHunter3.GetActorReference().startCombat(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
Alias_BountyHunter1.GetReference().DeleteWhenAble()
Alias_BountyHunter2.GetReference().DeleteWhenAble()
Alias_BountyHunter3.GetReference().DeleteWhenAble()
(Alias_Trigger.GetReference() as WETriggerScript).RearmTrigger()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
;Player surrendered
Punish.extraditePlayer()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish  Auto  
