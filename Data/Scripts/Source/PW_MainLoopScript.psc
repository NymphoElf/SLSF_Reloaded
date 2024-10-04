 Scriptname PW_MainLoopScript extends PW_ScriptComponent Conditional
{Manages NPC approaches and sex calls. Start studying here if you wish to comprehend this mod.}

import PW_Utility

;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| DATA |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
;PROPERTIES (SCRIPTS)
SexlabFramework Property Sexlab Auto
PW_ModIntegrationsScript property Mods Auto
PW_TrackerScript property Tracker Auto
PW_WRIQScript property WRIQ Auto
PW_PlayerScript property playerScript Auto
PW_ActorManagerScript property actorMgr Auto
PW_QuotaManagerScript property quotaMgr Auto
PW_SexQueueScript property sexQueue Auto
PW_Constants property pwConst Auto
PW_DialogueConds property dgCond Auto

;PROPERTIES (MISC)
bool property debugDialoguesEnabled = false Auto Conditional
Actor property player Auto
ReferenceAlias property LocalPWThane Auto
ReferenceAlias property playerAlias Auto
ReferenceAlias Property approachAlias Auto	; This alias is used for all approach scenes
MiscObject property Gold Auto
Faction property beggarFaction Auto

Faction property PW_CharmedFaction Auto


;CONTROL (MCM)
Bool property modEnabled = true Auto	;Are we registering for updates?

;CONTROL (INTERNAL)
Float property updatePeriod = 5.0 Auto
Bool property approachesSuspended = false Auto
int property suspendedUpdateCount = 0 Auto

Bool property debugNotificationsEnabled = false Auto	;Turn true to get debug notification spam. TODO instead add priority levels such as 1, 2, 3, 4, minor, major, critical, etc 
	;"State" int that tracks what the mod is currently doing based on its value. This system is the basis of this whole loop... Enum would be ideal. Enum is not an option.
	;This could perhaps (?) be an *actual* state system by switching the actual state of this script, and could possibly be more secure that way. However, I don't
	;think the work involved in transforming it into that would be worth it.
Int LoopState = 0
	;0:		Inactive: 				The player is not, nor has not, been the city whore. Ever. Anywhere
	;1: 	Ready: 					The player can be approached.
	;2:		Being approached:		The player is being approached.
	;3:		Cooldown:				Waiting one scanPeriod before searching for another approacher.
Float stateStartTime		;Keeps track of when the current state started, real time for approach timeout, game time for everything else


;CITY TRACKING
;References to each city location. Array is alphabetized; you can see how it's initialized by viewing script properties.
Location[] property pwCities Auto
;0: Dawnstar, 1: Falkreath, 2: Markarth, 3: Morthal, 4: Riften, 5: Solitude, 6: Whiterun, 7: Windhelm, 8: Winterhold


Bool property isWhoreNow = false Auto Conditional	;A condition mostly used for dialogue, to indicate whether the player is the whore in their current location
int property playerCurrentStatus = 0 Auto Conditional	;Hold the player's numeric status in the current location. Should probably be moved to LocationTracking


;NPC APPROACHES (MCM)
Int property scanPeriod = 60 Auto 	;How many in-game minutes between each scan for approachers
Int property approachChance = 100 Auto	;The chance per approach check that an npc will approach
Int property approachTimeout = 60 Auto		;The time in real seconds the approacher has to approach the player before cancelling the approach
GlobalVariable property genderPrefGlob Auto
Bool property canPlayerSolicit = true Auto Conditional
GlobalVariable Property SolicitFailChance Auto

Faction property recentClientFaction auto
Actor[] property recentClients auto
float property recentClientDelta = 4.0 auto
int property numrecentClients auto

int property offDutyApproachChance = 5 Auto Conditional

Int property difficultClientChance = 5 Auto Conditional
Int property sadisticClientChance = 5 Auto Conditional
Int property notPayingChance = 25 Auto Conditional

bool property femalesCanRequestBlowjobs = false Auto

int property swarmChance = 20 Auto
int property swarmMax = 10 Auto
;int property swarmLOSRequired = 2 Auto

;NPC APPROACHES (INTERNAL)
Bool isSoliciting = false
Bool property npcApproached = false Auto Conditional
Bool property paymentDispensed = false Auto Conditional
Bool property approachRunning = false Auto Conditional
float payingNpcStart
float payingNpcTimeout
ReferenceAlias Property PayingNpc Auto
ReferenceAlias property LastSadisticClient Auto
ReferenceAlias property LastSadisticThief Auto
int property currentClientPay = 9999 Auto Conditional	;If we get over 9000 coins for a standard pay in playtesting we know something's wrong

;MISCELLANEOUS/RANDOM EVENTS
form[] stolenItems	;to save a list of items when they're stolen if we need to reference them later
int stolenItemsSize	;the size of that list
ReferenceAlias property LastThief Auto
int property randomEventChance = 5 Auto	;Percent chance for a random event to take the place of an approach
int property numRandomEvents = 5 AutoReadonly	;Readonly value representing the number of events we have
int[] property randomEventWeights Auto		;How many ticks each event takes up on the wheel of fortune (see SpinRandomEvent())
int[] property conditionalEventWeights Auto		;Depending on follower presence, beastiality prefs, SD+ installation, etc, we'll cancel out some weightings
	;RANDOM EVENT NUMBERS
		;0 - NPC wants follower instead
		;1 - NPC wants player to fuck dog
		;2 - NPC robs player
		;3 - NPC offers to buy player (SD+)
int property chosenEvent Auto Conditional	;The dialogue is the fork in the events, this is the path it will take

ReferenceAlias property PlayerFollower Auto
ReferenceAlias property RandomEventDog Auto

Faction property PW_HasUsedPlayerFaction Auto

;UNPAID CLIENTS
Faction property PW_UnpaidFaction Auto
bool property stealingEnabled = true Auto Conditional
Int property stealMinValue = 50 Auto
Int property stealMaxValue = 2000 Auto
int property stealMaxItems = 4 Auto
int property stealMinItems = 2 Auto


;QUOTAS (INTERNAL)
Int[] property earlyBuyouts Auto		;Flat amount the player can pay to end duty
Float property buyoutMultiplier = 1.5 Auto	


;GOLD (MCM)
Int property basePay = 100 Auto	;The base amount of gold paid
Int property payPerLevel = 0 Auto		;(This * Player) level will be added to the base gold for a subtotal
;Modifiers will then be applied to the subtotal

int property standardCut = 0 Auto Conditional 	;what percent of pay will the player keep all the time?
int property overtimeCut = 30 Auto Conditional		;what percent of pay will the player keep when over quota?


;GOLD (INTERNAL)
GlobalVariable property PW_BribeGold  Auto  
GlobalVariable property PW_StandardPay  Auto 

GlobalVariable property PW_BooleanTippingEnabled Auto
GlobalVariable Property PW_CharmTipMinMult  Auto  
GlobalVariable Property PW_CharmTipMaxMult  Auto  
GlobalVariable Property PW_CharmMegaTipMult Auto
GlobalVariable property PW_CharmMegaTipChance Auto

GlobalVariable property PW_ReportingGold Auto
GlobalVariable property PW_ReportingGoldLie Auto
GlobalVariable property PW_nghExpected Auto


;RULES (MCM)
Int property nudityLevel = 1 Auto Conditional		;Values: 0 - Player can wear clothes, 1 - non-body/head slot allowed, 2 - player must be fully nude
Bool property weaponsAllowed = false Auto Conditional
Bool property citiesShareStatus = false Auto
Bool property restraintsRemovalEnabled = true Auto Conditional
Bool property tattooRemovalEnabled = true Auto Conditional


;PLAYER EQUIPMENT TRACKING (ALL INTERNAL)
Bool property isPlayerNaked auto Conditional
bool property isPlayerCollared auto Conditional
Bool property isPlayerYoked auto Conditional
bool property isPlayerGagged auto Conditional
bool property isPlayerArmed auto Conditional

Armor property bodySlotItem Auto
Armor property headSlotItem Auto
Armor property feetSlotItem Auto
Armor property handsSlotItem Auto

armor[] property exemptEquipment Auto
int property numExemptEquipment Auto
bool property bodySlotExempt = false Auto
bool property headSlotExempt = false Auto
bool property handsSlotExempt = false Auto
bool property feetSlotExempt = false Auto

Armor property collarSlotItem Auto
Armor property yokeSlotItem Auto
Armor property gagSlotItem Auto

Weapon property equippedWeapon Auto


;CONTENT PREFERENCES (MCM)
bool property beastialityEnabled = true Auto Conditional

GlobalVariable property PW_ApproachVaginalChance Auto
GlobalVariable property PW_ApproachBlowjobChance Auto
GlobalVariable property PW_ApproachAnalChance Auto

