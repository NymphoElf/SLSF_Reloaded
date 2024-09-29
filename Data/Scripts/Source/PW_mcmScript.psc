Scriptname PW_mcmScript extends SKI_ConfigBase

PW_MainLoopScript property Main Auto
PW_TrackerScript property Tracker Auto
PW_IntroDetectionScript property Intro Auto
PW_ModIntegrationsScript property Mods Auto
PW_PunishmentScript property Punish Auto
PW_Utility property pwUtil Auto
PW_FameScript property Fame Auto
PW_CommentsScript property Comments Auto
PW_QuotaManagerScript property QuotaMgr Auto
PW_ActorManagerScript property actorMgr Auto
PW_ComponentManagerScript property componentManager Auto
PW_SexQueueScript property sexQueue Auto
PW_Constants property constants Auto

Spell property PW_DebuffSpell Auto
ImageSpaceModifier property FadeToBlack Auto
GlobalVariable property playerGenderPref Auto
GlobalVariable property PW_PlayerCanBeDominantWithGender Auto

GlobalVariable property PW_ApproachVaginalChance Auto
GlobalVariable property PW_ApproachBlowjobChance Auto
GlobalVariable property PW_ApproachAnalChance Auto

;STARTUP AND QUOTAS 
int startInEnforcedModeIndex
int eligibilityTimeoutPeriodIndex
int slaveryLockoutIndex

int guardFGCooldownIndex
int introHandlingModeIndex
int introHandlingBountyIndex

;NPC APPROACH INDICES
	;Main
int modEnabledIndex
int scanPeriodIndex
int approachChanceIndex
int approachTimeoutIndex
int approachRadiusIndex
int canGuardsApproachIndex
int canEldersApproachIndex
int canFollowersApproachIndex
int canSlavesApproachIndex

int approachVaginalChanceIndex
int approachBlowjobChanceIndex
int approachAnalChanceIndex
int canFemalesRequestBlowjobsIndex

int difficultClientChanceIndex

int sadisticClientChanceIndex

int canPlayerSolicitIndex
int declineSexChanceIndex

int notPayingChanceIndex
int stealingEnabledIndex
int stealValueIndex
int stealMinValueIndex
int stealMaxValueIndex
int stealMaxItemsIndex
int stealMinItemsIndex

int swarmChanceIndex
int swarmMaxIndex
;int swarmLOSReqIndex


;MISCELLANEOUS
int commentsEnabledIndex
int offDutyApproachChanceIndex
int showRandomEventDescsIndex
bool showRandomEventDescs = false
int randomEventChanceIndex
int randomEventTutorialIndex
int[] randomEventWeightsIndex

int showRuleExemptIndex
int ruleExemptEquipmentIndex
int removeRuleExemptIndex
Message property PW_ExemptEquipmentSelector Auto

int basePayIndex
int payPerLevelIndex

int tippingEnabledIndex
int tipMinMultIndex
int tipMaxMultIndex
int megaTipChanceIndex
int megaTipMultIndex

int playerHandlesGoldIndex
int missingReportChanceIndex

int overtimeCutIndex
int standardCutIndex

int nudityLevelIndex
int weaponsAllowedIndex

int restraintsRemovalEnabledIndex

int enforcedModeQuotaMultIndex
int enforcedModeInventoryTakenIndex
int enforcedModeHeavierRestraintsIndex


;QUOTA CONFIG INDICES
int quotaModeIndex
int daysLeftIndex
int minClientQuotaIndex
int maxClientQuotaIndex
int minGoldQuotaIndex
int maxGoldQuotaIndex
int reportingPeriodIndex
int cantLeaveIndex

int nghExpectedGoldIndex
int nghExpectedClientsIndex

;STARTUP INDICES
int fameStartEnabledIndex
int heroFameStartEnabledIndex
int storyStartEnabledIndex

int allHoldsIndex

;MOD TOGGLE INDICES
int usingDDIndex
int usingSLSFIndex
int usingSlaveTatsIndex
;int usingZaZIndex
int usingSLTRIndex

int[] ssCityEnabledIndices

;MISC 
int tattooModeIndex

;FAME
int fameLocSelectorIndex

;HERO 
int HFtotalIndex
int HFthresholdIndex
int HFdragonbornIndex
int HFpointsPerTitleIndex
int HFdragonKillIndex
int HFquestCompleteIndex
int isPlayerThaneIndex

;SLSF
int SLSFThresholdIndex
int slsfTotalIndex
int bestialityFameIndex
int exhibitionistFameIndex
int nastyFameIndex
int slutFameIndex
int submissiveFameIndex
int whoreFameIndex

;BUILT-IN
int includeSLSFValuesIndex
int sexFameThresholdIndex
int fameTotalIndex
int promiscuityMultiplierIndex
int modestyPeriodIndex
int modestyMultiplierIndex

;STATUS TRACKING INDICES
int currStatusLocSelectorIndex
int currentLocStatusIndex
int currentEligibilityTimeoutIndex
int[] pwCityStatusIndices
int currentQuotaIndex
int cumulativeClientsIndex
int cumulativeGoldIndex
int overtimeClientsIndex
int recentClientsIndex
int expectedGoldIndex

;PUNISHMENT INDICES
int punishmentScoreIndex
int punishmentThresholdsIndex
int[] thresholdConfigIndex
int[] sceneToggleIndex

int scoreDeclineSexIndex
int scoreBreakRuleIndex
int scoreFailQuotaIndex
int scoreAcceptSexIndex

int thresholdServiceExtension
int thresholdPublicRape
int thresholdLightTorture
int thresholdHeavyTorture
int thresholdExecution

int thresholdEnforcedMode
int fakeExecutionChanceIndex
int debuffsEnabledIndex

;MENU LABEL STRING ARRAYS
string[] quotaModes
string[] installedStatus
string[] pwStatus
string[] tattooModes
string[] dueStatus
string[] genderPrefs
string[] genderDominantPrefs
string[] nudityLevels
string[] cityNames
string[] introHandlingModes

;CONTENT PREFERENCES
int playerGenderPrefIndex
int playerDominantPrefIndex
int executionEnabledIndex
int beastialityEnabledIndex

;DEBUG INDICES
int updatePeriodIndex

int removeItemsIndex
int returnItemsIndex
int returnStolenItemsIndex

int[] debugSceneStartIndices

int debugAdd100PunishmentScore
int debugAdd1000PunishmentScore
int debugTriggerIndex2
int debugTriggerIndex3
int debugTriggerIndex4
int changeDebuffLevelIndex

int debugEnforcedModeTriggerIndex
int debugClearEnforcedModeTriggerIndex

int debugStopSceneIndex
int debugStopQueueIndex
int debugDHLPResumeIndex

int debugMakeEligible
int debugMakeWhore
int debugClearStatus
int debugClearEligibilityCooldown

int debugMessagesIndex

int debugRemoveFtbIndex

int debugPrintJarlsIndex
int debugPrintThaneStatusIndex

int debugSimulateClientIndex
int debugSimulateClientUnpaidIndex

int[] debugStartRandomEventIndices

int debugPowerScanIndex
int debugGetValidApproacherIndex
int debugPrintValidApproacherReportIndex

int debugTestSexQueueQueueingIndex
int debugTestSexQueueRunningIndex
int debugTestSexQueueAutomaticIndex

int debugTestFameGainLossIndex

GlobalVariable property PW_BooleanTippingEnabled Auto
GlobalVariable property PW_CharmMegaTipChance Auto
GlobalVariable property PW_CharmMegaTipMult Auto
GlobalVariable property PW_CharmTipMaxMult Auto
GlobalVariable property PW_CharmTipMinMult Auto


ObjectReference property PW_ItemHolder Auto
GlobalVariable property PW_DifficultClientChance Auto
GlobalVariable property PW_SadisticClientchance Auto

GlobalVariable property PW_SelectedIntroHandlingMode Auto
GlobalVariable property PW_BountyForRefusalToSeeThane Auto

bool testToolsDisplayed = false
int testToolsDisplayedIndex

int mcmLockoutIndex

bool mcmLockoutEnabled = false

Quest devQuest

;===Advanced Nudity Variables===
Int requireNudeIndex
Int requireToplessIndex
Int requireChestIndex
Int requireBraIndex
Int requireBottomlessIndex
Int requireGenitalsIndex
Int requireAssIndex
Int requireUnderwearIndex

event OnInit()
	parent.OnInit()
	
	;Determine if in dev environment
	devQuest = Quest.GetQuest("PW_DevQuest")
	if(devQuest != none)
		testToolsDisplayed = true
	endIf
	
	quotaModes = new string[3]
	quotaModes[0] = "Clients"
	quotaModes[1] = "Money"
	quotaModes[2] = "Endless"

	installedStatus = new string[2]
	installedStatus[0] = "Not Installed"
	installedStatus[1] = "Installed"

	pwStatus = new string[3]
	pwStatus[0] = "Ineligible"
	pwStatus[1] = "Eligible"
	pwStatus[2] = "City Whore"
	
	tattooModes = new string[2]
	tattooModes[0] = "Hold Symbols"
	tattooModes[1] = "Labels"
	
	randomEventWeightsIndex = Utility.createIntArray(main.numRandomEvents, 0)

	thresholdConfigIndex = new int[6]
	sceneToggleIndex = new int[6]

	dueStatus = new string[2]
	dueStatus[0] = "Not Due"
	dueStatus[1] = "Due"

	genderPrefs = new string[3]
	genderPrefs[0] = "Male"
	genderPrefs[1] = "Female"
	genderPrefs[2] = "Both"
	
	
	genderDominantPrefs = new string[4]
	genderDominantPrefs[0] = "Males"
	genderDominantPrefs[1] = "Females"
	genderDominantPrefs[2] = "Anyone"
	genderDominantPrefs[3] = "Nobody"
	
	cityNames = new string[9]
	cityNames[0] = "Dawnstar"
	cityNames[1] = "Falkreath"
	cityNames[2] = "Markarth"
	cityNames[3] = "Morthal"
	cityNames[4] = "Riften"
	cityNames[5] = "Solitude"
	cityNames[6] = "Whiterun"
	cityNames[7] = "Windhelm"
	cityNames[8] = "Winterhold"
	
	introHandlingModes = new string[4]
	introHandlingModes[0] = "Walk away"
	introHandlingModes[1] = "Bounty"
	introHandlingModes[2] = "Bounty + Attack"
	introHandlingModes[3] = "Made PW Anyway"
	
	ssCityEnabledIndices = new int[9]
	
	debugSceneStartIndices = Utility.createIntArray(Punish.punishmentTypes + 1, 0)
	
	debugStartRandomEventIndices = Utility.createIntArray(main.numRandomEvents, 0)
endEvent

event OnConfigInit()
	
	if(!mcmLockoutEnabled || !Tracker.isWhoreAnywhere)
		Pages = new string[11]
		Pages[0]  = "Current Status and Quotas"
		Pages[1]  = "Quota and Payment Settings"
		Pages[2]  = "On-duty Settings"
		Pages[3]  = "Startup Settings"
		Pages[4]  = "Fame Settings"
		Pages[5]  = "Punishment Settings"
		Pages[6]  = "Miscellaneous"
		Pages[7]  = "Mod Integrations"
		Pages[8]  = "Content Preferences"
		Pages[9]  = "Debug and Control"
		Pages[10] = "Credits"
	else
		Pages = new string[1]
		Pages[0] = "MCM Locked"
	endIf

endEvent

Event OnConfigOpen()
	If Mods.isANDInstalled == true
		nudityLevels = new string[4]
		nudityLevels[0] = "None Required"
		nudityLevels[1] = "Partial"
		nudityLevels[2] = "Full"
		nudityLevels[3] = "Use A.N.D."
	else
		nudityLevels = new string[3]
		nudityLevels[0] = "None Required"
		nudityLevels[1] = "Partial"
		nudityLevels[2] = "Full"
	endIf
endEvent

