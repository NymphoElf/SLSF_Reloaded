Scriptname PW_SLSF

int[] function getSLSFFames() global
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
	
	;Debug.Notification("PW_SLSF does not detect the SLSF plugin")
	return Utility.CreateIntArray(9, -1)
endFunction
