;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 26
Scriptname PW_QF__04073672 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY KitchenGirl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_KitchenGirl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Letter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Letter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartyJarlWindhelm
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartyJarlWindhelm Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Thane
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thane Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartyJarlMarkarth
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartyJarlMarkarth Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartyEarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartyEarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartyJarlWhiterun
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartyJarlWhiterun Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartyDuke
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartyDuke Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartyJarlFalkreath
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartyJarlFalkreath Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartySultan
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartySultan Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PartyThane
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PartyThane Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE PW_WHMIQ_Script
Quest __temp = self as Quest
PW_WHMIQ_Script kmyQuest = __temp as PW_WHMIQ_Script
;END AUTOCAST
;BEGIN CODE
courierScript.AddAliasToContainer(Alias_Letter)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;Good ending

if FollowerAlias.GetActorReference() != None
  FollowerAlias.GetActorReference().EnableAI(true)
endIf

PW_GoodEndingReceived.SetValue(1)

Alias_PartyThane.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlWindhelm.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlFalkreath.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlWhiterun.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlMarkarth.GetActorReference().RemoveFromFaction(PW_InQuestFaction)

PlayerItemChest.RemoveAllItems(Player, true, false)
player.MoveTo(WindhelmCenterMarker)
PostQuest.Start()
SendModEvent("dhlp-Resume")

CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
;
SetObjectiveDisplayed(31, false)

SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
postOathScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE PW_WHMIQ_Script
Quest __temp = self as Quest
PW_WHMIQ_Script kmyQuest = __temp as PW_WHMIQ_Script
;END AUTOCAST
;BEGIN CODE
; post-tending time jump

while player.IsInFaction(SexLabAnimatingFaction)
  Utility.Wait(1.0)
endWhile

ftb.ApplyCrossfade(2.0)
Utility.Wait(2.10)

kmyQuest.Stage50Story()
kmyQuest.SetSpeechPositions()
toastScene.Start()

