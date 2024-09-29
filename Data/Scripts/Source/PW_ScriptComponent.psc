Scriptname PW_ScriptComponent extends Quest  Conditional
{ Base class for most major components of PW }

string property componentName Auto
bool property debugEnabled = true Auto


function Initialize()
	;/ Override this in derived class, with definitions and assignments for first startup /;
endFunction

function Startup()
	;/ Override this in derived class, with steps performed every single startup (event registers) /;
endFunction

string function GetName()
	if(componentName == "")
		return "Unnamed"
	else
		return componentName
	endIf
endFunction