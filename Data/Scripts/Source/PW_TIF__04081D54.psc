;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PW_TIF__04081D54 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
NewProperty.mod(-2)
Debug.MessageBox("The chef places burning, freshly-cooked salmon and potatoes on your bare torso, and you silently vow to take revenge for her sudden speed of service. The Jarl devours the food, using his tongue far more than necessary, which elicits a drunken laugh from the nobles each time. When he's done he disregards you and banters with the other men, your use as a prop in his party stunt exhausted.")
(GetOwningQuest() as PW_WHMIQ_Script).Stage40IncrementGuestsTended()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property NewProperty  Auto  