event OnPageReset(string page) ;Called whenever a new page is selected, and used to determine what page was selected and render it

	int currentLocIndex = Tracker.currentLocIndex
	int lastLocIndex = Tracker.lastLocIndex
	
	;Default these to something, anything. There are no functional rammifications for what, but it prevents errors
	if(lastLocIndex < 0 || lastLocIndex > 8)
		lastLocIndex = 6
	endIf
	
	if (currentLocIndex < 0 || currentLocIndex > 8)
		currentLocIndex = lastLocIndex
	endIf
	
	if(page == "MCM Locked")
		AddTextOption("MCM locked while you are a public whore", "")
	elseIf(page == "Current Status and Quotas")
	;TRACKER 
	;QUOTA 
	;PUNISH 
		SetCursorFillMode(LEFT_TO_RIGHT)
		currStatusLocSelectorIndex = AddMenuOption("Viewing: ", cityNames[lastLocIndex])
		if(Tracker.GetStatus(lastLocIndex) == 0 && Fame.eligibilityTimeoutDays[lastLocIndex] > 0)
			currentLocStatusIndex = AddTextOption("Status", pwStatus[Tracker.GetStatus(lastLocIndex)] + " for " + Fame.eligibilityTimeoutDays[lastLocIndex] + " days")
		else
			currentLocStatusIndex = AddTextOption("Status", pwStatus[Tracker.GetStatus(lastLocIndex)])
		endIf
		
		AddEmptyOption()
		AddEmptyOption()

		SetCursorFillMode(TOP_TO_BOTTOM)
		
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("Current Progress")
		daysLeftIndex = AddHeaderOption(QuotaMgr.getQuotaPeriodString(lastLocIndex) + " left")
		if(!QuotaMgr.playerHandlesGold)
			if(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_CLIENTS || QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_ENDLESS)
				;Top progress row
				nghExpectedClientsIndex = AddTextOption("Pending Report", QuotaMgr.nghExpectedClients[lastLocIndex] + " clients")
				cumulativeClientsIndex = AddTextOption("Reported Progress", QuotaMgr.cumulativeClients[lastLocIndex] + " clients")
				
				if(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_CLIENTS)
					;Bottom quota row - don't display in Endless
					AddEmptyOption()
					currentQuotaIndex = AddTextOption("Quota", (QuotaMgr.clientQuotas[lastLocIndex] as string) + " clients")
				endIf
				
				AddEmptyOption()
				expectedGoldIndex = AddTextOption("Expected Progress", (QuotaMgr.nghExpectedGold[lastLocIndex] as string) + " gold")
			elseIf(QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_GOLD)
				nghExpectedGoldIndex = AddTextOption("Pending Report",    (QuotaMgr.nghExpectedGold[lastLocIndex] as string)+ " gold")
				cumulativeGoldIndex  = AddTextOption("Reported Progress", (QuotaMgr.cumulativeGold[lastLocIndex] as string) + " gold")
				AddEmptyOption()
				currentQuotaIndex = AddTextOption("Quota", (QuotaMgr.goldQuotas[lastLocIndex] as string) + " gold")
			endIf
		elseIf(QuotaMgr.quotaMode == quotaMgr.QUOTA_MODE_CLIENTS || QuotaMgr.quotaMode == QuotaMgr.QUOTA_MODE_ENDLESS)
			recentClientsIndex = AddTextOption("Unreported Progress", (QuotaMgr.recentClients[lastLocIndex] as string) + " clients")
			cumulativeClientsIndex = AddTextOption("Reported Progress", (QuotaMgr.cumulativeClients[lastLocIndex] as string) + " clients")

			if(QuotaMgr.overtimeClients[lastLocIndex] >= 1)
				overtimeClientsIndex = AddTextOption("Overtime", (QuotaMgr.overtimeClients[lastLocIndex] as string) + " clients")
			else
				AddEmptyOption()
			endIf
			
			currentQuotaIndex = AddTextOption("Quota", (QuotaMgr.clientQuotas[lastLocIndex] as string) + " clients")
			
			AddEmptyOption()
			
			int expectedAmount = QuotaMgr.calculatePay() * QuotaMgr.recentClients[lastLocIndex]
			expectedGoldIndex = AddTextOption("Expected Turn-in", expectedAmount)
			
		elseIf(QuotaMgr.quotaMode == quotaMgr.QUOTA_MODE_GOLD)
			cumulativeGoldIndex = AddTextOption("Turned In", (QuotaMgr.cumulativeGold[lastLocIndex] as string) + " gold")
			currentQuotaIndex = AddTextOption("Quota", (QuotaMgr.goldQuotas[lastLocIndex] as string) + " gold")
			AddEmptyOption()
			AddEmptyOption()
			
		endIf
		
		
		

		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Punishment Status")
		punishmentScoreIndex = AddTextOption("Punishment Score", Punish.punishmentScores[lastLocIndex])
		
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("Next Punishments")
		AddTextOption("Alert Level", Punish.alertLevel[lastLocIndex])
		thresholdServiceExtension = AddTextOption("Service Extension", "at " + Punish.getNextThreshold(lastLocIndex, 1))
		AddTextOption("", dueStatus[Punish.getFlag(lastLocIndex, 1) as int])
		thresholdPublicRape = AddTextOption("Public Rape", "at " + Punish.getNextThreshold(lastLocIndex, 2))
		AddTextOption("", dueStatus[Punish.getFlag(lastLocIndex, 2) as int])
		thresholdLightTorture = AddTextOption("Light Torture", "at " + Punish.getNextThreshold(lastLocIndex, 3))
		AddTextOption("", dueStatus[Punish.getFlag(lastLocIndex, 3) as int])
		thresholdHeavyTorture = AddTextOption("Heavy Torture", "at " + Punish.getNextThreshold(lastLocIndex, 4))
		AddTextOption("", dueStatus[Punish.getFlag(lastLocIndex, 4) as int])
		thresholdExecution = AddTextOption("Execution", "at " + Punish.getNextThreshold(lastLocIndex, 5))
		AddTextOption("", dueStatus[Punish.getFlag(lastLocIndex, 5) as int])
		
	elseIf(page == "Startup Settings")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Startup Settings")
		fameStartEnabledIndex = AddToggleOption("Sexual Fame Start", Fame.fameStartEnabled)
		heroFameStartEnabledIndex = AddToggleOption("Hero Fame Start", Fame.usingHeroFame)
		slaveryLockoutIndex = AddToggleOption("SD+ Fame Start Lockout", Fame.eligibilitySlaveryLockout)
		eligibilityTimeoutPeriodIndex = AddSliderOption("Fame Eligibility Timeout", Fame.eligibilityTimeoutPeriod, "{0} days")
		storyStartEnabledIndex = AddToggleOption("Story Start", Intro.storyStartEnabled)
		startInEnforcedModeIndex = AddToggleOption("Start in enforced mode", Tracker.startInEnforcedMode)
		
		SetCursorPosition(1)
		AddHeaderOption("Guard Approaches")
		introHandlingModeIndex = AddMenuOption("Consequence for refusal", introHandlingModes[PW_SelectedIntroHandlingMode.GetValue() as int])
		introHandlingBountyIndex = AddSliderOption("Bounty for refusal", PW_BountyForRefusalToSeeThane.GetValue() as int, "{0}")
		guardFGCooldownIndex = AddSliderOption("Guard Greet Cooldown", intro.guardInformReset, "{3} days")
		
	elseIf(page == "Quota and Payment Settings")
	;QUOTA 
	;TRACKER
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Quota Settings")
		quotaModeIndex = AddMenuOption("Quota Mode", quotaModes[QuotaMgr.quotaMode])
		minClientQuotaIndex = AddSliderOption("Min Client Quota", QuotaMgr.minClientQuota, "{0} clients")
		maxClientQuotaIndex = AddSliderOption("Max Client Quota", QuotaMgr.maxClientQuota, "{0} clients")
		minGoldQuotaIndex = AddSliderOption("Min Gold Quota", QuotaMgr.minGoldQuota, "{0} gold")
		maxGoldQuotaIndex = AddSliderOption("Max Gold Quota", QuotaMgr.maxGoldQuota, "{0} gold")
		reportingPeriodIndex = AddSliderOption("Duration", QuotaMgr.reportingPeriod, "{0} days")
		cantLeaveIndex = AddToggleOption("Can't leave until done", Tracker.cantLeave)

		SetCursorPosition(1)
		
		AddHeaderOption("Payment Settings")
		basePayIndex = AddSliderOption("Base Gold", QuotaMgr.basePay, "{0}")
		payPerLevelIndex = AddSliderOption("Gold Per Level", QuotaMgr.payPerLevel, "{0}")
		playerHandlesGoldIndex = AddToggleOption("Player handles gold", QuotaMgr.playerHandlesGold)
		missingReportChanceIndex = AddSliderOption("  Chance NPCs don't pay later", QuotaMgr.missingReportChance, "{0}%", disabledIfFalse(!QuotaMgr.playerHandlesGold))
		standardCutIndex = AddSliderOption("Player's cut", QuotaMgr.standardCut, "{0}%")
		overtimeCutIndex = AddSliderOption("Overtime cut", QuotaMgr.overtimeCut, "{0}%")
		
		AddHeaderOption("Charm Settings")
		tippingEnabledIndex = AddToggleOption("Charm options provide additional gold", PW_BooleanTippingEnabled.GetValue() as bool)
		tipMinMultIndex = AddSliderOption("Minimum tip (multiplied against pay)", PW_CharmTipMinMult.GetValue(), "{1}")
		tipMaxMultIndex = AddSliderOption("Maximum tip (multiplied against pay)", PW_CharmTipMaxMult.GetValue(), "{1}")
		megaTipChanceIndex = AddSliderOption("Mega-tip chance", PW_CharmMegaTipChance.GetValue(), "{0}%")
		megaTipMultIndex = AddSliderOption("Mega-tip tip multiplier", PW_CharmMegaTipMult.GetValue())
		
		
	elseIf(page == "On-duty Settings")
	;MAIN
	;PUNISH
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("NPC Approaches")
		scanPeriodIndex = AddSliderOption("NPC Approach Interval", Main.scanPeriod, "{0} game minutes")
		approachChanceIndex = AddSliderOption("Approach Chance", Main.approachChance, "{0}%")
		approachTimeoutIndex = AddSliderOption("Approach Timeout", Main.approachTimeout, "{0} seconds")
		approachRadiusIndex = AddSliderOption("NPC Distance", actorMgr.approachRadius, "{0}")
		canGuardsApproachIndex = AddToggleOption("Approaches From Guards", actorMgr.canGuardsApproach)
		canEldersApproachIndex = AddToggleOption("Approaches From Elders", actorMgr.canEldersApproach)
		canFollowersApproachIndex = AddToggleOption("Approaches From Followers", actorMgr.canFollowersApproach)
		canSlavesApproachIndex = AddToggleOption("Approaches From Slaves", actorMgr.canSlavesApproach)
		
		AddHeaderOption("Approacher Requests")
		approachVaginalChanceIndex = AddSliderOption("Vaginal", PW_ApproachVaginalChance.GetValue(),"{0}%")
		approachBlowjobChanceIndex = AddSliderOption("Blowjob", PW_ApproachBlowjobChance.GetValue(),"{0}%")
		approachAnalChanceIndex = AddSliderOption("Anal", PW_ApproachAnalChance.GetValue(), "{0}%")
		
		canFemalesRequestBlowjobsIndex = AddToggleOption("Women can ask for blowjobs", main.femalesCanRequestBlowjobs)
		
		AddHeaderOption("Player Offering Sex")
		canPlayerSolicitIndex = AddToggleOption("Player can offer sex", Main.canPlayerSolicit)
		declineSexChanceIndex = AddSliderOption("Chance to Decline", Main.SolicitFailChance.GetValue() as int, "{0}%")
		
		AddHeaderOption("Rules")
		weaponsAllowedIndex = AddToggleOption("Allowed to hold weapons", Main.weaponsAllowed)
		restraintsRemovalEnabledIndex = AddToggleOption("Restraints Removed After", Main.restraintsRemovalEnabled)
		nudityLevelIndex = AddMenuOption("Nudity Required", nudityLevels[Main.nudityLevel])
		AddEmptyOption()
		showRuleExemptIndex = AddToggleOption("List Current Exempt Equipment (click)", false)
		ruleExemptEquipmentIndex = AddToggleOption("Make Equipment Exempt (click)", false)
		removeRuleExemptIndex = AddMenuOption("Clear Current Exempt Equipment (click)", false)
		
		
		SetCursorPosition(1)	;The top-right
		
		AddHeaderOption("Queues")
		swarmChanceIndex = AddSliderOption("Chance for queue to form", main.swarmChance, "{0}%")
		swarmMaxIndex = AddSliderOption("Maximum NPCs that will join", main.swarmMax, "{0}")
		;swarmLOSReqIndex = AddSliderOption("Require NPCs with LOS", main.swarmLOSRequired, "{0}")

		AddHeaderOption("Enforced Mode")
		enforcedModeQuotaMultIndex = AddSliderOption("Quota Multiplier", quotaMgr.enforcedModeQuotaMult, "{1}x")
		enforcedModeInventoryTakenIndex = AddToggleOption("Inventory Taken", Punish.enforcedModeInventoryTaken)
		enforcedModeHeavierRestraintsIndex = AddToggleOption("Heavier Restraints", Punish.enforcedModeHeavierRestraints)
		
		mcmLockoutIndex = AddToggleOption("Lock MCM while public whore", mcmLockoutEnabled)
		If main.nudityLevel == 3
			AddHeaderOption("Advanced Nudity Settings")
			requireNudeIndex = AddToggleOption("Require Nudity", main.requireNude)
			requireToplessIndex = AddToggleOption("Require Topless", main.requireTopless, disabledIfFalse(main.requireNude == False))
			requireChestIndex = AddToggleOption("Require Showing Chest", main.requireChest, disabledIfFalse(main.requireNude == False && main.requireTopless == False))
			requireBraIndex = AddToggleOption("Require Showing Bra", main.requireBra, disabledIfFalse(main.requireNude == False && main.requireTopless == False && main.requireChest == False))
			requireBottomlessIndex = AddToggleOption("Require Bottomless", main.requireBottomless, disabledIfFalse(main.requireNude == False))
			requireGenitalsIndex = AddToggleOption("Require Showing Genitals", main.requireGenitals, disabledIfFalse(main.requireNude == False && main.requireBottomless == False))
			requireAssIndex = AddToggleOption("Require Showing Ass", main.requireAss, disabledIfFalse(main.requireNude == False && main.requireBottomless == False))
			requireUnderwearIndex = AddToggleOption("Require Showing Underwear", main.requireUnderwear, disabledIfFalse(main.requireNude == False && main.requireBottomless == False && main.requireGenitals == False && main.requireAss == False))
		endIf
	
	elseIf(page == "Miscellaneous")
	;MAIN 
	;MODS
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("General")
		commentsEnabledIndex = AddToggleOption("NPC Comments", Comments.commentsEnabled)
		offDutyApproachChanceIndex = AddSliderOption("Off-duty Approach Chance", Main.offDutyApproachChance, "{0}%")
		tattooModeIndex = AddMenuOption("SlaveTat Type", tattooModes[Mods.tattooMode], disabledIfFalse(Mods.usingSlaveTats))
		
		AddHeaderOption("Setbacks")
		difficultClientChanceIndex = AddSliderOption("Difficult Client Chance", Main.difficultClientChance, "{0}%")
		sadisticClientChanceIndex = AddSliderOption("Sadistic Client Chance", Main.sadisticClientChance, "{0}%")
		notPayingChanceIndex = AddSliderOption("Walk-away Chance", Main.notPayingChance, "{0}%")
		
		AddHeaderOption("Theft")
		stealingEnabledIndex = AddToggleOption("NPCs can steal items", Main.stealingEnabled)
		stealMinItemsIndex = AddSliderOption("Min items stolen", Main.stealMinItems, "{0}", disabledIfFalse(Main.stealingEnabled))
		stealMaxItemsIndex = AddSliderOption("Max items stolen", Main.stealMaxItems, "{0}", disabledIfFalse(Main.stealingEnabled))
		stealMinValueIndex = AddSliderOption("Min item value", Main.stealMinValue, "{0}", disabledIfFalse(Main.stealingEnabled))
		stealMaxValueIndex = AddSliderOption("Max item value", Main.stealMaxValue, "{0}", disabledIfFalse(Main.stealingEnabled))
		

		
		SetCursorPosition(1)
		AddHeaderOption("Random Event Settings")
		randomEventTutorialIndex = AddToggleOption("Click for explanation", false)
		AddEmptyOption()
		randomEventChanceIndex = AddSliderOption("Chance for Random Event", Main.randomEventChance, "{0}%")
		
		AddHeaderOption("Random Event Weights")
		showRandomEventDescsIndex = AddToggleOption("Show Descriptions", showRandomEventDescs)
		int index = 0
		while index < Main.numRandomEvents
			randomEventWeightsIndex[index] = AddSliderOption(main.randomEventStrings[index], Main.randomEventWeights[index])
			index += 1
		endWhile
			
	
	elseIf(page == "Punishment Settings")
	;PUNISH
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Settings")
		fakeExecutionChanceIndex = AddSliderOption("Fake Execution Chance", Punish.fakeExecutionChance, "{0}%", disabledIfFalse(Punish.executionEnabled))
		AddEmptyOption()
		debuffsEnabledIndex = AddToggleOption("Debuffs Enabled", Punish.debuffsEnabled)
		
		AddEmptyOption()
		AddEmptyOption()
		AddHeaderOption("Punishment Thresholds")
		
		SetCursorFillMode(LEFT_TO_RIGHT)
		int index = 1
		while index <= Punish.punishmentTypes
			thresholdConfigIndex[index] = AddSliderOption(Punish.punishmentLevelStrings[index], Punish.punishmentThresholds[index])
			sceneToggleIndex[index] = AddToggleOption("Enabled?", Punish.punishmentSceneEnabled[index])
			index += 1
		endWhile
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		thresholdEnforcedMode = AddSliderOption("Enter Enforced Mode at", Punish.enfModeThreshold)
		
		SetCursorPosition(1)
		AddHeaderOption("Punishment Score Changes")
		scoreDeclineSexIndex = AddSliderOption("Increase from declining sex", Punish.refusalIncreaseScore)
		scoreBreakRuleIndex = AddSliderOption("Increase from breaking rules", Punish.rulesIncreaseScore)
		scoreFailQuotaIndex = AddSliderOption("Increase from failing quota", Punish.quotaIncreaseScore)
		AddEmptyOption()
		scoreAcceptSexIndex = AddSliderOption("Decrease from accepting sex", Punish.sexDecreaseScore)
		AddEmptyOption()
		
		
	elseIf(page == "Fame Settings")
	;FAME  
		SetCursorFillMode(TOP_TO_BOTTOM)
		fameLocSelectorIndex = AddMenuOption("Viewing: ", cityNames[lastLocIndex])
		
		AddHeaderOption("Hero Fame View")
		isPlayerThaneIndex = AddToggleOption("Thane", Fame.isPlayerThane[lastLocIndex], disabledIfFalse(Fame.usingHeroFame))
		
		AddToggleOption("Dragonborn", Fame.isPlayerDragonborn, disabledIfFalse(Fame.usingHeroFame))
		if testToolsDisplayed
			AddToggleOption("Alduin Slain", Fame.isAlduinDead, disabledIfFalse(Fame.usingHeroFame))
			AddEmptyOption()
		endIf
		
		AddToggleOption("Archmage", Fame.isPlayerArchmage, disabledIfFalse(Fame.usingHeroFame))
		if testToolsDisplayed
			AddToggleOption("College Member", Fame.isPlayerCollegeMember, disabledIfFalse(Fame.usingHeroFame))
			AddEmptyOption()
		endIf
		
		AddToggleOption("Harbinger", Fame.isPlayerHarbinger, disabledIfFalse(Fame.usingHeroFame))
		if testToolsDisplayed
			AddToggleOption("Companion", Fame.isPlayerCompanion, disabledIfFalse(Fame.usingHeroFame))
			AddEmptyOption()
		endIf
		
		AddToggleOption("Listener", Fame.isPlayerHarbinger, disabledIfFalse(Fame.usingHeroFame))
		if testToolsDisplayed
			AddToggleOption("Dark Brotherhood Member", Fame.isPlayerCompanion, disabledIfFalse(Fame.usingHeroFame))
			AddToggleOption("Emperor Dead", Fame.isEmperorDead, disabledIfFalse(Fame.usingHeroFame))
			AddEmptyOption()
		endIf
		
		AddToggleOption("Thieves Guild Leader", Fame.isPlayerThievesGuildLeader, disabledIfFalse(Fame.usingHeroFame))
		if testToolsDisplayed
			AddToggleOption("Thieves Guild Member", Fame.isPlayerThievesGuildMember, disabledIfFalse(Fame.usingHeroFame))
			AddToggleOption("Nightingale", Fame.isPlayerNightingale, disabledIfFalse(Fame.usingHeroFame))
			AddEmptyOption()
		endIf
		
		AddTextOption("Dragons Slain", Fame.dragonsSlain, disabledIfFalse(Fame.usingHeroFame))
		AddTextOption("Quests Completed", Fame.questsCompleted, disabledIfFalse(Fame.usingHeroFame))
		
		AddHeaderOption("Hero Fame Configuration")
		heroFameStartEnabledIndex = AddToggleOption("Hero Fame Start Enabled", Fame.usingHeroFame)
		HFthresholdIndex = AddSliderOption("Total Hero Fame Required", Fame.HFthreshold, "{0}", disabledIfFalse(Fame.usingHeroFame))
		HFtotalIndex = AddTextOption("Current Total: ", Fame.calculateHeroFame(lastLocIndex))
		AddEmptyOption()
		HFdragonbornIndex = AddSliderOption("Points for being Dragonborn", Fame.HFdragonbornScore)
		HFpointsPerTitleIndex = AddSliderOption("Points per title", Fame.HFpointsPerTitle)
		HFdragonKillIndex = AddSliderOption("Points per dragon slain", Fame.HFdragonKillScore)
		HFquestCompleteIndex = AddSliderOption("Points per quest completed", Fame.HFquestScore)
		
		SetCursorPosition(1)
		AddEmptyOption()
		AddHeaderOption("Sex Fame View")
		bestialityFameIndex = AddTextOption("Bestiality Fame:", Fame.CalculateSexFame(lastLocIndex, constants.FAME_TYPE_BESTIALITY))
		exhibitionistFameIndex = AddTextOption("Exhibitionist Fame:", Fame.CalculateSexFame(lastLocIndex, constants.FAME_TYPE_EXHIBITIONIST))
		slutFameIndex = AddTextOption("Slut Fame:", Fame.CalculateSexFame(lastLocIndex, constants.FAME_TYPE_SLUT))
		submissiveFameIndex = AddTextOption("Submissive Fame:", Fame.CalculateSexFame(lastLocIndex, constants.FAME_TYPE_SUBMISSIVE))
		whoreFameIndex = AddTextOption("Whore Fame:", Fame.CalculateSexFame(lastLocIndex, constants.FAME_TYPE_WHORE))
		
		AddHeaderOption("Sex Fame Configuration")
		fameStartEnabledIndex = AddToggleOption("Sexual Fame Start Enabled", Fame.fameStartEnabled)
		sexFameThresholdIndex = AddSliderOption("Total Sex Fame Required", Fame.sexFameThreshold, "{0}")
		includeSLSFValuesIndex = AddToggleOption("Include SLSF in calculations", Fame.includeSLSFValues, disabledIfFalse(Mods.usingSLSF))
		promiscuityMultiplierIndex = AddSliderOption("Promiscuity Daily Multiplier", Fame.promiscuityMultiplier, "{1}x")
		modestyMultiplierIndex = AddSliderOption("Modesty Daily Multiplier", Fame.modestyMultiplier, "{1}x")
		modestyPeriodIndex = AddSliderOption("Modesty Multiplier After", Fame.modestyPeriod, "{0} days")
		;fameTotalIndex = AddTextOption("Current Total: " + Fame.fameValues[lastLocIndex], "", disabledIfFalse(!Mods.usingSLSF))


	elseIf(page == "Mod Integrations")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Mod Toggles")
		usingDDIndex = AddToggleOption("Devious Devices:", Mods.usingDD, disabledIfFalse(Mods.isDDInstalled))
		usingSLSFIndex = AddToggleOption("Sexlab Sexual Fame:", Mods.usingSLSF, disabledIfFalse(Mods.isSLSFInstalled))
		usingSlaveTatsIndex = AddToggleOption("SlaveTats:", Mods.usingSlaveTats, disabledIfFalse(Mods.isSlaveTatsInstalled))
		usingSLTRIndex = AddToggleOption("Submissive Lola: ", Mods.usingSLTR, disabledIfFalse(Mods.isSLTRInstalled))
		
		
		
		if(testToolsDisplayed)
			AddEmptyOption()
			AddHeaderOption("Installation Statuses")
			AddMenuOption("Devious Devices Integration: ", 			installedStatus[Mods.isDDInstalled as int], 		   OPTION_FLAG_DISABLED)
			AddMenuOption("Sexlab Sexual Fame: ",					installedStatus[Mods.isSLSFInstalled as int], 		   OPTION_FLAG_DISABLED)
			AddMenuOption("SlaveTats: ", 							installedStatus[Mods.isSlaveTatsInstalled as int], 	   OPTION_FLAG_DISABLED)
			AddMenuOption("ZaZ Animation Pack: ", 					installedStatus[Mods.isZaZInstalled as int], 		   OPTION_FLAG_DISABLED)
			AddMenuOption("Submissive Lola: ", 						installedStatus[Mods.isSLTRInstalled as int], 		   OPTION_FLAG_DISABLED)
			AddMenuOption("Simple Slavery: ",                       installedStatus[Mods.isSimpleSlaveryInstalled as int], OPTION_FLAG_DISABLED)
		endIf
		
		
		SetCursorPosition(1)	;The top-right
		
		AddHeaderOption("Simple Slavery Cities")
		int i = 0
		while (i <= 8)
			ssCityEnabledIndices[i] = AddToggleOption(cityNames[i], Tracker.ssCityEnabled[i], disabledIfFalse(Mods.usingSimpleSlavery))
			i += 1
		endWhile
	
	
	elseIf(page == "Content Preferences")
		SetCursorFillMode(TOP_TO_BOTTOM)
		playerGenderPrefIndex = AddMenuOption("Sexual Preference", genderPrefs[playerGenderPref.GetValue() as int])
		playerDominantPrefIndex = AddMenuOption("Player can be dominant with", genderDominantPrefs[PW_PlayerCanBeDominantWithGender.GetValue() as int])
		executionEnabledIndex = AddToggleOption("Execution Scenes", Punish.executionEnabled)
		beastialityEnabledIndex = AddToggleOption("Beastiality Content", Main.beastialityEnabled)

	elseIf(page == "Debug and Control")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Control")
		modEnabledIndex = AddToggleOption("Mod Running", Main.modEnabled)
		updatePeriodIndex = AddSliderOption("Update Interval", main.updatePeriod)
		
		AddEmptyOption()
		
		debugMessagesIndex = AddToggleOption("Debug Notifications", pwUtil.debugNotificationsEnabled)

		AddEmptyOption()

		AddHeaderOption("Testing/Dev")
		
		testToolsDisplayedIndex = AddToggleOption("Show Test Options", testToolsDisplayed)
		
		if(testToolsDisplayed)
			debugPowerScanIndex = AddToggleOption("Scan for actors (power)", false)
			debugGetValidApproacherIndex = AddToggleOption("Get Valid Approacher", false)
			debugPrintValidApproacherReportIndex = AddToggleOption("Print Approacher Validity Report", false)
			debugEnforcedModeTriggerIndex = AddToggleOption("Set Enforced Mode here", false)
			debugClearEnforcedModeTriggerIndex = AddToggleOption("Clear Enforced Mode here", false)
			debugAdd100PunishmentScore = AddToggleOption("Add 100 punishment score", false)
			debugAdd1000PunishmentScore = AddToggleOption("Add 1000 punishment score", false)
			debugTriggerIndex2 = AddToggleOption("Send to SLTR", false)
			debugTriggerIndex3 = AddToggleOption("Simulate SS++ start", false)
			debugTriggerIndex4 = AddToggleOption("Print Components", false)
			debugPrintJarlsIndex = AddToggleOption("Print List of Jarls", false)
			debugPrintThaneStatusIndex = AddToggleOption("Print Thane statuses", false)
			debugSimulateClientIndex = AddToggleOption("Simulate taking paid client", false)
			debugSimulateClientUnpaidIndex = AddToggleOption("Simulate taking unpaid client", false)
			debugTestSexQueueQueueingIndex = AddToggleOption("Test Sex Queue Queueing", false)
			debugTestSexQueueRunningIndex = AddToggleOption("Test Sex Queue SexLab", false)
			debugTestSexQueueAutomaticIndex = AddToggleOption("Start Sex Queue Auto Mode", false)
			debugTestFameGainLossIndex = AddToggleOption("Start Sex Fame Increase/Decrease Test", false)
		endIf
		
		
		AddEmptyOption()

		changeDebuffLevelIndex = AddSliderOption("Set Current Debuff Level", Punish.debuffLevel)

		AddEmptyOption()
		
		
		SetCursorPosition(1)
		AddHeaderOption("Debug")
		removeItemsIndex = AddToggleOption("Remove All Items", false)
		returnItemsIndex = AddToggleOption("Return All Confiscated Items", false)
		returnStolenItemsIndex = AddToggleOption("Return All Stolen Items", false)
		debugRemoveFtbIndex = AddToggleOption("Remove fade-to-black", false)
		
		AddEmptyOption()
		
		debugStopSceneIndex = AddToggleOption("Stop Current Punishment Scene", false)
		debugStopQueueIndex = AddToggleOption("Stop Sex Queue/Swarm", false)
		
		if(testToolsDisplayed)
			int dssi = 1
			while(dssi <= Punish.punishmentTypes)
				debugSceneStartIndices[dssi] = AddToggleOption("Start " + Punish.punishmentLevelStrings[dssi] + " scene", false)
				dssi += 1
			endWhile
			
			AddEmptyOption()
			
			int dsre = 0
			while(dsre < main.numRandomEvents)
				debugStartRandomEventIndices[dsre] = AddToggleOption("Start " + main.randomEventStrings[dsre] + " event", false)
				dsre += 1
			endWhile
			
		endIf
		
		AddEmptyOption()
		
		debugDHLPResumeIndex = AddToggleOption("Send dhlp-Resume", false)
		
		AddHeaderOption("Status Control")
		debugMakeEligible = AddToggleOption("Make Eligible here", false)
		debugMakeWhore = AddToggleOption("Make Whore here", false)
		debugClearStatus = AddToggleOption("Clear Status here", false)
		
		;Clearing eligibility cooldown will not be a common thing, don't clutter MCM with this by default
		if(testToolsDisplayed)
			debugClearEligibilityCooldown = AddToggleOption("Clear Eligibility Cooldown here", false)
		endIf
		
		
	elseIf(page == "Credits")
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		AddHeaderOption("Creator")
		AddTextOption("", "Visio Diaboli")
		
		AddHeaderOption("Initial Idea")
		AddTextOption("", "gianclod")
		
		AddHeaderOption("Initial Technical Concept")
		AddTextOption("", "Verstort")
		
		AddHeaderOption("Interactive Gallows Scripts")
		AddTextOption("", "Pamatronic")
		
		AddHeaderOption("Help with DD Soft-Dependency")
		AddTextOption("", "Tenri")
		
		SetCursorPosition(1)
		
		AddHeaderOption("ESP/Script Fixes")
		AddTextOption("", "Fienyx")
		AddTextOption("", "Bane Master")
		AddTextOption("", "DayTri")
		
		AddHeaderOption("Content Ideas")
		AddTextOption("", "blahity")
		
		AddHeaderOption("Fixing The Guard Greet Bug")
		AddTextOption("", "oldprv724")
		
		AddHeaderOption("Testing And Ideas")
		AddTextOption("","poblivion")
		AddTextOption("", "Sidewasy")
		AddTextOption("", "jc321")
		AddTextOption("", "laucters")
		AddTextOption("", "zenrae")
		AddTextOption("", "drunken toad")
		AddTextOption("", "wHOaMiEH")
		
		AddHeaderOption("Troubleshooting")
		AddTextOption("", "crococat")
		AddTextOption("", "Naps-On-Dirt")
		AddTextOption("", "Antaufein")
		
		
		
		
		
		
	endIf

