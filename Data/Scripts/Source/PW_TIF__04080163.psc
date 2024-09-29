;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__04080163 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("The slave taps the giant on his thigh, makes a gesture, and then points to you. The giant looks at you for a second, and then grabs you by the waist, effortlessly lifting you into the air. Realizing that he could snap you in half just by squeezing, you have no choice but to be as submissive as possible and hope for his mercy.")
sexlab.QuickStart(Game.GetPlayer(), Alias_Giant.GetActorReference(), hook="PW_SQ_Giant_FirstGiantSex")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto  

ReferenceAlias Property Alias_Giant  Auto  
