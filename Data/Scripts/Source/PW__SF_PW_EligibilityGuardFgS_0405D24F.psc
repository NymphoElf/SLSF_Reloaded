;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__SF_PW_EligibilityGuardFgS_0405D24F Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
PW_Utility.pwDebug(self, 1, "eligibility force greet scene END")
PW_Utility.sendEvent("PW_Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
PW_Utility.pwDebug(self, 1, "eligibility force greet scene ENTER")
PW_Utility.sendEvent("PW_Suspend")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
