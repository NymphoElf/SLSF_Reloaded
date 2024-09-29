Scriptname PW_PunishmentScript extends PW_ScriptComponent conditional

import PW_Utility


PW_QuotaManagerScript property quotaMgr Auto

GlobalVariable property PW_BribeGold Auto
PW_ModIntegrationsScript property Mods Auto
PW_MainLoopScript property main auto
PW_ActorManagerScript property actorMgr Auto
PW_TrackerScript property tracker Auto
PW_Utility property pwUtil Auto


PW_PlayerScript property mainPlayerScript Auto
Actor Player

ReferenceAlias property RuleBreakGuard Auto
ReferenceAlias property AlertLevel1Guard Auto
ReferenceAlias property LightTortureZaZMarker Auto
SexLabFramework property Sexlab Auto 
ReferenceAlias property TortureCellMarker Auto
ReferenceAlias property HoldingCellMarker Auto
Actor property TorturerM Auto
Actor property TorturerF Auto
Actor property currentTorturer Auto
ActorBase[] property nobles Auto
ActorBase property adventurerAB Auto
ReferenceAlias property TorturerRef Auto
ReferenceAlias property ReturnMarker Auto
ReferenceAlias property LocalPWThane Auto
ReferenceAlias property PublicRapePlayerXMarker Auto
ReferenceAlias property PublicRapeThaneXMarker Auto
ObjectReference property HoldingRoomMarker Auto

ReferenceAlias Property ChainRapist  Auto  

ObjectReference property ZaZFurniture Auto

ObjectReference[] property PublicRapePlayerXMarkers Auto
ObjectReference[] property PublicRapeThaneXMarkers Auto

ImageSpaceModifier property FadeToBlack Auto

ObjectReference property PW_ItemHolder Auto
ObjectReference property PW_SQItemHolder Auto

ReferenceAlias[] property Spectators Auto

bool property pwDgConHitEnough = false Auto Conditional
bool property pwDgConAnotherAfter = false Auto Conditional
bool property pwDgConLTChoseRape = false Auto Conditional
bool property pwDgConLightIntoHeavy = false Auto Conditional
bool property pwDgConStayingInCell = false Auto Conditional

int property enfModeThreshold = 300 auto conditional

Float guardApproachStart
Bool property guardApproaching = false Auto
Bool property guardDialogueStarted = false Auto Conditional

bool[] property punishmentSceneEnabled Auto ;Has user toggled on/off?
Scene[] property PunishmentScenes Auto
;An array containing the punishment scenes.
;Indices are as follows:
;1 - Service extension default
;2 - Public Rape
;3 - Light Torture
;4 - Heavy Torture
;5 - Execution
;6 - Generic torture
;9 - Service extension intro

Faction[] property CrimeFactions Auto

;SCENE PROGRESS trackerS
int property activeScene = 0 Auto Conditional	;Denotes currently playing scene
;Values correspond to punishment tiers, except for the following specific values:
;	101: scene played when player outright defies a guard or the thane

bool property currentSexAdvancingScene = false Auto Conditional
int property sceneStage = 0 Auto Conditional
bool property sexSceneStarted = false Auto Conditional	;To keep track of whether we should be in a sex scene, and avance regardless if it hasn't triggered

float mbsPeriod = 1.0 ;message box story period, time in seconds between message boxes displaying

int property punishmentTypes = 5 AutoReadOnly 	;One-stop variable for adjusting the number of punishments that other scripts think exist
int[] property punishmentScores Auto	;Punishment score in each hold
string[] property punishmentLevelStrings Auto
;0: None, 1: Service Extension, 2: Public Rape, 3: Light Torture, 4: Heavy Torture, 5: Execution
;This array isn't going to be heavily used - it's more for me to keep track of what the levels mean. (Though it will be used for MCM and such).


int[] property punishmentThresholds Auto
;0: 0, 1: 100, 2: 200, 3: 300, 4: 400, 5: 500
;Indices correspond to the punishment levels above, while values hold the punishment score the player must reach to get that punishment
;These represent multiples as well, e.g. if the threshold for service extension is 60, then the player will receive a service extension at 60, 120, 180, and so on.

int[] property nextThresholds Auto
;Indices correspond to the punishment levels, values hold the next punishment score at which the player will receive that punishment

bool[] punishmentFlags
;Indices 0-53, default all false
;A punishment flag marks whether the player is due for a certain punishment in a certain hold
;Holds the punishment flags sorted by hold and then by punishment level, that is:
;0: Dawnstar lvl 0, 1: Dawnstar lvl 1, ... , 5: Dawnstar lvl 5, 6: Falkreath lvl 0, etc

;SCENE COMPLETION TRACKING - for the ones we only want running once
bool property completedLightTortureIntro = false auto conditional
bool property completedServiceExtensionIntro = false auto conditional
bool property completedPublicRapeIntro = false auto conditional



;SCORE INCREMENTS/DECREMENTS
int property sexDecreaseScore = 5 Auto					;When the player accepts or offers sex
int property OTSexDecreaseScore = 10 Auto				;When the player accepts or offers sex after the quota is already met
int property refusalIncreaseScore	= 35 Auto			;When the player refuses sex
int property rulesIncreaseScore = 35 Auto				;When the player breaks a rule
int property quotaIncreaseScore = 100 Auto				;When the player fails to meet quota
int property sideQuestFailureIncreaseScore = 100 Auto	;When the player fails a side quest
int property sideQuestBanditsDecreaseScore = 100 Auto	;Bandit SQ score decrease

bool property executionEnabled = true Auto conditional
int property fakeExecutionChance = 0 Auto Conditional

;DEBUFF
Spell[] property PW_DebuffSpells Auto Conditional
bool property debuffsEnabled = true Auto Conditional

;How broken the player's will is by punishment events
int property debuffLevel = 0 Auto Conditional

;This is a condition on the debuff spells, mainly meant to facilitate sex
bool property tempDisableDebuffs = false Auto conditional

int property debuffFadeDays = 3 Auto	;Number of days without an increase that must pass before current debuff level decreases by one
int daysOnCurrentDebuffLevel = 0


Sound[] property Voices Auto
int property playerVoice Auto
Race[] property Races Auto

;EXECUTION
ActorBase[] property executionCitizens Auto
ActorBase[] property executionNobles Auto
ReferenceAlias property ExecThane Auto
ReferenceAlias property ExecJarl Auto

bool[] property dueForPunishment Auto
int[] property alertLevel Auto					;Alert level in each hold
float[] property alertLevelStarts Auto			;Game time that the current alert level was set in each hold
int property alertLevelIncrementPeriod = 1 Auto 	;Number of days after which alert level goes from 1 to 2, or 2 to 3
int property numAlertLevel2Cities = 0 Auto Conditional	;How many cities have an alert level of 2 or higher
int property numAlertLevel3Cities = 0 Auto Conditional
int property currentAlertLevel Auto Conditional