endEvent

event OnOptionSelect(int optionIndex)
	
	;ELIGIBILITY/STARTUP
	if(optionIndex == fameStartEnabledIndex)
		Fame.fameStartEnabled = !Fame.fameStartEnabled
		SetToggleOptionValue(fameStartEnabledIndex, Fame.fameStartEnabled)
	
	elseIf(optionIndex == includeSLSFValuesIndex)
		Fame.includeSLSFValues = !Fame.includeSLSFValues
		SetToggleOptionValue(includeSLSFValuesIndex, Fame.includeSLSFValues)
	
	elseIf(optionIndex == heroFameStartEnabledIndex)
		Fame.usingHeroFame = !Fame.usingHeroFame
		SetToggleOptionValue(heroFameStartEnabledIndex, Fame.usingHeroFame)
		
	elseIf(optionIndex == slaveryLockoutIndex)
		Fame.eligibilitySlaveryLockout = !Fame.eligibilitySlaveryLockout
		SetToggleOptionValue(slaveryLockoutIndex, Fame.eligibilitySlaveryLockout)
		
	elseIf(optionIndex == storyStartEnabledIndex)
		Intro.storyStartEnabled = !Intro.storyStartEnabled 
		SetToggleOptionValue(storyStartEnabledIndex, Intro.storyStartEnabled )
		
	elseIf(optionIndex == startInEnforcedModeIndex)
		Tracker.startInEnforcedMode = !Tracker.startInEnforcedMode
		SetToggleOptionValue(startInEnforcedModeIndex, Tracker.startInEnforcedMode)

		
	elseIf(optionIndex == allHoldsIndex)
		Intro.allHolds = !Intro.allHolds
		SetToggleOptionValue(allHoldsIndex, Intro.allHolds)

	;ON-DUTY
	elseIf(optionIndex == cantLeaveIndex)
		Tracker.cantLeave = !Tracker.cantLeave
		SetToggleOptionValue(cantLeaveIndex, Tracker.cantLeave)
		
	elseIf(optionIndex == canGuardsApproachIndex)
		actorMgr.canGuardsApproach = !actorMgr.canGuardsApproach
		SetToggleOptionValue(canGuardsApproachIndex, actorMgr.canGuardsApproach)
	elseIf(optionIndex == canEldersApproachIndex)
		actorMgr.canEldersApproach = !actorMgr.canEldersApproach
		SetToggleOptionValue(canEldersApproachIndex, actorMgr.canEldersApproach)
	elseIf(optionIndex == canFollowersApproachIndex)
		actorMgr.canFollowersApproach = !actorMgr.canFollowersApproach
		SetToggleOptionValue(canFollowersApproachIndex, actorMgr.canFollowersApproach)
	elseIf(optionIndex == canSlavesApproachIndex)
		actorMgr.canSlavesApproach = !actorMgr.canSlavesApproach
		SetToggleOptionValue(canSlavesApproachIndex, actorMgr.canSlavesApproach)
		
	elseIf(optionIndex == canFemalesRequestBlowjobsIndex)
		Main.femalesCanRequestBlowjobs = !Main.femalesCanRequestBlowjobs
		SetToggleOptionValue(canFemalesRequestBlowjobsIndex, Main.femalesCanRequestBlowjobs)
	
	elseIf(optionIndex == stealingEnabledIndex)
		Main.stealingEnabled = !Main.stealingEnabled
		SetToggleOptionValue(stealingEnabledIndex, Main.stealingEnabled)
		SetOptionFlags(stealValueIndex, disabledIfFalse(Main.stealingEnabled), false) 
		SetOptionFlags(stealMinItemsIndex, disabledIfFalse(Main.stealingEnabled), false)
		SetOptionFlags(stealMaxItemsIndex, disabledIfFalse(Main.stealingEnabled), false)
		SetOptionFlags(stealMinValueIndex, disabledIfFalse(Main.stealingEnabled), false)
		SetOptionFlags(stealMaxValueIndex, disabledIfFalse(Main.stealingEnabled), false)
		
	elseIf(optionIndex == canPlayerSolicitIndex)
		Main.canPlayerSolicit = !Main.canPlayerSolicit
		SetToggleOptionValue(canPlayerSolicitIndex, Main.canPlayerSolicit)
		
	elseIf(optionIndex == mcmLockoutIndex)
		mcmLockoutEnabled = !mcmLockoutEnabled
		SetToggleOptionValue(mcmLockoutIndex, mcmLockoutEnabled)
		
	elseIf(optionIndex == restraintsRemovalEnabledIndex)
		Main.restraintsRemovalEnabled = !Main.restraintsRemovalEnabled
		SetToggleOptionValue(restraintsRemovalEnabledIndex, Main.restraintsRemovalEnabled)

	elseIf(optionIndex == playerHandlesGoldIndex)
		if(Tracker.isWhoreAnywhere)
			Debug.MessageBox("Cannot change gold handling mode while there's an active quota")
		else
			QuotaMgr.playerHandlesGold = !QuotaMgr.playerHandlesGold
			SetOptionFlags(missingReportChanceIndex, disabledIfFalse(!QuotaMgr.playerHandlesGold), false)
			SetToggleOptionValue(playerHandlesGoldIndex, QuotaMgr.playerHandlesGold)
		endIf
		
	elseIf(optionIndex == tippingEnabledIndex)
		if PW_BooleanTippingEnabled.GetValue() == 0
			PW_BooleanTippingEnabled.SetValue(1)
		else
			PW_BooleanTippingEnabled.SetValue(0)
		endIf
		SetToggleOptionValue(tippingEnabledIndex, PW_BooleanTippingEnabled.GetValue() as int)
		
	elseIf(optionIndex == weaponsAllowedIndex)
		Main.weaponsAllowed = !Main.weaponsAllowed
		SetToggleOptionValue(weaponsAllowedIndex, Main.weaponsAllowed)
	
	elseIf(optionIndex == showRuleExemptIndex)
		string outputstr
		int index = 0
		while index < Main.exemptEquipment.Length && Main.exemptEquipment[index] != none
			outputstr = outputstr + Main.exemptEquipment[index].GetName() + "\n"
			index += 1
		endWhile
		Debug.MessageBox(outputstr)
		
	elseIf(optionIndex == ruleExemptEquipmentIndex)
		Main.addRuleExemption(PW_ExemptEquipmentSelector.show())
	
	elseIf(optionIndex == removeRuleExemptIndex)
		Main.exemptEquipment = new armor[16]
		Main.headSlotExempt = false
		Main.bodySlotExempt = false
		Main.feetSlotExempt = false
		Main.handsSlotExempt = false
		
	elseIf(optionIndex == enforcedModeInventoryTakenIndex)
		Punish.enforcedModeInventoryTaken = !Punish.enforcedModeInventoryTaken
		SetToggleOptionValue(enforcedModeInventoryTakenIndex, Punish.enforcedModeInventoryTaken)
	elseIf(optionIndex == enforcedModeHeavierRestraintsIndex)
		Punish.enforcedModeHeavierRestraints = !Punish.enforcedModeHeavierRestraints
		SetToggleOptionValue(enforcedModeHeavierRestraintsIndex, Punish.enforcedModeHeavierRestraints)
	
	;MISCELLANEOUS SETTINGS 
	elseIf(optionIndex == commentsEnabledIndex)
		Comments.CommentsEnabled = !Comments.CommentsEnabled
		SetToggleOptionValue(commentsEnabledIndex, Comments.commentsEnabled)
	
	elseIf(optionIndex == randomEventTutorialIndex)
		Debug.MessageBox("When an NPC approaches you, there's a chance that it becomes a random event instead. The possible events are shown below (descriptions off by default incase you don't want things spoiled), alongside a 'weighting': if you imagine the mod spinning a 'wheel of fortune' type wheel when a random event is to happen, and then taking the event it stops on, this is the number of slots on the wheel that event gets.")

	elseIf(optionIndex == showRandomEventDescsIndex)
		showRandomEventDescs = !showRandomEventDescs
		SetToggleOptionValue(showRandomEventDescsIndex, showRandomEventDescs)
	
	;STATUS

	;PUNISHMENT
	elseIf(optionIndex == debuffsEnabledIndex)
		Punish.debuffsEnabled = !Punish.debuffsEnabled
		SetToggleOptionValue(debuffsEnabledIndex, Punish.debuffsEnabled)
	
	;CONTROL
	elseIf(optionIndex == modEnabledIndex)
		Main.modEnabled = !Main.modEnabled
		SetToggleOptionValue(modEnabledIndex, Main.modEnabled)
		
		if(main.modEnabled)
			Main.RegisterForSingleUpdate(3.0)
		endIf
	

	;MODS
	elseIf(optionIndex == usingDDIndex)
		Mods.usingDD = !Mods.usingDD
		SetToggleOptionValue(usingDDIndex, Mods.usingDD)
	elseIf(optionIndex == usingSLSFIndex)
		Mods.usingSLSF = !Mods.usingSLSF
		SetToggleOptionValue(usingSLSFIndex, Mods.usingSLSF)
	elseIf(optionIndex == usingSlaveTatsIndex)
		Mods.usingSlaveTats = !Mods.usingSlaveTats
		SetToggleOptionValue(usingSlaveTatsIndex, Mods.usingSlaveTats)
	;elseIf(optionIndex == usingZaZIndex)
	;	Mods.usingZaZ = ! Mods.usingZaZ
	;	SetToggleOptionValue(usingZaZIndex, Mods.usingZaZ)
	elseIf(optionIndex == usingSLTRIndex)
		Mods.usingSLTR = ! Mods.usingSLTR
		SetToggleOptionValue(usingSLTRIndex, Mods.usingSLTR)
		
	;ADVANCED NUDITY DETECTION
	elseIf(optionIndex == requireNudeIndex)
		main.requireNude = !main.requireNude
		SetToggleOptionValue(requireNudeIndex, main.requireNude)
		ForcePageReset()
	
	elseIf(optionIndex == requireToplessIndex)
		main.requireTopless = !main.requireTopless
		SetToggleOptionValue(requireToplessIndex, main.requireTopless)
		ForcePageReset()
		
	elseIf(optionIndex == requireChestIndex)
		main.requireChest = !main.requireChest
		SetToggleOptionValue(requireChestIndex, main.requireChest)
		ForcePageReset()
		
	elseIf(optionIndex == requireBraIndex)
		main.requireBra = !main.requireBra
		SetToggleOptionValue(requireBraIndex, main.requireBra)
		ForcePageReset()
		
	elseIf(optionIndex == requireBottomlessIndex)
		main.requireBottomless = !main.requireBottomless
		SetToggleOptionValue(requireBottomlessIndex, main.requireBottomless)
		ForcePageReset()
	
	elseIf(optionIndex == requireGenitalsIndex)
		main.requireGenitals = !main.requireGenitals
		SetToggleOptionValue(requireGenitalsIndex, main.requireGenitals)
		ForcePageReset()
		
	elseIf(optionIndex == requireAssIndex)
		main.requireAss = !main.requireAss
		SetToggleOptionValue(requireAssIndex, main.requireAss)
		ForcePageReset()
	
	elseIf(optionIndex == requireUnderwearIndex)
		main.requireUnderwear = !main.requireUnderwear
		SetToggleOptionValue(requireUnderwearIndex, main.requireUnderwear)
		ForcePageReset()

	;CONTENT PREF
	elseIf(optionIndex == executionEnabledIndex)
		Punish.executionEnabled = !Punish.executionEnabled
		SetToggleOptionValue(executionEnabledIndex, Punish.executionEnabled)
	elseIf(optionIndex == beastialityEnabledIndex)
		Main.beastialityEnabled = !Main.beastialityEnabled
		SetToggleOptionValue(beastialityEnabledIndex, Main.beastialityEnabled)

	;DEBUG
	elseIf(optionIndex == removeItemsIndex)
		;Game.GetPlayer().RemoveAllItems(PW_ItemHolder)
		;PW_Utility.SendFormEvent("PW_RemoveItems", PW_ItemHolder)
		punish.RemoveItems(PW_ItemHolder)
		
	elseIf(optionIndex == returnItemsIndex)
		PW_ItemHolder.RemoveAllItems(Game.GetPlayer())
	elseIf(optionIndex == returnStolenItemsIndex)
		main.ReturnAllStolenItems()
		
	elseIf(optionIndex == debugRemoveFtbIndex)
		FadeToBlack.Remove()
	
	elseIf(optionIndex == debugPrintJarlsIndex)
		Tracker.PrintJarls()
	elseIf(optionIndex == debugPrintThaneStatusIndex)
		Fame.PrintThaneStatuses()
	
	elseIf(optionIndex == debugSimulateClientIndex)
		quotaMgr.SimulateClientTaken()
	elseIf(optionIndex == debugSimulateClientUnpaidIndex)
		quotaMgr.SimulateClientTakenUnpaid()
		
	elseIf(optionIndex == debugMessagesIndex)
		pwUtil.debugNotificationsEnabled = !pwUtil.debugNotificationsEnabled
		SetToggleOptionValue(debugMessagesIndex, pwUtil.debugNotificationsEnabled)
		
	elseIf(optionIndex == testToolsDisplayedIndex)
		testToolsDisplayed = !testToolsDisplayed
		SetTextOptionValue(testToolsDisplayedIndex, testToolsDisplayed, false)
		Debug.MessageBox("Re-open MCM for changes to take effect")
	elseIf(optionIndex == debugPowerScanIndex)
		actorMgr.PowerScan()
	elseIf(optionIndex == debugGetValidApproacherIndex)
		actor validActor = actorMgr.GetValidApproacherNoScan()
		if(validActor != none)
			Debug.MessageBox(validActor.GetLeveledActorBase().GetName())
		else	
			Debug.MessageBox("None found, try re-scanning or viewing report")
		endIf
	elseIf(optionIndex == debugPrintValidApproacherReportIndex)
		actorMgr.PrintValidApproacherReport()
	elseIf(optionIndex == debugEnforcedModeTriggerIndex)
		Tracker.SetEnforcedMode(tracker.currentLocIndex)
	elseIf(optionIndex == debugClearEnforcedModeTriggerIndex)
		PW_Utility.SendIntEvent("PW_ClearEnforcedMode", tracker.currentLocIndex)
	elseIf(optionIndex == debugAdd100PunishmentScore)
		Punish.increaseScore(100)
	elseIf(optionIndex == debugAdd1000PunishmentScore)
		Punish.increaseScore(1000)
	elseIf(optionIndex == debugTriggerIndex2)
		Mods.SendToSLTR()
		
	elseIf(optionIndex == debugTriggerIndex3)
		SendModEvent("PW_ssStart")
		
	elseIf(optionIndex == debugTriggerIndex4)
		componentManager.PrintComponents()
		
	elseIf(optionIndex == debugStopSceneIndex)
		Punish.endScene(true, true)
		
	elseIf(optionIndex == debugStopQueueIndex)
		sexQueue.Shutdown()
		
	elseIf(optionIndex == debugDHLPResumeIndex)
		SendModEvent("dhlp-Resume")
	
	elseIf(optionIndex == debugMakeEligible)
		PW_Utility.sendIntEvent("PW_MakeEligible", Tracker.currentLocIndex)
	elseIf(optionIndex == debugMakeWhore)
		PW_Utility.sendIntEvent("PW_MakePublicWhore", Tracker.currentLocIndex)
	elseIf(optionIndex == debugClearStatus)
		PW_Utility.sendEvent("PW_ClearStatusLocal")
		;PW_Utility.sendIntEvent("PW_ClearStatus", Tracker.currentLocIndex)
		
	elseIf(optionIndex == debugTestSexQueueQueueingIndex)
		sexQueue.RunQueueingTest()
	elseIf(optionIndex == debugTestSexQueueRunningIndex)
		sexQueue.RunSexTest()
	elseIf(optionIndex == debugTestSexQueueAutomaticIndex)
		sexQueue.StartAutomaticMode(5, "MCMTestHook", animationTags = "Blowjob")
	
	elseIf(optionIndex == debugTestFameGainLossIndex)
		Fame.TestFameIncreaseDecrease()
		
	else
		;Check city array indices
		int index = 0
		while (index <= 8)
			if(optionIndex == ssCityEnabledIndices[index])
				Tracker.ssCityEnabled[index] = !Tracker.ssCityEnabled[index]
				SetToggleOptionValue(ssCityEnabledIndices[index], Tracker.ssCityEnabled[index])
			endIf
			index += 1
		endWhile
		
		;Check punishment array indices
		index = 1
		while (index <= Punish.punishmentTypes)
			if(optionIndex == sceneToggleIndex[index])
				Punish.punishmentSceneEnabled[index] = !Punish.punishmentSceneEnabled[index]
				SetToggleOptionValue(optionIndex, Punish.punishmentSceneEnabled[index])
			elseIf(optionIndex == debugSceneStartIndices[index])
				Punish.startScene(index, removeItems = true, moveReturnMarker = true)
			endIf
			index += 1
		endWhile
		
		;Check random event start indices
		index = 0
		while(index < main.numRandomEvents)
			if(optionIndex == debugStartRandomEventIndices[index])
				main.StartRandomEvent(index)
			endIf
			index += 1
		endWhile
	endIf
	
