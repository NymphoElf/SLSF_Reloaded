;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A043C8A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
FadeToBlack.ApplyCrossFade(1.0)
Utility.Wait(0.5)
Debug.MessageBox(akSpeaker.GetLeveledActorBase().GetName() + " walks off and returns about a half hour later, stating that you're no longer the city whore here.")
Utility.Wait(0.5)
FadeToBlack.Remove()
PW_Utility.sendIntEvent("PW_ClearStatus", Tracker.currentLocIndex)
akSpeaker.SendModEvent("PCSubEnslave")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property FadeToBlack  Auto  

PW_TrackerScript property Tracker Auto
