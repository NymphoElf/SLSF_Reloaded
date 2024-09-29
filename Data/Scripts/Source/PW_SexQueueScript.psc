Scriptname PW_SexQueueScript extends PW_ScriptComponent  Conditional

; OVERVIEW
; ----------------------------------------------------------------------------------------
; Enqueue() actors to make them wait until the next opening to have sex with the player.
; This should be used as a substitute to calling Sexlab directly, as it can synchronize
; multiple Sexlab scenes. The first up actor in the queue is the one Sexlab uses, then
; it is dequeued once the scene ends.
;
; Enqueue can be passed a string as a hook, which will then be associated with that alias.
; If an alias' hook is not empty, this script will broadcast events with that hook, allowing
; registration for 'callbacks' upon the actor being processed through the queue.
;
; Events sent are:
; 		PW_SexQueueSexStart_<hook>			: Sent when the actor starts sex
;		PW_SexQueueSexEndNonfinal_<hook>	: Sent when the actor's sex scene ends, but there's another after. No time for elaborate handling
;		PW_SexQueueSexEndFinal_<hook>		: Sent when the actor's sex scene ends, there are none after, and you can take your time handling the aftermath
;		PW_SexQueueDequeue_<hook>			: Sent when the actor is removed from the queue, usually after SexEnd, but potentially before if removed early
;
; All of these events SEND THE CORRESPONDING ACTOR AS AN ARGUMENT, so the event's code should
; look something like this:
;
;		(at registration, registering for sex start, where you set 'MyApproacher' as the hook):
;		RegisterForModEvent("PW_SexQueueSexStart_MyApproacher", "OnSexQueueSexStart")
;
;		(the event):
;		event OnSexQueueSexStart(Form theOriginalActor)
;			if theOriginalActor as Actor
;				Debug.MessageBox(actor.GetLeveledActorBase().GetName() + " is done with the player!")
;				
;				; OPTIONAL BUT RECOMMENDED - do cleanup
;				UnregisterForModEvent("PW_SexQueueSexStart_MyApproacher") 	; where you do the cleanup is obviously subject to functional requirements
;			endIf
;		endEvent
;

import PW_Utility

PW_ActorManagerScript property actorMgr Auto
SexLabFramework property sexlab Auto

;Internal hook, this one never reaches the caller
String SEXLAB_HOOK = "PWSQM"

PW_SexQueueAliasScript[] property aliases Auto

int numActors = 0
int enqueueingIndex = 0
int dequeueingIndex = 0

ActorBase property testActorBase Auto ;spawned when testing the queue

bool automaticMode = false
bool property processing = false Auto Conditional
bool sceneActive = false
float actorStartTime = 0.0

float timeout = 15.0 ;seconds to wait for sex scene to start

string SEX_START =        "PW_SexQueueSexStart"
string SEX_END_FINAL =    "PW_SexQueueSexEnd"
string SEX_END_NONFINAL = "PW_SexQueueSexEndNonfinal"

float property updateInterval = 10.0 Auto

Faction property inQueueFaction Auto
Faction property SexlabAnimatingFaction Auto
Formlist property autoEnqueueExemptFactions Auto

;Auto mode runtime vars
int autoNoneFoundCount
int autoModeRoundsRemaining
string  autoModeHook
string autoModeAnimTags

int AUTO_NONE_FOUND_MAX = 10

Actor property player Auto

function Initialize()
	pwDebug(self, 1, "initialized")
	
	;Change magic number for alias list size below
	aliases = new PW_SexQueueAliasScript[15]
	int i = 0
	while(i < 15)
		aliases[i] = GetAlias(i) as PW_SexQueueAliasScript
		i += 1
	endWhile
	
	player = Game.GetPlayer()
	
	processing = false
endFunction

function Startup()
	RegisterForModEvent("HookAnimationStart_"+SEXLAB_HOOK, "OnQueueSexStart")
	RegisterForModEvent("HookAnimationEnd_"+SEXLAB_HOOK, "OnQueueSexEnd")
	
	pwDebug(self, 1, "started up")
endFunction

function StartProcessing()
	if(!processing)
		processing = true
		SendModEvent("dhlp-Suspend")
	endIf
	RegisterForSingleUpdate(0.5)