SwapJobAliasScript[] Property JarlJobAliasScripts Auto

int currentLocIndex = -1
int lastLocIndex = -1

Scene Property normalApproachFGScene Auto
Scene Property normalApproachVaginalFGScene Auto
Scene Property normalApproachBlowjobFGScene Auto
Scene Property normalApproachAnalFGScene Auto
Scene Property randomEventFGScene Auto
Scene Property offDutyApproachFGScene Auto

string[] Property randomEventStrings Auto
string[] Property randomEventDescs Auto

ObjectReference property stolenItemChest auto 
ObjectReference property sideQuestItemChest auto 


ImageSpaceModifier property FadeToBlack Auto


;===Advanced Nudity Stuff===
AND_MCM Property AND_Config Auto Hidden

Faction Property AND_NudeActorFaction Auto Hidden
Faction Property AND_ToplessFaction Auto Hidden
Faction Property AND_BottomlessFaction Auto Hidden
Faction Property AND_ShowingBraFaction Auto Hidden
Faction Property AND_ShowingChestFaction Auto Hidden
Faction Property AND_ShowingUnderwearFaction Auto Hidden
Faction Property AND_ShowingGenitalsFaction Auto Hidden
Faction Property AND_ShowingAssFaction Auto Hidden

Bool Property requireNude Auto Hidden
Bool Property requireTopless Auto Hidden
Bool Property requireChest Auto Hidden
Bool Property requireBra Auto Hidden
Bool Property requireBottomless Auto Hidden
Bool Property requireGenitals Auto Hidden
Bool Property requireAss Auto Hidden
Bool Property requireUnderwear Auto Hidden

Armor[] Property AND_Slots Auto Hidden
Keyword[] Property AND_Curtain_Keywords Auto Hidden
Keyword[] Property AND_ArmorTop_Keywords Auto Hidden
Keyword[] Property AND_ArmorBottom_Keywords Auto Hidden
Keyword[] Property AND_Bra_Keywords Auto Hidden
Keyword[] Property AND_Underwear_Keywords Auto Hidden
Keyword[] Property AND_Other_Keywords Auto Hidden
Keyword[] Property AND_Baka_Keywords Auto Hidden

;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| CONTROL |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

function Initialize()
	earlyBuyouts = new int[9]
	recentClients = new actor[40]
	exemptEquipment = new armor[15]
	randomEventWeights = Utility.createIntArray(numRandomEvents, 5)
	conditionalEventWeights = Utility.createIntArray(numRandomEvents, 0)
	
	player = Game.GetPlayer() ;Define quick reference to player actor
	
	updateArmor()
	
	randomEventStrings = new string[5]
	randomEventDescs = new string[5]
	randomEventStrings[0] = "Follower's Turn"
	randomEventDescs[0] = "An NPC asks for your follower instead of you."
	randomEventStrings[1] = "Breeding Bitch"
	randomEventDescs[1] = "You're asked to fuck a dog for extra pay."
	randomEventStrings[2] = "Robbery"
	randomEventDescs[2] = "Someone will decide you have enough gold for them to steal some."
	randomEventStrings[3] = "Buy Offer"
	randomEventDescs[3] = "A client will offer to buy out your quota, making you their slave via SD+."
	randomEventStrings[4] = "Threesome"
	randomEventDescs[4] = "A client will want you to find a third person to participatte."
	
	stateStartTime = Utility.GetCurrentGameTime()
	
	dgCond.RerollClientConds()

endFunction

Event OnUpdate()
	
	if(modEnabled)
		if(approachesSuspended)
			pwDebug(self, 2, "PW Suspended")
		else
			sendEvent("PW_CheckTimeComponents")
			;/ Normal approaches /;
			if(currentLocIndex >= 0 && currentLocIndex <= 8)
				if(playerCurrentStatus == 2 \	
				  || ((Tracker.isWhoreAnywhere || Tracker.hasBeenWhore[currentLocIndex]) && offDutyApproachChance > 0))	;/ Off-duty approaches /;
					RespondToState()
					pwDebug(self, 2, "State: " + debugState())
				endIf
			endIf
		endIf

		RegisterForSingleUpdate(updatePeriod)
	endIf

endEvent

