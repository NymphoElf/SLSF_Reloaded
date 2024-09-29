;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 41
Scriptname PW__SF_PW_BelethorsAdvertisme_0A03AFAD Extends Scene Hidden

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
BelethorsDoor.Activate(Customer1Alias.GetActorReference())
Utility.Wait(0.5)
Customer1Alias.GetActorReference().delete()
Customer1Alias.clear()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
BelethorsDoor.Activate(Customer2Alias.GetActorReference())
Utility.Wait(0.5)
Customer2Alias.GetActorReference().delete()
Customer2Alias.clear()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
Game.EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
BelethorsDoor.Activate(Customer2Alias.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
actor player = game.getplayer()
game.disablePlayerControls()
player.MoveTo(DisplayMarker)
player.setAngle(player.GetAngleX(), player.GetAngleY(), player.getanglez() + player.getheadingangle(BelethorsDoor))
Game.DisablePlayerControls()
if(playerGenderPref.GetValue() as int == 2 || playerGenderPref.GetValue() as int == 0)
Customer1Alias.ForceRefTo(SpawnMarker.PlaceAtMe(NazeemAB) as actor)
Customer2Alias.ForceRefTo(SpawnMarker.PlaceAtMe(VilkasAB) as actor)
else
Customer1Alias.ForceRefTo(SpawnMarker.PlaceAtMe(YsoldaAB) as actor)
Customer2Alias.ForceRefTo(SpawnMarker.PlaceAtMe(AelaAB) as actor)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
(getowningquest() as pw_wriqscript).belethorStage = 2
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
string customerName = Customer1Alias.GetActorReference().GetLeveledActorBase().GetName()
if(Game.GetPlayer().GetActorBase().GetSex() == 0)
Debug.MessageBox(customerName + " begins feeling your torso, working down towards your hips, and then groping at your ass for a few seconds, before turning back to Belethor.")
elseIf(Customer1Alias.GetActorReference().GetActorBase().GetSex() == 0)
Debug.MessageBox(customerName + " caresses your cheek, then presses a thumb down on your lower lip, before bringing his head down to inspect your breasts very closely. He then gizes them a squeeze and slaps your ass before turning back to Belethor.")
else
Debug.MessageBox(customerName + " caresses your cheek, then presses a thumb down on your lower lip, before bringing her head down to inspect your breasts very closely. She then gizes them a squeeze and slaps your ass before turning back to Belethor.")
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
BelethorsDoor.Activate(Customer1Alias.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ActorBase Property NazeemAB  Auto  

ReferenceAlias Property Customer1Alias  Auto  

ObjectReference Property BelethorsDoor Auto

ObjectReference Property SpawnMarker  Auto  

PW_MainLoopScript Property Main  Auto  

ReferenceAlias Property Customer2Alias  Auto  

ActorBase Property VilkasAB  Auto  

ActorBase Property AelaAB  Auto  

ActorBase Property YsoldaAB  Auto  

ObjectReference Property EntranceMarker  Auto  

ObjectReference Property DisplayMarker  Auto  

SexLabFramework Property SexLab  Auto  

GlobalVariable Property playerGenderPref  Auto  
