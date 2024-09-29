;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW__TIF__0904CFDC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveAllItems(HuldaItemChest, true)
Game.GetPlayer().AddItem(BarkeepClothes01)
Game.GetPlayer().AddItem(BarkeepShoes)
Game.GetPlayer().EquipItem(BarkeepClothes01)
Game.GetPlayer().EquipItem(barkeepShoes)
Debug.MessageBox("Hulda takes your items and secures them behind the counter for you. She gives you a barmaid's outfit.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property BarkeepClothes01  Auto  

Armor Property barkeepShoes  Auto  

ObjectReference Property HuldaItemChest  Auto  
