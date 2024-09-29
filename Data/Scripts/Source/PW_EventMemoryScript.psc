Scriptname PW_EventMemoryScript extends PW_ScriptComponent

;---------------------------------------------------
; PW Event Memory System
;---------------------------------------------------
;
; This component keeps a "log" of occurrences that
; PW wants to track. This way, components like Fame
; can have a detailed understanding of the player's
; actions up to this poInt.
;
; Details tracked per event:
;------------------------------
Int[] eventType         ;type of occurrence, enumerated by EVENT_TYPE_ constants in PW_Constants
Float[] time            ;GameTime of occurrence
Form[] otherActorAB  ;actor base of sex or dialogue partner
Int[] numWitnesses      ;number of people who saw the event
Int[] outcome           ;TBD
;------------------------------
;
; Note that the PW_EventMemoryScript does not do any
; recognition on its own. It is the responsibility of
; other components to register events. All this script
; does is "remember" them, and provide some analysis
; functions and variables.
;
;


int earliestEventIndex = 0

Int property maxEventsStored = 30 Auto

PW_Constants property constants Auto

;Overridden PW_ScriptComponent function
Function Initialize()
	ResetList()
	constants = PW_Constants.GetConstants()
endFunction

;Overridden PW_ScriptComponent function
Function Startup()
	RegisterForModEvent("PW_AddToEventMemory", "Push")
endFunction

Function ResetList()
	eventType = Utility.CreateIntArray(maxEventsStored)
	time = Utility.CreateFloatArray(maxEventsStored)
	otherActorAB = Utility.CreateFormArray(maxEventsStored)
	numWitnesses = Utility.CreateIntArray(maxEventsStored)
	outcome = Utility.CreateIntArray(maxEventsStored)
endFunction

Event Push(Int argEventType, Float argTime, Form argOtherActorAB, int argNumWitnesses, int argOutcome)
	earliestEventIndex += 1
	if earliestEventIndex >= maxEventsStored - 1
		earliestEventIndex = maxEventsStored - 1
	endIf
	
	;Shift existing
	int i = earliestEventIndex
	while i >= 1
		eventType[i]    = eventType[i - 1]
		time[i]         = time[i - 1]
		otherActorAB[i] = otherActorAB[i - 1]
		numWitnesses[i] = numWitnesses[i - 1]
		outcome[i]      = outcome[i - 1]
		
		i -= 1
	endWhile
	
	;Add existing to new slot
	eventType[0]    = argEventType
	time[0]         = argTime
	otherActorAB[0] = argOtherActorAB
	numWitnesses[0] = argNumWitnesses
	outcome[0]      = argOutcome
	
endEvent

String Function GetEventDescription(int eventIndex)
	string actorName = "None"
	if otherActorAB[eventIndex] as ActorBase
		actorName = (otherActorAB[eventIndex] as ActorBase).GetName()
	endIf
	
	return "Type: " + eventType[eventIndex] + ", Time: " + time[eventIndex] + ", Actor: " + actorName
endFunction

Function PrintListStateMessageBox()
	string output = ""
	int i = 0
	while i < maxEventsStored
		output += GetEventDescription(i) + "\n"
		i += 1
	endWhile
	Debug.MessageBox(output)
endfunction

Function TestListFunctionality()
	Utility.Wait(0.1)
	Debug.MessageBox("Beginning Event Memory list functionality test")
	
	ActorBase nazeemAB = Game.GetFormFromFile(0x00013BBF, "Skyrim.esm") as ActorBase
	ActorBase brynjolfAB = Game.GetFormFromFile(0x0001B07D, "Skyrim.esm") as ActorBase
	ActorBase alduinAB = Game.GetFormFromFile(0x0008E4F1, "Skyrim.esm") as ActorBase
	
	Debug.MessageBox("Adding and then printing state, 4x")
	Push(constants.EVENT_TYPE_SEX, Utility.GetCurrentGameTime(), nazeemAB as Form, 34, constants.EVENT_OUTCOME_NONE)
	PrintListStateMessageBox()
	Utility.Wait(0.2)
	
	Push(constants.EVENT_TYPE_NONE, Utility.GetCurrentGameTime(), brynjolfAB as Form, 12, constants.EVENT_OUTCOME_NONE)
	PrintListStateMessageBox()
	Utility.Wait(0.2)
	
	Push(constants.EVENT_TYPE_PAID_SEX, Utility.GetCurrentGameTime(), alduinAB as Form, 765, constants.EVENT_OUTCOME_NONE)
	PrintListStateMessageBox()
	Utility.Wait(0.2)
	
	Push(constants.EVENT_TYPE_SEX, Utility.GetCurrentGameTime(), nazeemAB as Form, 1, constants.EVENT_OUTCOME_NONE)
	PrintListStateMessageBox()
	Utility.Wait(0.2)
	
	
	Debug.MessageBox("Resetting and then printing state")
	ResetList()
	PrintListStateMessageBox()
	
endFunction

