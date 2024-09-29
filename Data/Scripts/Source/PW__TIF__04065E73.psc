;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__04065E73 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Sexlab.QuickStart(Game.GetPlayer(), akSpeaker)
BeerFetchBandit.ForceRefTo(akSpeaker)
GetOwningQuest().SetObjectiveDisplayed(21)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property BeerFetchBandit  Auto  