endFunction

function Shutdown()
	StopAutomaticMode()
	UnregisterForUpdate()
	
	sceneActive = false
	processing = false
	
	SendModEvent("dhlp-Resume")
	
	dequeueingIndex = 0
	
	int i = 0
	while i < aliases.length
		DequeueCurrent()
		i += 1
	endWhile
	
	dequeueingIndex = 0 ; is probably 0 anyway but redundancy is safety here
	enqueueingIndex = 0
	numActors = 0
	
endFunction

event OnUpdate()
	pwDebug(self, 1, "update")
	
	if(sceneActive && !player.IsInFaction(SexlabAnimatingFaction) && Utility.GetCurrentRealTime() - actorStartTime >= timeout)
		pwDebug(self, 2, "sex scene timed out after " + (Utility.GetCurrentRealTime() - actorStartTime) + " seconds")
		;timeout conditions are met, move on
		DequeueCurrent()
		if(IsEmpty())
			Shutdown()
			return
		elseIf(processing)
			StartSexWithNext()
		endIf
	else
		
	endIf
	
	if(processing)
		RegisterForSingleUpdate(updateInterval)
	endIf
endEvent

event OnQueueSexStart(int tid, bool hasPlayer)
	actorStartTime = Utility.GetCurrentRealTime()
	SendSexQueueEvent(SEX_START, GetCurrent().GetCallbackHook())
endEvent

event OnQueueSexEnd(int tid, bool hasPlayer)
	pwDebug(self, 1, "received Sexlab sex end event")
	
	if(IsEmpty())
		SendSexQueueEvent(SEX_END_FINAL, GetCurrent().GetCallbackHook())
	else
		SendSexQueueEvent(SEX_END_NONFINAL, GetCurrent().GetCallbackHook())
	endIf
	
	DequeueCurrent()
	
	if(IsEmpty())
		Shutdown()
		return
	elseIf(processing)
		Utility.Wait(4.0)
		StartSexWithNext()
	endIf
	
	sceneActive = false
	
endEvent

function StartSexWithNext()
	sceneActive = true
	actorStartTime = Utility.GetCurrentRealTime()
	
	PW_SexQueueAliasScript nextActor
	bool actorFound = false
	while !IsEmpty() && !actorFound
		nextActor = GetCurrent()
		if nextActor.GetActorReference() == none
			DequeueCurrent()
		else
			actorFound = true
		endIf
	endWhile
	
	if nextActor.GetActorReference() == none
		pwDebug(self, 5, "only found 'none' actors in queue, shutting down queue")
		Shutdown()
		return
	endIf
	
	
	pwDebug(self, 1, "starting sex with next actor: " + nextActor.GetActorReference().GetLeveledActorBase().GetName())
	
	if(nextActor.GetIsRapist())
		SexLab.QuickStart(player, nextActor.GetActorReference(), hook = SEXLAB_HOOK, victim = player, AnimationTags = nextActor.GetAnimTags())
	else
		SexLab.QuickStart(player, nextActor.GetActorReference(), hook = SEXLAB_HOOK, AnimationTags = nextActor.GetAnimTags())
	endIf
	
endFunction

;Enqueue actor, give it a hook optionally
function Enqueue(Actor who, bool isRape = false, string aksHook = "", string aksAnimTags = "")
	pwDebug(self, 1, "Enqueue ENTER")
	if IsFull()
		pwDebug(self, 5, "Enqueue(): attempted to add an actor while queue full")
		return
	elseIf who == None
		pwDebug(self, 5, "Enqueue(): 'None' actor passed in, returning")
		return
	else
		pwDebug(self, 1, "Enqueue: adding " + who.GetLeveledActorBase().GetName() + " to queue")
	endIf
	
	StartProcessing()
	
	aliases[enqueueingIndex].ForceRefWithHook(who, isRape, aksHook=aksHook, aksAnimTags=aksAnimTags)
	who.AddToFaction(inQueueFaction)
	
	numActors += 1
	
	enqueueingIndex += 1
	
	if(enqueueingIndex >= aliases.length)
		pwDebug(self, 1, "Enqueue: resetting enqueueing index")
		enqueueingIndex = 0
	endIf
	
	if(processing && !sceneActive)
		pwDebug(self, 1, "Enqueue: starting sex with enqueued actor")
		StartSexWithNext()
	endIf
	
	pwDebug(self, 1, "Enqueue EXIT")
