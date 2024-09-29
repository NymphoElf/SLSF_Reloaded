;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A041BB4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;(GetOwningQuest() as PW_MainLoopScript).Tracker.playerReport(PW_ReportingGold.GetValue() as int)
PW_Utility.sendIntEvent("PW_TurnInGold", PW_ReportingGold.GetValue() as int)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold  Auto  

GlobalVariable Property PW_ReportingGold  Auto  
