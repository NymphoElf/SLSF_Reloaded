Scriptname PW_FameScript  extends PW_ScriptComponent conditional

import PW_Utility

PW_ModIntegrationsScript property mods Auto
PW_ActorManagerScript property actorMgr Auto
PW_Constants property constants Auto

SexlabFramework property Sexlab Auto

FavorJarlsMakeFriendsScript property fjmfs  Auto

int property playerCurrentStatus = 0 Auto

;Hero Fame
bool property usingHeroFame = true Auto Conditional
int[] property heroFame Auto
int property currentHeroFame Auto Conditional
int property HFthreshold = 700 Auto Conditional
int property questsCompleted Auto Conditional
int property HFpointsPerTitle = 50 Auto
int property HFdragonKillScore = 5 Auto
int property HFquestScore = 5 Auto
int property HFdragonbornScore = 100 Auto
bool property isPlayerDragonborn Auto Conditional
bool property isPlayerDragonbornUsurped Auto Conditional
bool[] property isPlayerThane Auto
bool property isPlayerThaneHere Auto Conditional
bool property isAlduinDead Auto Conditional

bool property isPlayerCollegeMember Auto Conditional
bool property isPlayerArchmage Auto Conditional

bool property isPlayerCompanion Auto Conditional
bool property isPlayerHarbinger Auto Conditional

bool property isPlayerDarkBrotherhoodMember Auto Conditional
bool property isPlayerListener Auto Conditional
bool property isEmperorDead Auto Conditional

bool property isPlayerThievesGuildMember Auto Conditional
bool property isPlayerThievesGuildLeader Auto Conditional
bool property isPlayerNightingale Auto Conditional

bool property isPlayerStormcloak Auto Conditional
bool property isPlayerImperial Auto Conditional
bool property isCivilWarWon Auto Conditional


Quest property MQ105 Auto ;announced Dragonborn by Greybeards
Quest property MQ305 Auto ;killing Alduin

Quest property MG01 Auto ;joining the college
Quest property MG08 Auto ;confrontation with Ancano/becoming Archmage

Quest property C01 Auto ;joining the Companions
Quest property C06 Auto ;becoming Harbinger

Quest property DB01 Auto ;joining the Dark Brotherhood
Quest property DB04 Auto ;becoming the Listener
Quest property DB11 Auto ;assassinating the Emperor

Quest property TG02 Auto ;joining Thieves Guild
Quest property TG08A Auto ;becoming Nightingale
Quest property TGLeadership Auto ;becoming Thieves Guild Leader

Quest property CW01A Auto ;joining the Imperials
Quest property CW01B Auto ;joining the Stormcloaks



int property dragonsSlain Auto Conditional
ActorBase property dragonAB Auto

;Eligibility
int property eligibilityTimeoutPeriod = 7 Auto
int[] property eligibilityTimeoutDays Auto
int property SLSFThreshold = 200 Auto	;SLSF fame eligibility threshold
int property sexFameThreshold = 350 Auto	;Built in fame eligibility threshold
bool property eligibilitySlaveryLockout = true Auto Conditional


;These are the pillars of sexual fame in PW:  
int[] property bestialityFame Auto     ;intercourse with animals, having recently taken damage from animals
int[] property exhibitionistFame Auto   ;being naked, being stripped
int[] property slutFame Auto            ;having sex in public, having visible slavetats, performing degrading acts
int[] property submissiveFame Auto      ;submitting, wilfully or not, and being seen as a slave or with restraints on
int[] property whoreFame Auto           ;gained from selling body, or engaging other whores

;SLSF values (added to respective builtin fame values in calculation)
bool property includeSLSFValues Auto ; do we use SLSF values in calculations
int[] property slsfBestialityFame Auto
int[] property slsfExhibitionistFame Auto
int[] property slsfSlutFame Auto
int[] property slsfSubmissiveFame Auto
int[] property slsfWhoreFame Auto

string[] property increaseMessages Auto
string[] property decreaseMessages Auto

