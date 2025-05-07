ScriptName SLSF_Reloaded_UpdateManager extends Quest

SLSF_Reloaded_DataManager Property DataManager Auto
SLSF_Reloaded_playerScript Property PlayerScript Auto
SLSF_Reloaded_FameManager Property FameManager Auto

Float Property ModVersion = 3.1 AutoReadOnly

Function CheckModUpdate(Float pVersion)
	If pVersion < ModVersion
		If pVersion < 3.1
			DataManager.DisplayFameFlags = New Bool[4]
			DataManager.EnableCumDumpFlags = New Bool[100]
			DataManager.EnableCuckFlags = New Bool[100]
			DataManager.EnableUnfaithfulFlags = New Bool[100]
			DataManager.EnableAirheadFlags = New Bool[100]
			
			FameManager.CuckFameCleared = FameManager.SLSFCFameTypesCleared
			FameManager.UnfaithfulFameCleared = FameManager.SLSFCFameTypesCleared
		EndIf
	EndIf
	
	PlayerScript.LastModVersion = ModVersion
EndFunction