Bool property breakingNudityRule = false Auto Conditional
Bool property breakingRestraintsRule = false Auto Conditional
Bool property breakingWeaponsRule = false Auto Conditional

bool property enforcedMode = false Auto Conditional
bool property enforcedModeInventoryTaken = true Auto Conditional
bool property enforcedModeHeavierRestraints = true Auto Conditional

Spell property CantLeaveSpell Auto

GlobalVariable property playerGenderPref Auto

int currentLocIndex = -1
int lastLocIndex

MagicEffect property CantLeaveMGEF Auto

Location property punishmentRoomsLoc Auto


function Initialize()
	;Initialization of all those things above
	
	Player = Game.GetPlayer()

	int index = 0
	while index < PW_DebuffSpells.Length
		Player.AddSpell(PW_DebuffSpells[index], false)
		index += 1
	endWhile

	
	punishmentScores = Utility.CreateIntArray(9, 0)

	punishmentLevelStrings = new string[6]
		punishmentLevelStrings[0] = "None"
		punishmentLevelStrings[1] = "Service Extension"
		punishmentLevelStrings[2] = "Public Rape"
		punishmentLevelStrings[3] = "Light Torture"
		punishmentLevelStrings[4] = "Heavy Torture"
		punishmentLevelStrings[5] = "Execution"

	punishmentThresholds = new int[6]
		punishmentThresholds[0] = 0
		punishmentThresholds[1] = 100
		punishmentThresholds[2] = 200
		punishmentThresholds[3] = 300
		punishmentThresholds[4] = 400
		punishmentThresholds[5] = 500
		
	punishmentSceneEnabled = Utility.CreateBoolArray(punishmentTypes + 1, true)
		
	dueForPunishment = new bool[9]
	alertLevel = new int[9]
	alertLevelStarts = new float[9]
	
	punishmentFlags = new bool[54]
	nextThresholds = new int[54]
	index = 0
	while index <= 53	;Probably unnecessary?
		nextThresholds[index] = punishmentThresholds[(index % 6)]
		index += 1
	endWhile

	index = 0
	playerVoice = 881
	while(index < 5)
		if(Player.GetRace() == Races[index])
			playerVoice = index
		endIf
		index += 1
	endWhile
	if(playerVoice == 881)
		playerVoice = 5
	endIf
	
	pwDebug(self, 3, "punishment initialized")
endFunction

event Startup()
	;Generic Sexlab hooks for toggling debuffs
	RegisterForModEvent("HookAnimationStart", "ExternalSexStart")
	RegisterForModEvent("HookAnimationEnd", "ExternalSexEnd")
	
	;Punishment-scene-started Sexlab hooks
	RegisterForModEvent("HookAnimationEnd_pwPunishSex", "pwOnPunishSexEnd")
    RegisterForModEvent("HookAnimationStart_pwPunishSex", "pwOnPunishSexStart")
	
	RegisterForModEvent("PW_CheckTimeComponents", "CheckTimeComponents")
	RegisterForModEvent("PW_DailyUpdate", "OnDailyUpdate")
	
	RegisterForModEvent("PW_EnterCity", "EnterCity")
	RegisterForModEvent("PW_LeaveCity", "LeaveCity")
	
	RegisterForModEvent("PW_SetEnforcedMode", "SetEnforcedMode")
	RegisterForModEvent("PW_ClearEnforcedMode", "ClearEnforcedMode")
	
	
	RegisterForModEvent("PW_IncrementAlertLevel", "IncrementAlertLevel")
	RegisterForModEvent("PW_IncrementAlertLevelLocal", "IncrementAlertLevelLocal")
	RegisterForModEvent("PW_ClearAlertLevel", "ClearAlertLevel")
	RegisterForModEvent("PW_ClearAlertLevelLocal", "ClearAlertLevelLocal")
	RegisterForModEvent("PW_FloorAlertLevel", "FloorAlertLevel")
	
	RegisterForModEvent("PW_SideQuestCompleted", "OnSideQuestCompleted")
	RegisterForModEvent("PW_SideQuestFailed", "OnSideQuestFailed")
	
	RegisterForModEvent("PW_RemoveItems", "RemoveItems")
endEvent

event EnterCity(int newLocIndex)
	currentLocIndex = newLocIndex
	lastLocIndex = newLocIndex
	LocalPWThane.ForceRefTo(tracker.pwThanes[newLocIndex])
endEvent

event LeaveCity(int locIndex)
	currentLocIndex = -1
	
	if(Game.GetPlayer().HasMagicEffect(CantLeaveMGEF) && !Main.approachesSuspended && !Game.GetPlayer().IsInLocation(punishmentRoomsLoc))
		FadeToBlack.ApplyCrossFade()
		Utility.Wait(2.0)
		Debug.MessageBox("You feel the Thane's spell begin to choke you. You can't breathe no matter how hard you try, and eventually collapse to the ground.")
		Utility.Wait(6.0)
		Game.GetPlayer().MoveTo(Tracker.cityCenterMarkers[mainPlayerScript.cantLeaveIndex])
		Debug.MessageBox("Some time later you awaken, slung over the shoulder of a guard. You see that you've been carried back into the city, as the guard drops you and tells you to get back to work.")
		FadeToBlack.Remove()
	endIf
	
endEvent

event CheckTimeComponents()
	if(main.playerCurrentStatus == 2)
		guardLOSCheck()
	endIf
endEvent

event OnDailyUpdate()
	if debuffLevel > 0
		daysOnCurrentDebuffLevel += 1
		if daysOnCurrentDebuffLevel >= debuffFadeDays
			debuffLevel -= 1
			daysOnCurrentDebuffLevel = 0
		endIf
	endIf
endEvent

event ExternalSexStart(int tid, bool HasPlayer)
	if(HasPlayer)
		tempDisableDebuffs = true
	endIf
endEvent

event ExternalSexEnd(int tid, bool HasPlayer)
	if(HasPlayer)
		tempDisableDebuffs = false
	endIf
endEvent

function damagePlayer(float damage, bool guaranteeScream = false, bool lethal = false)
	if(Player.GetActorValue("Health") >= (damage + 1.0) && lethal == false)
		Player.DamageActorValue("Health", damage)
	else
		Player.DamageActorValue("Health", Player.GetActorValue("Health") - 1.0)
	endIf
	
	if(guaranteeScream)
		playerScream()
	endIf

	return
endFunction

