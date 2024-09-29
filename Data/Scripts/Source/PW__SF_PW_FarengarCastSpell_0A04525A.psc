;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname PW__SF_PW_FarengarCastSpell_0A04525A Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Debug.MessageBox("You shudder as the spell washes over you, and your mind goes blank. Your singular focus is Farengar, and your only desire is to obey his every word.")
;FarengarHypnosis.Cast(Farengar.GetActorReference(), Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property FarengarHypnosis  Auto  

ReferenceAlias Property Farengar  Auto  