;HOW THE FAME SYSTEM WORKS:
;
; The player's actions will increase this fame, and PW will attempt to force
; her into situations that cause this to happen.
;
; All fame types will go into calculating eligibility.

;TODO
; -Have slut and whore fame affect off-duty approach chance
; -Bestiality fame on damage from animals
; -Exhibitionism fame - periodically?

float property promiscuityMultiplier = 1.2 auto	;While the player is being seen having sex daily, this multiplier is applied to simulate rumors
int property modestyPeriod = 1 auto	;After this many days without being seen having sex, the abstinence multiplier will be applied instead
float property modestyMultiplier = 0.7 auto	;Once she's no longer being spotted getting fucked, this multiplier will be applied per day
float[] property lastFameGainGameTime auto

bool property fameStartEnabled = true Auto

int currentLocIndex
int lastLocIndex

Actor player

function Initialize()

	player = Game.GetPlayer()
	
	bestialityFame = new int[9]
	exhibitionistFame = new int[9]
	slutFame = new int[9]
	submissiveFame = new int[9]
	whoreFame = new int[9]
	
	includeSLSFValues = mods.usingSLSF
	slsfBestialityFame = new int[9]
	slsfExhibitionistFame = new int[9]
	slsfSlutFame = new int[9]
	slsfSubmissiveFame = new int[9]
	slsfWhoreFame = new int[9]
	
	lastFameGainGameTime = new float[9]
	
	increaseMessages = new string[5]
	increaseMessages[0] = "You have gained some reputation for sleeping with animals"
	increaseMessages[1] = "You have gained some reputation for exposing your body"
	increaseMessages[2] = "You have gained some reputation for slutty behavior"
	increaseMessages[3] = "You have gained some reputation for being submissive"
	increaseMessages[4] = "You have gained some reputation for selling your body"
	
	decreaseMessages = new string[5]
	decreaseMessages[0] = "Your reputation for sleeping with animals has decreased"
	decreaseMessages[1] = "Your reputation as an exhibitionist has decreased"
	decreaseMessages[2] = "Your reputaiton for being a slut has decreased"
	decreaseMessages[3] = "Your reputation for submission has decreased"
	decreaseMessages[4] = "Your reputation as a whore has decreased"

	heroFame = new int[9]

	eligibilityTimeoutDays = new int[9]
	
	isPlayerThane = new bool[9]
	
	pwDebug(self, 2, "Fame Initialized")
endFunction

function Startup()
	RegisterForModEvent("HookAnimationStart", "OnSexStart")
	RegisterForModEvent("PW_EnterCity", "EnterCity")
	RegisterForModEvent("PW_LeaveCity", "LeaveCity")
	RegisterForModEvent("PW_PlayerEquipmentChanged", "OnEquipmentChanged")
	RegisterForModEvent("PW_DailyUpdate", "OnDailyUpdate")
	RegisterForModEvent("PW_CheckTimeComponents", "CheckTimeComponents")
	RegisterForModEvent("PW_CurrentStatusChange", "OnPWStatusChanged")
	RegisterForModEvent("PW_StatusCleared", "OnStatusCleared")
	
	RegisterForModEvent("PW_ModFame", "ModFame")
	RegisterForModEvent("PW_ModFameLocal", "ModFameLocal")
	UpdateFeats()
	
endFunction

event EnterCity(int newLocIndex)
	if(newLocIndex < 0 || newLocIndex > 8)
		pwDebug(self, constants.LOG_ERROR, "received an invalid location index: " + newLocIndex)
		return
	endIf
	
	currentLocIndex = newLocIndex
	lastLocIndex = newLocIndex
	
	isPlayerThaneHere = isPlayerThane[newLocIndex]
endEvent

event LeaveCity(int locIndex)
	currentLocIndex = -1
endEvent

event OnEquipmentChanged()
	Armor bodySlotItem = player.GetWornForm(0x00000004) as Armor
	if bodySlotItem == none
		;TODO player is naked, periodically check if people watching
	endIf
