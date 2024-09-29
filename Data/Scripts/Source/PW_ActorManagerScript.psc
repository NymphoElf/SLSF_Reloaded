Scriptname PW_ActorManagerScript extends PW_ScriptComponent Conditional

import PW_Utility


;TODO - add "oneshot" functions that find one actor, and circumvent the actor list

SexlabFramework Property Sexlab Auto

bool actorSearchEnabled = false;
int property approachRadius = 1500 Auto		;What distance can NPCs decide to approach from?
GlobalVariable property playerGenderPref Auto
Bool property canGuardsApproach = false Auto Conditional	;Whether guards can approach the player or not
Bool property canEldersApproach = false Auto Conditional
Bool property canFollowersApproach = false Auto Conditional
Bool property canSlavesApproach = false Auto Conditional
Faction property recentClientFaction auto

Faction property isGuardFaction Auto
Faction property PW_ThaneFaction Auto
Faction property PlayerFollowerFaction Auto
Faction property zbfSlaveFaction Auto

actor player

actor[] validActors	    ;A list of actors that are valid for approaching the player. Currently only used for selecting one on approach, but may be useful later
int actorListSize = 0	   ;This stores the number of elements that have valid data in them.

bool suspended = false

float scanPeriod = 8.0	; Begin a new search if it's been at least this many real seconds since the last scan
float lastScan = 0.0 	; Time in real seconds of last scan

Spell property scanPower Auto

string validApproacherReport

int property scanMode = 1 Auto
int property SCAN_MODE_CELL = 0 AutoReadOnly
int property SCAN_MODE_POWER = 1 AutoReadOnly

Race Property ElderRace  Auto  


function Initialize()
	player = Game.GetPlayer()
	validActors= new actor[30]
	
	actorSearchEnabled = true
	
endFunction

function Startup()
	RegisterForModEvent("PW_CheckTimeComponents", "CheckTimeComponents")
	
	;For now, scanning in cities is enough
	RegisterForModEvent("PW_EnterCity", "EnterCity")
	RegisterForModEvent("PW_LeaveCity", "LeaveCity")
	
	RegisterForModEvent("dhlp-Suspend", "Suspend")
	RegisterForModEvent("dhlp-Resume", "Resume")
	
	validApproacherReport = ""

endFunction

event Suspend(string eventName, string strArg, float numArg, Form sender)
	suspended = true
endEvent

event Resume(string eventName, string strArg, float numArg, Form sender)
	suspended = false
endEvent

event EnterCity(int locIndex)
	SetActorSearchEnabled(true)
endEvent

event LeaveCity(int locIndex)
	SetActorSearchEnabled(false)
endEvent

event SetActorSearchEnabled(bool enabled)
	actorSearchEnabled = enabled
endEvent

event CheckTimeComponents()
;/ Old way - now we scan on request for actors, if we need to based on time
	if(actorSearchEnabled && !suspended)
		actorListSize = CellScan()
	endIf
/;
endEvent

function Scan()
	if scanMode == SCAN_MODE_CELL
		CellScan()
	elseIf scanMode == SCAN_MODE_POWER
		PowerScan()
	endIf

	lastScan = Utility.GetCurrentRealTime()
endFunction


function CellScan()
;Searches NPCs in the current cell for those that are suitable to approach the player, stores them in validNpcs[]
;Returns the number of npcs in validNpcs[]

