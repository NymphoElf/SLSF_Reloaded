ScriptName SLSF_Reloaded_TimeManager extends Quest

SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_Logger Property Logger Auto

Float Property LastCheckedTime Auto Hidden

Bool Property TimeManagerRunning Auto Hidden

Event OnInit()
	Startup()
	Logger.Log("SLSF Reloaded - TimeManager Initialized", True)
EndEvent

Function Startup()
	TimeManagerRunning = False
	;Always set the default LastCheckedTime as the initialized game-time. This is necessary to prevent the scripts going crazy when installing mid-playthrough or updating
	LastCheckedTime = Utility.GetCurrentGameTime()
	Logger.Log("SLSF Reloaded - TimeManager Startup: TimeManagerRunning is " + TimeManagerRunning, True)
	Logger.Log("SLSF Reloaded - TimeManager Startup: LastCheckedTime is " + LastCheckedTime, True)
EndFunction

Function PeriodicFameTimer()
	TimeManagerRunning = True
	
	Float CurrentTime = Utility.GetCurrentGameTime()
	Float TimeDifference = (CurrentTime - LastCheckedTime) ;check the time difference since last check.
	
	;Check for Negative Countdown, which should be 'impossible'. If it is negative, reset LastCheckedTime to current time and terminate
	If TimeDifference < 0
		LastCheckedTime = CurrentTime
		TimeManagerRunning = False
		Logger.Log("SLSF Reloaded Time Manager - Time Difference is negative. Reset LastCheckedTime to CurrentTime.")
		return
	EndIf
	
	Int CountdownChange = 0 ;Define and initialize CountdownChange
	
	Logger.Log("SLSF Reloaded Time Manager - Time Difference is: " + TimeDifference + " (Need 0.0199 or more)")
	
	While TimeDifference < 0.0199 ;Script delay can prevent the checked time from reaching 0.02, so we check a slightly lower number
		Logger.Log("SLSF Reloaded Time Manager - Checked too soon. Waiting 5 in-game minutes...")
		
		Utility.WaitGameTime(0.08) ;If we checked too soon, wait ~5 in-game minutes and check again
		CurrentTime = Utility.GetCurrentGameTime()
		
		TimeDifference = (CurrentTime - LastCheckedTime)
		Logger.Log("SLSF Reloaded Time Manager - Waited 5 in-game minutes. Time Difference is now: " + TimeDifference + " (Need 0.0199 or more)")
	EndWhile
	
	LastCheckedTime = CurrentTime ;Keep original checked time as Last Checked to prevent Time Manager always waiting 5 minutes
	
	CountdownChange = (TimeDifference * 48) as Int
	If CountdownChange < 1
		;Once the script gets this far, we know this should be at least 1
		CountdownChange = 1
	EndIf
	Logger.Log("SLSF Reloaded Time Manager - Update Fame. Countdown Change: " + CountdownChange)
	FameManager.UpdateFame(CountdownChange)
	
	TimeManagerRunning = False
EndFunction