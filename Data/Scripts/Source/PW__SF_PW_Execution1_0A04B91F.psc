;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 41
Scriptname PW__SF_PW_Execution1_0A04B91F Extends Scene Hidden

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
GallowScript.Lever.Activate(Game.GetPlayer())
Utility.Wait(3.0)
Debug.MessageBox("So ends the story of  " + Game.GetPlayer().GetLeveledActorBase().GetName() + ", disobedient public whore.")
FadeToBlack.ApplyCrossfade(4.0)
int index = 0
while index < AdventurerAliases.Length
AdventurerAliases[index].GetActorReference().Delete()
AdventurerAliases[index].clear()
index += 1
endWhile
index = 0
while index < NobleAliases.Length
NobleAliases[index].GetActorReference().Delete()
NobleAliases[index].clear()
index += 1
endWhile
Utility.Wait(30.0)
if(!Game.GetPlayer().isDead())
Debug.MessageBox("You begin to drift back into consciousness. It feels difficult to breath, though you steadily manage to.")
Utility.Wait(3.0)
Debug.MessageBox("What happened? Is this the afterlife?")
Utility.Wait(0.5)
Debug.MessageBox("You're informed very harshly that this is not the afterlife as a boot presses down onto your stomach, knocking the hard-earned breath out of you once more.")
Debug.MessageBox("You hear the Thane speaking to you, just barely, as though they were hundreds of feet away from you.\n\n'You were supposed to die today. Luckily for you, it benefits both of us that you stick around a bit longer. But don't test your luck again. Get back out on the streets, whore.'")
Game.GetPlayer().MoveTo(Punish.PublicRapePlayerXMarkers[Punish.Tracker.lastLocIndex])
Utility.Wait(1.0)
Debug.MessageBox("You're carried, half-unconscious, into the city once more, and woken up by a slap across the face from a guard.")
endIf
FadeToBlack.Remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
Punish.debuffLevel = 6
;We'll often skip level 5 here but fuck it.
;The PC literally thought she was killed.
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
FadeToBlack.Apply()
Utility.Wait(1.0)
Debug.MessageBox("The party guests continuously violate you in brutal ways. After a bit, the nobles begin drinking skooma, which gives them inhuman strength - something they take full advantage of to fuck you harder and for logner.")
Utility.Wait(1.0)
Debug.MessageBox("Between the thought of these being your last moments alive, and your complete helplessness to prevent all of your holes from being filled at just about every moment, you fall into a frenzied panic.")
Utility.Wait(1.0)
if(Game.GetPlayer().GetLeveledActorBase().GetSex() == 1)
Debug.MessageBox("You try to fight free, and escape. This can't be the end! But the hands that grap your wrists and ankles and neck are like iron, pinning you and pulling you where they want you while others molest your boobs and squeeze at your ass.")
else
Debug.MessageBox("You try to fight free, and escape. This can't be the end! But the hands that grap your wrists and ankles and neck are like iron, preventing all movement while your violation continues.")
endIf
Utility.Wait(1.0)
Debug.MessageBox("Suddenly the stimulation overwhelms you, and your body betrays you, contracting in self-sabotaging orgasm. There's a laugh from the party guests, and your mind begins to go blank as you realize you're completely defeated.")
Utility.Wait(1.0)
Debug.MessageBox("In a daze, you passively watch as you're fucked over and over again, and distantly hear yourself gasp and shudder with every climax they force out of you. Before you know it you're being stood up and lead up the steps to the gallows.")
GallowsRef.Activate(Game.GetPlayer())
Utility.Wait(1.0)
FadeToBlack.Remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Punish.pwPunishChainRape(7, Punish.chainRapist)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if(!Mods.usingZaZ)
     Debug.MessageBox("A scene was called that requires ZaZ Animation Pack v8.0 or higher. Skipped Execution scene.")
     Punish.sendToNextScene()
     Stop()
     return
else
Game.DisablePlayerControls()
Game.EnablePlayerControls(abFighting = false)

FadeToBlack.ApplyCrossFade(2.0)
Utility.Wait(1.0)
Game.GetPlayer().MoveTo(EntryMarker)
int index = 0
while index < 3
actor adventurer = FillGuestMarkers[index].placeAtMe(Punish.adventurerAB, 1) as actor
AdventurerAliases[index].forcerefto(adventurer)
adventurer.SetAngle(0.0, 0.0, adventurer.GetAngleZ() + Adventurer.GetHeadingAngle(Game.GetPlayer()))
index += 1
endWhile


NobleAliases[0].ForceRefTo(nobleGuestMarkers[0].PlaceAtMe(LocalJarl.GetActorReference().GetLeveledActorBase(), 1))
NobleAliases[1].ForceRefTo(nobleGuestMarkers[1].PlaceAtMe(LocalPWThane.GetActorReference().GetLeveledActorBase(), 1))
index = 2
while index < 6
actor noble =  nobleGuestMarkers[index].PlaceAtMe(nobleAB, 1) as actor
NobleAliases[index].ForceRefTo(noble)
noble.SetAngle(0.0, 0.0, Noble.GetAngleZ() + noble.GetHeadingAngle(Game.GetPlayer()))
index += 1
endwhile

Utility.Wait(3.0)
FadeToBlack.Remove()

gallowScript.nonLethal = (Utility.RandomInt(0, 99) < Punish.FakeExecutionChance)
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


ReferenceAlias Property Torturer  Auto  

ObjectReference Property entryMarker  Auto  

PW_ModIntegrationsScript Property Mods Auto

ObjectReference Property GallowsRef Auto

PW_PunishmentScript Property Punish  Auto  

ObjectReference[] Property FillGuestMarkers  Auto  

ObjectReference[] Property NobleGuestMarkers  Auto  

ImageSpaceModifier Property FadeToBlack  Auto  

ReferenceAlias Property LocalJarl  Auto  

ReferenceAlias Property LocalPWThane  Auto  

ReferenceAlias[] Property AdventurerAliases  Auto  

ReferenceAlias[] Property NobleAliases  Auto  

ActorBase Property nobleAB  Auto 

PW_GallowFurnScriptShort Property gallowScript  Auto  

Int Property fakeExecutionRoll  Auto  