;DEPRECATED AS OF 1.1.1, unless re-introduction is needed for performance. Use power scan instead now

	
	pwDebug(self, 2, "ActorManager performing cell scan")
	Cell currentCell = player.GetParentCell()	;The cell the player is in, for ease of reference
	int npcsInCell = currentCell.GetNumRefs(43)	;Number of npcs in cell at time of function call. NOTE: this can become inaccurate quickly
	Actor nthNpc = none	;A storage space for whichever hypothetical NPC is being processed in the loop
	validActors = new Actor[30]	;Array to hold only the NPC's that are valid. 30 should be more than enough valid NPCs

	int inputIndex = npcsInCell	;Index to track position through the theoretical total number of NPCs
	int outputIndex = 0	;Index to keep track of position in the output array of only 'valid' NPCs

	;Find all valid NPCs in current cell, store in validNpcs
	while inputIndex > 0 && outputIndex <= 49
		nthNpc = currentCell.GetNthRef(inputIndex, 43) as Actor	;Take an NPC (type 43) from the current cell
		if isValidActor(nthNpc)
			validActors[outputIndex] = nthNpc
			outputIndex += 1
		endif

		inputIndex -= 1
	endwhile
	pwDebug(self, 2, "ActorManager cell scan found " + outputIndex + " actors")
	
	if outputIndex > 0  	;Because there's a theoretical chance this returns no valid npcs
		actorListSize = outputIndex
	else
		actorListSize = 0
	endif
	;Question is - could this have been done better? I posit that it could, but will not change it just yet.

endfunction

function PowerScan()
	pwDebug(self, 2, "ActorManager performing power scan")
	validActors = new Actor[30]
	actorListSize = 0
	scanPower.cast(akSource = player)
	
	Utility.Wait(2.0)
	
	pwDebug(self, 1, actorListSize + " actors found in power scan")
endFunction

function RegisterPowerScannedActor(actor scannedActor)
	;These debug lines fucking MURDER the PW log. Only for when absolutely necessary
	if(IsValidActor(scannedActor))
		;pwDebug(self, 1, "adding power scanned actor " + scannedActor.GetLeveledActorBase().GetName())
		AddPowerScanned(scannedActor)
	else
		;pwDebug(self, 3, "power scanned actor " + scannedActor.GetLeveledActorBase().GetName() + " is not valid")
		return
	endIf
endFunction

function AddPowerScanned(actor newActor)
	if actorListSize < validActors.length
		validActors[actorListSize] = newActor
		actorListSize += 1
	endIf
endFunction


;Is this an actor we can use for anything maybe?
bool function isValidActor(actor npc)
	;if npc exists, isn't player, isn't creature, isn't dead, isn't asleep, isn't a child, and isn't unconscious...
	if (npc != none && npc != player && !npc.HasKeyWordString("ActorTypeCreature") && !npc.IsDead() && npc.GetSleepState() < 3 && !npc.IsChild() && !npc.IsUnconscious() && !npc.IsDisabled())
		if(!Sexlab.IsActorActive(npc))		;if npc isn't in a sexlab scene
			return true
		endIf
	endIf
	
	return false
endfunction

bool function isValidApproacher(actor npc)
{Is this an actor that can approach the player?
Takes into account content preferences}
	
	;if npc exists, isn't player, isn't creature, isn't dead, isn't asleep, isn't a child, and isn't unconscious...
	if (npc == none || npc == player || npc.HasKeyWordString("ActorTypeCreature") || npc.IsDead() || npc.GetSleepState() >= 3 || npc.IsChild() || npc.IsUnconscious() || npc.IsDisabled())
		;validApproacherReport += npc.GetLeveledActorBase().GetName() + ": failed sanity check\n"
		return false
	endIf
	
	if(Sexlab.IsActorActive(npc) || npc.GetDistance(player) > approachRadius )		;if npc isn't in a sexlab scene and isn't too far away and has LOS...
		;validApproacherReport += npc.GetLeveledActorBase().GetName() + ": failed Sexlab/distance check\n"
		return false
	endIf
	
	
	if(playerGenderPref.GetValue() as int != 2 && npc.GetActorBase().GetSex() != playerGenderPref.GetValue() as int) ;if PC is bi or the npc is the preferred sex...
		;validApproacherReport += npc.GetLeveledActorBase().GetName() + ": failed gender preference check\n"
		return false
	endIf
	
	if(		(!npc.IsInFaction(isGuardFaction) || canGuardsApproach) \
		&&  (npc.GetRace() != ElderRace || canEldersApproach) \
		&& 	(!npc.IsInFaction(PlayerFollowerFaction) || canFollowersApproach) \
		&& 	!npc.IsInFaction(recentClientFaction) && !npc.isInFaction(PW_ThaneFaction) \
		&&  (!npc.isInFaction(zbfSlaveFaction) || canSlavesApproach))
		
		;validApproacherReport += (npc.GetLeveledActorBase().GetName() + ": was valid\n")
		return true  ;then this is a valid approacher
	endIf
	
	;validApproacherReport += npc.GetLeveledActorBase().GetName() + ": failed faction check\n"
	return false