function playerScream()
	Voices[playerVoice].play(Player)
	return
endFunction

event OnSideQuestCompleted(string eventName, string strArg, float numArg, Form sender)
	if(numArg < 0 || numArg > 8)
		numArg = lastLocIndex
	endIf
	
	if(strArg == "bandits")
		decreaseScore(sideQuestBanditsDecreaseScore, numArg as int)
	endIf
endEvent

event OnSideQuestFailed(string eventName, string strArg, float numArg, Form sender)
	if(numArg < 0 || numArg > 8)
		numArg = lastLocIndex
	endIf
	
	increaseScore(sideQuestFailureIncreaseScore, numArg as int)
endEvent

function increaseScore(int increase, int where = -2)
	if(where == -2 || where == -1)	; This line of code is a fossil
		where = lastLocIndex
	elseIf(where < 0 || where > 8)
		return	;invalid argument
	endIf

	;I like to use statements such as increaseScore(increase * 1.2) but this causes ugly non-5-multiple results so we add this to keep it clean
	if((increase % 5) != 0)
		increase = increase - (increase % 5)
	endIf

	punishmentScores[where] = punishmentScores[where] + increase

	if(punishmentScores[where] > 0 && where == lastLocIndex)
		Debug.Notification("Your punishment score here has increased by " + increase + ". It is now " + punishmentScores[where] + ".")
	endIf

	checkFlags(where)
	
	PW_Utility.SendEvent("PW_UpdateLocInfo")
	
	return
endFunction

function decreaseScore(int decrease, int where = -2)
	if(where == -2 || where == -1)
		where = lastLocIndex
	elseIf(where < 0 || where > 8)
		return	;invalid argument
	endIf

	;I don't think there'll ever be an 'unclean' decrease but just in case
	if((decrease % 5) != 0)
		decrease = decrease - (decrease % 5)
	endIf

	punishmentScores[where] = punishmentScores[where] - decrease
	

	;if(punishmentScores[where] < 0)
	;	punishmentScores[where] = 0
	;endIf

	return
endFunction

event IncrementAlertLevel(int locIndex)

	if(locIndex < 0 || locIndex > 8)
		return
	endIf

	alertLevel[locIndex] = alertLevel[locIndex] + 1
	alertLevelStarts[locIndex] = Utility.GetCurrentGameTime()

	if(alertLevel[locIndex] == 3)
		numAlertLevel3Cities += 1
	elseIf(alertLevel[locIndex] >= 2)
		numAlertLevel2Cities += 1
	endIf
	
	if(locIndex == lastLocIndex)
		currentAlertLevel = alertLevel[lastLocIndex]
	endIf
	
	sendIntIntEvent("PW_AlertLevelChanged", locIndex, alertLevel[locIndex])
endEvent

; Increment Alert Level wrapper that knocks off one parameter and assumes locally
event IncrementAlertLevelLocal()
	IncrementAlertLevel(lastLocIndex)
endEvent

event ClearAlertLevel(int locIndex)
	if(locIndex < 0 || locIndex > 8)
		return
	endIf

	if(alertLevel[locIndex] == 3)
		numAlertLevel3Cities -= 1
		numAlertLevel2Cities -= 1
	elseIf(alertLevel[locIndex] >= 2)
		numAlertLevel2Cities -= 1
	endIf
	
	alertLevel[locIndex] = 0
	alertLevelStarts[locIndex] = 0

	if(locIndex == lastLocIndex)
		currentAlertLevel = alertLevel[lastLocIndex]
	endIf

	sendIntIntEvent("PW_AlertLevelChanged", locIndex, alertLevel[locIndex])
endEvent

event ClearAlertLevelLocal()
	ClearAlertLevel(lastLocIndex)
endEvent

event FloorAlertLevel(int locIndex, int minAlertLevel)
	if(alertLevel[locIndex] < minAlertLevel)
		alertLevel[locIndex] = minAlertLevel
	endIf
	
	if(locIndex == lastLocIndex)
		currentAlertLevel = alertLevel[lastLocIndex]
	endIf
	
	sendIntIntEvent("PW_AlertLevelChanged", locIndex, alertLevel[locIndex])
endEvent

function triggerNextFlag(int locIndex = -2)
;Finds the next punishment the player will be due for and then makes them due
;for it.

	if(locIndex == -2 || locIndex == -1)
		locIndex = lastLocIndex
	elseIf(locIndex > 8 || locIndex < 0)
		return
	endif
	
	int index = 1
	int punishmentIndex = 1
	int nearestThreshold = getNextThreshold(locIndex, 1)
	while index <= punishmentTypes
		if(getNextThreshold(locIndex, index) < nearestThreshold && punishmentSceneEnabled[index])
			nearestThreshold = getNextThreshold(locIndex, index)
			punishmentIndex = index
		endif
		index += 1
	endWhile
	
	if(punishmentIndex != 0)
		increaseScore((nearestThreshold - punishmentScores[locIndex]), locIndex)
	endif
	
	return
endFunction

function setNextThreshold(int locIndex, int punishmentIndex)
{Pushes the next time the player will be due for a punishment upward until it is higher than their score in the location}
	nextThresholds[((6 * locIndex) + punishmentIndex)] = (((punishmentScores[locIndex] / punishmentThresholds[punishmentIndex]) + 1) * punishmentThresholds[punishmentIndex])
	return
endFunction

int function getNextThreshold(int locIndex, int punishmentIndex)
{Retrieves the next score at which the player will be due for a punishment, in a particular location. Adds readability.}
	return nextThresholds[((6 * locIndex) + punishmentIndex)]
endFunction

function rescaleThreshold(int punishmentIndex, int value)
{Changes the base threshold for a punishment, adjusts the next thresholds in each hold and marks the player not due for the punishment}
	punishmentThresholds[punishmentIndex] = value
	int index = 0
	while index <= 8
		nextThresholds[((6 * index) + punishmentIndex)] = value	;Set this to its minimum possible value, so if our punishment score is less than the new value, and setNextThreshold thus doesn't do anything, we have a default value
		setNextThreshold(index, punishmentIndex)
		setFlag(index, punishmentIndex, false)
		index += 1
	endWhile
	return
endFunction