endEvent


event OnOptionMenuOpen(int optionIndex)

	if(optionIndex == introHandlingModeIndex)
		SetMenuDialogOptions(introHandlingModes)
		SetMenuDialogStartIndex(PW_SelectedIntroHandlingMode.GetValue() as int)
		SetMenuDialogDefaultIndex(1)
	
	elseIf(optionIndex == playerGenderPrefIndex)
		SetMenuDialogOptions(genderPrefs)
		SetMenuDialogStartIndex(playerGenderPref.GetValue() as int)
		SetMenuDialogDefaultIndex(2)
		
	elseIf(optionIndex == playerDominantPrefIndex)
		SetMenuDialogOptions(genderDominantPrefs)
		SetMenuDialogStartIndex(PW_PlayerCanBeDominantWithGender.GetValue() as int)
		SetMenuDialogDefaultIndex(1)
		
	elseIf(optionIndex == nudityLevelIndex)
		SetMenuDialogOptions(nudityLevels)
		SetMenuDialogStartIndex(Main.nudityLevel)
		SetMenuDialogDefaultIndex(1)
		ForcePageReset()
		
	elseIf(optionIndex == quotaModeIndex)
		SetMenuDialogOptions(quotaModes)
		SetMenuDialogStartIndex(QuotaMgr.quotaMode)
		SetMenuDialogDefaultIndex(0)
	
	elseIf(optionIndex == fameLocSelectorIndex)
		SetMenuDialogOptions(cityNames)
		SetMenuDialogStartIndex(Tracker.currentLocIndex)
		SetMenuDialogDefaultIndex(0)
	elseIf(optionIndex == currStatusLocSelectorIndex)
		SetMenuDialogOptions(cityNames)
		SetMenuDialogStartIndex(Tracker.currentLocIndex)
		setMenuDialogDefaultIndex(0)
		
	elseIf(optionIndex == tattooModeIndex)
		SetMenuDialogOptions(tattooModes)
		SetMenuDialogStartIndex(Mods.tattooMode)
		setMenuDialogDefaultIndex(0)
	
	endIf

