;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PW_TIF__040822FA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ftb.applycrossfade(0.5)
Utility.Wait(0.5)
Debug.MessageBox("You only manage to get out a few words before he clamps a hand around your mouth. You don't have the willpower to fight back - he's in complete control.")
utility.wait(0.1)
Debug.MessageBox("'Don't mind her, she's just trying to amuse us,' he says. The guests look on, increasingly dubious. \n'Let me remind you why you're doing this,' he whispers.")
utility.wait(0.1)
Debug.MessageBox("His other hand moves down to your cunt and begins to finger you. His fingers feel weird. There's some kind of oil on them.")
utility.wait(0.1)
Debug.MessageBox("Within seconds your head begins to feel clouded again, and you realize that this was the drug he must have dosed you with earlier. Each time he enters you it feels better, until you're squealing with pleasure into his palm, at which point he uncovers your mouth.")
ImageSpaceModifier.RemoveCrossfade(0.5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property ftb  Auto  