Event OnPlayerLoadGame()
	If mods.isANDInstalled == true
		AND_NudeActorFaction = Game.GetFormFromFile(0x831, "Advanced Nudity Detection.esp") as Faction
		AND_ToplessFaction = Game.GetFormFromFile(0x832, "Advanced Nudity Detection.esp") as Faction
		AND_BottomlessFaction = Game.GetFormFromFile(0x833, "Advanced Nudity Detection.esp") as Faction
		AND_ShowingBraFaction = Game.GetFormFromFile(0x834, "Advanced Nudity Detection.esp") as Faction
		AND_ShowingChestFaction = Game.GetFormFromFile(0x82F, "Advanced Nudity Detection.esp") as Faction
		AND_ShowingUnderwearFaction = Game.GetFormFromFile(0x835, "Advanced Nudity Detection.esp") as Faction
		AND_ShowingGenitalsFaction = Game.GetFormFromFile(0x830, "Advanced Nudity Detection.esp") as Faction
		AND_ShowingAssFaction = Game.GetFormFromFile(0x82E, "Advanced Nudity Detection.esp") as Faction
		
		AND_Curtain_Keywords = new Keyword[9]
			AND_Curtain_Keywords[0] = Game.GetFormFromFile(0x806, "Advanced Nudity Detection.esp") as Keyword ;ChestCurtain
			AND_Curtain_Keywords[1] = Game.GetFormFromFile(0x80B, "Advanced Nudity Detection.esp") as Keyword ;ChestCurtain Transparent
			AND_Curtain_Keywords[2] = Game.GetFormFromFile(0x80C, "Advanced Nudity Detection.esp") as Keyword ;AssCurtain
			AND_Curtain_Keywords[3] = Game.GetFormFromFile(0x815, "Advanced Nudity Detection.esp") as Keyword ;AssCurtain Transparent
			AND_Curtain_Keywords[4] = Game.GetFormFromFile(0x822, "Advanced Nudity Detection.esp") as Keyword ;PelvicCurtain
			AND_Curtain_Keywords[5] = Game.GetFormFromFile(0x816, "Advanced Nudity Detection.esp") as Keyword ;PelvicCurtain Transparent
			AND_Curtain_Keywords[6] = Game.GetFormFromFile(0x821, "Advanced Nudity Detection.esp") as Keyword ;Miniskirt
			AND_Curtain_Keywords[7] = Game.GetFormFromFile(0x818, "Advanced Nudity Detection.esp") as Keyword ;Miniskirt Transparent
			AND_Curtain_Keywords[8] = Game.GetFormFromFile(0x824, "Advanced Nudity Detection.esp") as Keyword ;Microskirt
		
		AND_ArmorTop_Keywords = new Keyword[3]
			AND_ArmorTop_Keywords[0] = Game.GetFormFromFile(0x82A, "Advanced Nudity Detection.esp") as Keyword ;Normal
			AND_ArmorTop_Keywords[1] = Game.GetFormFromFile(0x82B, "Advanced Nudity Detection.esp") as Keyword ;Transparent
			AND_ArmorTop_Keywords[2] = Game.GetFormFromFile(0x83B, "Advanced Nudity Detection.esp") as Keyword ;NoCover
			
		AND_ArmorBottom_Keywords = new Keyword[7]
			AND_ArmorBottom_Keywords[0] = Game.GetFormFromFile(0x82C, "Advanced Nudity Detection.esp") as Keyword ;Normal
			AND_ArmorBottom_Keywords[1] = Game.GetFormFromFile(0x82D, "Advanced Nudity Detection.esp") as Keyword ;Transparent
			AND_ArmorBottom_Keywords[2] = Game.GetFormFromFile(0x83C, "Advanced Nudity Detection.esp") as Keyword ;NoCover
			AND_ArmorBottom_Keywords[3] = Game.GetFormFromFile(0x828, "Advanced Nudity Detection.esp") as Keyword ;Hotpants
			AND_ArmorBottom_Keywords[4] = Game.GetFormFromFile(0x829, "Advanced Nudity Detection.esp") as Keyword ;Transparent Hotpants
			AND_ArmorBottom_Keywords[5] = Game.GetFormFromFile(0x817, "Advanced Nudity Detection.esp") as Keyword ;ShowgirlSkirt
			AND_ArmorBottom_Keywords[6] = Game.GetFormFromFile(0x819, "Advanced Nudity Detection.esp") as Keyword ;Transparent ShowgirlSkirt
			
		AND_Bra_Keywords = new Keyword[3]
			AND_Bra_Keywords[0] = Game.GetFormFromFile(0x804, "Advanced Nudity Detection.esp") as Keyword ;Normal
			AND_Bra_Keywords[1] = Game.GetFormFromFile(0x81D, "Advanced Nudity Detection.esp") as Keyword ;Transparent
			AND_Bra_Keywords[2] = Game.GetFormFromFile(0x839, "Advanced Nudity Detection.esp") as Keyword ;NoCover
			
		AND_Underwear_Keywords = new Keyword[8]
			AND_Underwear_Keywords[0] = Game.GetFormFromFile(0x805, "Advanced Nudity Detection.esp") as Keyword ;Normal
			AND_Underwear_Keywords[1] = Game.GetFormFromFile(0x81E, "Advanced Nudity Detection.esp") as Keyword ;Transparent
			AND_Underwear_Keywords[2] = Game.GetFormFromFile(0x83A, "Advanced Nudity Detection.esp") as Keyword ;NoCover
			AND_Underwear_Keywords[3] = Game.GetFormFromFile(0x81F, "Advanced Nudity Detection.esp") as Keyword ;Thong
			AND_Underwear_Keywords[4] = Game.GetFormFromFile(0x820, "Advanced Nudity Detection.esp") as Keyword ;Transparent Thong
			AND_Underwear_Keywords[5] = Game.GetFormFromFile(0x83D, "Advanced Nudity Detection.esp") as Keyword ;NoCover Thong
			AND_Underwear_Keywords[6] = Game.GetFormFromFile(0x80A, "Advanced Nudity Detection.esp") as Keyword ;CString
			AND_Underwear_Keywords[7] = Game.GetFormFromFile(0x808, "Advanced Nudity Detection.esp") as Keyword ;Transparent CString
			
		AND_Other_Keywords = new Keyword[4]
			AND_Other_Keywords[0] = Game.GetFormFromFile(0x825, "Advanced Nudity Detection.esp") as Keyword ;NearlyNaked
			AND_Other_Keywords[1] = Game.GetFormFromFile(0x826, "Advanced Nudity Detection.esp") as Keyword ;NipplePastie
			AND_Other_Keywords[2] = Game.GetFormFromFile(0x827, "Advanced Nudity Detection.esp") as Keyword ;VaginaPastie
			AND_Other_Keywords[3] = Game.GetFormFromFile(0x807, "Advanced Nudity Detection.esp") as Keyword ;CoversAll
		
		AND_Config = Game.GetFormFromFile(0x837, "Advanced Nudity Detection.esp") as AND_MCM
		
	Else
		AND_Curtain_Keywords = new Keyword[1]
		AND_ArmorTop_Keywords = new Keyword[1]
		AND_ArmorBottom_Keywords = new Keyword[1]
		AND_Bra_Keywords = new Keyword[1]
		AND_Underwear_Keywords = new Keyword[1]
		AND_Other_Keywords = new Keyword[1]
		
		AND_Curtain_Keywords[0] = None
		AND_ArmorTop_Keywords[0] = None
		AND_ArmorBottom_Keywords[0] = None
		AND_Bra_Keywords[0] = None
		AND_Underwear_Keywords[0] = None
		AND_Other_Keywords[0] = None
		
		AND_NudeActorFaction = none
		AND_ToplessFaction = none
		AND_BottomlessFaction = none
		AND_ShowingBraFaction = none
		AND_ShowingChestFaction = none
		AND_ShowingUnderwearFaction = none
		AND_ShowingGenitalsFaction = none
		AND_ShowingAssFaction = none
		
		AND_Config = None
	EndIf
	
	If mods.isSLAInstalled == True
		AND_Baka_Keywords = new Keyword[18]
			AND_Baka_Keywords[0] = Game.GetFormFromFile(0x8E855, "SexLabAroused.esm") as Keyword ;HalfNaked
			AND_Baka_Keywords[1] = Game.GetFormFromFile(0x8E856, "SexLabAroused.esm") as Keyword ;BraBikini
			AND_Baka_Keywords[2] = Game.GetFormFromFile(0x8E857, "SexLabAroused.esm") as Keyword ;ThongT
			AND_Baka_Keywords[3] = Game.GetFormFromFile(0x8F3F5, "SexLabAroused.esm") as Keyword ;ThongGstring
			AND_Baka_Keywords[4] = Game.GetFormFromFile(0x8EDC2, "SexLabAroused.esm") as Keyword ;ThongLowleg
			AND_Baka_Keywords[5] = Game.GetFormFromFile(0x8EDC3, "SexLabAroused.esm") as Keyword ;ThongCString
			AND_Baka_Keywords[6] = Game.GetFormFromFile(0x8FEA0, "SexLabAroused.esm") as Keyword ;ArmorPartTop
			AND_Baka_Keywords[7] = Game.GetFormFromFile(0x8FEA1, "SexLabAroused.esm") as Keyword ;ArmorPartBottom
			AND_Baka_Keywords[8] = Game.GetFormFromFile(0x8F40D, "SexLabAroused.esm") as Keyword ;FullSkirt
			AND_Baka_Keywords[9] = Game.GetFormFromFile(0x8F3F4, "SexLabAroused.esm") as Keyword ;MicroHotpants
			AND_Baka_Keywords[10] = Game.GetFormFromFile(0x8F40F, "SexLabAroused.esm") as Keyword ;MicroSkirt
			AND_Baka_Keywords[11] = Game.GetFormFromFile(0x8F40E, "SexLabAroused.esm") as Keyword ;MiniSkirt
			AND_Baka_Keywords[12] = Game.GetFormFromFile(0x8EDC1, "SexLabAroused.esm") as Keyword ;PantiesNormal
			AND_Baka_Keywords[13] = Game.GetFormFromFile(0x8F3F3, "SexLabAroused.esm") as Keyword ;PantsNormal
			AND_Baka_Keywords[14] = Game.GetFormFromFile(0x8F409, "SexLabAroused.esm") as Keyword ;PastiesCrotch
			AND_Baka_Keywords[15] = Game.GetFormFromFile(0x8F40A, "SexLabAroused.esm") as Keyword ;PastiesNipple
			AND_Baka_Keywords[16] = Game.GetFormFromFile(0x8F402, "SexLabAroused.esm") as Keyword ;PelvicCurtain
			AND_Baka_Keywords[17] = Game.GetFormFromFile(0x8F403, "SexLabAroused.esm") as Keyword ;ShowgirlSkirt
	else
		AND_Baka_Keywords = new Keyword[1]
			AND_Baka_Keywords[0] = None
	endIf
endEvent