endEvent


event OnOptionMenuAccept(int optionIndex, int value)

	if(optionIndex == introHandlingModeIndex)
		PW_SelectedIntroHandlingMode.SetValue(value)
		SetMenuOptionValue(introHandlingModeIndex, introHandlingModes[value])
	
	elseIf(optionIndex == playerGenderPrefIndex)
		playerGenderPref.SetValue(value)
		SetMenuOptionValue(optionIndex, genderPrefs[value])
	
	
	elseIf(optionIndex == playerDominantPrefIndex)
		PW_PlayerCanBeDominantWithGender.SetValue(value)
		SetMenuOptionValue(optionIndex, genderDominantPrefs[value])
		
	elseIf(optionIndex == nudityLevelIndex)
		Main.nudityLevel = value
		SetMenuOptionValue(optionIndex, nudityLevels[value])
	
	elseIf(optionIndex == quotaModeIndex)
		QuotaMgr.changeQuotaMode(value)
		SetMenuOptionValue(optionIndex, quotaModes[value])
	elseIf(optionIndex == fameLocSelectorIndex)
		changeFamePage(value)
	elseIf(optionIndex == currStatusLocSelectorIndex)
		changeStatusPage(value)
		
	elseIf(optionIndex == tattooModeIndex)
		Mods.tattooMode = value
		SetMenuOptionValue(optionIndex, tattooModes[value])
		
	endIf
	
endEvent