endFunction

PW_SexQueueAliasScript function GetCurrent()
	return aliases[dequeueingIndex]
endFunction

function DequeueCurrent()
	if(aliases[dequeueingIndex] != none)
		Actor dequeueTarget = aliases[dequeueingIndex].GetActorReference()
		if(dequeueTarget != none)
			pwDebug(self, 1, "dequeueing " + dequeueTarget.GetLeveledActorBase().GetName())
			dequeueTarget.RemoveFromFaction(inQueueFaction)
			aliases[dequeueingIndex].Clear()
		else
			;pwDebug(self, 1, "not dequeueing because there was no actor at index " + dequeueingIndex)
		endIf
	endIf
	
	numActors -= 1
	
	dequeueingIndex += 1
	if(dequeueingIndex >= aliases.length)
		dequeueingIndex = 0
	endIf
	
endFunction


function SendSexQueueEvent(string eventName, string eventHook)
	if(eventHook == "")
		pwDebug(self, 4, "not sending sex queue event because invalid hook was given")
		return
	endIf
	string eventNameFull = eventName + "_" + eventHook
	pwDebug(self, 2, "sending event " + eventNameFull)
	int handle = ModEvent.Create(eventNameFull)
	ModEvent.PushForm(handle, GetCurrent().GetActorReference() as Form)
	ModEvent.Send(handle)
endFunction

Bool function IsFull()
	return numActors == aliases.length
endFunction

bool function IsEmpty()
	return numActors == 0
endFunction

int function GetSize()
	return numActors
endFunction

bool function StartAutomaticMode(int maxRounds, string hook = "", faction exemptFaction = none, string animationTags = "")
{returns whether starting automatic mode was successful}
	GoToState("AUTOMATIC")
	
	autoNoneFoundCount = 0
	autoModeRoundsRemaining = maxRounds
	autoModeHook = hook
	autoModeAnimTags = animationTags
	
	if(exemptFaction != none)
		autoEnqueueExemptFactions.AddForm(exemptFaction)
	endIf
	
	StartProcessing()
	
	return true
endFunction

function StopAutomaticMode()
endFunction


State AUTOMATIC
	event OnUpdate()
		pwDebug(self, 1, "update (automatic mode)\n  " \
						+  autoModeRoundsRemaining + " rounds remaining\n" + \
						"  hook=" + autoModeHook)
		
		if(autoModeRoundsRemaining > 0)
			int i = 0
			int numNewActors = 0
			while i < 3 && autoModeRoundsRemaining > 0
				actor potentialNewActor = actorMgr.GetValidApproacher(autoEnqueueExemptFactions)
				if(potentialNewActor != none)
					if(!IsFull() && autoModeRoundsRemaining > 0)
						;TODO rape maybe shouldn't be unconditionally false here
						Enqueue(potentialNewActor, isRape = false, aksHook = autoModeHook, aksAnimTags = autoModeAnimTags)
						autoModeRoundsRemaining -= 1
					endIf
					numNewActors += 1
				endIf
				i += 1
			endWhile
			
			if(numNewActors == 0)
				autoNoneFoundCount += 1
			endIf
		else
			pwDebug(self, 4, "skipping actor pull because enough auto mode rounds are queued")
		endIf
		
		if autoNoneFoundCount >= AUTO_NONE_FOUND_MAX
			pwDebug(self, 4, "shutting down queue because no new actors found after " + AUTO_NONE_FOUND_MAX + " updates")
			Shutdown()
			return
		endIf
	
		;Perform normal update behavior for timeouts
		if(sceneActive && !player.IsInFaction(SexlabAnimatingFaction) && Utility.GetCurrentRealTime() - actorStartTime >= timeout)
			pwDebug(self, 4, "partner timed out: " + aliases[dequeueingIndex].GetActorReference().GetLeveledActorBase().GetName())
			;timeout conditions are met, move on
			DequeueCurrent()
			if(IsEmpty())
				Shutdown()
				return
			else
				StartSexWithNext()
			endIf
		else
			pwDebug(self, 2, "scene should be running with " +  aliases[dequeueingIndex].GetActorReference().GetLeveledActorBase().GetName() + ", "  + (timeout - (Utility.GetCurrentRealTime() - actorStartTime)) + " seconds before timeout check")
		endIf
		
		if(processing)
			RegisterForSingleUpdate(updateInterval)
		endIf
	endEvent

	bool function StartAutomaticMode(int maxRounds, string hook = "", faction exemptFaction = none, string animationTags = "")
		return false
	endFunction
	
	
	function StopAutomaticMode()
		pwDebug(self, 3, "disengaging automatic mode")
		
		GoToState("")
		
		autoModeHook = ""
		autoModeAnimTags = ""
		
		autoEnqueueExemptFactions.Revert()
		
	endFunction
	