event OnUpdateGameTime()
{Used to reset recent approacher list every delta. Not very elegant but it's something}
	int index = 0
	while index <= numrecentClients
		if(recentClients[index] != none)
			recentClients[index].removeFromFaction(recentClientFaction)
		endIf
		index += 1
	endWhile
	
	recentClients = new actor[40]
	numrecentClients = 0
endEvent

function Startup()

	pwDebug(self, 3, "main starting up")

	;Register for all mod events our scripts use
	RegisterForModEvent("HookAnimationEnd_REDogSex", "REDogSexEnd")	;Dog fucker random event hook so we know when to despawn the dog
	RegisterForModEvent("dhlp-Suspend", "dhlpSuspend")
	RegisterForModEvent("dhlp-Resume", "dhlpResume")
	
	RegisterForModEvent("PW_SexQueueSexEnd_pwMain", "pwOnSexEnd")
	RegisterForModEvent("PW_SexQueueSexEndNonfinal_pwMain", "pwOnSexEnd")
	RegisterForModEvent("PW_SexQueueSexEnd_MainSexSwarm", "pwOnSexEnd")
	RegisterForModEvent("PW_SexQueueSexEndNonfinal_MainSexSwarm", "OnSexSwarmSexEnd")
	
	WRIQ.RegisterForModEvent("HookAnimationEnd_BelethorScene", "onBelethorSceneSexEnd")
	WRIQ.RegisterForModEvent("HookAnimationEnd_FarengarScene", "onFarengarSceneSexEnd")
	
	RegisterForModEvent("PW_EnterCity", "EnterCity")
	RegisterForModEvent("PW_LeaveCity", "LeaveCity")
	RegisterForModEvent("PW_UpdateLocInfo", "UpdateLocInfo")
	RegisterForModEvent("PW_CurrentStatusChange", "OnCurrentStatusChange")
	RegisterForModEvent("PW_StripPlayer", "StripPlayer")
	RegisterForModEvent("PW_UpdateGlobal", "GlobalUpdated")
	RegisterForModEvent("PW_PlayerEquipmentChanged", "UpdateArmor")

	RegisterForUpdateGameTime(recentClientDelta)
	RegisterForSingleUpdate(updatePeriod)
	
	LoopState = 0

	
	return
endFunction

event UpdateLocInfo()
	
endEvent

event dhlpSuspend(string eventName, string strArg, float numArg, Form sender)
	approachesSuspended = true
	UnregisterForUpdate()
	pwDebug(self, 3, "PW Suspended")
endEvent

event dhlpResume(string eventName, string strArg, float numArg, Form sender)
	Utility.Wait(2.0)
	approachesSuspended = false
	suspendedUpdateCount = 0
	RegisterForSingleUpdate(updatePeriod)
	pwDebug(self, 3, "PW Resumed")
endEvent

event OnCurrentStatusChange(int newStatus)
	playerCurrentStatus = newStatus
endEvent

event EnterCity(int locIndex)
	currentLocIndex = locIndex
	lastLocIndex = locIndex
	LocalPWThane.ForceRefTo(tracker.pwThanes[locIndex])
	
	if(locIndex >= 0 && locIndex <= 8)
		playerCurrentStatus = tracker.GetStatus(locIndex)
	else
		playerCurrentStatus = 0
	endIf
endEvent

event LeaveCity(int locIndex)
	currentLocIndex = -1
endEvent


event GlobalUpdated(form globForm)
	GlobalVariable glob
	if (globForm as GlobalVariable)
		glob = globForm as GlobalVariable
		
		;Quick reminder, this function returns false if the instance isn't found, instead of causing an error
		UpdateCurrentInstanceGlobal(glob)
	endIf
	
endEvent

;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| NPC APPROACHES|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

function RespondToState()
;Checks the current approach loop state and performs any checks/actions accordingly

	if(LoopState == 0)
		setState(1)

	elseIf(LoopState == 1 && isPlayerApproachable())  ;If state is ready
	
		UpdateDialogueData()
		
		if(playerCurrentStatus == 2)
			actor approacher = actorMgr.GetBestApproacher()
			npcApproached = false
			if (approacher != none)
				if(Utility.RandomInt(0, 99) < approachChance)
					if(Utility.RandomInt(0, 99) < randomEventChance)	;Check for random event
						pwDebug(self, 1, "random event attempting to intercept approach")
						chosenEvent = SpinRandomEvent()
						if(chosenEvent != -1)
							pwDebug(self, 1, "random event running")
							approachPlayer(approacher, randomEventFGScene)
						else
							pwDebug(self, 1, "no random event valid, defaulting to normal approach")
							approachPlayer(approacher, normalApproachFGScene)
						endIf
					else
					
						; Determine what type of sex will be asked of the player
						int randomRoll = Utility.RandomInt(0, 299)
						
						; Blowjob
						if randomRoll < PW_ApproachBlowjobChance.GetValue() && (femalesCanRequestBlowjobs || approacher.GetLeveledActorBase().GetSex() == 0)
							ApproachPlayer(approacher, normalApproachBlowjobFGScene)
						
						; Anal
						elseIf randomRoll < PW_ApproachBlowjobChance.GetValue() + PW_ApproachAnalChance.GetValue()
							ApproachPlayer(approacher, normalApproachAnalFGScene)
							
						; Vaginal
						elseIf randomRoll < PW_ApproachBlowjobChance.GetValue() + PW_ApproachAnalChance.GetValue() + PW_ApproachVaginalChance.GetValue()
							ApproachPlayer(approacher, normalApproachVaginalFGScene)
						
						else
							ApproachPlayer(approacher, normalApproachFGScene)
						endIf
						
					endIf
				else
					setState(3)
				endIf
			endIf
		else
			pwDebug(self, 1, "checking for off duty approaches")
			if(Utility.RandomInt(0, 99) < offDutyApproachChance)	;Player isn't city whore here/now, check for off-duty approaches
				actor approacher = actorMgr.GetBestApproacher()
				approachPlayer(approacher, offDutyApproachFGScene)
				pwDebug(self, 1, "off duty approach started")
			else
				setState(3)
				pwDebug(self, 1, "skipping off duty approach")
			endIf
		endIf

	elseIf(LoopState == 2 && (Utility.GetCurrentRealTime() - stateStartTime) >= approachTimeout && !Sexlab.IsActorActive(Game.GetPlayer()))	;If an approach is active, then check if approach's timed out, reset if it has.
		if approachTimeout == 0
			SetState(1)
		else
			SetState(3)
		endIf

	elseif(LoopState == 3 && (Utility.GetCurrentGameTime() - stateStartTime) * 1440 >= scanPeriod)  	;If in the period between scans, check if it's ended, then return to State 1 if so
		SetState(1)

	endIf 

	if((Utility.GetCurrentRealTime() - payingNpcStart) >= 20 && payingNpc.GetActorRef() != none)
		payingNpc.Clear()
	endIf


	return

endFunction

;Configures conditions and global variables to prepare for dialogue
function UpdateDialogueData()
	PW_StandardPay.SetValue(quotaMgr.calculatePay())
	UpdateCurrentInstanceGlobal(PW_StandardPay)
	
	dgCond.RerollClientConds()
endFunction


; Used for debugging
function StartRandomEvent(int eventIndex)
	actor approacher = actorMgr.GetBestApproacher()
	
	if approacher != none
		chosenEvent = eventIndex
		ApproachPlayer(approacher, randomEventFGScene)
	endIf
endFunction


bool function isPlayerApproachable()
;Checks whether the player can currently be approached. 

	if(Sexlab.IsActorActive(player))
		pwDebug(self, 2, "PW: Player busy in SL scene")
		return false
 	endIf

	if(player.IsInCombat())
		pwDebug(self, 2, "PW: Player busy in combat")
		return false
	endIf

	if(approachRunning)
		pwDebug(self, 2, "PW: Player busy already being approached")
		return false
	endIf

	if(approachesSuspended)
		pwDebug(self, 2, "PW: DHLP suspend prevented approach")
		return false
	endIf

	return true
endFunction



function ApproachPlayer(actor approacher, Scene approachScene)

	
	setState(2)		;If we've gotten this far we're fairly certain the approacher is ready to go, we go ahead and mark an approach as running
	approachRunning = true
	npcApproached = false 

	approachAlias.Clear()
	approachAlias.ForceRefTo(approacher)
	
	approachScene.ForceStart()

	
	return
endfunction

function addRecentClient(actor client)
	if(numrecentClients < 40)
		client.AddToFaction(recentClientFaction)
		recentClients[numrecentClients] = client
		numrecentClients += 1
	endIf

	return
endFunction


int function SpinRandomEvent()
{Let's make Sheogorath proud}

	filterEventWeights()	;Filter out any events we can't start right now
	int index = 0		;Check that at least one event has a non-zero weighting
	bool allZero = true
	while(index < numRandomEvents)
		if(randomEventWeights[index] != 0)
			allZero = false
			index = numRandomEvents
		endIf
		index += 1
	endWhile
	
	if(allZero)
		return -1		;If all of the events have a weight of zero then we back out, return -1
	endIf

	;Now actually find the random event to give
	int ticks = Utility.RandomInt(0, numRandomEvents * 10)		;current number of ticks remaining in the spin
	index = Utility.RandomInt(0, numRandomEvents - 1)		;current event we're checking, start on random one

	while(ticks > 0)
		if(randomEventWeights[index] < ticks)	;if remaining ticks is greater than the weight of this event, we skip through spinning this section
			ticks -= randomEventWeights[index]
			index += 1		;index goes up
			if(index >= (numRandomEvents))		;numRandomEvents = last event index + 1, so if we reach index >= numRandomEvents, we reset index to the first index
				while (randomEventWeights[index] == 0)
					index += 1
				endWhile
			endIf
	
		else	;otherwise we stop on this index
			ticks = 0
		endIf
	endWhile
	
	prepareEvent(index)
	return index
	
endFunction


function filterEventWeights()
	if(Tracker.PlayerFollower.GetActorReference() == none || !Tracker.PlayerFollower.GetActorReference().HasLOS(Game.GetPlayer()))
		conditionalEventWeights[0] = 0
	endIf
	if(!beastialityEnabled)
		conditionalEventWeights[1] = 0
	endIf
	if(!stealingEnabled)
		conditionalEventWeights[2] = 0
	endIf
	if(!Mods.usingSDPlus || Mods.isPlayerEnslaved())
		conditionalEventWeights[3] = 0
	endIf
	return
endFunction

function simulateEventRolls()
	int[] count = new int[4]
	int index = 0
	while index < 50
		int chosen = SpinRandomEvent()
		count[chosen] = count[chosen] + 1
		index += 1
	endWhile
	
	Debug.MessageBox(count[0] + " " + count[1] + " " + count[2] + " " + count[3])
	return
endFunction

function prepareEvent(int eventIndex)
{get everything ready for  a particular event to happen}
	if(eventIndex == 0)
		PlayerFollower.ForceRefTo(Tracker.PlayerFollower.GetActorReference())
	endIf
	return
endFunction


; TODO - move this to quota manager... I don't know where the fuck it was supposed to have gone
function checkPlayerReportingGold()
	if(quotaMgr.quotaMode == quotaMgr.QUOTA_MODE_CLIENTS || quotaMgr.quotaMode == quotaMgr.QUOTA_MODE_ENDLESS)
		int pay = quotaMgr.calculatePay()
		int expectedAmount = pay * quotaMgr.recentClients[currentLocIndex]
	
		dgCond.hasEnough = player.GetItemCount(Gold) >= expectedAmount
		if(dgCond.hasEnough)
			PW_ReportingGold.SetValue(expectedAmount)
		else
		
			PW_ReportingGold.SetValue(player.GetItemCount(Gold))
		endIf
		PW_ReportingGoldLie.SetValue((player.GetItemCount(Gold) / 2) as int)
	elseIf(quotaMgr.quotaMode == 1)
		int remaining = (quotaMgr.goldQuotas[currentLocIndex] - quotaMgr.cumulativeGold[currentLocIndex])
		dgCond.hasEnough = player.GetItemCount(Gold) >= remaining
		
		if(dgCond.hasEnough)
			PW_ReportingGold.SetValue(remaining)
		else
			PW_ReportingGold.SetValue(player.GetItemCount(Gold) as int)
		endIf
	endIf

	UpdateCurrentInstanceGlobal(PW_ReportingGold)
	UpdateCurrentInstanceGlobal(PW_ReportingGoldLie)

	return
endFunction


;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| SEX SCENES |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
function pwStartSex(actor client, bool isRape = false, bool playerInitiated = false, string animTags = "")
;Starts a PW sex scene between the player and client
;This is NOT an all-purpose sex-starting function: it is only to be called when sex is being initiated with a PW client, as it prepares the loop and some other variables as such.
	
	isSoliciting = playerInitiated	;Set our flag if the player is the one who approached the npc
	if(isSoliciting)
		approachRunning = false
	endIf

	;We calculate how much the client is going to pay at the start of this, for the following reasons:
		;A) If the player is getting paid, then she must have had sex
		;B) If there's a pay deduction for having to "force it out of her" then we can tell based on whether the animation is rape
	;TODO: this is outdated and, frankly, flat-out dangerous logic, so let's fix this sometime

	currentClientPay = quotaMgr.calculatePay(isRape)	;update our property so that dialogue can view it and hand it out after
	

	pwDebug(self, 2, "PW: Starting sex with " + client.GetLeveledActorBase().GetName())
	
	if(Utility.RandomInt(0, 99) < swarmChance)
		sexQueue.Enqueue(client, isRape, "MainSexSwarm", aksAnimTags=animTags)
		Debug.MessageBox("Nearby citizens see you getting fucked, and begin to gather around.")
		sexQueue.StartAutomaticMode(swarmMax, "MainSexSwarm", recentClientFaction)
	else
		sexQueue.Enqueue(client, isRape, "pwMain", aksAnimTags = animTags)
	endIf

	dgCond.isRape = isRape
	dgCond.beggar = client.IsInFaction(beggarFaction)

	return