event OnOptionSliderOpen(int optionIndex)

	;ELIGIBILITY/STARTUP
	if(optionIndex == eligibilityTimeoutPeriodIndex)
		SetSliderDialogStartValue(Fame.eligibilityTimeoutPeriod)
		SetSliderDialogDefaultValue(7)
		SetSliderDialogRange(1, 30)
		SetSliderDialogInterval(1)
	
	elseIf(optionIndex == introHandlingBountyIndex)
		SetSliderDialogStartValue(PW_BountyForRefusalToSeeThane.GetValue() as int)
		SetSliderDialogDefaultValue(250)
		SetSliderDialogRange(50, 1000)
		SetSliderDialogInterval(50)
	
	elseIf(optionIndex == guardFGCooldownIndex)
		SetSliderDialogStartValue(intro.guardInformReset)
		SetSliderDialogDefaultValue(0.125)
		SetSliderDialogRange(0.05, 1.0)
		SetSliderDialogInterval(0.005)
		
	elseIf(optionIndex == minClientQuotaIndex)
		SetSliderDialogStartValue(QuotaMgr.minClientQuota)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(5, QuotaMgr.maxClientQuota)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == maxClientQuotaIndex)
		SetSliderDialogStartValue(QuotaMgr.maxClientQuota)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(QuotaMgr.minClientQuota, 250)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == minGoldQuotaIndex)
		SetSliderDialogStartValue(QuotaMgr.minGoldQuota)
		SetSliderDialogDefaultValue(3000)
		SetSliderDialogRange(500, QuotaMgr.maxGoldQuota)
		SetSliderDialogInterval(100)
	elseIf(optionIndex == maxGoldQuotaIndex)
		SetSliderDialogStartValue(QuotaMgr.maxGoldQuota)
		SetSliderDialogDefaultValue(6000)
		SetSliderDialogRange(QuotaMgr.minGoldQuota, 100000)
		SetSliderDialogInterval(100)
	elseIf(optionIndex == reportingPeriodIndex)
		SetSliderDialogStartValue(QuotaMgr.reportingPeriod)
		SetSliderDialogDefaultValue(7)
		SetSliderDialogRange(1, 30)
		SetSliderDialogInterval(1)

	;NPC APPROACHES
	elseIf(optionIndex == scanPeriodIndex)
		SetSliderDialogStartValue(Main.scanPeriod)
		SetSliderDialogDefaultValue(60)
		SetSliderDialogRange(0, 360)
		SetSliderDialogInterval(5)
	elseIf(optionIndex == approachChanceIndex)
		SetSliderDialogStartValue(Main.approachChance)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf (optionIndex == approachTimeoutIndex)
		SetSliderDialogStartValue(Main.approachTimeout)
		SetSliderDialogDefaultValue(60)
		SetSliderDialogRange(10, 300)
		SetSliderDialogInterval(5)
	elseIf(optionIndex == approachRadiusIndex)
		SetSliderDialogStartValue(actorMgr.approachRadius)
		SetSliderDialogDefaultValue(800)
		SetSliderDialogRange(0, 3000)
		SetSliderDialogInterval(100)
		
	elseIf(optionIndex == approachVaginalChanceIndex)
		SetSliderDialogStartValue(PW_approachVaginalChance.GetValue() as int)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	elseIf(optionIndex == approachBlowjobChanceIndex)
		SetSliderDialogStartValue(PW_approachBlowjobChance.GetValue() as int)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	elseIf(optionIndex == approachAnalChanceIndex)
		SetSliderDialogStartValue(PW_ApproachAnalChance.GetValue() as int)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	
	elseIf(optionIndex == swarmChanceIndex)
		SetSliderDialogStartValue(main.swarmChance)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == swarmMaxIndex)
		SetSliderDialogStartValue(main.swarmMax)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 50)
		SetSliderDialogInterval(1)
	;elseIf(optionIndex == swarmLOSReqIndex)
	;	SetSliderDialogStartValue(main.swarmLOSRequired)
	;	SetSliderDialogDefaultValue(2)
	;	SetSliderDialogRange(0, 10)
	;	SetSliderDialogInterval(1)

	elseIf(optionIndex == declineSexChanceIndex)
		SetSliderDialogStartValue(Main.SolicitFailChance.GetValue() as int)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)

	elseIf(optionIndex == difficultClientChanceIndex)
		SetSliderDialogStartValue(Main.difficultClientChance)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == sadisticClientChanceIndex)
		SetSliderDialogStartValue(Main.sadisticClientChance)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
		
	elseIf(optionIndex == notPayingChanceIndex)
		SetSliderDialogStartValue(Main.notPayingChance)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == stealMinValueIndex)
		SetSliderDialogStartValue(Main.stealMinValue)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(50, 1000)
		SetSliderDialogInterval(50)
	elseIf(optionIndex == stealMaxValueIndex)
		SetSliderDialogStartValue(Main.stealMaxValue)
		SetSliderDialogDefaultValue(2000)
		SetSliderDialogRange(300, 5000)
		SetSliderDialogInterval(50)
	elseIf(optionIndex == stealMinItemsIndex)
		SetSliderDialogStartValue(Main.stealMinItems)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(1, Main.stealMaxItems)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == stealMaxItemsIndex)
		SetSliderDialogStartValue(Main.stealMaxItems)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(Main.stealMinItems, 20)
		SetSliderDialogInterval(1)


	;PAYMENT
	elseIf(optionIndex == basePayIndex)
		SetSliderDialogStartValue(QuotaMgr.basePay)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 300)
		SetSliderDialogInterval(5)
	elseIf(optionIndex == payPerLevelIndex)
		SetSliderDialogStartValue(QuotaMgr.payPerLevel)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	elseIf(optionIndex == missingReportChanceIndex)
		SetSliderDialogStartValue(QuotaMgr.missingReportChance)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	elseIf(optionIndex == standardCutIndex)
		SetSliderDialogStartValue(QuotaMgr.standardCut)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == overtimeCutIndex)
		SetSliderDialogStartValue(QuotaMgr.overtimeCut)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	elseIf (optionIndex == tipMinMultIndex)
		SetSliderDialogStartValue(PW_CharmTipMinMult.GetValue())
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, PW_CharmTipMaxMult.GetValue())
		SetSliderDialogInterval(0.1)
	
	elseIf (optionIndex == tipMaxMultIndex)
		SetSliderDialogStartValue(PW_CharmTipMaxMult.GetValue())
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(PW_CharmTipMinMult.GetValue(), 1.5)
		SetSliderDialogInterval(0.1)
		
	elseIf (optionIndex == megaTipChanceIndex)
		SetSliderDialogStartValue(PW_CharmMegaTipChance.GetValue())
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 25)
		SetSliderDialogInterval(1)
	
	elseIf (optionIndex == megaTipMultIndex)
		SetSliderDialogStartValue(PW_CharmMegaTipMult.GetValue())
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(0.1)
		

	elseIf(optionIndex == enforcedModeQuotaMultIndex)
		SetSliderDialogStartValue(quotaMgr.enforcedModeQuotaMult)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(0.1)
	
	elseIf(optionIndex == randomEventChanceIndex)
		SetSliderDialogStartValue(Main.randomEventChance)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	;FAME
	elseIf(optionIndex == HFthresholdIndex)
		SetSliderDialogStartValue(Fame.HFthreshold)
		SetSliderDialogDefaultValue(700)
		SetSliderDialogRange(25, 1500)
		SetSliderDialogInterval(25)
	elseIf(optionIndex == HFdragonbornIndex)
		SetSliderDialogStartValue(Fame.HFdragonbornScore)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(5)
	elseIf(optionIndex == HFpointsPerTitleIndex)
		SetSliderDialogStartValue(Fame.HFpointsPerTitle)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	elseIf(optionIndex == HFdragonKillIndex)
		SetSliderDialogStartValue(Fame.HFdragonKillScore)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	elseIf(optionIndex == HFquestCompleteIndex)
		SetSliderDialogStartValue(Fame.HFquestScore)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
		
	elseIf(optionIndex == SLSFThresholdIndex)
		SetSliderDialogStartValue(Fame.SLSFThreshold)
		SetSliderDialogDefaultValue(200)
		SetSliderDialogRange(50, 1000)
		SetSliderDialogInterval(50)
	elseIf(optionIndex == sexFameThresholdIndex)
		SetSliderDialogStartValue(Fame.sexFameThreshold)
		SetSliderDialogDefaultValue(200)
		SetSliderDialogRange(25, 1500)
		SetSliderDialogInterval(25)
	
	elseIf(optionIndex == promiscuityMultiplierIndex)
		SetSliderDialogStartValue(Fame.promiscuityMultiplier)
		SetSliderDialogDefaultValue(1.2)
		SetSliderDialogRange(1.0, 3.0)
		SetSliderDialogInterval(0.1)
	elseIf(optionIndex == modestyMultiplierIndex)
		SetSliderDialogStartValue(Fame.modestyMultiplier)
		SetSliderDialogDefaultValue(0.8)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
		
	elseIf(optionIndex == modestyPeriodIndex)
		SetSliderDialogStartValue(Fame.modestyPeriod)
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 30)
		SetSliderDialogInterval(1)
		
	;MISCELLANEOUS 
	elseIf(optionIndex == offDutyApproachChanceIndex)
		SetSliderDialogStartValue(Main.offDutyApproachChance)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 50)
		SetSliderDialogInterval(1)

	;PUNISHMENT
	elseIf(optionIndex == fakeExecutionChanceIndex)
		SetSliderDialogStartValue(Punish.fakeExecutionChance)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	
	elseIf(optionIndex == thresholdEnforcedMode)
		SetSliderDialogStartValue(Punish.refusalIncreaseScore)
		SetSliderDialogDefaultValue(300)
		SetSliderDialogRange(100, 10000)
		SetSliderDialogInterval(50)
		
	elseIf(optionIndex == scoreDeclineSexIndex)
		SetSliderDialogStartValue(Punish.refusalIncreaseScore)
		SetSliderDialogDefaultValue(35)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
		
	elseIf(optionIndex == scoreBreakRuleIndex)
		SetSliderDialogStartValue(Punish.rulesIncreaseScore)
		SetSliderDialogDefaultValue(35)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	
	elseIf(optionIndex == scoreFailQuotaIndex)
		SetSliderDialogStartValue(Punish.refusalIncreaseScore)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 300)
		SetSliderDialogInterval(5)
		
	elseIf(optionIndex == scoreAcceptSexIndex)
		SetSliderDialogStartValue(Punish.sexDecreaseScore)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 25)
		SetSliderDialogInterval(5)
	
	;DEBUG
	elseIf(optionIndex == changeDebuffLevelIndex)
		SetSliderDialogStartValue(Punish.debuffLevel)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 6)
		SetSliderDialogInterval(1)
	elseIf(optionIndex == updatePeriodIndex)
		SetSliderDialogStartValue(main.updatePeriod)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(1.0, 60.0)
		SetSliderDialogInterval(1.0)
		
	else	;Check array indices
	
		int index = 1
		while index <= Punish.punishmentTypes
			if(optionIndex == thresholdConfigIndex[index])
				SetSliderDialogStartValue(Punish.punishmentThresholds[index])
				SetSliderDialogDefaultValue(index * 100)
				SetSliderDialogRange(10, 1000)
				SetSliderDialogInterval(5)
			endIf
			index += 1
		endWhile
	
		index = 0
		while index < Main.numRandomEvents
			if(optionIndex == randomEventWeightsIndex[index])
				SetSliderDialogStartValue(Main.randomEventWeights[index])
				SetSliderDialogDefaultValue(5)
				SetSliderDialogRange(0, 10)
				SetSliderDialogInterval(1)
			endIf
			index += 1
		endWhile
	endIf
	
endEvent


