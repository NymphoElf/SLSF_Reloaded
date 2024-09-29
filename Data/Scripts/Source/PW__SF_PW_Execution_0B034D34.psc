;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname PW__SF_PW_Execution_0B034D34 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if(!Mods.usingZaZ)
     Debug.MessageBox("A scene was called that requires ZaZ Animation Pack v8.0 or higher. Skipped Execution scene.")
     Punish.sendToNextScene()
     Stop()
else

;Mods.initializeGallows(GallowsRef)
FadeToBlack.ApplyCrossFade(2.0)
Utility.Wait(1.0)
Game.GetPlayer().MoveTo(EntryMarker)
int index = 0
while index < 3
AdventuererAliases[index].forcerefto(FillGuestMarkers[index].placeAtMe(Punish.adventurerAB, 1))
index += 1
endWhile


NobleAliases[0].ForceRefTo(nobleGuestMarkers[0].PlaceAtMe(LocalJarl.GetActorReference().GetLeveledActorBase(), 1))
NobleAliases[1].ForceRefTo(nobleGuestMarkers[1].PlaceAtMe(LocalPWThane.GetActorReference().GetLeveledActorBase(), 1))
index = 2
while index < 6
NobleAliases[index].ForceRefTo(nobleGuestMarkers[index].PlaceAtMe(nobleAB, 1))
index += 1
endwhile

Utility.Wait(3.0)
FadeToBlack.Remove()
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property KillIdle  Auto  

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

ReferenceAlias[] Property AdventuererAliases  Auto  

ReferenceAlias[] Property NobleAliases  Auto  

ActorBase Property nobleAB  Auto  