endfunction

actor function GetValidApproacher(Formlist blockedFactions = none)
{Wrapper for GetValidApproacherNoScan that caches actors for later use}

	if(Utility.GetCurrentRealTime() - lastScan >= scanPeriod)
		Scan()
	endIf
	
	return GetValidApproacherNoScan(blockedFactions)
	
endFunction

actor function GetValidApproacherNoScan(Formlist blockedFactions = none)
{Cycles through valid actor list, chooses one that's a viable approacher.
TODO: maybe try and find a better algorithm. This one prefers actors in the lower indices}
	int index = 0
	while(index < actorListSize)
		actor potentialApproacher = validActors[index]
		if potentialApproacher != none
			if isValidApproacher(potentialApproacher) && !IsActorInFactions(potentialApproacher, blockedFactions)
				pwDebug(self, 3, "PW approacher found: " + potentialApproacher.GetLeveledActorBase().GetName())
				return potentialApproacher
			endIf
		endIf
		index += 1
	endWhile
	
	pwDebug(self, 3, "PW found no approachers")
	return None
endFunction

actor function GetBestApproacher(Formlist blockedFactions = none)
	if DueForScan()
		Scan()
	endIf
	
	
	; Multiplied by cos(heading angle to a prospective approacher) to compensate for the player (likely) moving
	int MAX_ANGLE_COMPENSATION = 500 ;units straight ahead
	
	int index = 0 
	
	int bestDistance = 100000 ; something that will always be beate
	actor bestSoFar = none
	int angleCompensationOfBest = 0
	
	while(index < actorListSize)
		if validActors[index] != none
			if IsValidApproacher(validActors[index]) && !IsActorInFactions(validActors[index], blockedFactions)
				float headingAngle = player.GetHeadingAngle(validActors[index])
				float angleCompensation = 0
				if headingAngle >= -60.0 && headingAngle <= 60.0 ;take only front 120 deg, but mult by 1.5 to treat it like a 180 deg cosine range for greater preference towards center of path
					angleCompensation = Math.Cos(headingAngle * 1.5) * MAX_ANGLE_COMPENSATION
				endIf
				
				int adjustedDistance = (player.GetDistance(validActors[index]) - angleCompensation) as int
				if  adjustedDistance <= bestDistance
					bestSoFar = validActors[index]
					bestDistance = player.GetDistance(validActors[index]) as int
					angleCompensationOfBest = angleCompensation as int
					
				endIf
			endIf
		endIf
		index += 1
	endWhile
	
	if bestSoFar != none
		pwDebug(self, 2, "GetBestApproacher: best approacher is " + bestSoFar.GetLeveledActorBase().GetName() + " (" + bestDistance + " units away) (directional compensation of " + angleCompensationOfBest + " units)")
	else
		pwDebug(self, 2, "GetBestApproacher: failed to find any approacher")
	endIf
	
	return bestSoFar
endFunction

;Returns whether the actor is in any of the passed factions
bool function IsActorInFactions(actor who, Formlist factions)
	if !factions || factions.GetSize() < 1
		return false
	endIf
	
	int i = 0
	while i < factions.GetSize()
		if factions.GetAt(i) as Faction
			if who.IsInFaction(factions.GetAt(i) as Faction)
				return true
			endIf
		endIf
		i += 1
	endWhile
	
	return false
endFunction