ImageSpaceModifier.RemoveCrossfade(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE PW_WHMIQ_Script
Quest __temp = self as Quest
PW_WHMIQ_Script kmyQuest = __temp as PW_WHMIQ_Script
;END AUTOCAST
;BEGIN CODE
ftb.ApplyCrossFade(2.0)
Utility.Wait(2.0)
Alias_PartyThane.GetActorReference().MoveTo(kmyQuest.thaneStartMarker)
questScript.PostFirstGangbangStory()
ImageSpaceModifier.RemoveCrossfade(2.0)

setObjectiveDisplayed(30)
if PW_WHMIQ_Integrity.GetValue() >= 0
  SetObjectiveDisplayed(31)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
ftb.ApplyCrossFade(2.0)
Utility.Wait(2.1)

Debug.MessageBox("And thus the Thane and the guests return to their various sleeping quarters, leaving you alone with your master.")
Utility.Wait(1.0)

Alias_PartyJarlWhiterun.GetActorReference().Delete()
Alias_PartyJarlFalkreath.GetActorReference().Delete()
Alias_PartyJarlMarkarth.GetActorReference().Delete()
Alias_PartyDuke.GetActorReference().Delete()
Alias_PartyEarl.GetActorReference().Delete()
Alias_PartySultan.GetActorReference().Delete()
Alias_PartyThane.GetActorReference().Delete()

ImageSpaceModifier.RemoveCrossFade(2.0)
Utility.Wait(2.1)

SetObjectiveDisplayed(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN AUTOCAST TYPE PW_WHMIQ_Script
Quest __temp = self as Quest
PW_WHMIQ_Script kmyQuest = __temp as PW_WHMIQ_Script
;END AUTOCAST
;BEGIN CODE
ftb.ApplyCrossFade(2.0)
Utility.Wait(2.1)

Debug.MessageBox("After you are fed, the celebration and debauchery continues for several more hours. Your body is battered and sore from the abuse it's received, but your oath compels you to serve without any rest.")
Utility.Wait(1.0)
Debug.MessageBox("Once it seems things have winded down, Thane Enrensen calls everyone's attention one more time, for a departing announcement.")

kmyQuest.SetSpeechPositions()
TrueEnding.Start()

ImageSpaceModifier.RemoveCrossFade(2.0)
Utility.Wait(2.1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE PW_WHMIQ_Script
Quest __temp = self as Quest
PW_WHMIQ_Script kmyQuest = __temp as PW_WHMIQ_Script
;END AUTOCAST
;BEGIN CODE
;Stage 20 does transition into main event
SendModEvent("dhlp-Suspend")

SetObjectiveCompleted(10)
kmyQuest.RegisterForEvents()
;bool isPlayerFemale = Game.GetPlayer().GetLeveledActorBase().GetSex() != 1
Player.RemoveAllItems(PlayerItemChest, true, false)
Game.DisablePlayerControls()

ftb.ApplyCrossfade(3.0)

Utility.Wait(5.0)

Debug.MessageBox("The guards bring in a keg of the Jarl's reserve mead, and there is a toast, followed by several more rounds of mead being handed out over the next few hours.")

Utility.Wait(3.0)

Debug.MessageBox("A few glasses in, you notice the thane looking at you. Was it Ericson? Bensen?\n")
Debug.MessageBox("Whatever his name was, he's observing you closely, with a piercing analytical gaze. Something's off - he seems sober, even after going through a few glasses of mead.")

Utility.Wait(3.0)
Debug.MessageBox("The thane taps the Jarl on the shoulder, and nods his head towards you. While you try to decipher this gesture, your eyes roll back into your head, and your head hits the table.\n\nAs the room around you fades away, you hear the Jarl tell the guards to get you to the guest's quarters.")

Utility.Wait(3.0)

if FollowerAlias.GetActorReference() != none
  FollowerAlias.GetActorReference().EnableAI(false)
endIf
kmyQuest.SetUpParty()
Utility.Wait(3.0)

Debug.MessageBox("When you begin to return to consciousness, you hear the distant voices of the other jarls and nobles, laughing and conversing. Had the party started while you were passed out? Could that long have passed?")

Utility.Wait(3.0)

Debug.MessageBox("You realize you're standing in one of the hallways branching off of the palace's main room. To your surprise, you're completely naked, and your mouth is filled with a gag.")
Utility.Wait(1.0)
Debug.MessageBox("You try to reach for the gag, but find that your wrists are being held behind you. You hear an amused huff from behind you, and realize Thane Enrensen is holding you in place.\n\n\"Easy there,\" he says. \"Don't you remember what happened? No? Well, listen carefully when the Jarl explains it.\"")

Utility.Wait(1.0)

Utility.Wait(3.0)

Debug.MessageBox("From the greathall, you hear the Jarl loudly announce, \"Okay, I'll keep you waiting no longer. Enrensen, bring in Windhelm's newest trophy!\"\n\nThane Enrensen opens a door to the greathall and pushes you through, walking in as you stumble ungracefully in front of him. Several Jarls and noblemen watch this spectacle in astonishment.")

Utility.Wait(2.0)
druggedImod.ApplyCrossfade(2.0)

jarlAnnouncementScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
ftb.ApplyCrossFade(2.0)
Utility.Wait(2.1)
Game.DisablePlayerControls()

if FollowerAlias.GetActorReference() != None
  FollowerAlias.GetActorReference().EnableAI(true)
endIf

Debug.MessageBox("You are escorted to the guest quarters, where you promptly fall asleep, and are fucked senseless even in your dreams.")

Utility.Wait(8.0)

Debug.MessageBox("When you awake, it's to Thane Enrensen snapping a collar on your neck. He tells you that you are expected to earn a certain amount of gold for Windhelm by whoring yourself out to the citizens. He tells you that you report to him in this role, and warns you to behave.")
Debug.MessageBox("With that, you are given your items, and escorted out of the palace.")
Game.EnablePlayerControls()
SendModEvent("dhlp-Resume")

mods.CollarPlayer()
PW_Utility.SendIntEvent("PW_MakePublicWhore", 7)
player.MoveTo(WindhelmCenterMarker)

PW_TrueEndingReceived.SetValue(1)

PlayerItemChest.RemoveAllItems(Player, true, false)

ImageSpaceModifier.RemoveCrossfade(2.0)
Utility.Wait(2.1)
PostQuest.Start()

Alias_PartyThane.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlWindhelm.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlFalkreath.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlWhiterun.GetActorReference().RemoveFromFaction(PW_InQuestFaction)
Alias_PartyJarlMarkarth.GetActorReference().RemoveFromFaction(PW_InQuestFaction)

CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

WICourierScript Property courierScript  Auto  

ImageSpaceModifier Property ftb  Auto  

Scene Property jarlAnnouncementScene  Auto  

ImageSpaceModifier Property druggedImod  Auto  

GlobalVariable Property PW_WHMIQ_Integrity  Auto  

PW_WHMIQ_Script Property QuestScript  Auto  

Scene Property ToastScene  Auto  

Scene Property postOathScene  Auto  

Faction Property SexLabAnimatingFaction  Auto  

Actor Property Player  Auto  

PW_ModIntegrationsScript property mods Auto

ReferenceAlias Property FollowerAlias  Auto  

ObjectReference Property WindhelmCenterMarker  Auto  

Scene Property TrueEnding  Auto  

Quest Property PostQuest  Auto  

GlobalVariable Property PW_GoodEndingReceived  Auto  

GlobalVariable Property PW_TrueEndingReceived  Auto  

ObjectReference Property PlayerItemChest  Auto  

Faction Property PW_InQuestFaction  Auto  