endEvent

event OnDailyUpdate()
	UpdateFeats()
	
	int i = 0
	while i <= 8
		;Tick down eligibility cooldowns
		if eligibilityTimeoutDays[i] > 0
			eligibilityTimeoutDays[i] = eligibilityTimeoutDays[i] - 1
		endIf
		
		;Check modesty
		if (Utility.GetCurrentGameTime() - lastFameGainGameTime[i]) >= modestyPeriod
			if (bestialityFame[i] > 0)
				bestialityFame[i] = (bestialityFame[i] * modestyMultiplier) as int
			endIf
			if (exhibitionistFame[i] > 0)
				exhibitionistFame[i] = (exhibitionistFame[i] * modestyMultiplier) as int
			endIf
			if (slutFame[i] > 0)
				slutFame[i] = (slutFame[i] * modestyMultiplier) as int
			endIf
			if (submissiveFame[i] > 0)
				submissiveFame[i] = (submissiveFame[i] * modestyMultiplier) as int
			endIf
			if (whoreFame[i] > 0)
				whoreFame[i] = (whoreFame[i] * modestyMultiplier) as int
			endIf
		else ;rumors will spread
			if (bestialityFame[i] > 0)
				bestialityFame[i] = (bestialityFame[i] * promiscuityMultiplier) as int
			endIf
			if (exhibitionistFame[i] > 0)
				exhibitionistFame[i] = (exhibitionistFame[i] * promiscuityMultiplier) as int
			endIf
			if (slutFame[i] > 0)
				slutFame[i] = (slutFame[i] * promiscuityMultiplier) as int
			endIf
			if (submissiveFame[i] > 0)
				submissiveFame[i] = (submissiveFame[i] * promiscuityMultiplier) as int
			endIf
			if (whoreFame[i] > 0)
				whoreFame[i] = (whoreFame[i] * promiscuityMultiplier) as int
			endIf
		endIf
		
		i += 1
	endWhile
	
endEvent

event CheckTimeComponents()
	UpdateFame()
endEvent

event OnPWStatusChanged(int newStatus)
	playerCurrentStatus = newStatus
endEvent

event OnSexStart(int tid, bool HasPlayer)
	pwDebug(self, constants.LOG_TRACE, "OnSexStart ENTER")
	
	if !HasPlayer
		pwDebug(self, constants.LOG_DEBUG, "OnSexStart: animation does not contain player, ignoring")
		return
	endIf
	
	if tid < 0
		;I don't think this will happen but I guess it doesn't hurt anything
		pwDebug(self, constants.LOG_ERROR, "OnSexStart: Sexlab scene failed to start")
		return
	endIf
	
	int numWitnesses = actorMgr.GetNumActorsWithLOSOrNear(player, 1500)	;Player and Partner would be subtracted, but ActorManager doesn't "see" actors in animations
	
	;No witnesses, no fame to gain
	if(numWitnesses <= 0)
		pwDebug(self, constants.LOG_DEBUG, "OnSexStart: no witnesses to sex scene, ignoring")
		return
	endIf
	
	;Not in a city, but TODO keep this in mind. Maybe people will gossip in the future.
	if (currentLocIndex < 0 || currentLocIndex > 8)
		pwDebug(self, constants.LOG_DEBUG, "OnSexStart: not in an area fame can be gained")
		return
	endIf

	
	;If we made it here, fame will be gained. Get thread controller because we need some info.
	sslThreadController threadController = Sexlab.GetController(tid)
	
	;Calculate which fames are increasing.
	;TODO whore fame
	int increase = (1.0 * numWitnesses) as int
	
	if threadController.HasCreature
		SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_BESTIALITY, increase)
		SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_SLUT, increase / 2)
	else
		SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_SLUT, increase)
	endIf
	
endEvent