function printValidApproacherReport()
	Debug.MessageBox(validApproacherReport)
endFunction


actor function getValidActorGuard(bool LOSNeeded)
	pwDebug(self, 2, "being queried for a valid guard...")
	Scan()
	
	int index = 0
		actor currentActor = none
		while index < actorListSize
			currentActor = validActors[index]
			if(currentActor.GetFactionRank(isGuardFaction) >= 0 && !currentActor.GetActorBase().IsUnique())
				pwDebug(self, 2, "returning guard")
				return currentActor
			endIf
			index += 1
		endWhile
	pwDebug(self, 4, "found no valid guard")
	return none
endFunction

actor[] function GetValidApproachers(int maxSize)
	
endFunction

; Acquires a fresh actor array from the cell
actor[] function getValidActorArray(int maxSize)
{Expensive ass function to get a random valid actor (NOT in the validActors) array. Steals code from a lot of my other functions
to gather a list of valid NPCs in the cell and randomly select a configurable number.}

	Cell currentCell = player.GetParentCell()	;The cell the player is in, for ease of reference
	int npcsInCell = currentCell.GetNumRefs(43)	;Number of npcs in cell at time of function call. NOTE: this can become inaccurate quickly
	Actor nthNpc = none	;A storage space for whichever hypothetical NPC is being processed in the loop
	Actor[] validArray = new Actor[20]	;Array to hold only the NPC's that are valid 

	int inputIndex = npcsInCell	;Index to track position through the theoretical total number of NPCs
	int outputIndex = 0	;Index to keep track of position in the output array of only 'valid' NPCs

	while inputIndex > 0 && outputIndex <= maxSize
		nthNpc = currentCell.GetNthRef(inputIndex, 43) as Actor	;Take an NPC (type 43) from the current cell
		if (isValidActor(nthNpc))
			validArray[outputIndex] = nthNpc
			outputIndex += 1
		endif
		inputIndex -= 1
	endWhile

	return validArray

endFunction

; Acquires a fresh actor array from the cell, of no more than 5 actors
actor[] function getValidActorArray5()
	Cell currentCell = player.GetParentCell()	;The cell the player is in, for ease of reference
	int npcsInCell = currentCell.GetNumRefs(43)	;Number of npcs in cell at time of function call. NOTE: this can become inaccurate quickly
	Actor nthNpc = none	;A storage space for whichever hypothetical NPC is being processed in the loop
	Actor[] validArray = new Actor[5]	;Array to hold only the NPC's that are valid 

	int inputIndex = npcsInCell	;Index to track position through the theoretical total number of NPCs
	int outputIndex = 0	;Index to keep track of position in the output array of only 'valid' NPCs

	while inputIndex > 0 && outputIndex < 5
		nthNpc = currentCell.GetNthRef(inputIndex, 43) as Actor	;Take an NPC (type 43) from the current cell
		if nthNpc != none
			if (isValidApproacher(nthNpc))
				validArray[outputIndex] = nthNpc
				outputIndex += 1
			endif
		endIf
		inputIndex -= 1
	endWhile

	return validArray
endFunction

int function  GetNumActorsWithLOS(actor target)
	Scan()
	
	int losCount = 0
	int i = 0
	while(i < actorListSize)
		if(validActors[i] != none)
			if(validActors[i].HasLOS(target))
				losCount += 1
			endIf
		endIf
		i += 1
	endWhile
	
	return losCount
endFunction


int function  GetNumActorsWithLOSOrNear(actor target, int radius = 1500)
	Scan()
	
	int losCount = 0
	int i = 0
	while(i < actorListSize)
		if(validActors[i] != none)
			if(validActors[i].HasLOS(target) || validActors[i].GetDistance(target) < radius)
				losCount += 1
			endIf
		endIf
		i += 1
	endWhile
	
	return losCount
endFunction


bool function DueForScan()
	return (Utility.GetCurrentRealTime() - lastScan >= scanPeriod)
endFunction
