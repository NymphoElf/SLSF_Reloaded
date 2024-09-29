Scriptname PW_Utility extends Quest  

GlobalVariable property GameDay Auto
GlobalVariable property GameHour Auto

bool property debugNotificationsEnabled = false Auto
bool property loggingEnabled = true Auto
int property debugShowLevel = 2 Auto
int property debugMessageBoxLevel = 5 Auto

string[] property LEVEL_STRINGS Auto

event OnInit()
	RegisterForModEvent("PW_DebugMessage", "debugMessage")
endEvent

event debugMessage(form sender, int level, string msg)

	string compName = ""
	bool compAllowsDebug = true
	PW_ScriptComponent sc = sender as PW_ScriptComponent
	if(sc != none)
		compName = sc.componentName + ": "
		compAllowsDebug = sc.debugEnabled
	endIf
	
	string output = "PW: " + compName + msg
	
	Debug.TraceUser("PublicWhore", LEVEL_STRINGS[level] + ": " + output)

	if(level >= debugShowLevel && debugNotificationsEnabled && compAllowsDebug)
		if(level >= debugMessageBoxLevel)
			Debug.MessageBox(output)
		elseIf level >= debugShowLevel
			Debug.Notification(output)
		endIf
	endIf
	
	
endEvent

;/
DEBUG LEVELS:
	1 - TRACE
	2 - DEBUG
	3 - WARNING
	4 - ERROR
	5 - FATAL
/;

function pwDebug(form sender, int level, string msg) global
	int handle = ModEvent.create("PW_DebugMessage")
	ModEvent.pushForm(handle, sender)
	ModEvent.pushInt(handle, level)
	ModEvent.pushString(handle, msg)
	ModEvent.send(handle)
endFunction


;TODO Convert all of these to global functions

function advanceTimeToNext(int hour)
{Moves time forward, to the next hour passed, in 24-hour time}
	if(GameHour.GetValue() <= hour)
		GameHour.SetValue(hour)
	else
		GameDay.SetValue(GameDay.GetValue() + 1)
		GameHour.SetValue(hour)
	endIf
	return
endFunction

function advanceHours(int numOfHours)
	advanceTimeToNext(((GameHour.GetValue() + numOfHours) as int)% 24)
	return
endFunction

function advanceDays(int numOfDays)
	GameDay.SetValue(GameDay.GetValue() + numOfDays)
	return
endFunction

float function getHoursToNext(int hour)
	if(hour > GameHour.GetValue())
		return (hour - GameHour.GetValue()) as float
	else
		return (24 - (GameHour.GetValue() - hour)) as float
	endIf
		
endFunction

function RemoveWeapons(actor from, actor to = none) global
	
	int index = from.GetNumItems()
	while index > 0
		index -= 1
		form currItem = from.GetNthForm(index)
		if (currItem as weapon || currItem as armor)
			from.removeItem(currItem, from.GetItemCount(currItem), true, to)
		endIf
	endWhile
endFunction

function SetGlobal(GlobalVariable glob, int newValue) Global
{Sets a global to the specified value and pushes an event signifying that the
global was updated, so other scripts can update their instances of it}
	
	glob.setValue(newValue)

	int handle = ModEvent.create("PW_UpdateGlobal")
	ModEvent.pushForm(handle, glob as Form)
	ModEvent.Send(handle)

endFunction

;Sends an event that contains no data
function SendEvent(string eventName) Global
	int handle = ModEvent.create(eventName)
	ModEvent.send(handle)

	pwDebug(none, 1, "sending event: " + eventName)
endFunction

function SendIntEvent(string eventName, int value) Global
	int handle = ModEvent.create(eventName)
	ModEvent.pushInt(handle, value)
	ModEvent.send(handle)

	pwDebug(none, 1, "sending int event: " + eventName + "(" + value + ")")
endFunction

function sendStringEvent(string eventName, string value) Global
	int handle = ModEvent.create(eventName)
	ModEvent.pushString(handle, value)
	ModEvent.send(handle)

	pwDebug(none, 1, "sending string event: " + eventName + "(" + value + ")")
endFunction

function SendIntIntEvent(string eventName, int value1, int value2) Global
	int handle = ModEvent.create(eventName)
	ModEvent.pushInt(handle, value1)
	ModEvent.pushInt(handle, value2)
	ModEvent.send(handle)

	pwDebug(none, 1, "sending int int event: " + eventName + "(" + value1 + ", " + value2 + ")")
endFunction

function SendIntBoolEvent(string eventName, int intVal, bool boolVal) Global
	int handle = ModEvent.Create(eventName)
	ModEvent.pushInt(handle, intVal)
	ModEvent.pushBool(handle, boolVal)
	ModEvent.send(handle)
	
	pwDebug(none, 1, "sending int bool event: " + eventName + "(" + intVal + ", " + boolVal + ")")
endFunction

function SendIntFloatEvent(string eventName, int intVal, float floatVal) Global
	int handle = ModEvent.Create(eventName)
	ModEvent.pushInt(handle, intVal)
	ModEvent.pushFloat(handle, floatVal)
	ModEvent.send(handle)
	
	pwDebug(none, 1, "sending int float event: " + eventName + "(" + intVal + ", " + floatVal + ")")
endFunction

function SendFormEvent(string eventName, Form formArg) Global
	int handle = ModEvent.Create(eventName)
	ModEvent.pushForm(handle, formArg)
	ModEvent.send(handle)
	
	pwDebug(none, 1, "sending form event: " + eventName + "(" + formArg.GetName() + ")")
endFunction