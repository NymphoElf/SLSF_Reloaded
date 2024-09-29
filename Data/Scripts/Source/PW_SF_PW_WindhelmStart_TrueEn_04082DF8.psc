;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname PW_SF_PW_WindhelmStart_TrueEn_04082DF8 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ftb.ApplyCrossFade(0.5)
Utility.Wait(0.6)

Debug.MessageBox("Thane Enrensen produces a paintbrush and runs it over your asscheek, marking you as Windhelm's property. Whatever ink he's using burns, but you make sure to stay still and endure it.")
mods.AddSlaveTat(7)

ImageSpaceModifier.RemoveCrossfade(0.5)
Utility.Wait(0.6)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
GetOwningQuest().SetStage(80)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property ftb  Auto
PW_ModIntegrationsScript property mods Auto