event OnOptionSliderAccept(int optionIndex, float value)

	;STARTUP
	if(optionIndex == eligibilityTimeoutPeriodIndex)
		Fame.eligibilityTimeoutPeriod = value as int
		SetSliderOptionValue(eligibilityTimeoutPeriodIndex, Fame.eligibilityTimeoutPeriod, "{0} days")
	
	elseIf(optionIndex == introHandlingBountyIndex)
		PW_BountyForRefusalToSeeThane.SetValue(value)
		SetSliderOptionValue(introHandlingBountyIndex, value, "{0}")
	
	elseIf(optionIndex == guardFGCooldownIndex)
		intro.guardInformReset = value as int
		SetSliderOptionValue(guardFGCooldownIndex, value, "{3} days")
	
	elseIf(optionIndex == minClientQuotaIndex)
		QuotaMgr.minClientQuota = value as int
		SetSliderOptionValue(minClientQuotaIndex, QuotaMgr.minClientQuota, "{0} clients")
	elseIf(optionIndex == maxClientQuotaIndex)
		QuotaMgr.maxClientQuota = value as int
		SetSliderOptionValue(maxClientQuotaIndex, QuotaMgr.maxClientQuota, "{0} clients")
	elseIf(optionIndex == minGoldQuotaIndex)
		QuotaMgr.minGoldQuota = value as int
		SetSliderOptionValue(minGoldQuotaIndex, QuotaMgr.minGoldQuota, "{0} gold")
	elseIf(optionIndex == maxGoldQuotaIndex)
		QuotaMgr.maxGoldQuota = value as int
		SetSliderOptionValue(maxGoldQuotaIndex, QuotaMgr.maxGoldQuota, "{0} gold")
	elseIf(optionIndex == reportingPeriodIndex)
		QuotaMgr.reportingPeriod = value as int
		SetSliderOptionValue(reportingPeriodIndex, QuotaMgr.reportingPeriod, "{0} days")

	;NPC APPROACH
	elseIf(optionIndex == scanPeriodIndex)
		Main.scanPeriod = value as int
		SetSliderOptionValue(scanPeriodIndex, Main.scanPeriod, "{0}")
	elseIf(optionIndex == approachChanceIndex)
		Main.approachChance = value as int
		SetSliderOptionValue(approachChanceIndex, Main.approachChance, "{0}")
	elseIf (optionIndex == approachTimeoutIndex)
		Main.approachTimeout = value as int
		SetSliderOptionValue(approachTimeoutIndex, Main.approachTimeout, "{0}")
	elseIf (optionIndex == approachRadiusIndex)
		actorMgr.approachRadius = value as int
		SetSliderOptionValue(approachRadiusIndex, actorMgr.approachRadius, "{0}")
		
	elseIf (optionIndex == approachVaginalChanceIndex)
		PW_approachVaginalChance.SetValue(value as int)
		SetSliderOptionValue(approachVaginalChanceIndex, PW_approachVaginalChance.GetValue(), "{0}%")
		
	elseIf (optionIndex == approachBlowjobChanceIndex)
		PW_approachBlowjobChance.SetValue(value as int)
		SetSliderOptionValue(approachBlowjobChanceIndex, PW_approachBlowjobChance.GetValue(), "{0}%")
	
	elseIf (optionIndex == approachAnalChanceIndex)
		PW_approachAnalChance.SetValue(value as int)
		SetSliderOptionValue(approachAnalChanceIndex, PW_approachAnalChance.GetValue(), "{0}%")
		
	elseIf(optionIndex == swarmChanceIndex)
		main.swarmChance = value as int
		SetSliderOptionValue(swarmChanceIndex, main.swarmChance, "{0}%")
	elseIf(optionIndex == swarmMaxIndex)
		main.swarmMax = value as int
		SetSliderOptionValue(swarmMaxIndex, main.swarmMax, "{0}")
	;elseIf(optionIndex == swarmLOSReqIndex)
	;	main.swarmLOSRequired = value as int
	;	SetSliderOptionValue(swarmLOSReqIndex, main.swarmLOSRequired, "{0}")

	elseIf(optionIndex == declineSexChanceIndex)
		Main.SolicitFailChance.setValue(value as int)
		Main.UpdateCurrentInstanceGlobal(Main.SolicitFailChance)
		SetSliderOptionValue(declineSexChanceIndex, Main.SolicitFailChance.GetValue() as int, "{0}%")

	elseIf(optionIndex == difficultClientChanceIndex)
		Main.difficultClientChance = value as int
		PW_DifficultClientChance.SetValue(value)
		Main.UpdateCurrentInstanceGlobal(PW_DifficultClientChance)
		SetSliderOptionValue(difficultClientChanceIndex, Main.difficultClientChance, "{0}%")
	elseIf(optionIndex == sadisticClientChanceIndex)
		Main.sadisticClientChance = value as int
		PW_SadisticClientchance.SetValue(value)
		Main.UpdateCurrentInstanceGlobal(PW_SadisticClientchance)
		SetSliderOptionValue(sadisticClientChanceIndex, Main.sadisticClientChance, "{0}%")
	
	elseIf(optionIndex == notPayingChanceIndex)
		Main.notPayingChance = value as int
		SetSliderOptionValue(notPayingChanceIndex, Main.notPayingChance, "{0}%")
	elseIf(optionIndex == stealMinValueIndex)
		Main.stealMinValue = value as int
		SetSliderOptionValue(stealMinValueIndex, Main.stealMinValue)
	elseIf(optionIndex == stealMaxValueIndex)
		Main.stealMaxValue = value as int
		SetSliderOptionValue(stealMaxValueIndex, Main.stealMaxValue)
	elseIf(optionIndex == stealMinItemsIndex)
		Main.stealMinItems = value as int
		SetSliderOptionValue(stealMinItemsIndex, Main.stealMinItems)
	elseIf(optionIndex == stealMaxItemsIndex)
		Main.stealMaxItems = value as int
		SetSliderOptionValue(stealMaxItemsIndex, Main.stealMaxItems)
	endIf
	
	
	;PAYMENT
	if(optionIndex == basePayIndex)
		QuotaMgr.basePay = value as int
		SetSliderOptionValue(basePayIndex, QuotaMgr.basePay, "{0}")
	elseIf(optionIndex == payPerLevelIndex)
		QuotaMgr.payPerLevel = value as int
		SetSliderOptionValue(payPerLevelIndex, QuotaMgr.payPerLevel, "{0}")
		
	elseIf(optionIndex == missingReportChanceIndex)
		QuotaMgr.missingReportChance = value as int
		SetSliderOptionValue(missingReportChanceIndex, QuotaMgr.missingReportChance, "{0}%")
		
	elseIf(optionIndex == standardCutIndex)
		QuotaMgr.standardCut = value as int
		SetSliderOptionValue(standardCutIndex, QuotaMgr.standardCut, "{0}%")
	elseIf(optionIndex == overtimeCutIndex)
		QuotaMgr.overtimeCut = value as int
		SetSliderOptionValue(overtimeCutIndex, QuotaMgr.overtimeCut, "{0}%")
		
		
	elseIf (optionIndex == tipMinMultIndex)
		PW_CharmTipMinMult.SetValue(value)
		SetSliderOptionValue(tipMinMultIndex, value, "{1}")
	
	elseIf (optionIndex == tipMaxMultIndex)
		PW_CharmTipMaxMult.SetValue(value)
		SetSliderOptionValue(tipMaxMultIndex, value, "{1}")
		
	elseIf (optionIndex == megaTipChanceIndex)
		PW_CharmMegaTipChance.SetValue(value)
		SetSliderOptionValue(megaTipChanceIndex, value, "{1}")
	
	elseIf (optionIndex == megaTipMultIndex)
		PW_CharmMegaTipMult.SetValue(value)
		SetSliderOptionValue(megaTipMultIndex, value, "{1}")
		
	elseIf(optionIndex == enforcedModeQuotaMultIndex)
		quotaMgr.enforcedModeQuotaMult = value as float
		SetSliderOptionValue(enforcedModeQuotaMultIndex, quotaMgr.enforcedModeQuotaMult, "{1}x")

	elseIf(optionIndex == changeDebuffLevelIndex)
		Punish.debuffLevel = value as int
		SetSliderOptionValue(changeDebuffLevelIndex, Punish.debuffLevel)
		
	elseIf(optionIndex == randomEventChanceIndex)
		Main.randomEventChance = value as int
		SetSliderOptionValue(randomEventChanceIndex, Main.randomEventChance)
		
	;FAME 
	elseIf(optionIndex == HFthresholdIndex)
		Fame.HFthreshold = value as int
		SetSliderOptionValue(HFthresholdIndex, Fame.HFthreshold)
	elseIf(optionIndex == HFdragonbornIndex)
		Fame.HFdragonbornScore = value as int
		SetSliderOptionValue(HFdragonbornIndex, value)
	elseIf(optionIndex == HFpointsPerTitleIndex)
		Fame.HFpointsPerTitle = value as int
		SetSliderOptionValue(HFpointsPerTitleIndex, value)
	elseIf(optionIndex == HFdragonKillIndex)
		Fame.HFdragonKillScore = value as int
		SetSliderOptionValue(HFdragonKillIndex, value)
	elseIf(optionIndex == HFquestCompleteIndex)
		Fame.HFquestScore = value as int
		SetSliderOptionValue(HFquestCompleteIndex, value)
		
	elseIf(optionIndex == SLSFThresholdIndex)
		Fame.SLSFThreshold = value as int
		SetSliderOptionValue(SLSFThresholdIndex, Fame.SLSFThreshold)
		
	elseIf(optionIndex == sexFameThresholdIndex)
		Fame.sexFameThreshold = value as int
		SetSliderOptionValue(sexFameThresholdIndex, Fame.sexFameThreshold)
	
	elseIf(optionIndex == promiscuityMultiplierIndex)
		Fame.promiscuityMultiplier = value as float
		SetSliderOptionValue(promiscuityMultiplierIndex, Fame.promiscuityMultiplier, "{1}x")
		
	elseIf(optionIndex == modestyMultiplierIndex)
		Fame.modestyMultiplier = value as float
		SetSliderOptionValue(modestyMultiplierIndex, Fame.modestyMultiplier, "{1}x")
		
	elseIf(optionIndex == modestyPeriodIndex)
		Fame.modestyPeriod = value as int
		SetSliderOptionValue(modestyPeriodIndex, Fame.modestyPeriod)
		
	;MISCELLANEOUS
	elseIf(optionIndex == offDutyApproachChanceIndex)
		Main.offDutyApproachChance = value as int
		SetSliderOptionValue(offDutyApproachChanceIndex, Main.offDutyApproachChance)
		
	;PUNISHMENT
	elseIf(optionIndex == fakeExecutionChanceIndex)
		Punish.fakeExecutionChance = value as int
		SetSliderOptionValue(fakeExecutionChanceIndex, Punish.fakeExecutionChance)
		
	elseIf(optionIndex == scoreDeclineSexIndex)
		Punish.refusalIncreaseScore = value as int
		SetSliderOptionValue(scoreDeclineSexIndex, Punish.refusalIncreaseScore)
	elseIf(optionIndex == scoreBreakRuleIndex)
		Punish.rulesIncreaseScore = value as int
		SetSliderOptionValue(scoreBreakRuleIndex, Punish.rulesIncreaseScore)
	elseIf(optionIndex == scoreFailQuotaIndex)
		Punish.quotaIncreaseScore = value as int
		SetSliderOptionValue(scoreFailQuotaIndex, Punish.quotaIncreaseScore)
		
	elseIf(optionIndex == scoreAcceptSexIndex)
		Punish.sexDecreaseScore = value as int
		SetSliderOptionValue(scoreAcceptSexIndex, Punish.sexDecreaseScore)
		
	;DEBUG/CONTROL
	elseIf(optionIndex == updatePeriodIndex)
		Main.updatePeriod = value as float
		SetSliderOptionValue(updatePeriodIndex, main.updatePeriod)
		
	else
	
		int index = 1	;Loop through punishments
		while index <= Punish.punishmentTypes	
			if(optionIndex == thresholdConfigIndex[index])
				Punish.rescaleThreshold(index, value as int)
				SetSliderOptionValue(thresholdConfigIndex[index], Punish.punishmentThresholds[index])
			endIf
			index += 1
		endWhile
		
		index = 0		;Loop through random events
		while index < Main.numRandomEvents
			if(optionIndex == randomEventWeightsIndex[index])
				Main.randomEventWeights[index] = value as int
				SetSliderOptionValue(randomEventWeightsIndex[index], Main.randomEventWeights[index])
			endIf
			index += 1
		endWhile
	endIf
	
endEvent


