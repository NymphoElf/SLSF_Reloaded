;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 160
Scriptname PW__SF_PW_ArrestTortureNonCom_0A02DF8E Extends Scene Hidden

;BEGIN FRAGMENT Fragment_63
Function Fragment_63()
;BEGIN CODE
FadeToBlack.ApplyCrossfade()
Punish.messageBoxStory(false)
Punish.addZaZ("Rack")
Utility.Wait(1.5)
Game.DisablePlayerControls(true, true, false, false, true, false, true, false)
Player.MoveTo(Punish.ZaZFurniture)
Actor Torturer = TorturerRef.GetActorReference()
Torturer.MoveTo(OperateMarker)
Torturer.SetAngle(Torturer.GetAngleX(), Torturer.GetAngleY(), (Torturer.GetAngleZ() + Torturer.GetHeadingAngle(Game.GetPlayer())))
while(Game.GetPlayer().GetSitState() == 0)
   Punish.ZaZFurniture.Activate(Game.GetPlayer())
   Utility.Wait(4.0)
endWhile

FadeToBlack.Remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_59
Function Fragment_59()
;BEGIN CODE
Debug.MessageBox("Wave after wave of the spell pulses through you. Your heart is racing and your breasts rise and fall heavily as you gasp for air - even that movement is enough to stimulate you.")
Debug.MessageBox("The torturer briefly pauses, and you try to reposition yourself, subconsciously hoping to better expose yourself to the spell. But after several seconds, the spell does not strike you again.")
if(TorturerRef.GetActorReference().GetActorBase().GetSex() == 0)
Debug.MessageBox("You look up at the torturer, and you have to supress the overwhelming desire to ask him to pin you down and  ravage you on the spot. He begins to laugh at you, causing your face to turn bright red as you wonder if you had accidentally revealed your thoughts.")
else
Debug.MessageBox("You look up at the torturer, and you have to supress the overwhelming desire to ask her to destroy you with a strapon. She begins to laugh at you, causing your face to turn bright red as you wonder if you had accidentally revealed your thoughts.")
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
Debug.MessageBox("The torturer adjusts a mechanism on the rack, and it begins to pull your arms and legs in opposite directions. Just before the point of pain, the torturer stops, leaving your body stretched just taut enough that you're unable to move.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_143
Function Fragment_143()
;BEGIN CODE
Crusher.MoveTo(HoldingRoomMarker)
Game.GetPlayer().PlayIdle(Wounded3)
Punish.MessageBoxStory()
TorturerRef.GetActorRef().MoveTo(EntryMarker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_125
Function Fragment_125()
;BEGIN CODE
Punish.ZaZFurniture.Activate(Game.GetPlayer())
Utility.Wait(1.0)
Game.EnablePlayerControls()
Game.SetPlayerAIDriven(false)
Game.DisablePlayerControls(false, true, false, false, false, false, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_52
Function Fragment_52()
;BEGIN CODE
Game.GetPlayer().RestoreActorValue("Health", 400)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_135
Function Fragment_135()
;BEGIN CODE
Punish.pwPunishStartSex(Crusher, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_122
Function Fragment_122()
;BEGIN CODE
Punish.damagePlayer(150, true)
Debug.MessageBox("You begin to lose track of where the pain is coming from - all you know is that everything hurts. You hear the ropes of the rack begin to strain, though you're certain they're nowhere near breaking. Is this how you die? Torn in half by this psychotic torturer while you pathetically sob and scream, helpless to free yourself? You wish you had just given them what they wanted... your pride couldn't be worth this fate...")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_127
Function Fragment_127()
;BEGIN CODE
Debug.MessageBox("As you orgasm, the residual effects of the spell wear off almost instantaneously. You back away from the torturer, dazed, as you realize that the spell had caused you to be completely driven by lust for that entire duration. You don't know how you were capable of thinking some of the things you had thought, though the fact that they were still your own thoughts lingers uncomfortably in your mind.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_128
Function Fragment_128()
;BEGIN CODE
Crusher.MoveTo(Game.GetPlayer())
TorturerRef.GetActorRef().MoveTo(HoldingRoomMarker)
Punish.messageBoxStory()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_139
Function Fragment_139()
;BEGIN CODE
Punish.pwPunishStartSex(Crusher, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
Punish.incrementDebuff()
Punish.sendToNextScene()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_120
Function Fragment_120()
;BEGIN CODE
Punish.DamagePlayer(30, true)
Debug.MessageBox("You don't see how the rack could possibly extend further, but it does without any difficulty, unimpeded by the girlish screams and futile attempts to stop it made by its captive. Stars streak across your vision as the merciless machine pulls harder than ever, dislocating your hips and sending an excruciating pain throughout your entire body.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_137
Function Fragment_137()
;BEGIN CODE
Punish.pwPunishStartSex(Crusher, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_123
Function Fragment_123()
;BEGIN CODE
Red.ApplyCrossFade(1.0)
Punish.DamagePlayer(90.0, true, false)
Debug.MessageBox("The torturer starts to sound more irritated, and turns the wheel faster and faster. You scream as a sharp pain floods your arms and your shoulders dislocate. Seeing this the torturer stops for a moment and smiles, then delicately strokes your cheek, wiping away a stream of tears you hadn't even noticed.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_133
Function Fragment_133()
;BEGIN CODE
Punish.pwPunishStartSex(Crusher, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_82
Function Fragment_82()
;BEGIN CODE
Darkness.Remove()
FadeToBlack.Apply()
Punish.sceneStage = 6
Punish.messageBoxStory(false)
Torch1Light.Enable()
Torch2Light.Enable()
TorturerRef.GetActorReference().MoveTo(EntryMarker)
Punish.addZaZ("Pillory")
Utility.Wait(1.0)
while(Game.GetPlayer().GetSitState() == 0)
   Punish.ZaZFurniture.Activate(Game.GetPlayer())
   Utility.Wait(4.0)
endWhile
FadeToBlack.Remove()
weapon crop = Mods.getZaZWeapon("Crop")
TorturerRef.GetActorReference().AddItem(crop, 1)
TorturerRef.GetActorReference().EquipItem(crop, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_141
Function Fragment_141()
;BEGIN CODE
Punish.pwPunishStartSex(Crusher, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
Blur.ApplyCrossfade(2.5)
Game.GetPlayer().DamageActorValue("Health", (Game.GetPlayer().GetActorValue("Health") * 0.1) as int)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_56
Function Fragment_56()
;BEGIN CODE
Punish.ZaZFurniture.Activate(Game.GetPlayer())
Game.GetPlayer().MoveTo(PlayerFallMarker)
Player.SetAngle(Player.GetAngleX(), Player.GetAngleY(), Player.GetAngleZ() + Player.GetHeadingAngle(TorturerRef.GetReference()))
Player.PlayIdle(Wounded3)
Game.DisablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_71
Function Fragment_71()
;BEGIN CODE
Game.EnablePlayerControls()
Game.SetPlayerAIDriven(false)
FadeToBlack.ApplyCrossFade()
TorturerRef.GetReference().MoveTo(HoldingRoomMarker)
Torch1Light.Disable()
Torch2Light.Disable()
pwUtil.advanceDays(2)
Punish.sceneStage = 4
Punish.messageBoxStory(false)
ImageSpaceModifier.RemoveCrossfade()
Darkness.Apply()
Game.GetPlayer().PlayIdle(BreakIdle)
Punish.sceneStage = 5
Punish.messageBoxStory(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_115
Function Fragment_115()
;BEGIN CODE
Punish.damagePlayer(20, true)
Debug.MessageBox("The torturer continues to turn a wheel on the side of the rack, and the pressure tugging at you becomes much stronger. You feel a dull pain in your shoulders and hips, and realize that this thing could quite easily rip you apart.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_130
Function Fragment_130()
;BEGIN CODE
Punish.pwPunishStartSex(Crusher, true, true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PW_PunishmentScript Property Punish  Auto  

ImageSpaceModifier Property FadeToBlack  Auto  


ImageSpaceModifier Property Red Auto  


ObjectReference Property OperateMarker  Auto  

ReferenceAlias Property TorturerRef  Auto  

ImageSpaceModifier Property Blur  Auto  


ObjectReference Property PlayerFallMarker  Auto  

Actor Property Player  Auto  


ObjectReference Property Torch1Light  Auto  

ObjectReference Property Torch2Light  Auto  

ObjectReference Property HoldingRoomMarker  Auto  

PW_Utility Property pwUtil  Auto  

ImageSpaceModifier Property Darkness  Auto  

Idle Property Wounded3  Auto  

ObjectReference Property entryMarker  Auto  

Idle Property BreakIdle  Auto  

PW_ModIntegrationsScript Property Mods Auto

Actor Property Crusher  Auto  
