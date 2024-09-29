;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__09052BD3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Key restraintsKey = Game.GetFormFromFile(0x0701775F, "Devious Devices - Integration.esm") as key
;Game.GetPlayer().AddItem(restraintsKey, 1)
Mods.unequipAllDD()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


PW_ModIntegrationsScript property Mods Auto