function UpdateFeats()
	Quest ToHRealAndFalseHeroes = Quest.GetQuest("AAARealandFalseHeroes")

	if(ToHRealAndFalseHeroes != none)
		if(ToHRealAndFalseHeroes.GetStage() >= 10)
			isPlayerDragonbornUsurped = true
			isPlayerDragonborn = false
		endIf
	endIf
	
	if(!isPlayerDragonborn && !isPlayerDragonbornUsurped)
		isPlayerDragonborn = MQ105.IsStageDone(60)
	endIf

	isAlduinDead = MQ305.IsStageDone(190)
	
	isPlayerCollegeMember = MG01.GetStage() >= 40
	isPlayerArchmage = MG08.IsStageDone(200)
	
	isPlayerCompanion = C01.IsCompleted()
	isPlayerHarbinger = C06.IsCompleted()
	
	isPlayerDarkBrotherhoodMember = DB01.IsStageDone(200)
	isPlayerListener = DB04.IsStageDone(40)
	isEmperorDead = DB11.GetStage() >= 50
	
	isPlayerThievesGuildMember = TG02.GetStage() >= 20
	isPlayerNightingale = TG08A.GetStage() >= 60
	isPlayerThievesGuildLeader = TGLeadership.GetStage() >= 40
	
	dragonsSlain = Game.QueryStat("Dragon Souls Collected")
	questsCompleted = Game.QueryStat("Quests Completed")
	
	UpdateThaneStatuses()
	
	currentHeroFame = calculateHeroFame(currentLocIndex)
	
	return
endFunction

function UpdateThaneStatuses()
	isPlayerThane[0] = fjmfs.PaleImpGetOutofJail > 0        ||  fjmfs.PaleSonsGetOutofJail > 0
	isPlayerThane[1] = fjmfs.FalkreathImpGetOutofJail > 0   ||  fjmfs.FalkreathSonsGetOutofJail > 0
	isPlayerThane[2] = fjmfs.ReachImpGetOutofJail > 0       ||  fjmfs.ReachSonsGetOutofJail > 0
	isPlayerThane[3] = fjmfs.HjaalmarchImpGetOutofJail > 0  ||  fjmfs.HjaalmarchSonsGetOutofJail > 0
	isPlayerThane[4] = fjmfs.RiftImpGetOutofJail > 0        ||  fjmfs.RiftSonsGetOutofJail > 0
	isPlayerThane[5] = fjmfs.HaafingarImpGetOutofJail > 0   ||  fjmfs.HaafingarSonsGetOutofJail > 0
	isPlayerThane[6] = fjmfs.WhiterunImpGetOutofJail > 0    ||  fjmfs.WhiterunSonsGetOutofJail > 0
	isPlayerThane[7] = fjmfs.EastmarchImpGetOutofJail > 0   ||  fjmfs.EastmarchSonsGetOutofJail > 0
	isPlayerThane[8] = fjmfs.WinterholdImpGetOutofJail > 0  ||  fjmfs.WinterholdSonsGetOutofJail > 0
	
	;PrintThaneStatuses()
endFunction

function PrintThaneStatuses()
	;To test if thane tracking is working
	int i = 0
	string output = "Thane Statuses:\n\n"
	while i <= 8
		output += PW_Constants.GetCityName(i) + ": "
		
		if(isPlayerThane[i])
			output += "Thane"
		else
			output += "Not Thane"
		endIf
		i += 1
		
		output += "\n"
	endWhile
	
	Debug.MessageBox(output)
endFunction