endfunction

function pwStartCharmedSex(actor client, bool isRape = false, bool playerInitiated = false, string animTags = "")
	client.AddToFaction(PW_CharmedFaction)
	if PW_BooleanTippingEnabled.GetValue() > 0
		int standardPay = PW_StandardPay.GetValue() as int
		int tip = (Utility.RandomFloat(PW_CharmTipMinMult.GetValue(), PW_CharmTipMaxMult.GetValue()) * standardPay) as int
		
		if Utility.RandomInt(0, 99) < PW_CharmMegaTipChance.GetValue() as int
			tip = (tip * PW_CharmMegaTipMult.GetValue()) as int
		endIf
		
		player.AddItem(gold, tip)
	endIf
	
	pwStartSex(client, isRape, playerInitiated, animTags)
endFunction


event pwOnSexEnd(Form partnerAsForm)
{received when a PW on-duty sex scene ends, received when a sex scene with a PW client ends}
	Actor partner = partnerAsForm as Actor
	if !partner
		pwDebug(self, 5, "pwOnSexEnd: argument was not an actor, aborting")
		return
	endIf
	
	addRecentClient(partner)
	partner.AddToFaction(PW_HasUsedPlayerFaction)

	;Increment clients taken, since this is event is only received when a client is fully taken
	quotaMgr.incrementClients(currentLocIndex)
	dgCond.notPaying = (Utility.RandomInt(1, 100) <= notPayingChance) && !partner.IsInFaction(PW_CharmedFaction)

	if(dgCond.sadisticRape)	;no payment here
		LastSadisticClient.ForceRefTo(partner)
		dgCond.sadisticRape = false

	elseIf(!quotaMgr.playerHandlesGold)
		quotaMgr.CitizenReport()
		
	elseIf(dgCond.notPaying)
		partner.AddToFaction(PW_UnpaidFaction)
	else
		paymentDispensed = false
		pwDebug(self, 2, "Client is paying now")
		PayingNPC.ForceRefTo(partner)
		payingNpcStart = Utility.GetCurrentRealTime()
	endIf
		
	isSoliciting = false	;Set this back to false at the end of OnSexEnd because this is the last resultant function that checks it from player-initiated sex
	dgCond.beggar = false
	dgCond.notPaying = false
	
	if partner.IsInFaction(PW_CharmedFaction)
		partner.RemoveFromFaction(PW_CharmedFaction)
	endIf
	
	if approachTimeout == 0
		SetState(1)
	else
		SetState(3)
	endIf
endevent

event OnSexSwarmSexEnd(Form partnerAsForm)
	Actor partner = partnerAsForm as Actor
	if !partner
		pwDebug(self, 5, "OnSwarmSexEnd: argument was not an actor, aborting")
		return
	endIf
	
	addRecentClient(partner)
	partner.AddToFaction(PW_HasUsedPlayerFaction)
	
	quotaMgr.incrementClients(currentLocIndex)
	dgCond.notPaying = (Utility.RandomInt(1, 100) <= notPayingChance)
	
	if(!quotaMgr.playerHandlesGold)
		pwDebug(self, 2, "applying citizen report for " + partner.GetLeveledActorBase().GetName())
		quotaMgr.CitizenReport()
		
	elseIf(dgCond.notPaying)
		pwDebug(self, 2, "not receiving pay from " + partner.GetLeveledActorBase().GetName())
		partner.AddToFaction(PW_UnpaidFaction)
	else
		pwDebug(self, 2, "receiving pay from " + partner.GetLeveledActorBase().GetName())
		player.AddItem(gold, quotaMgr.calculatePay())
	endIf
	
endEvent

event REDogSexEnd(int tid, bool HasPlayer)
	Utility.Wait(2.0)
	Debug.MessageBox("After filling you with dog semen, the dog runs off.")
	RandomEventDog.GetActorReference().Delete()
	RandomEventDog.clear()
	
endEvent

event sadisticSexEnd(int tid, bool HasPlayer)
	Debug.MessageBox(LastSadisticClient.GetActorReference().GetLeveledActorBase().GetName() + " pushes you into the dirt and slaps you across the face as you try to stand up, then begins searching your belongings, taking some of your gold. To your utter humiliation, your aggressor has publicly proven that you ARE just an object for their pleasure.")
endEvent

;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| EQUIPMENT MONITOR/CONTROL|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

event UpdateArmor()
;This is called by the OnObject(Un)Equipped event(s) in the PlayerEventTracker script,
;attached to the PlayerRef quest alias
	bodySlotItem = player.GetWornForm(0x00000004) as Armor
	headSlotItem = player.GetWornForm(0x00000002) as Armor
	feetSlotItem = player.GetWornForm(0x00000080) as Armor
	handsSlotItem = player.GetWornForm(0x00000008) as Armor
	collarSlotItem = player.GetWornForm(0x00008000) as Armor
	gagSlotItem = player.GetWornForm(0x00004000) as Armor
	
	; ZaZ anim pack and DD use different slots for yokes. Check for DD then fallback
	yokeSlotItem = player.GetWornForm(0x0010000) as Armor
	if yokeSlotItem == None
		yokeSlotItem = player.GetWornForm(0x0008000) as Armor
		if yokeSlotItem == None
			yokeSlotItem = None
		elseIf !yokeSlotItem.HasKeyWordString("zbfWornYoke")	
			yokeSlotItem = None
		endIf
	endIf
	
	
	equippedWeapon = player.GetEquippedWeapon()
	
	isPlayerCollared = collarSlotItem != none
	isPlayerYoked = yokeSlotItem != none
	isPlayerGagged = (gagSlotItem != none && (gagSlotItem.HasKeyWordString("zad_DeviousGag") || gagSlotItem.HasKeyWordString("zbfWornGag")))
	isPlayerNaked = getPlayerNudity() >= nudityLevel
	isPlayerArmed = equippedWeapon != none

	return
endEvent

