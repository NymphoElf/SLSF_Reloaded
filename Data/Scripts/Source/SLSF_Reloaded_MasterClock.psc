ScriptName SLSF_Reloaded_MasterClock extends Quest

SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_LegacyOverwrite Property LegacyOverwrite Auto
SLSF_Reloaded_Logger Property Logger Auto

Float Property HourSplit = 0.041667 AutoReadOnly
Float Property HalfHourSplit = 0.020834 AutoReadOnly
Float Property QuarterHourSplit = 0.010417 AutoReadOnly

Float Property LastTimeChecked Auto Hidden

GlobalVariable Property SLSF_Reloaded_Skooma Auto

Int Property HalfHourSync Auto Hidden
Int Property HourSync Auto Hidden
Int Property DaySync Auto Hidden

Int Property DecayTicker Auto Hidden
Int Property SpreadTicker Auto Hidden

Event OnInit()
	Startup()
EndEvent

Function Startup()
	Utility.Wait(2)
	RegisterForUpdateGameTime(0.25)
	SLSF_Reloaded_Logger.Log("<Master Clock> [OnInit] - Master Clock Initialized!", Logger.CRITICAL)
EndFunction

Event OnUpdateGameTime()
	SLSF_Reloaded_Logger.Log("<Master Clock> [OnUpdateGameTime] - START")
	Float CurrentGameTime = Utility.GetCurrentGameTime()
	Float TimeDifference = CurrentGameTime - LastTimeChecked
	
	SLSF_Reloaded_Logger.Log("<Master Clock> [OnUpdateGameTime] - CurrentGameTime = " + CurrentGameTime)
	SLSF_Reloaded_Logger.Log("<Master Clock> [OnUpdateGameTime] - LastTimeChecked = " + LastTimeChecked)
	SLSF_Reloaded_Logger.Log("<Master Clock> [OnUpdateGameTime] - TimeDifference = " + TimeDifference)
	
	If TimeDifference < 0
		LastTimeChecked = CurrentGameTime
		SLSF_Reloaded_Logger.Log("<Master Clock> [OnUpdateGameTime] - Time Difference is negative. Reset LastCheckedTime to CurrentGameTime.")
		return
	EndIf
	
	Int IterationsNeeded = (TimeDifference / QuarterHourSplit) as Int
	
	HalfHourSync += IterationsNeeded
	;HourSync += IterationsNeeded
	;DaySync += IterationsNeeded
	
	Int Multiplier = 0
	
	If HalfHourSync >= 2
		Multiplier = (HalfHourSync / 2)
		HalfHourChecks(Multiplier)
		HalfHourSync -= (Multiplier * 2)
	EndIf
	;/
	If HourSync >= 4
		Multiplier = (HourSync / 4)
		HourChecks(Multiplier)
		HourSync -= (Multiplier * 4)
	EndIf
	/;
	If IterationsNeeded > 0
		LastTimeChecked += QuarterHourSplit * IterationsNeeded
	EndIf
	SLSF_Reloaded_Logger.Log("<Master Clock> [OnUpdateGameTime] - END")
EndEvent

Function HalfHourChecks(Int Multiplier)
	SLSF_Reloaded_Logger.Log("<Master Clock> [HalfHourChecks] - START")
	DecayHandler(Multiplier)
	SpreadHandler(Multiplier)
	PeriodicFameUpdate(Multiplier)
	SLSF_Reloaded_Logger.Log("<Master Clock> [HalfHourChecks] - END")
EndFunction

Function DecayHandler(Int Multiplier)
	SLSF_Reloaded_Logger.Log("<Master Clock> [DecayHandler] - START")
	DecayTicker += Multiplier
	Int DecayTimes = 0
	While DecayTicker >= Config.DecayTimeNeeded
		DecayTimes += 1
		DecayTicker -= Config.DecayTimeNeeded
	EndWhile
	
	If DecayTimes > 0
		FameManager.DecayFame(DecayTimes)
	EndIf
	SLSF_Reloaded_Logger.Log("<Master Clock> [DecayHandler] - END")
EndFunction

Function SpreadHandler(Int Multiplier)
	SLSF_Reloaded_Logger.Log("<Master Clock> [SpreadHandler] - START")
	SpreadTicker += Multiplier
	While SpreadTicker >= Config.SpreadTimeNeeded
		FameManager.SpreadFameRoll()
		SpreadTicker -= Config.SpreadTimeNeeded
	EndWhile
	SLSF_Reloaded_Logger.Log("<Master Clock> [SpreadHandler] - END")
EndFunction

Function PeriodicFameUpdate(Int Multiplier)
	SLSF_Reloaded_Logger.Log("<Master Clock> [PeriodicFameUpdate] - START")
	FameManager.UpdateFame(Multiplier)
	
	Int OldSkoomaValue = SLSF_Reloaded_Skooma.GetValue() as Int
	Int NewSkoomaValue = OldSkoomaValue - Multiplier
	
	If NewSkoomaValue < 0
		NewSkoomaValue = 0
	EndIf
	
	SLSF_Reloaded_Skooma.SetValue(NewSkoomaValue)
	
	If Config.AllowLegacyOverwrite == True
		SLSF_Reloaded_Logger.Log("<Master Clock> [PeriodicFameUpdate] - AllowLegacyOverwrite is TRUE")
		LegacyOverwrite.OverwriteLegacyFame()
	Else
		SLSF_Reloaded_Logger.Log("<Master Clock> [PeriodicFameUpdate] - AllowLegacyOverwrite is FALSE")
	EndIf
	SLSF_Reloaded_Logger.Log("<Master Clock> [PeriodicFameUpdate] - END")
EndFunction