function UpdateFame()
{Updates our fame values and then performs an eligibility check. This is meant primarily to be called every update in Main}

	if(currentLocIndex < 0 || currentLocIndex > 8)
		return
	endIf
	
	if(usingHeroFame)
		currentHeroFame = calculateHeroFame(currentLocIndex)
	endIf
	
	if(Mods.usingSLSF)
		updateLocSLSF(currentLocIndex)
	else
		slsfBestialityFame = new int[9]
		slsfExhibitionistFame = new int[9]
		slsfSlutFame = new int[9]
		slsfSubmissiveFame = new int[9]
		slsfWhoreFame = new int[9]
	endIf
	
	if(playerCurrentStatus == 0 && eligibilityTimeoutDays[currentLocIndex] == 0 && !(Mods.isPlayerEnslaved() && eligibilitySlaveryLockout))

		;Check for fame starts
		if(usingHeroFame && currentHeroFame >= HFthreshold)	;Heroic fame
			SendIntEvent("PW_MakeEligibleHeroFame", currentLocIndex)
			
		elseIf(fameStartEnabled && IsPlayerSexFameEligible(currentLocIndex))	;Sexual fame
			SendIntEvent("PW_MakeEligible", currentLocIndex)
				
		endIf
	endIf
	

	return
endFunction

int Function CalculateSexFame(int locIndex, int fameType)
	if locIndex < 0 || locIndex > 8
		pwDebug(self, constants.LOG_ERROR, "CalculateSexFame(): not a valid location index")
		return 0
	endIf

	if fameType == constants.FAME_TYPE_BESTIALITY
		return slsfBestialityFame[locIndex] + bestialityFame[locIndex]
		
	elseIf fameType == constants.FAME_TYPE_EXHIBITIONIST
		return slsfExhibitionistFame[locIndex] + exhibitionistFame[locIndex]
		
	elseIf fameType == constants.FAME_TYPE_SLUT
		return slsfSlutFame[locIndex] + slutFame[locIndex]
		
	elseIf fameType == constants.FAME_TYPE_SUBMISSIVE
		return slsfSubmissiveFame[locIndex] + submissiveFame[locIndex]
		
	elseIf fameType == constants.FAME_TYPE_WHORE
		return slsfWhoreFame[locIndex] + whoreFame[locIndex]
	
	else
		pwDebug(self, constants.LOG_ERROR, "CalculateSexFame(): not a valid fame type")
		return 0
	endIf
endFunction

int Function CalculateTotalSexFame(int locIndex)
	if locIndex < 0 || locIndex > 8
		pwDebug(self, constants.LOG_ERROR, "CalculateTotalSexFame(): invalid locIndex, returning 0")
		return 0
	endIf
	
	return slsfBestialityFame[locIndex] + bestialityFame[locIndex] \
	     + slsfExhibitionistFame[locIndex] + exhibitionistFame[locIndex] \
		 + slsfSlutFame[locIndex] + slutFame[locIndex] \
		 + slsfSubmissiveFame[locIndex] + submissiveFame[locIndex] \
		 + slsfWhoreFame[locIndex] + whoreFame[locIndex]
endFunction

Bool Function IsPlayerSexFameEligible(int locIndex)
	if locIndex < 0 || locIndex > 8
		pwDebug(self, constants.LOG_ERROR, "IsPlayerSexFameEligible(): invalid locIndex, returning false")
		return false
	endIf
	
	return CalculateTotalSexFame(locIndex) >= sexFameThreshold
endFunction

int function CalculateHeroFame(int locIndex)
	int total = 0
	if(isPlayerDragonborn)
		total += HFdragonbornScore
	endIf
	
	if(isPlayerThane[locIndex])
		total += HFpointsPerTitle
	endIf
	
	if(isPlayerArchmage)
		total += HFpointsPerTitle
	endIf
	
	if(isPlayerHarbinger)
		total += HFpointsPerTitle
	endIf
	
	if(isPlayerListener)
		total += HFpointsPerTitle
	endIf
	
	if(isPlayerThievesGuildLeader)
		total += HFpointsPerTitle
	endIf
	
	total += (questsCompleted * HFquestScore)
	
	total += (dragonsSlain * HFdragonKillScore)
	
	return total
endFunction


;TODO there are better ways to create an eligibility timeout, but this is clean enough for now
event OnStatusCleared(int locIndex)
	eligibilityTimeoutDays[locIndex] = eligibilityTimeoutPeriod
endEvent

function ClearEligibilityTimeoutLocal()
	ClearEligibilityTimeout(currentLocIndex)
endFunction

