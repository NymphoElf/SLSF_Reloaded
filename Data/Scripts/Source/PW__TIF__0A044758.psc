;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0A044758 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int choice = GropeMessage.show()
if(choice == 0)
Debug.MessageBox("You violently push them away, and they briefly snap out of it before walking off in a daze.")
(GetOwningQuest() as PW_WRIQScript).arcadiaStage = 7
elseIf(choice == 1)
(GetOwningQuest() as PW_WRIQScript).arcadiaStage = 8
Debug.MessageBox("As you try to wriggle out of their grasp, they push you to the ground and climb on top of you, defiling you on the spot.")
GetOwningQuest().SetObjectiveCompleted(40)
GetOwningQuest().SetObjectiveDisplayed(40, false)
GetOwningQuest().SetObjectiveDisplayed(41)
Sexlab.quickStart(Game.GetPlayer(), akSpeaker, victim = Game.GetPlayer())
else
Debug.MessageBox("Quietly turned on by this treatment, you submissively allow them to feel you up, and put up no resistance as they begin to fuck you.")
(GetOwningQuest() as PW_WRIQScript).arcadiaStage = 7
Sexlab.quickStart(Game.GetPlayer(), akSpeaker)
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property GropeMessage  Auto  

SexLabFramework Property SexLab  Auto  