function checkFlags(int locIndex = -2)
;Checks the player's current punishment score against the next threshold for each punishment in the given city, and marks the flag if they're due for it. 
;Defaults to current location with no args

	if(locIndex == -2) 	;Sort out whether we're defaulting...
		locIndex = lastLocIndex
	elseIf(locIndex == -1)
		locIndex = lastLocIndex
	elseIf(locIndex < 0 || locIndex > 8)	;...and filter out non-default, non-valid index arguments
		pwDebug(self, 1, "PW: An invalid location index was passed to checkFlags()")
		return 
	endif	;Then keep going

	int index = 1	;We don't want this loop checking for multiples of the 'no punishment' tier so we start the loop at 1
	while index <= punishmentTypes		;So go through each punishment
		if(punishmentScores[locIndex] >= getNextThreshold(locIndex, index) && punishmentSceneEnabled[index])		;Is the player's punishment score high enough for the next instance of this punishment? Is it enabled?
			setNextThreshold(locIndex, index)		;If so, push the next instance of that punishment to a higher score
			setFlag(locIndex, index)			;Then set the flag for that punishment here
		endIf
		index += 1
	endWhile

	return
endFunction

function setFlag(int locIndex, int punishmentIndex, bool setTo = true)
;Selects the punishment flag for (location, punishment) to true by default, false via optional parameter.
	if(SceneSanityCheck(punishmentIndex))
		punishmentFlags[((6 * locIndex) + punishmentIndex)] = setTo
		
		if(setTo)
			SendIntIntEvent("PW_FloorAlertLevel", locIndex, 1) ; Set alert level to at least 1
		endIf
	endIf
	
	return
endFunction

; Check if scene makes sense to play
bool function SceneSanityCheck(int sceneIndex)
	if(sceneIndex == 1 && quotaMgr.quotaMode == quotaMgr.QUOTA_MODE_ENDLESS) ; Don't allow service extension if there isn't a quota
		return false
	endIf
	return true
endFunction

bool function getFlag(int locIndex, int punishmentIndex)
;The twin function of the one above. A simple method of retrieving a specific punishment flag.
	return punishmentFlags[((6 * locIndex) + punishmentIndex)]
endFunction

	;------------------------------------------------------------------------------------------------------------------------------------------------------------------;
	;  Remember that these are 54 element arrays, that we pretend are 6x9 arrays													                                   ;
	;  With Dawnstar being the first row, Falkreath being the second, etc in alphabetical order, columns being the punishments in order.	                           ;
	;  That's how we come up with the ((6*locIndex) + punishmentIndex) shit															                                   ;
	;------------------------------------------------------------------------------------------------------------------------------------------------------------------;



