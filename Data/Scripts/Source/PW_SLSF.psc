Scriptname PW_SLSF extends Quest

PW_ModIntegrationsScript Property Mods Auto
PW_FameScript Property Fame Auto

Function Startup()
	If Mods.isSLSFInstalled == true
		;Register SLSF Reloaded FameReturn
		RegisterForModEvent("SLSF_Reloaded_ReturnRequestedFame", "OnSLSFReloadedFameReturn")
	endIf
EndFunction

Event OnSLSFReloadedFameReturn(String LocationName, String Category, Int FameValue)
	If Category == "Slut"
		Fame.SLSFR_SlutFame = FameValue
	ElseIf Category == "Whore"
		Fame.SLSFR_WhoreFame = FameValue
	ElseIf Category == "Exhibitionist"
		Fame.SLSFR_ExhibitionistFame = FameValue
	ElseIf Category == "Submissive"
		Fame.SLSFR_SubmissiveFame = FameValue
	ElseIf Category == "Bestiality"
		Fame.SLSFR_BestialityFame = FameValue
	endIf
EndEvent

int[] function getSLSFFames() global
;/
	if(Game.GetModByName("SexLab - Sexual Fame [SLSF].esm" ) != 255)
		SLSF_CompatibilityScript SLSF = Game.GetFormFromFile(0x0001E157, "SexLab - Sexual Fame [SLSF].esm") as SLSF_CompatibilityScript
		
		
		
		if(SLSF.GetCurrentFameValues(true).length < 9)
			;Debug.Notification("PW_SLSF got a none-array from SLSF")
			return Utility.CreateIntArray(9, -1)
			
		else
			int[] fameValues = SLSF.GetCurrentFameValues(true)
			;Debug.Notification("PW_SLSF returning " + fameValues)
			return fameValues
		endIf
		
		
	endIf
/;
	;Kept this line to "dummy" the Script
	;Debug.Notification("PW_SLSF does not detect the SLSF plugin")
	return Utility.CreateIntArray(9, -1)
endFunction