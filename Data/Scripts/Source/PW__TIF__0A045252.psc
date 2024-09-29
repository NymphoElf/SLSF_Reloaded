;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__0A045252 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
FadeToBlack.ApplyCrossFade(1.0)
Utility.Wait(1.0)
Debug.MessageBox("Over the next hour, several more customers enter Belethor's store, similarly commenting on you or molesting you, with a few going all the way and fucking you. You do your best to help Belethor bring in business, and sure enough as the rumours of his new advertisement spread, the store gets busier and busier, with more comments, groping, and sales, until it finally starts to die down. Belethor thanks you, handing you a share of the profits.")
Utility.Wait(1.0)
FadeToBlack.Remove()
GetOwningQuest().SetObjectiveCompleted(32)
(GetOwningQuest() as PW_WRIQScript).belethorStage = 3
(GetOwningQuest() as PW_WRIQScript).incrementAssisted()
Game.GetPlayer().AddItem(Gold, 1000)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property FadeToBlack  Auto  

MiscObject Property Gold  Auto  