function exemptEquipped(armor which)
	if(which.GetSlotMask() == 0x00000002)
		headSlotExempt = true
	elseIf(which.GetSlotMask() == 0x00000004)
		bodySlotExempt = true
	elseIf(which.GetSlotMask() == 0x00000008)
		handsSlotExempt = true
	elseIf(which.GetSlotMask() == 0x00000080)
		feetSlotExempt = true
	endIf
	
	return
endFunction

function exemptUnequipped(armor which)
	if(which.GetSlotMask() == 0x00000002)
		headSlotExempt = false
	elseIf(which.GetSlotMask() == 0x00000004)
		bodySlotExempt = false
	elseIf(which.GetSlotMask() == 0x00000008)
		handsSlotExempt = false
	elseIf(which.GetSlotMask() == 0x00000080)
		feetSlotExempt = false
	endIf
	
	return
endFunction


int function getPlayerNudity()
;Returns the nudity level that the player is currently in compliance with
	If nudityLevel < 3
		if((headSlotItem == none || headSlotExempt || headSlotItem.HasKeyWordString("SexLabNoStrip")) && (bodySlotItem == none || bodySlotExempt) || bodySlotItem.HasKeyWordString("SexLabNoStrip"))
			if((handsSlotItem == none || handsSlotExempt || handsSlotItem.HasKeyWordString("SexLabNoStrip")) && (feetSlotItem == none || feetSlotExempt || feetSlotItem.HasKeyWordString("SexLabNoStrip")))
				return 2
			endIf
			return 1
		endIf
		return 0
	else
		Bool complyingTop = false
		Bool complyingBottom = false
		
		If requireNude == true
			If player.GetFactionRank(AND_NudeActorFaction) == 1
				return 3
			endIf
			return 0
		else
			If requireTopless == true
				If player.GetFactionRank(AND_ToplessFaction) == 1
					complyingTop = true
				endIf
			elseIf requireChest == true
				If player.GetFactionRank(AND_ShowingChestFaction) == 1
					complyingTop = true
				endIf
			elseif requireBra == true
				If player.GetFactionRank(AND_ShowingBraFaction) == 1 || player.GetFactionRank(AND_ShowingChestFaction) == 1
					complyingTop = true
				endIf
			else
				complyingTop = true
			endIf
			
			If requireBottomless == true
				If player.GetFactionRank(AND_BottomlessFaction) == 1
					complyingBottom = true
				endIf
			elseif requireGenitals == true && requireAss == true
				If player.GetFactionRank(AND_ShowingGenitalsFaction) == 1 && player.GetFactionRank(AND_ShowingAssFaction) == 1
					complyingBottom = true
				endIf
			elseif requireGenitals == true && requireAss == false
				If player.GetFactionRank(AND_ShowingGenitalsFaction) == 1
					complyingBottom = true
				endIf
			elseif requireGenitals == false && requireAss == true
				If player.GetFactionRank(AND_ShowingAssFaction) == 1
					complyingBottom = true
				endIf
			elseif requireUnderwear == true
				If player.GetFactionRank(AND_ShowingUnderwearFaction) == 1 || player.GetFactionRank(AND_ShowingAssFaction) == 1 || player.GetFactionRank(AND_ShowingGenitalsFaction) == 1
					complyingBottom == true
				endIf
			else
				complyingBottom = true
			endIf
			
			If complyingTop == true && complyingBottom == true
				return 3
			endIf
			return 0
		endIf
	endIf

endFunction