endState


;/ --------------------------------------------- /;
;/ -------------- Test Functions --------------- /;
;/ --------------------------------------------- /;
function PrintQueueState()
	string output = ""
	
	int i = 0
	while(i < aliases.length)
		if(i == enqueueingIndex)
			output += "(Q) "
		endIf
		
		if(i == dequeueingIndex)
			output += "(D) "
		endIf
	
		actor current = aliases[i].GetActorReference()
		if current != none
			output += i + ": " + current.GetLeveledActorBase().GetName()+ "\n"
		else
			output += i + ": unassigned\n"
		endIf
		i += 1
	endWhile
	
	Debug.MessageBox("Queue state:\n" + output)
	
endFunction

function RunQueueingTest()

	Utility.Wait(0.01)
	
	Actor[] nazeems = new Actor[15]
	
	int i = 0
	while(i < 15)
		nazeems[i] = Game.GetPlayer().PlaceAtMe(testActorBase) as Actor
		Enqueue(nazeems[i])
		Utility.Wait(0.01)
		i += 1
	endWhile
	
	Debug.MessageBox("spawned 15 new actors")
	PrintQueueState()
	
	Utility.Wait(2.0)
	
	Debug.MessageBox("dequeueing the first 3")
	i = 0
	while i < 3
		DequeueCurrent()
		i += 1
		Utility.Wait(0.01)
	endWhile
	
	PrintQueueState()	
	
	Utility.Wait(2.0)
	
	
	Debug.MessageBox("dequeueing the next 12")
	i = 0
	while i < 12
		DequeueCurrent()
		i += 1
		Utility.Wait(0.01)
	endWhile
	
	PrintQueueState()
	
	Debug.MessageBox("end of sex queue test")
	
	Utility.Wait(2.0)
	i = 0
	while i < 15
		nazeems[i].Delete()
		i += 1
	endWhile
	
	Shutdown()
endFunction

function RunSexTest()

	Utility.Wait(0.01)
	
	processing = false
	
	Actor[] nazeems = new Actor[15]
	
	int i = 0
	while(i < 15)
		nazeems[i] = Game.GetPlayer().PlaceAtMe(testActorBase) as Actor
		Utility.Wait(0.01)
		i += 1
	endWhile
	
	Debug.MessageBox("spawned 15 new actors")
	
	Debug.MessageBox("queueing 3 and setting to running")
	bool runningPreviously = processing
	processing = true
	
	i = 0
	while(i < 3)
		Enqueue(nazeems[i])
		Utility.Wait(0.01)
		i += 1
	endWhile
	
	Debug.MessageBox("queueing complete, waiting for queue to empty")
	
	while !IsEmpty()
		Debug.Notification("SEX QUEUE TEST: waiting for queue to empty")
		Utility.Wait(3.0)
	endWhile
	
	Debug.MessageBox("completed, queueing all 15 now")
	
	i = 0
	while(i < 15)
		Enqueue(nazeems[i])
		Utility.Wait(0.01)
		i += 1
	endWhile
	
	PrintQueueState()
	
	while !IsEmpty()
		Utility.Wait(3.0)
	endWhile
	
	Debug.MessageBox("end of sex queue test")
	
	processing = runningPreviously
	
	Utility.Wait(2.0)
	i = 0
	while i < 15
		nazeems[i].Delete()
		i += 1
	endWhile
	
	Shutdown()
endFunction
