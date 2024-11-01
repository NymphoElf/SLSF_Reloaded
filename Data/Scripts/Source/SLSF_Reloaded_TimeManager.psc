ScriptName SLSF_Reloaded_TimeManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_MCM Property Config Auto

Float Property LastCheckedTime Auto Hidden

Bool Property TimeManagerRunning Auto Hidden

Event OnInit()
	Startup()
EndEvent

Function Startup()
	TimeManagerRunning = False
	LastCheckedTime = 0
EndFunction

Function PeriodicFameTimer()
	TimeManagerRunning = True
	
	Float CurrentTime = Utility.GetCurrentGameTime()
	Float TimeDifference = (CurrentTime - LastCheckedTime) ;check the time difference since last check. 
	
	Int CountdownChange = 0 ;Define and initialize CountdownChange
	
	If Config.EnableTracing == True
		Debug.Trace("SLSF Reloaded Time Manager - Time Difference = " + TimeDifference)
	EndIf
	
	While TimeDifference < 0.0199 ;Script delay can prevents the checked time from reaching 0.02, so we check a slightly lower number
		If Config.EnableTracing == True
			Debug.Trace("SLSF Reloaded Time Manager - Updated too soon. Waiting 5 in-game minutes...")
		EndIf
		
		Utility.WaitGameTime(0.08) ;If we checked too soon, wait ~5 in-game minutes and check again
		
		TimeDifference = (CurrentTime - LastCheckedTime)
	EndWhile
	
	LastCheckedTime = CurrentTime ;Keep original checked time as Last Checked to prevent Time Manager always waiting 5 minutes
	
	CountdownChange = (TimeDifference * 48) as Int
	If CountdownChange < 1
		;Once the script gets this far, we know this should be at least 1
		CountdownChange = 1
	EndIf
	
	FameManager.UpdateFame(CountdownChange)
	
	TimeManagerRunning = False
EndFunction