event StripPlayer()
{Strips the player based on required nudity level}

	if(nudityLevel == 1)
		if(bodySlotItem != none && !bodySlotExempt && !bodySlotItem.HasKeyWordString("SexLabNoStrip"))
			player.UnequipItem(bodySlotItem)
		endIf
		if(headSlotItem != none && !headSlotExempt && !headSlotItem.HasKeyWordString("SexLabNoStrip"))
			player.UnequipItem(headSlotItem)
		endIf
		updateArmor()
		
	elseIf(nudityLevel == 2)
		if(bodySlotItem != none && !bodySlotExempt && !bodySlotItem.HasKeyWordString("SexLabNoStrip"))
			player.UnequipItem(bodySlotItem)
		endIf
		if(headSlotItem != none && !headSlotExempt && !headSlotItem.HasKeyWordString("SexLabNoStrip"))
			player.UnequipItem(headSlotItem)
		endIf
		if(feetSlotItem != none && !feetSlotExempt && !feetSlotItem.HasKeyWordString("SexLabNoStrip"))
			player.UnequipItem(feetSlotItem)
		endIf
		if(handsSlotItem != none && !handsSlotExempt && !handsSlotItem.HasKeyWordString("SexLabNoStrip"))
			player.UnequipItem(handsSlotItem)
		endIf
		updateArmor()
	
	elseif(nudityLevel == 3)
		Int SlotIndex = 0
		Int KeywordIndex = 0
		Bool SlotUnequipped = False
		AND_Slots = new Armor[28]
			AND_Slots[0] = player.GetEquippedArmorInSlot(31)
			AND_Slots[1] = player.GetEquippedArmorInSlot(32)
			AND_Slots[2] = player.GetEquippedArmorInSlot(33)
			AND_Slots[3] = player.GetEquippedArmorInSlot(34)
			AND_Slots[4] = player.GetEquippedArmorInSlot(35)
			AND_Slots[5] = player.GetEquippedArmorInSlot(36)
			AND_Slots[6] = player.GetEquippedArmorInSlot(37)
			AND_Slots[7] = player.GetEquippedArmorInSlot(38)
			AND_Slots[8] = player.GetEquippedArmorInSlot(39)
			AND_Slots[9] = player.GetEquippedArmorInSlot(40)
			AND_Slots[10] = player.GetEquippedArmorInSlot(41)
			AND_Slots[11] = player.GetEquippedArmorInSlot(42)
			AND_Slots[12] = player.GetEquippedArmorInSlot(43)
			AND_Slots[13] = player.GetEquippedArmorInSlot(44)
			AND_Slots[14] = player.GetEquippedArmorInSlot(45)
			AND_Slots[15] = player.GetEquippedArmorInSlot(46)
			AND_Slots[16] = player.GetEquippedArmorInSlot(47)
			AND_Slots[17] = player.GetEquippedArmorInSlot(48)
			AND_Slots[18] = player.GetEquippedArmorInSlot(49)
			AND_Slots[19] = player.GetEquippedArmorInSlot(52)
			AND_Slots[20] = player.GetEquippedArmorInSlot(53)
			AND_Slots[21] = player.GetEquippedArmorInSlot(54)
			AND_Slots[22] = player.GetEquippedArmorInSlot(55)
			AND_Slots[23] = player.GetEquippedArmorInSlot(56)
			AND_Slots[24] = player.GetEquippedArmorInSlot(57)
			AND_Slots[25] = player.GetEquippedArmorInSlot(58)
			AND_Slots[26] = player.GetEquippedArmorInSlot(59)
			AND_Slots[27] = player.GetEquippedArmorInSlot(60)
		
		If requireNude == true
			
			While SlotIndex < AND_Slots.Length
				While KeywordIndex < AND_Curtain_Keywords.Length && SlotUnequipped == False
					If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[KeywordIndex])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True ;Break loop if item unequipped - we no longer need to iterate on this slot
					endIf
					KeywordIndex += 1
				endWhile
				
				KeywordIndex = 0 ;Reset Keyword Index for next list
				
				While KeywordIndex < AND_ArmorTop_Keywords.Length && SlotUnequipped == False
					If AND_Slots[SlotIndex].HasKeyword(AND_ArmorTop_Keywords[KeywordIndex])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					EndIf
					KeywordIndex += 1
				endWhile
				
				KeywordIndex = 0
				
				While KeywordIndex < AND_ArmorBottom_Keywords.Length && SlotUnequipped == False
					If AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[KeywordIndex])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					EndIf
					KeywordIndex += 1
				EndWhile
				
				KeywordIndex = 0
				
				While KeywordIndex < AND_Bra_Keywords.Length && SlotUnequipped == False
					If AND_Slots[SlotIndex].HasKeyword(AND_Bra_Keywords[KeywordIndex])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					KeywordIndex += 1
				endWhile
				
				KeywordIndex = 0
				
				While KeywordIndex < AND_Underwear_Keywords.Length && SlotUnequipped == False
					If AND_Slots[SlotIndex].HasKeyword(AND_Underwear_Keywords[KeywordIndex])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					KeywordIndex += 1
				endWhile
				
				KeywordIndex = 0
				
				While KeywordIndex < AND_Other_Keywords.Length && SlotUnequipped == False
					If AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[KeywordIndex])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					KeywordIndex += 1
				endWhile
				
				KeywordIndex = 0
				
				While KeywordIndex < AND_Baka_Keywords.Length && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false
					If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = true
					endIf
					KeywordIndex += 1
				endWhile
				
				If SlotUnequipped == false && SlotIndex == 1
					player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
				endIf
				
				KeywordIndex = 0
				SlotIndex += 1
				SlotUnequipped = False
			EndWhile
		else
			If requireTopless == true
				While SlotIndex < AND_Slots.Length
					While KeywordIndex < AND_ArmorTop_Keywords.Length && SlotUnequipped == False
						If AND_Slots[SlotIndex].HasKeyword(AND_ArmorTop_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					while KeywordIndex < AND_Bra_Keywords.Length && SlotUnequipped == False
						If AND_Slots[SlotIndex].HasKeyword(AND_Bra_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[0]) || AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[1])\ 
					|| AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[1]) || AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					While KeywordIndex < AND_Baka_Keywords.Length && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false
						If KeywordIndex < 1
							KeywordIndex = 1 ;Check Bra
						ElseIf KeywordIndex < 6
							KeywordIndex = 6 ;Check ArmorTop
						ElseIf KeywordIndex < 15
							KeywordIndex = 15 ;Check PastiesNipple
						Else
							KeywordIndex = AND_Baka_Keywords.Length
						EndIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = true
						endIf
						KeywordIndex += 1
					endWhile
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					KeywordIndex = 0
					SlotIndex += 1
					SlotUnequipped = False
				endWhile
			elseif requireChest == true
				While SlotIndex < AND_Slots.Length
					If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[0]) || AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[1])\ 
					|| AND_Slots[SlotIndex].HasKeyword(AND_ArmorTop_Keywords[0]) || AND_Slots[SlotIndex].HasKeyword(AND_ArmorTop_Keywords[1])\ 
					|| AND_Slots[SlotIndex].HasKeyword(AND_Bra_Keywords[0]) || AND_Slots[SlotIndex].HasKeyword(AND_Bra_Keywords[1]) || AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					While KeywordIndex < AND_Baka_Keywords.Length && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false
						If KeywordIndex < 1
							KeywordIndex = 1
						ElseIf KeywordIndex < 6
							KeywordIndex = 6
						Else
							KeywordIndex = AND_Baka_Keywords.Length
						EndIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = true
						endIf
						KeywordIndex += 1
					endWhile
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					SlotIndex += 1
					SlotUnequipped = False
				endWhile
			elseif requireBra == true
				While SlotIndex < AND_Slots.Length
					If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[0]) || AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[1])\ 
					|| AND_Slots[SlotIndex].HasKeyword(AND_ArmorTop_Keywords[0]) || AND_Slots[SlotIndex].HasKeyword(AND_ArmorTop_Keywords[1]) || AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[6]) && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == False
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					EndIf
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					SlotIndex += 1
					SlotUnequipped = False
				endWhile
			endIf
			
			;Reset for bottom checks
			If KeywordIndex != 0
				KeywordIndex = 0
			endIf
			
			If SlotIndex != 0
				SlotIndex = 0
			endIf
			
			If SlotUnequipped != false
				SlotUnequipped = false
			endIf
			
			If requireBottomless == true
				While SlotIndex < AND_Slots.Length
					While KeywordIndex < AND_ArmorBottom_Keywords.Length && SlotUnequipped == False
						If AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endif
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					While KeywordIndex < AND_Underwear_Keywords.Length && SlotUnequipped == False
						If AND_Slots[SlotIndex].HasKeyword(AND_Underwear_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 2 ;Set to 2 so that ChestCurtain Keywords are skipped in the next while loop, but the rest of the array can be checked
					
					While KeywordIndex < AND_Curtain_Keywords.Length && SlotUnequipped == False
						If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					if AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[2]) || AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					While KeywordIndex < AND_Baka_Keywords.Length && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false
						If KeywordIndex == 1
							KeywordIndex = 2 ;Skip Bra
						ElseIf KeywordIndex == 6
							KeywordIndex = 7 ;Skip ArmorTop
						ElseIf KeywordIndex == 15
							KeywordIndex = 16 ;Skip PastiesNipple
						EndIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = true
						endIf
						KeywordIndex += 1
					endWhile
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					KeywordIndex = 0
					SlotIndex += 1
					SlotUnequipped == False
				endWhile
			elseif requireGenitals == true && requireAss == true
				While SlotIndex < AND_Slots.Length
					While KeywordIndex < AND_ArmorBottom_Keywords.Length && SlotUnequipped == False
						If KeywordIndex == 2 ;Skip NoCover Bottom
							KeywordIndex = 3
						endIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endif
						
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					While KeywordIndex < AND_Underwear_Keywords.Length && SlotUnequipped == False
						If KeywordIndex == 2 ;Skip NoCover Underwear
							KeywordIndex = 3
						elseIf KeywordIndex == 5 ;Skip NoCover Thong
							KeywordIndex = 6
						endIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Underwear_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 2 ;Set to 2 so that ChestCurtain Keywords are skipped in the next while loop, but the rest of the array can be checked
					
					While KeywordIndex < 8 && SlotUnequipped == False ;Microskirt is skipped
						If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					if AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					While KeywordIndex < AND_Baka_Keywords.Length && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false
						If KeywordIndex == 1
							KeywordIndex = 2 ;Skip Bra
						ElseIf KeywordIndex == 6
							KeywordIndex = 7 ;Skip ArmorTop
						ElseIf KeywordIndex == 14
							KeywordIndex = 16 ;Skip PastiesCrotch & PastiesNipple
						EndIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = true
						endIf
						KeywordIndex += 1
					endWhile
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					KeywordIndex = 0
					SlotIndex += 1
					SlotUnequipped == False
				endWhile
			elseif requireGenitals == true && requireAss == false
				While SlotIndex < AND_Slots.Length
					While KeywordIndex < 5 && SlotUnequipped == False ;Skip ShowgirlSkirts since Ass is not required
						If KeywordIndex == 2 ;Skip NoCover Bottom
							KeywordIndex = 3
						endIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endif
						
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					While KeywordIndex < AND_Underwear_Keywords.Length && SlotUnequipped == False
						If KeywordIndex == 2 ;Skip NoCover Underwear
							KeywordIndex = 3
						elseIf KeywordIndex == 5 ;Skip NoCover Thong
							KeywordIndex = 6
						endIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Underwear_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 4 ;Since showing ass is not required, skip Chest and Ass Curtains in array
					
					While KeywordIndex < 8 && SlotUnequipped == False ;Microskirt is skipped
						If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[KeywordIndex]) 
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					if AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					While KeywordIndex < 17 && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false ;Skip ShowgirlSkirt since ass is not required
						If KeywordIndex == 1
							KeywordIndex = 2 ;Skip Bra
						ElseIf KeywordIndex == 6
							KeywordIndex = 7 ;Skip ArmorTop
						ElseIf KeywordIndex == 14
							KeywordIndex = 16 ;Skip PastiesCrotch & PastiesNipple
						EndIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = true
						endIf
						KeywordIndex += 1
					endWhile
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					KeywordIndex = 0
					SlotIndex += 1
					SlotUnequipped == False
				endWhile
			elseif requireGenitals == false && requireAss == true
				While SlotIndex < AND_Slots.Length
					While KeywordIndex < AND_ArmorBottom_Keywords.Length && SlotUnequipped == False
						If KeywordIndex == 2 ;Skip NoCover Bottom and both versions of Hotpants
							KeywordIndex = 5
						endIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endif
						
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					While KeywordIndex < 2 && SlotUnequipped == False ;Only check normal underwear, except NoCover version. Thongs and CStrings reveal ass, therefore they don't need to be unequipped
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Underwear_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 2
					
					While KeywordIndex < 8 && SlotUnequipped == False ;Microskirt is skipped
						If KeywordIndex == 4
							KeywordIndex = 6 ;Skip PelvicCurtain since Genitals are not required
						endIf
						If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[KeywordIndex]) 
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					if AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					While KeywordIndex < AND_Baka_Keywords.Length && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false
						If KeywordIndex < 7
							KeywordIndex = 7 ;Check ArmorBottom & FullSkirt
						ElseIf KeywordIndex < 11 && KeywordIndex != 8
							KeywordIndex = 11 ;Check PantsNormal
						ElseIf KeywordIndex < 17
							KeywordIndex = 17 ;Check ShowgirlSkirt
						EndIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = true
						endIf
						KeywordIndex += 1
					endWhile
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					KeywordIndex = 0
					SlotIndex += 1
					SlotUnequipped == False
				endWhile
			elseIf requireUnderwear == true
				While SlotIndex < AND_Slots.Length
					If AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[0]) || AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[1])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					KeywordIndex = 3 ;Skip NoCover bottom
					
					;Only check the remaining keywords if both Hotpants and Showgirl Skirt are equipped, which hides underwear.
					If (player.WornHasKeyword(AND_ArmorBottom_Keywords[3]) || player.WornHasKeyword(AND_ArmorBottom_Keywords[4]))\ 
					&& (player.WornHasKeyword(AND_ArmorBottom_Keywords[5]) || player.WornHasKeyword(AND_ArmorBottom_Keywords[6]))
						While KeywordIndex < AND_ArmorBottom_Keywords.Length && SlotUnequipped == False
							If AND_Slots[SlotIndex].HasKeyword(AND_ArmorBottom_Keywords[KeywordIndex])
								player.UnequipItem(AND_Slots[SlotIndex])
								SlotUnequipped = True
							endIf
							KeywordIndex += 1
						endWhile
					endIf
					
					KeywordIndex = 2 ;Skip Chest Curtains
					
					While KeywordIndex < AND_Curtain_Keywords.Length && SlotUnequipped == False
						If AND_Slots[SlotIndex].HasKeyword(AND_Curtain_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = True
						endIf
						KeywordIndex += 1
					endWhile
					
					KeywordIndex = 0
					
					if AND_Slots[SlotIndex].HasKeyword(AND_Other_Keywords[3])
						player.UnequipItem(AND_Slots[SlotIndex])
						SlotUnequipped = True
					endIf
					
					While KeywordIndex < AND_Baka_Keywords.Length && AND_Config.IgnoreBakaKeywords == False && SlotUnequipped == false
						If KeywordIndex < 7
							KeywordIndex = 7 ;Check ArmorBottom & FullSkirt
						ElseIf KeywordIndex < 11 && KeywordIndex != 8
							KeywordIndex = 11 ;Check PantsNormal
						ElseIf KeywordIndex < AND_Baka_Keywords.Length
							KeywordIndex = AND_Baka_Keywords.Length
						EndIf
						
						If AND_Slots[SlotIndex].HasKeyword(AND_Baka_Keywords[KeywordIndex])
							player.UnequipItem(AND_Slots[SlotIndex])
							SlotUnequipped = true
						endIf
						KeywordIndex += 1
					endWhile
					
					If SlotUnequipped == false && SlotIndex == 1
						player.UnequipItem(AND_Slots[SlotIndex]) ;If we have not unequipped an item and it is in Slot32, assume vanilla and strip it.
					endIf
					
					SlotIndex += 1
					SlotUnequipped == False
				endWhile
			endIf
		endIf
	endIf
	
	if(!weaponsAllowed && isPlayerArmed)
		player.UnequipItem(equippedWeapon)
	endIf
	
	return
endEvent

function collarPlayer()
;Calls for the PW DD script to attach a random generic collar to the player. Completely safe to call even if DD isn't installed/enabled,
;because it will only actually do anything if DD is installed AND enabled, and furthermore PW_DD is a global-only script

	if(Mods.usingDD && Mods.isDDInstalled)
		PW_DD.collarPlayer()
	endIf
endFunction

function addRuleExemption(int choice)
	if(choice == 4)
		return
	endIf
	
	if(numExemptEquipment == exemptEquipment.Length)
		Debug.MessageBox("You have already allocated the maximum amount of rule-exempt equipment. Remove some before adding more.")
		return
	endIf 
	
	armor[] playerArmor = new armor[4]
	playerArmor[0] = headSlotItem
	playerArmor[1] = bodySlotItem
	playerArmor[2] = handsSlotItem
	playerArmor[3] = feetSlotItem
	
	if(playerArmor[choice] != none)
		exemptEquipment[numExemptEquipment] = playerArmor[choice]
		Debug.MessageBox(playerArmor[choice].GetName() + " is now rule-exempt!")
		numExemptEquipment += 1
		
		if(choice == 0)
			headSlotExempt = true
		elseIf(choice == 1)
			bodySlotExempt = true
		elseIf(choice == 2)
			handsSlotExempt = true
		elseIf(choice == 3)
			feetSlotExempt = true
		endIf
		
	else
		Debug.MessageBox("No item equipped in that slot. If you have such an item equipped, it likely uses a different slot that isn't tracked anyway.")
	endIf
	
	return
endFunction


form[] function stealItems(int numOfItems)
	form[] stolen = new form[15]
	int index = 0
	while index < numOfItems
		int invIndex = player.GetNumItems()
		while invIndex > 0
			Form item = player.GetNthForm(invIndex)
			if(item.GetGoldValue() >= stealMinValue && item.GetGoldValue() <= stealMaxValue && !item.HasKeyWordString("zad_InventoryDevice"))
				player.RemoveItem(item, 1, false, stolenItemChest)
				if(index <= 15)
					stolen[index] = item
				endIf
				invIndex = 0	;break loop
			endIf
			invIndex -= 1
		endWhile
		index += 1
	endWhile
	stolenItemsSize = numOfItems
	stolenItems = stolen

	return stolen
endFunction

function easyStealItems(actor thief)
	stealItems(Utility.RandomInt(stealMinItems, stealMaxItems))
	
	if(stolenItems.Length == 0)
		Debug.MessageBox(thief.GetLeveledActorBase().GetName() + " bumps into you and searches your body, not finding anything they want to take and pushing you out of the way in disgust.")
		return
	endIf 
	
	string messageString = thief.GetLeveledActorBase().GetName() + " bumps into you hard. While you're recovering, they take the following from your inventory:"
	
	int index = 0
	while(index < stolenItems.Length && stolenItems[index] != none)
		if(index == stolenItems.Length - 1)
			messageString = messageString + " " + stolenItems[index].GetName()
		else
			messageString = messageString + " " + stolenItems[index].GetName() + ","
		endIf
		index += 1
	endWhile

	LastThief.Clear()
	LastThief.ForceRefTo(thief)
	Debug.MessageBox(messageString)
	return
endFunction

function returnStolenItems()
	int index = 0
	while (index < stolenItemsSize)
		player.AddItem(stolenItems[index], 1)
		index += 1
	endWhile
	LastThief.Clear()
endFunction

function ReturnAllStolenItems()
	stolenItemChest.RemoveAllItems(player)
	sideQuestItemChest.RemoveAllItems(player)
endfunction

;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| STATE FUNCTIONS|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

function setState(int stateNum)
;Sets the loop state and starts the timer for this state. This could do with a rewrite, it's kind of janky
	
	pwDebug(self, 2, "PW: State set to: " + stateNum)
	if(stateNum >= 0 && stateNum <= 3)	;Because theoretically an incorrect state could be passed
		LoopState = stateNum
		if(stateNum == 1 || stateNum == 3)
			;Approach period and cooldown are measured in in-game minutes
			stateStartTime = Utility.GetCurrentGameTime()
			if(approachAlias.GetActorRef() != none)
				approachAlias.clear()
			endIf
		else
			;Approach Timeout is in real seconds
			stateStartTime = Utility.GetCurrentRealTime()
		endIf
	endIf
	
	approachRunning = false
	return

endFunction

string function debugState()
	if(LoopState == 0)
		return "Inactive"
	elseIf(LoopState == 1)
		return "Ready"
	elseIf(LoopState == 2)
		return "Being Approached"
	elseIf(LoopState == 3)
		return "Cooldown"
	else
		return "Unknown State: " + LoopState
	endIf
		
endFunction



function messageBoxStory(string story, actor otherActor = none, bool ftb = true)
	int playerSex = Game.GetPlayer().GetLeveledActorBase().GetSex()
	int otherActorSex = otherActor.GetLeveledActorBase().GetSex()
	string otherActorName = otherActor.GetLeveledActorBase().GetName()
	
	if(ftb)
		FadeToBlack.Apply()
	endIf
	
	if(story == "sadisticThiefBeatDown")
		if(otherActorSex == 0 && playerSex == 1)
			Utility.Wait(1.0)
			Debug.MessageBox(otherActorName + " slaps you hard across the face, and then backhands you the otherway, and slaps again and again. He grabs you by the neck and forces you onto your knees, bringing his own knee into your gut and knocking the wind out of you.")
			Utility.Wait(0.5)
			Debug.MessageBox("He then kicks you between the legs, making you start to double over in pain before he grabs you by the hair and jerks you back up to your feet. You receive another slap across the face, and then a brutally hard slap on your tit, which makes you scream and is likely to leave a mark.")
			Utility.Wait(5.0)
			Debug.MessageBox("Wrenching you by the hair he bends you over and begins to spank you repeatedly, each spank leaving a sting on your ass, and causing your tits to bounce unceremoniously from the impact, to the amusement of some newly-arrived spectators.")
			Utility.Wait(0.5)
			Debug.MessageBox("Throwing you hard into the ground, he begins to kick you - in the stomach, but also in the breasts, thighs and butt. Tears have welled up in your eyes, and instinctually try to deflect the blows, to no avail. After a few minutes he finally stops.")
		endIf
	endIf
	
	FadeToBlack.Remove()
	
endFunction