event OnOptionHighlight(int optionIndex)

	if(optionIndex == fameStartEnabledIndex)
		SetInfoText("If checked, you can be made the city whore based off of your reputation for sexual behavior.")
	elseIf(optionIndex == storyStartEnabledIndex)
		SetInfoText("If checked, you can be made the city whore by completing quests in Whiterun and Solitude. Speak to Jarl Balgruuf and ask 'Do you have any work for me, Jarl?' to begin Whiterun's intro quest.")
	elseIf(optionIndex == startInEnforcedModeIndex)
		SetInfoText("If checked, you will start in enforced mode. You will be unable to leave the city (takes precedence over the 'Can't leave' option), equipped with heavier restraints, and have a higher quota.")
	elseIf(optionIndex == introHandlingModeIndex)
		SetInfoText("What will happen if you refuse to go with the guardsto be declared as the public whore.\n   Walk away - nothing\n   Bounty - you will receive a bounty on your head, but otherwise be allowed to leave\n   Bounty + Attack - you will get a bounty and the guards will try to arrest you\n   Made PW Anyway - you'll learn that executive power extends to the guards in declaring a public whore")
	elseIf(optionIndex == introHandlingBountyIndex)
		SetInfoText("How much bounty you will receive when refusing to go with the guards, if applicable.")
	elseIf(optionIndex == guardFGCooldownIndex)
		SetInfoText("How long, as a fraction of one day, the guards will wait between bothering you about being taken to the Thane.")
	elseIf(optionIndex == playerGenderPrefIndex)
		SetInfoText("Only NPCs of this sex can initiate sex with the player.\nNOTE: enabling beastiality content means you will be having sex with male creatures regardless of this setting.")
	elseIf(optionIndex == playerGenderPrefIndex)
		SetInfoText("The player will occasionally get the option to take a dominant role with NPCs of the chosen sex.")
	elseIf(optionIndex == scanPeriodIndex)
		SetInfoText("How often a new NPC should be found to approach the player. For example, if NPC Approach Interval is set to 15 minutes, and approach chance is set to 50%, then there's a 50% chance every 15 minutes that you'll be approached.")
	elseIf(optionIndex == approachChanceIndex)
		SetInfoText("Chance that the NPC found will decide to approach the player. For example, if NPC Approach Interval is set to 15 minutes, and approach chance is set to 50%, then there's a 50% chance every 15 minutes that you'll be approached.")
	elseIf(optionIndex == approachTimeoutIndex)
		SetInfoText("How long, in real seconds, before an approacher gives up trying to get to the player. If they have not spoken to the player after trying to for this long, a new approacher will be found. You probably do not need to modify this, unless for some reason your NPCs are consistently taking more than a minute to get to you.")
	elseIf(optionIndex == approachRadiusIndex)
		SetInfoText("An NPC must be within this range to approach the player. I advise tweaking this value to your preferences. A lower distance will result in fewer approaches, but a higher radius may result in NPCs hunting you down across the entire city.")
	elseIf(optionIndex == approachBlowjobChanceIndex)
		SetInfoText("Chance that an NPC will specifically want vaginal.")
	elseIf(optionIndex == approachBlowjobChanceIndex)
		SetInfoText("Chance that an NPC will specifically want a blowjob.")
	elseIf(optionIndex == approachAnalChanceIndex)
		SetInfoText("Chance that an NPC will specifically want anal.")
	elseIf(optionIndex == canGuardsApproachIndex)
		SetInfoText("Whether or not guards can approach the player.")
	elseIf(optionIndex == canEldersApproachIndex)
		SetInfoText("Whether or not elders can approach the player.")
	elseIf(optionIndex == mcmLockoutIndex)
		SetInfoText("If enabled, the MCM will be locked while you are a public whore anywhere. There is absolutely no way to re-enable it until the job is complete. I do not recommend this, but the option is here if you want it.")
		
		
	elseIf(optionIndex == quotaModeIndex)
		SetInfoText("What you have to do to complete your job as Public Whore.\nCLIENTS: fuck a certain number of people in the given duration.\nGOLD: earn a certain amount of gold in the given duration.\nENDLESS: your service will continue indefinitely. If you leave the city with unreported progress, you will receive a bounty.") ;\nDuration: stay in the city until this long has passed\nAll Three: fuck enough people AND make enough gold AND stay in the city long enough")
	elseIf(optionIndex == minClientQuotaIndex)
		SetInfoText("The lowest possible number of people you'll have to fuck for a client quota");Client/All Three quota.")
	elseIf(optionIndex == maxClientQuotaIndex)
		SetInfoText("The highest possible number of people you'll have to fuck for a client quota") ;All Three quota.")
	elseIf(optionIndex == minGoldQuotaIndex)
		SetInfoText("The lowest possible amount of gold you'll have to turn in for a money quota")	;Money/All Three quota.")
	elseIf(optionIndex == maxGoldQuotaIndex)
		SetInfoText("The highest possible amount of gold you'll have to turn in for a money quota")	;Money/All Three quota.")
	elseIf(optionIndex == reportingPeriodIndex)
		SetInfoText("This is how long you have to meet your quota before you fail it")	;"In Duration mode, you'll be forced to stay in the city being the Public Whore for this duration.\nIn Gold and Client modes, you have this long to meet your quota before you're punished.\nIn All Three, you are forced to stay for this duration, at the end of which your gold and clients are checked.")
		
	elseIf(optionIndex == swarmChanceIndex)
		SetInfoText("When nearby NPCs see you having sex with a client, they may decide to swarm around you and take turns with you when you're finished.")
	elseIf(optionIndex == swarmMaxIndex)
		SetInfoText("This is the maximum number of NPCs that will gang up to you when the queue event starts. The script will attempt to find this many actors, but it may not.")
	;elseIf(optionIndex == swarmLOSReqIndex)
	;	SetInfoText("This many NPCs must have line of sight on the player before a queue event starts. Set to 0 to disable, or if the event isn't occurring as often as it should.")

	elseIf(optionIndex == missingReportChanceIndex)
		SetInfoText("If gold handling is turned off, this is the probability that any given client won't pay for having sex for you. When you go to report, that client will not count towards your progress.")

	elseIf(optionIndex == difficultClientChanceIndex)
		SetInfoText("The chance that a client will decide to give you a hard time, such as ignoring your refusals, making you beg for it, or making you prove you were worth their time.")
	elseIf(optionIndex == sadisticClientChanceIndex)
		SetInfoText("The chance that a client will be excessively cruel, raping you without pay, stealing your items after sex, or various other such infringements upon your rights.\nThis percentage is 'per opportunity to be sadistic', not 'per approach', and there are multiple opportunities, so up to about twice as many approaches as the percent would suggest will result in sadistic behavior.")
	elseIf(optionIndex == cantLeaveIndex)
		SetInfoText("If checked, you won't be allowed to leave the city (in any mode) until you're finished.")
	elseIf(optionIndex == notPayingChanceIndex)
		SetInfoText("The chance that a client will walk away after sex, without paying. You can attempt to get your money at any point after fucking them, but they may not want to pay after they've already gotten away with not paying.")
	elseIf(optionIndex == stealingEnabledIndex)
		SetInfoText("If enabled, difficult or walk-away clients will sometimes steal your items.")
	elseIf(optionIndex == stealMinItemsIndex)
		SetInfoText("The minimum number of items that can be stolen in a stealing event.")
	elseIf(optionIndex == stealMaxItemsIndex)
		SetInfoText("The maximum number of items that can be stolen in a stealing event.")

	;RULES
	elseIf(optionIndex == nudityLevelIndex)
		SetInfoText("None required: nudity not required\nPartial: only body and head equipment is disallowed\nFull: body, head, hands, and feet equipment is disallowed.\nNone of these settings affect jewelry or weapons.")
	elseIf(optionIndex == restraintsRemovalEnabledIndex)
		SetInfoText("If checked, the Thanes will provide you with a Devious Devices Restraints Key when you're freed.")

	;PAYMENT
	elseIf(optionIndex == playerHandlesGoldIndex)
		SetInfoText("If unchecked, the Thanes will not trust a lowly prostitute to handle the city's income. Citizens will be responsible for remembering to pay the Thane directly, meaning there's more incentive to just not pay you.")
	elseIf(optionIndex == standardCutIndex)
		SetInfoText("You will get to keep this much of the gold you turn in.")
	elseIf(optionIndex == overtimeCutIndex)
		SetInfoText("(Only applies in Client Quota Mode) You will get to keep this much of the gold you make from clients past your quota, on top of the standard cut above. This is additive, so for example if standard cut is 15% and overtime cut is 30%, you keep 45% of the gold from overtime clients.")
	
	elseIf(optionIndex == usingDDIndex)
		SetInfoText("Toggle DD features on or off for this mod. While on, you will have to wear restraints as the city whore. Generally it's only a collar, but not being compliant can result in more being added to your expected uniform.")
	elseIf(optionIndex == usingSLSFIndex)
		SetInfoText("Toggle SLSF features on or off for this mod. While on, you can be made the city whore just by having a high enough SLSF fame value in a city.")
	elseIf(optionIndex == usingSlaveTatsIndex)
		SetInfoText("Toggle SlaveTats features on or off for this mod. While on, you will be tattooed when you become the city whore, and 'un-tattooed' when your duty is complete.")
	;elseIf(optionIndex == usingZaZIndex)
	;	SetInfoText("Toggle ZaZ features on or off for this mod. While on, ZaZ furniture is used in some punishment scenes. Note - having this disabled may cause some scenes to be skipped.")
	
	
	elseIf(optionIndex == enforcedModeQuotaMultIndex)
		SetInfoText("Your quotas will be multiplied by this when you are sent into Enforced Mode.")
	elseIf(optionIndex == enforcedModeInventoryTakenIndex)
		SetInfoText("If toggled on, your entire inventory will be removed during Enforced Mode, and only returned to you after you've finished.")
	elseIf(optionIndex == enforcedModeHeavierRestraintsIndex)
		SetInfoText("If toggled on, you will be outfitted with a yoke and ankle shackles when Enforced Mode begins.")
		
		
	elseIf(optionIndex == returnItemsIndex)
		SetInfoText("Returns all items that have currently been taken from the player.")
	
	elseIf(optionIndex == randomEventChanceIndex)
		SetInfoText("The chance that one of the random events below will replace a standard NPC approach.")
		
	;FAME 
	elseIf(optionIndex == isPlayerThaneIndex)
		SetInfoText("Is the player the thane of " + PW_Constants.GetCityName(tracker.lastLocIndex) + "?")
	
	elseIf(optionIndex == SLSFThresholdIndex)
		SetInfoText("If your combined SLSF fame of the types below exceeds this number in any given location, you will be eligible to become the city whore there.")
	
	elseIf(optionIndex == slsfTotalIndex)
		SetInfoText("Your current total SLSF fame.")
		
	elseIf(optionIndex == sexFameThresholdIndex)
		SetInfoText("If your sex fame score exceeds this number in any given location, you will be eligible to become the city whore there.")
	
	elseIf(optionIndex == promiscuityMultiplierIndex)
		SetInfoText("For every consecutive day you are seen having sex, your fame will be multiplied by this amount to simulate the spread of rumors. Set to 1.0 to disable.")
		
	elseIf(optionIndex == modestyMultiplierIndex)
		SetInfoText("For every consecutive day your sex fame doesn't increase, your fame will be multiplied by this amount to simulate rumors dying down. Set to 1.0 to disable.")
		
	elseIf(optionIndex == modestyPeriodIndex)
		SetInfoText("You must not have gained fame for this many days before the modesty multiplier above is applied. Only applies to PW fame - SLSF fame decays as per its own configuration.")

	elseIf(optionIndex == fameTotalIndex)
		SetInfoText("Your current sex fame score.")
		
	;DEBUG 
	elseIf(optionIndex == updatePeriodIndex)
		SetInfoText("Sets how often the mod performs periodic work. The mod will be more responsive at lower settings, and have less performance impact at higher settings.")
	elseIf(optionIndex == debugStopSceneIndex)
		SetInfoText("Stops the currently running scene and returns you to where you were before.")
	
	elseIf(optionIndex == debugDHLPResumeIndex)
		SetInfoText("Sends a 'dhlp-Resume' event. Best not to use this unless you know what that means.")
	
	
	else
		int index = 0
		while index < Main.numRandomEvents
			if(optionIndex == randomEventWeightsIndex[index] && showRandomEventDescs)
				SetInfoText(main.randomEventDescs[index])
			endIf
			index += 1
		endWhile
	endIf
endEvent


int function disabledIfFalse(bool predicate)
	if(predicate)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	endIf
endFunction


function ChangeFamePage(int locIndex)
{change all options on the Fame page to represent a different location}

	if(locIndex < 0 || locIndex > 8)
		locIndex = 6
	endIf

	SetMenuOptionValue(fameLocSelectorIndex, cityNames[locIndex], true)
	;HERO
	SetTextOptionValue(HFtotalIndex, Fame.calculateHeroFame(locIndex), true)
	SetToggleOptionValue(isPlayerThaneIndex, Fame.isPlayerThane[locIndex], true)
	
	
	;PROMISCUOUS
	SetTextOptionValue(bestialityFameIndex,     Fame.CalculateSexFame(locIndex, constants.FAME_TYPE_BESTIALITY), true)
	SetTextOptionValue(exhibitionistFameIndex,  Fame.CalculateSexFame(locIndex, constants.FAME_TYPE_EXHIBITIONIST), true)
	SetTextOptionValue(slutFameIndex,           Fame.CalculateSexFame(locIndex, constants.FAME_TYPE_SLUT), true)
	SetTextOptionValue(submissiveFameIndex,     Fame.CalculateSexFame(locIndex, constants.FAME_TYPE_SUBMISSIVE), true)
	SetTextOptionValue(whoreFameIndex,          Fame.CalculateSexFame(locIndex, constants.FAME_TYPE_WHORE), true)
	
	
	return
endFunction

	
function changeStatusPage(int locIndex)
{change all options on the Status page to represent a different location}
	SetMenuOptionValue(currStatusLocSelectorIndex, cityNames[locIndex], true)
	
	if(Tracker.GetStatus(locIndex) == 0 && Fame.eligibilityTimeoutDays[locIndex] > 0)
			SetTextOptionValue(currentLocStatusIndex, pwStatus[Tracker.GetStatus(locIndex)] + " for " + Fame.eligibilityTimeoutDays[locIndex] + " days", false)
	else
			SetTextOptionValue(currentLocStatusIndex, pwStatus[Tracker.GetStatus(locIndex)], false)
	endIf

	if(!QuotaMgr.playerHandlesGold)
		if(QuotaMgr.quotaMode == 0)
			SetTextOptionValue(nghExpectedClientsIndex, (QuotaMgr.nghExpectedClients[locIndex] as string) + " clients", true)
			SetTextOptionValue(cumulativeClientsIndex,(QuotaMgr.cumulativeClients[locIndex] as string) + " clients", true)
			SetTextOptionValue(currentQuotaIndex, (QuotaMgr.clientQuotas[locIndex] as string) + " clients", true)
			SetTextOptionValue(expectedGoldIndex, (QuotaMgr.calculatePay() * QuotaMgr.recentClients[locIndex]), true)
		elseIf(QuotaMgr.quotaMode == 1)
			SetTextOptionValue(nghExpectedGoldIndex, (QuotaMgr.nghExpectedGold[locIndex] as string) + " gold", true)
			SetTextOptionValue(cumulativeGoldIndex, (QuotaMgr.cumulativeGold[locIndex] as string) + " gold", true)
			SetTextOptionValue(currentQuotaIndex, (QuotaMgr.goldQuotas[locIndex] as string) + " gold", true)
		endIf
			
	elseIf(QuotaMgr.quotaMode == 0)
		SetTextOptionValue(currentQuotaIndex, (QuotaMgr.clientQuotas[locIndex] as string) + " clients", true)
		SetTextOptionValue(cumulativeClientsIndex, (QuotaMgr.cumulativeClients[locIndex] as string) + " clients", true)
		SetTextOptionValue(recentClientsIndex, (QuotaMgr.recentClients[locIndex] as string) + " clients", true)
		SetTextOptionValue(recentClientsIndex, (QuotaMgr.overtimeClients[locIndex] as string) + " clients", true)
	endIf
	
	
	
	SetTextOptionValue(punishmentScoreIndex, Punish.punishmentScores[locIndex], true)

	SetTextOptionValue(thresholdServiceExtension, "at " + Punish.getNextThreshold(locIndex, 1), true)
	SetTextOptionValue(thresholdPublicRape, "at " + Punish.getNextThreshold(locIndex, 2), true)
	SetTextOptionValue(thresholdLightTorture, "at " + Punish.getNextThreshold(locIndex, 3), true)
	SetTextOptionValue(thresholdHeavyTorture, "at " + Punish.getNextThreshold(locIndex, 4), true)
	SetTextOptionValue(thresholdExecution, "at " + Punish.getNextThreshold(locIndex, 5), true)

endFunction
