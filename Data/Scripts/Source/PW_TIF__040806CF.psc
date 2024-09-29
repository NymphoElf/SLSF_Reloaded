;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__040806CF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("She taps the giant, gesturing at you and repeating a few giant language words. The giant suddenly grabs you and begins to inspect you. You brace for the possibly fatal penetration that awaits you.")
sexlab.QuickStart(Game.GetPlayer(), Alias_Giant.GetActorReference(), hook="PW_SQ_Giant_FirstGiantSex")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property Alias_Giant  Auto  