function guardLOSCheck()	;TODO make this less shitty
{This function fucking sucks. It desperately needs a readability refactor, but it works so it's not a priority.}

	actor nearbyGuard

	if(guardApproaching && (Utility.GetCurrentRealTime() - guardApproachStart) >= 20.0)
		pwDebug(self, 3, "PW: Guard reprimand timed out")
		RuleBreakGuard.clear()
		AlertLevel1Guard.clear()
		guardApproaching = false
		
	elseIf((alertLevel[lastLocIndex] == 1 || numAlertLevel2Cities > 0)&& !guardApproaching && main.isPlayerApproachable())
		nearbyGuard = actorMgr.getValidActorGuard(true)
		if nearbyGuard != none
			pwDebug(self, 3, "PW: Alert Guard approaching")
			AlertLevel1Guard.ForceRefTo(nearbyGuard)
			guardApproaching = true
			nearbyGuard.EvaluatePackage()
			PW_BribeGold.SetValue((quotaMgr.calculatePay() * 2) as int)
			guardApproachStart = Utility.GetCurrentRealTime()
		endIf
		
	elseIf(checkBreakingRules() && !guardApproaching && main.isPlayerApproachable() && Main.playerCurrentStatus == 2)
		nearbyGuard = actorMgr.getValidActorGuard(true)
		if nearbyGuard != none
			pwDebug(self, 3, "PW: Rule break guard approaching")
			RuleBreakGuard.ForceRefTo(nearbyGuard)
			guardApproaching = true
			nearbyGuard.EvaluatePackage()
			PW_BribeGold.SetValue((quotaMgr.calculatePay() * 2) as int)
			guardApproachStart = Utility.GetCurrentRealTime()
		endIf
		
	else
		return
		
	endIf

	return
endFunction


bool function checkBreakingRules()

	breakingNudityRule = false
	breakingRestraintsRule = false
	bool returnFlag = false

	if(Main.getPlayerNudity() < Main.nudityLevel)
		breakingNudityRule = true
		returnFlag = true
		pwDebug(self, 2, "PW: Player is breaking nudity rule")
	endIf

	if(!Main.isPlayerCollared && (Mods.usingZaZ || Mods.usingDD))
		breakingRestraintsRule = true
		returnFlag = true
		pwDebug(self, 2, "PW: Player is breaking collar rule")
	endIf
	
	if(Main.isPlayerArmed && !Main.weaponsAllowed)
		breakingWeaponsRule = true
		returnFlag = true
		pwDebug(self, 2, "PW: Player is holding unallowed weapons")
	endIf

	return returnFlag
endFunction


function addZaZ(string whichFurn)
	if(ZaZFurniture != none)
		ZaZFurniture.delete()
		ZaZFurniture = none
	endIf
	
	Furniture furnForm = Mods.getZaZFurniture(whichFurn)
	ZaZFurniture = LightTortureZaZMarker.GetReference().PlaceAtMe(furnForm)

	return
endFunction

event RemoveItems(Form destination)

	if(!(destination as ObjectReference))
		pwDebug(self, 4, "RemoveItems(): could not cast argument as ObjectReference, aborting")
		return
	endIf
	
	ObjectReference destObjRef =  destination as ObjectReference
	
	;Player.RemoveAllItems(destObjRef, true)
	int index = Player.GetNumItems()
	while index > 0
		index -= 1
		form currItem = Player.GetNthForm(index)
		if !(currItem.HasKeywordString("zad_InventoryDevice") \
				|| currItem.HasKeywordString("zad_Lockable") \
				|| currItem.HasKeywordString("zbfWornDevice") \
				|| currItem.HasKeywordString("SexLabNoStrip"))
			
			Player.removeItem(currItem, Player.GetItemCount(currItem), true, destObjRef)
		endIf
	endWhile

endEvent

function restoreItems()
	if(!enforcedMode || enforcedModeInventoryTaken)
		PW_ItemHolder.RemoveAllItems(Player, true, true)
	endIf
	return
endFunction

function startScene(int sceneNumber, bool removeItems = true, bool moveReturnMarker = false)
	SendModEvent("dhlp-Suspend")
	
	if(quotaMgr.HasUnreportedProgress(lastLocIndex))
		quotaMgr.ForceReport(lastLocIndex)	;calls updateLocInfo() inside
	endIf
	
	if(main.isPlayerYoked)
		Mods.unequipYoke()
	endIf

	if(moveReturnMarker)
		ReturnMarker.GetReference().MoveTo(Player)
	endIf

	if(removeItems)
		RemoveItems(PW_ItemHolder)
	endIf

	if(playerGenderPref.GetValue() as int == 1)
		setTorturerFemale()
	else
		setTorturerMale()
	endIf
	
	sceneNumber = sceneVariantCheck(sceneNumber)
	activeScene = sceneNumber
	sceneStage = 0

	PunishmentScenes[sceneNumber].ForceStart()

	pwDgConAnotherAfter = (getNextPunishment() != 0)
	
endFunction

int function sceneVariantCheck(int sceneNumber)
{Returns any variant of a scene (1st time running, etc) that should be played instead of the default scene for the index passed. 
Otherwise returns the index unchanged.}

	if(sceneNumber == 1 && !completedServiceExtensionIntro)
		return 9
	endIf
	
	return sceneNumber
endFunction

function endScene(bool restoreItems = true, bool restoreLocation = true)

	PunishmentScenes[activeScene].stop()
	
	if(restoreItems && !enforcedMode)
		restoreItems()
	endIf

	if(restoreLocation)
		Player.MoveTo(ReturnMarker.GetReference())
	endIf
	
	if(tracker.GetStatus(lastLocIndex) != 2)
		Tracker.MakePublicWhoreSelfContained(lastLocIndex, false)
	endIf
	
	if(punishmentScores[lastLocIndex] >= enfModeThreshold && !enforcedMode)
		setEnforcedMode()
	endIf
	
	if(!main.isPlayerYoked && enforcedMode)
		Mods.equipYoke()
	endIf

	activeScene = 0
	sceneStage = 0

	SendModEvent("UpdateLocInfo")
	
	ImageSpaceModifier.RemoveCrossfade(2.0)
	SendModEvent("dhlp-Resume")
	
endFunction

function setEnforcedMode(int locIndex = -2)
	if(locIndex == -2 || locIndex == -1)
		locIndex = lastLocIndex
	elseIf(locIndex < 0 || locIndex > 8)
		return
	endIf

	enforcedMode = true

	FadeToBlack.Apply()
	if(enforcedModeInventoryTaken)
		Utility.Wait(1.0)
		Debug.MessageBox("The guards roughly strip you naked and confiscate all of your items.")
		RemoveItems(PW_ItemHolder)
	endIf
	Utility.Wait(1.0)
	Debug.MessageBox("You are held down while a mage approaches and casts an incantation upon you. You feel a very faint pressure around your neck, as though the spell were ready to choke you at a moment's notice.")
	Game.GetPlayer().AddSpell(CantLeaveSpell)
	Utility.Wait(1.0)
	
	if(enforcedModeHeavierRestraints)
		Debug.MessageBox("The guards that are holding you inform you that you are no longer permitted to leave the city. They lock you into more restraints and set you back to work.")
		Mods.equipAnkleShackles()
		Mods.equipYoke()
		Utility.Wait(1.0)
	endIf
	
	FadeToBlack.Remove()
	
	Utility.Wait(1.0)
	
	return
endFunction

event ClearEnforcedMode(int locIndex)
	if(locIndex == -2 || locIndex == -1)
		locIndex = lastLocIndex
	elseIf(locIndex < 0 || locIndex > 8)
		return
	endIf

	Game.GetPlayer().RemoveSpell(CantLeaveSpell)

	enforcedMode = false

	PW_ItemHolder.RemoveAllItems(Player, true, true)
	
	return
endEvent

function sendToNextScene(bool restoreItems = true, bool restoreLocation = true)
	if(getNextPunishment() == 0)
		endScene(restoreItems, restoreLocation)
	else
		startScene(pullNextPunishment(), true, false)
	endIf
	return
endFunction

	
ObjectReference function findFirstZbfFurniture(cell whicheverCell)
	int index = 0
	ObjectReference currentFurniture
	while index <= whicheverCell.GetNumRefs(40)
		currentFurniture = whicheverCell.GetNthRef(index, 40)
		if(currentFurniture.GetBaseObject().HasKeywordString("zbfFurniture"))
			return currentFurniture
		endIf
		index += 1
	endWhile
	
	return none

endFunction

function setTorturerMale(bool setMale = true)
	if(setMale)
		torturerM.enable()
		torturerF.disable()
		currentTorturer = TorturerM
	else
		torturerF.enable()
		torturerM.disable()
		currentTorturer = TorturerF
	endIf

	TorturerRef.Clear()
	TorturerRef.ForceRefTo(currentTorturer)

	return
endFunction


function setTorturerFemale(bool setFemale = true)
	setTorturerMale(!setFemale)
	return
endFunction


function pwPunishStartSex(Actor otherActor, bool isRape = false, bool advancingScene = false)
	sceneCompleted = false
	currentSexAdvancingScene = advancingScene
	
	sslThreadModel Thread = Sexlab.NewThread()
	Thread.AddActor(Player, isRape)
	Thread.AddActor(otherActor)
	Thread.SetHook("pwPunishSex")
	Thread.StartThread()
	
	if(advancingScene)
		RegisterForSingleUpdate(90.0)	;Register for an update 30 seconds from now, where we check to ensure that the scene has started
	endIf
	
	return
endFunction

function addVanillaBounty(int bounty)
	Debug.Notification(bounty + " bounty added here")

	CrimeFactions[lastLocIndex].ModCrimeGold(bounty)
	
	return
endFunction

event pwOnPunishSexStart(int tid, bool HasPlayer)
	sexSceneStarted = true
	sceneCompleted = false
endEvent

event pwOnPunishSexEnd(int tid, bool HasPlayer)
	if(currentSexAdvancingScene)
		sceneStage += 1
	endIf
	
	sexSceneStarted = false
	
	if(chainRapeActive)
		ChainRapist.Clear() 
		sceneCompleted = true
	endIf
endEvent

bool sceneCompleted = false
bool property chainRapeCompleted = false auto conditional
bool property chainRapeActive = false auto conditional

function pwPunishChainRape(int numOfTimes, ReferenceAlias chainRapistAlias = none)
{
Oh boy. My latest masterpiece, get ready -
In short: pass a number to this function, and it will randomly select rule-valid citizens to rape
	the player until that many people have raped her, usually a few less
In long: This function contains 3 loops, each nested inside the last.
	Outer Loop: keeps track of number of times thee player was raped and refreshes a 5-array of nearby actors
	Middle Loop: runs through that 5-array, forces each actor to our ChainRapist alias (travel to, start sex on end)
	Inner Loop: waits for 2 seconds at a time, checking if sex is completed, or we timed out, each time
}

	chainRapeCompleted = false
	
	if (chainRapistAlias == none)
		chainRapistAlias = ChainRapist
	endIf

	chainRapeActive = true
	int index = 0
	int ticksWaited = 0
	
	while index < numOfTimes
		int index2 = 0
		actor[] nearbyActors = actorMgr.getValidActorArray5()
		while (nearbyActors[index2] != none) && (index2 < 5) && index < numOfTimes
			sceneCompleted = false
			pwDebug(self, 1, "Actor: " + nearbyActors[index2].GetLeveledActorBase().GetName())
			chainRapistAlias.clear()
			chainRapistAlias.ForceRefTo(nearbyActors[index2])
			nearbyActors[index2].EvaluatePackage()
			ticksWaited = 0
			while (!sceneCompleted && ticksWaited < 15) && index < numOfTimes
				if(!sexSceneStarted)
					ticksWaited += 1
				endIf
				Utility.Wait(2.0)
				pwDebug(self, 1, "Waiting")
			endWhile
			index += 1
			if(index2 < 4)
				index2 += 1
			endIf
			pwDebug(self, 1, "Next")
			chainRapistAlias.Clear()
			nearbyActors[index2].EvaluatePackage()
		endWhile
	endWhile
	
	pwDebug(self, 1, "Chain rape completed, " + index + " people fucked you.")
	chainRapeActive = false
	chainRapeCompleted = true
			
	return
endFunction

event OnUpdate()
;We only really use OnUpdate here as a time-delayed check to see if Sexlab activated properly

	if(!sexSceneStarted)
		pwDebug(self, 2, "PW: a sex scene took too long, advancing scene now")
		sceneStage += 1
		;sceneCompleted = true
	endIf
	
endEvent

int function pullNextPunishment(int locIndex = -1)
{Takes a locIndex as an argument, returns the next punishment due there and clears its flag}
	if(locIndex == -1)
		locIndex = lastLocIndex
	else
		return 0
	endIf

	int index = 1
	while index <= punishmentTypes
		if(getFlag(locIndex, index))
			setFlag(locIndex, index, false)
			return index
		endIf
		index += 1
	endWhile
	
	return 0
endFunction

int function getNextPunishment(int locIndex = -1)
{Gets next punishment index without clearing the flag}
	if(locIndex == -1)
		locIndex = lastLocIndex
	else
		return 0
	endIf

	int index = 1
	while index <= punishmentTypes
		if(getFlag(locIndex, index))
			return index
		endIf
		index += 1
	endWhile
	
	return 0
endFunction

function extraditePlayer()
{sends the player to the city where their alert level is highest. Uses PublicRapeMarkers}
	FadeToBlack.Apply()
	
	int index = 0
	int highestIndex = 0
	while index <= 8
		if(alertLevel[index] >= alertLevel[highestIndex])
			highestIndex = index
		endIf
		index += 1
	endWhile

	alertLevel[highestIndex] = 0

	Utility.Wait(mbsPeriod)
	Debug.MessageBox("Your hands are bound and you are escorted to a carriage.")
	Player.MoveTo(PublicRapePlayerXMarkers[highestIndex])
	Utility.Wait(mbsPeriod)
	Debug.MessageBox("Sometime later, you arrive in " + PW_Constants.GetCityName(highestIndex) + ".")
	PW_Utility.SendEvent("PW_UpdateLocInfo")
	Utility.Wait(mbsPeriod)
	
	startScene(pullNextPunishment(), true, true)
	
	FadeToBlack.Remove()
	return
endFunction



;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||Debuffs||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
function incrementDebuff()
	if(debuffsEnabled && debuffLevel < 6)
		debuffLevel += 1
	endIf
	daysOnCurrentDebuffLevel = 0
	return
endFunction

function decrementDebuff()
	if(debuffLevel > 0)
		debuffLevel -= 1
	endIf
	daysOnCurrentDebuffLevel = 0
	return
endFunction

;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||Message Box Stories||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
function messageBoxStory(bool fade = true)

	if(fade)
		FadeToBlack.ApplyCrossFade()
	endIf

	bool playerF = !(Player.GetLeveledActorBase().GetSex() == 0)


	
	if(activeScene == 1)		;Service extension regular
		Utility.Wait(1.0)	
		Debug.MessageBox("The guard blindfolds you, then pushes and drags you through the streets to some unknown destination. You're told that you've been given an additional quota on top of your current one.")
		Utility.Wait(1.0)

	elseIf(activeScene == 2)		;Public Rape
		if(sceneStage == 0)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The guards lock you in a cell for hours. You get the sense that they're preparing something.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("When the cell door finally opens, a guard pulls you out, and hands you off to " + LocalPWThane.GetActorRef().GetLeveledActorBase().GetName() + ", who forcibly grabs you by the back of your collar and drags you, leaving you stumbling and gasping for air, out into full view of the public. Several people are already staring at you, and you hear catcalls, as though you had any choice in being displayed like this.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Eventually the Thane pulls you to your feet and shoves you forward. Completely naked and being watched by everyone, you feel paralyzed. There's no escape from whatever is about to happen - you are at the mercy of the crowd now")
			Utility.Wait(mbsPeriod)
		else
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("More and more people close in around you, and soon all you can see is a wall of people waiting to take their turn with you. " + LocalPWThane.GetActorRef().GetLeveledActorBase().GetName() + " half-heartedly tries to pace them, but more often than not you find your body being pulled and groped from all angles.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Again and again, you're thoroughly overpowered and raped, to the cheers of the masses. Your already-feeble attempts to resist only become weaker as you tire, but seeing the sheer amount of people watching your humiliation entirely defeats you. Citizens, shopkeepers, guards - even some people that you thought respected you - all of them gathered to fuck you, as though you were suddenly nothing more than a toy for all to use.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("True to " + LocalPWThane.GetActorRef().GetLeveledActorBase().GetName() + "'s word, they keep you there all day, as new people continue to show up to defile you. Hours later, pounded into submission and unable to move, your exhausted body now limply bouncing with each thrust from your rapist, you're finally carelessly thrown to the ground, as the last citizen leaves. " + LocalPWThane.GetActorRef().GetLeveledActorBase().GetName() + " begins to walk away, and you lose consciousness.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("When you come to, the sun is rising. You realize you must have been left on the ground all night. " + LocalPWThane.GetActorRef().GetLeveledActorBase().GetName() + " is approaching once more, pulling you up to your feet.")
			Utility.Wait(mbsPeriod)
		endIf

	elseIf(activeScene == 3)	;Light Torture		
		if(sceneStage == 0 && pwDgConStayingInCell)
			Utility.Wait(mbsPeriod)
			pwUtil.advanceHours(6)
			Debug.MessageBox("You awaken locked into a sturdy X-cross, in which you're kept for hours, before the door finally opens and the torturer re-enters")
			Utility.Wait(mbsPeriod)
			pwDgConStayingInCell = false

		elseIf(sceneStage == 0)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("You're blindfolded and escorted through the city, eventually losing track of where they're taking you. When the blindfold is finally torn off you find yourself in a dimly lit cell.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The guards slam the door behind you, and you're left alone with nothing but a bed and a bench. For hours, there's not a sound except for the crackle of the torches in your cell. You begin to lose track of just how much time is passing, but it feels like an eternity.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Suddenly you wake up, and find yourself cuffed to a large X-cross, completely naked. You have no idea when you fell asleep, or how you ended up in this position, but your wondering is cut short. Standing in front of the door is an imposing figure in leather armor, staring you down.")
			Utility.Wait(mbsPeriod)
		elseIf(sceneStage == 1)
			Utility.Wait(mbsPeriod)
			if(!playerF)
				Debug.MessageBox("The torturer continues whipping for some time. Your resolve holds for several strikes, but you soon find yourself letting out a small scream under the sheer force of each lash. You try to evade the whipping but the X-cross keeps you completely open and helpless... You're no adventurer right now - right now you're just a pathetic man at the mercy of this torturer.")
			else
				Debug.MessageBox("The torturer continues whipping for some time. Your resolve holds for several strikes, but you soon find yourself letting out a small scream under the sheer force of each lash. You try to evade the whipping but the X-cross keeps you completely open and helpless... You're no adventurer right now - right now you're just a naked girl at the mercy of this torturer.")
			endIf

			if(currentTorturer == TorturerM)
				Utility.Wait(mbsPeriod)
				Debug.MessageBox("You've lost track of just how many times you've been struck, or how many times you've screamed. Nothing you say elicits a response from your captor - he continues with professional focus. After what must have been several minutes he finally pauses and sheathes the crop. For about a minute he stares at you, his eyes invading every part of your body, inspecting his work.")
				Utility.Wait(mbsPeriod)
				Debug.MessageBox("Once he's satisfied, he unlocks the cuffs keeping you in place, and you fall weakly to the ground.")
			else
				Utility.Wait(mbsPeriod)
				Debug.MessageBox("You've lost of track of just how many times you've been struck, or how many times you've screamed. Nothing you say elicits a response from your captor - she continues with professional focus. After what must have been several minutes she finally pauses and sheathes the crop. For about a minute she stares at you, her eyes invading every part of your body, inspecting her work.")
				Utility.Wait(mbsPeriod)
				Debug.MessageBox("Once she's satisfied, she unlocks the cuffs keeping you in place, and you fall weakly to the ground.")
			endIf
		elseIf(sceneStage == 4)
			if(currentTorturer == TorturerM)
				Utility.Wait(1.0)
				Debug.MessageBox("The torturer makes you service him again and again. The whipping left you exhausted and hurt, and you can't help but trembling, which only frustrates your tormentor, who brutally strikes you whenever you lose your form. No matter how hard you try, you can't seem to do good enough to meet his requirements.")
				Utility.Wait(1.0)
				Debug.MessageBox("As much as you hate to admit it, the only escape from the pain seems to be the pleasure you receive from sex, which the torturer seems to know how to increase whenever you submit to his movements. Ultimately it doesn't prevent your injuries from eventually overwhelming you, and you collapse to the floor, drenched in sweat, tears, and cum.")
				Utility.Wait(1.0)
			else
				Utility.Wait(1.0)
				Debug.MessageBox("The torturer makes you service her again and again. The whipping left you exhausted and hurt, and you can't help but trembling, which only frustrates your tormentor, who brutally strikes you whenever you lose your form. No matter how hard you try, you can't seem to do good enough to meet her requirements.")
				Utility.Wait(1.0)
				Debug.MessageBox("As much as you hate to admit it, the only escape from the pain seems to be the pleasure you receive from sex, which the torturer seems to know how to increase whenever you submit to her movements. Ultimately it doesn't prevent your injuries from eventually overwhelming you, and you collapse to the floor, drenched in sweat, tears, and cum.")
				Utility.Wait(1.0)
			endIf
		endIf
		
	elseIf(activeScene == 4)	;Heavy torture
		if(sceneStage == 0 && pwDgConLightIntoHeavy)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The torturer exits, leaving you battered and exhausted on the cold stone floor.")
			Utility.Wait(mbsPeriod * 3)
			Debug.MessageBox("Some time passes before the door opens again, before a guard opens it to toss you a charred piece of meat and a jug of water, before leaving again.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("When the door opens again, the torturer wrenches you up by the arm and holds you to the side of the room as guards wheel a large torture rack into the room, which the torturer pushes you onto.")
			Utility.Wait(mbsPeriod)
			pwDgConLightIntoHeavy = false
			
		elseIf(sceneStage == 0 && pwDgConStayingInCell)
			Utility.Wait(mbsPeriod)
			pwUtil.advanceHours(6)
			Debug.MessageBox("You awaken lying in a torture rack. You feel helpless, realizing that there isn't a thing you can do to free or defend yourself in this position.")
			Utility.Wait(mbsPeriod)
			pwDgConStayingInCell = false

		elseIf(sceneStage == 0)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("This time you are practically dragged along by the guards, who seem to be showing less care than they had before. Everyone seems to be getting fed up with you, all because you've acted like a human and not a mere sex object.")
			Utility.Wait(mbsPeriod)
			if(playerF)
				Debug.MessageBox("Citizens cheer on the guards with calls of 'Put that bitch in her place!' and other such sentiments - the entire hold views you as a sex slave in denial.")
			else	
				Debug.MessageBox("Citizens cheer on the guards with calls of 'Put that bitch in his place!' and other such sentiments - the entire hold views you as a sex slave in denial.")
			endIf
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The blindfold is eventually ungracefully torn from your face, and you're shoved into a familiar stone cell, falling face-first onto the ground. Before you can get up, a guard picks you up and throws you over one shoulder, carrying you further into the room before slamming you down onto a large torture rack, and locking your wrists and ankles into it.")
		elseIf(sceneStage == 1)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("You hear yourself begging between screams, but it seems distant - pain has taken complete control and you couldn't stop now if you tried.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Your pleading is only amusing to the torturer, though, who continues turning the wheel. The room, blurry through your tears, suddenly fades away as you black out, giving you a brief respite from your agony.")
			Utility.Wait(mbsPeriod * 4)
			Debug.MessageBox("You don't remember where you are, or how long has passed, when you begin returning to consciousness. As your memory returns, you brace for the pain in your joints, but it does not come. The faint taste of a healing potion lingers on your tongue.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The restraints on the rack suddenly open and you are sent tumbling to the ground. Though you think you could still move, you lack the willpower to, realizing that the torturer is standing above you, and is fully capable of hurting you worse if you show any defiance.")
			Utility.Wait(mbsPeriod)
		elseIf(sceneStage == 5)	;Player left in darkness
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The torturer extinguishes the torches, and exits, leaving you in darkness.") 
			Utility.Wait(mbsPeriod * 4)
			Debug.MessageBox("You try to masturbate but you can't seem to make yourself cum, and only drive yourself crazier in the process. Had the spell done this too?")
			Utility.Wait(mbsPeriod)
			if(currentTorturer == torturerM)
				Debug.MessageBox("You had promised yourself that you wouldn't give in, but deep down you know that you would break that promise in an instant if the torturer would just return and have his way with you.")
			else
				Debug.MessageBox("You had promised yourself that you wouldn't give in, but deep down you know that you would break that promise in an instant if the torturer would just return and have her way with you.")
			endIf
			Utility.Wait(mbsPeriod)
			if(playerF)
				Debug.MessageBox("You wait and wait, but there's complete silence. Each second seems to last an eternity, and drives you more insane with desire, and yet nobody returns for what must be hours. All the while your breasts and pussy reverberate with the same buzzing feeling, depriving you of any intelligent thought and leaving only twisted fantasies as you grope yourself and pray for any one of them to come true.")
			else
				Debug.MessageBox("You wait and wait, but there's complete silence. Each second seems to last an eternity, and drives you more insane with desire, and yet nobody returns for what must be hours. All the while your dick reverberate with the same buzzing feeling, depriving you of any intelligent thought and leaving only twisted fantasies as you touch yourself and pray for any one of them to come true.")
			endIf
			;Utility.Wait(mbsPeriod * 20)
			Debug.MessageBox("You think that at least a day must have passed, and the door still remains agonizingly still. You're starving and dehydrated but don't really notice it too much, as the feverish sexual fantasies in your head become more and more depraved - at this point you would do anything whatsoever, proudly, just to cum. You find yourself dreaming of being raped and brutalized, and being completely objectified. If you were let out onto the streets now you would happily let yourself be ravaged for days on end if it just meant you could finish.")
			;Utility.Wait(mbsPeriod * 10)
		elseIf(sceneStage == 6)
			Utility.Wait(mbsPeriod)
			if(currentTorturer == torturerM)
				Debug.MessageBox("When the door finally opens, you find yourself begging the torturer to fuck you raw. He grabs you and pushes you into the corner, idly groping at your ass and causing you to moan softly, as two guards carry the rack out of the room and replace it with a pillory.")
				Utility.Wait(mbsPeriod)

				Debug.MessageBox("You put up no resistance as he man-handles you into the pillory, securing you in place and then slapping your ass hard enough to bruise it - after all, you had fantasized about being overpowered and abused for days now, and now your merciful captor was indulging this fantasy.")
				Utility.Wait(mbsPeriod)
			else
				Debug.MessageBox("When the door finally opens, you find yourself begging the torturer to fuck you raw. She grabs you and pushes you into the corner, idly groping at your ass and causing you to shudder in her arms, as two guards carry the rack out of the room and replace it with a pillory.")
				Utility.Wait(mbsPeriod)
				Debug.MessageBox("You put up no resistance as she roughly jams you into the pillory, securing you in place and then slapping your ass hard enough to bruise it - after all, you had fantasized about being overpowered and abused for days now, and now your merciful captor was indulging this fantasy.")
				Utility.Wait(mbsPeriod)
			endIf
		elseIf(sceneStage == 8)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The door opens, and you hear an animalistic grunting from the hallway, as a male troll enters the room. Upon seeing you, it briskly walks up to you, backing you into a corner as you hear the door close and lock behind it. As it stairs at your exposed breasts, a trail of drool trickles down onto them, and runs down along your belly.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("You're helpless to resist as it grabs your thigh with one massive hand and begins dragging you by the leg into the center of the room - with weapons you could fight this thing, but naked and defenseless you are utterly incapable of matching its brute strength. It throws your leg to the side but before you have a chance to even move it's on you again, having its way with you.")
			Utility.Wait(mbsPeriod)
			
		elseIf(sceneStage == 14)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Over and over again, Crusher rapes you and pumps you full of troll cum - it seems like there's no limit to how many loads he can shoot into you, and you feel like your womb may burst if he continues.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Bruised and broken by the troll's massive shaft and rippling muscles, and now passively watching your tits flying back and forth to his thrusts, you're briefly turned on by the primal dominance the creature is asserting over you.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The feeling is only fleeting, as you remember that this animal is capable of killing you, and probably will if the guards let it. You assert that the feeling was only a lasting effect of the spell. It had to be, right?")
			Utility.Wait(mbsPeriod)
		endIf

	elseIf(activeScene == 6)	;Generic Torture
		if(sceneStage == 0)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("The guards surround you and harshly push you to the ground, restraining your wrists behind your back. You are soon being dragged through the street against your will. They blindfold you, and you lose track of where they take you.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Eventually you hear a heavy door close behind you, and the guards strip you down, forcing you into a standing spread-eagle position and locking each limb into a cold metal cuff, leaving you  completely exposed and open. The blindfold is torn off as a new figure enters the room.")
			Utility.Wait(mbsPeriod)

		elseIf(sceneStage == 1)
			if(getNextPunishment() == 3 || getNextPunishment() == 4)	;We're staying in this room
				pwDgConStayingInCell = true
				Utility.Wait(mbsPeriod)
				Debug.MessageBox("Amidst the barrages of the crop, the torturer slips in a calculated palm to the side of your head, with enough force that you are knocked unconscious.")
				Utility.Wait(mbsPeriod)
			else
				Utility.Wait(mbsPeriod)
				Debug.MessageBox("After what feels like hours, the torturer puts another blindfold on you, and has the guards escort out of the cell.")
				Utility.Wait(mbsPeriod)
			endIf
		endIf
			

	elseIf(activeScene == 9)	;Service extension, first time around
		if(sceneStage == 0)
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Your items are confiscated, and you are lead through the city.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("You suspect the guard is intentionally taking a longer route, and become embarassed as you realize that a few men walking behind you are taking full advantage of that fact.")
			Utility.Wait(mbsPeriod)
			Debug.MessageBox("Eventually you reach " + LocalPWThane.GetActorRef().GetLeveledActorBase().GetName() + ", who is visibly irritated.")
		endIf
	endIf

	if(fade)
		FadeToBlack.Remove()
	endIf

	return
endFunction

ObjectReference Property execGallowsRef  Auto  
WEAPON Property torturerCrop  Auto  
