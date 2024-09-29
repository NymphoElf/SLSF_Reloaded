;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 22
Scriptname PW_SF_PW_WindhelmStart_PostOa_04082319 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ftb.ApplyCrossfade(1.0)
Utility.Wait(1.1)

Debug.MessageBox("The guards bring in a huge, beautiful stallion. As it approaches you see the size of it's cock and feel your jaw drop as the Thane's intent becomes clear to you.")
raloof = RaloofMarker.PlaceActorAtMe(RaloofAB, 1)

ImageSpaceModifier.RemoveCrossfade(1.0)
Utility.Wait(1.1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
GetOwningQuest().SetStage(70)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
sexQueue.Enqueue(Raloof, aksHook="RaloofSex", aksAnimTags="DoggyStyle")
sexQueue.Enqueue(Raloof, aksHook="RaloofSex", aksAnimTags="DoggyStyle")
sexQueue.Enqueue(Raloof, aksHook="RaloofSex", aksAnimTags="DoggyStyle")
sexQueue.Enqueue(Raloof, aksHook="RaloofSex", aksAnimTags="DoggyStyle")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
Debug.MessageBox("After proudly swallowing a load from every nobleman, you still find yourself hungry, but less than before. You accept the hunger as part of your new life - another mandate to serve your owner well.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
ftb.ApplyCrossfade(2.0)
Utility.Wait(2.1)

Debug.MessageBox("The guards escort Raloof out of the hall, while the guests cheer and drink to the mighty stallion's victory over you.")

Raloof.Delete()

ImageSpaceModifier.RemoveCrossFade(2.0)
Utility.Wait(2.1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
sexQueue.Enqueue(Alias_PartyJarlWindhelm.GetActorReference(), aksAnimTags="Blowjob")
sexQueue.Enqueue(Alias_PartyJarlWhiterun.GetActorReference(), aksAnimTags="Blowjob")
sexQueue.Enqueue(Alias_PartyJarlFalkreath.GetActorReference(), aksAnimTags="Blowjob")
sexQueue.Enqueue(Alias_PartyJarlMarkarth.GetActorReference(), aksAnimTags="Blowjob")
sexQueue.Enqueue(Alias_PartyDuke.GetActorReference(), aksAnimTags="Blowjob")
sexQueue.Enqueue(Alias_PartyEarl.GetActorReference(), aksAnimTags="Blowjob")
sexQueue.Enqueue(Alias_PartySultan.GetActorReference(), aksAnimTags="Blowjob")
sexQueue.Enqueue(Alias_PartyJarlWindhelm.GetActorReference(), aksAnimTags="Blowjob")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ActorBase Property RaloofAB  Auto  

ObjectReference Property RaloofMarker  Auto  

ImageSpaceModifier Property ftb  Auto  

PW_SexQueueScript Property sexQueue  Auto  

Actor Property Raloof  Auto  

ReferenceAlias Property NewProperty  Auto  

ReferenceAlias Property Alias_PartyJarlWindhelm  Auto  

ReferenceAlias Property Alias_PartyJarlFalkreath  Auto  

ReferenceAlias Property Alias_PartyJarlMarkarth  Auto  

ReferenceAlias Property Alias_PartyJarlWhiterun  Auto  

ReferenceAlias Property Alias_PartyDuke  Auto  

ReferenceAlias Property Alias_PartyEarl  Auto  

ReferenceAlias Property Alias_PartySultan  Auto  