function ClearEligibilityTimeout(int locIndex)
	eligibilityTimeoutDays[locIndex] = 0
endFunction

	
function UpdateLocSLSF(int index)
{Pulls SLSF fames from SLSF. SLSF gives values for the player's current location; they can't be pulled from any other location.
We nonetheless have an index arg on this just in case we find a way.}

	if(!Mods.usingSLSF)
		return
	endIf
	
	int[] receivedValues = PW_SLSF.getSLSFFames()
	if(receivedValues[0] >= 0)
		slsfbestialityFame[index] = receivedValues[2]
		slsfExhibitionistFame[index] = receivedValues[4]
		slsfSlutFame[index] = receivedValues[17]
		slsfSubmissiveFame[index] = receivedValues[18]
		slsfWhoreFame[index] = receivedValues[19]
		pwDebug(self, constants.LOG_TRACE, "received " + receivedValues + " from SLSF")
	else
		pwDebug(self, constants.LOG_ERROR, "received invalid data from SLSF")
	endIf

	return
endFunction

event ModFameLocal(int fameType, int amount)
	ModFame(lastLocIndex, fameType, amount)
endEvent

event ModFame(int locIndex, int fameType, int amount)
	if locIndex < 0 || locIndex > 8
		pwDebug(self, constants.LOG_ERROR, "ModFame(): received an invalid location index trying to mod fame type " + fameType + " by " + amount)
		return
	endIf
	
	if fameType < 0 || fameType > 4
		pwDebug(self, constants.LOG_ERROR, "ModFame(): tried to modify an invalid fame type")
		return
	endIf
	
	if amount > 0
		Debug.Notification(increaseMessages[fameType])
	elseIf amount < 0
		Debug.Notification(decreaseMessages[fameType])
	else
		pwDebug(self, constants.LOG_WARNING, "ModFame(): fame modification amount is zero - returning")
		return
	endIf
	
	if fameType == constants.FAME_TYPE_BESTIALITY
		bestialityFame[locIndex] = bestialityFame[locIndex] + amount
		if bestialityFame[locIndex] < 0
			bestialityFame[locIndex] = 0
		endIf
		
	elseIf fameType == constants.FAME_TYPE_EXHIBITIONIST
		exhibitionistFame[locIndex] = exhibitionistFame[locIndex] + amount
		if exhibitionistFame[locIndex] < 0
			exhibitionistFame[locIndex] = 0
		endIf
		
	elseIf fameType == constants.FAME_TYPE_SLUT
		slutFame[locIndex] = slutFame[locIndex] + amount
		if slutFame[locIndex] < 0
			slutFame[locIndex] = 0
		endIf
		
	elseIf fameType == constants.FAME_TYPE_SUBMISSIVE
		submissiveFame[locIndex] = submissiveFame[locIndex] + amount
		if submissiveFame[locIndex] < 0
			submissiveFame[locIndex] = 0
		endIf
		
	elseIf fameType == constants.FAME_TYPE_WHORE
		whoreFame[locIndex] = whoreFame[locIndex] + amount
		if whoreFame[locIndex] < 0
			whoreFame[locIndex] = 0
		endIf
	endIf
endEvent


function TestFameIncreaseDecrease()
	Utility.Wait(1.0)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_BESTIALITY, 1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_EXHIBITIONIST, 1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_SLUT, 1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_SUBMISSIVE, 1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_WHORE, 1)
	
	Debug.MessageBox("Fame has been increased by 50 across the board. Check MCM to verify whether this has worked correctly. It will remain increased for 5 seconds.")
	Utility.Wait(5.0)
	
	
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_BESTIALITY, -1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_EXHIBITIONIST, -1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_SLUT, -1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_SUBMISSIVE, -1)
	SendIntIntEvent("PW_ModFameLocal", constants.FAME_TYPE_WHORE, -1)
	
	Debug.MessageBox("Fame has now been decreased by 50 across the board. Check MCM to verify that fames have their original values. Test function has ended.")
endFunction
