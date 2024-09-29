;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 52
Scriptname PW_SF_PW_WindhelmStart_JarlAn_040748FC Extends Scene Hidden

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
game.disablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
QuestScript.PostMasturbationStory()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
Debug.MessageBox("Enrensen's account of the day the Jarl conquered you is far more detailed, describing all of the humiliating acts you performed afterwards. While he tells it, you become more and more convinced that he's lying, but also somewhat aroused by the thought of being made entirely subservient to a more powerful man.")
Debug.MessageBox("You realize with a shock that your hands have moved to pleasure yourself. They move on their own, on instinct, and you can't muster up the willpower to stop them.")
ImageSpaceModifier.RemoveCrossFade(2.0)

Sexlab.QuickStart(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
questScript.PreFirstGangbangStory()

;Behold the power of the PW Sex Queue System
sexQueue.Enqueue(Alias_PartyJarlMarkarth.GetActorReference())
sexQueue.Enqueue(Alias_PartySultan.GetActorReference())
sexQueue.Enqueue(Alias_PartyEarl.GetActorReference())
sexQueue.Enqueue(Alias_PartyThane.GetActorReference())
sexQueue.Enqueue(Alias_PartyJarlWindhelm.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
GetOwningQuest().setstage(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
Utility.Wait(2.0)
Game.EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
ftb.ApplyCrossfade(2.0)
Utility.Wait(2.0)
Debug.MessageBox("Thane Enrensen proceeds to recount a very brief, very humiliating, struggle between you and the Jarl. You don't remember these events occurring, but the more detail the Thane goes into, the clearer you can picture them. Have you simply forgotten? Or has your current state rendered you so suggestible as to take his word for it?")
Utility.Wait(0.5)
Debug.MessageBox("Through your senses fading in and out you hear the Thane describing how you begged for the Jarl to keep you instead of killing you, and then how he broke you in, for hours, on the greathall table. Your uncooperative brain feels grateful for his alleged mercy in this matter.")
Utility.Wait(0.5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property Alias_PartyEarl  Auto  

ImageSpaceModifier Property ftb  Auto  

Message Property postMasturbationMessage  Auto  

GlobalVariable Property PW_WHIQ_Integrity  Auto  

PW_SexQueueScript Property sexQueue  Auto  

ReferenceAlias Property Alias_PartyDuke  Auto  

ReferenceAlias Property Alias_PartySultan  Auto  

ReferenceAlias Property Alias_PartyThane  Auto  

ReferenceAlias Property Alias_PartyJarlWhiterun  Auto  

ReferenceAlias Property Alias_PartyJarlMarkarth  Auto  

ReferenceAlias Property Alias_PartyJarlFalkreath  Auto  

ReferenceAlias Property Alias_PartyJarlWindhelm  Auto  

PW_WHMIQ_Script Property QuestScript  Auto  
