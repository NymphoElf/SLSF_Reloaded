Scriptname PW_IntroDetectionScript extends PW_ScriptComponent Conditional
{Manages transitions between states - ineligible, eligible, city whore}

import PW_Utility

PW_MainLoopScript property Main Auto
PW_ModIntegrationsScript property Mods Auto
PW_TrackerScript property Tracker Auto
PW_QuotaManagerScript property QuotaMgr auto

int currentLocIndex = -1
int lastLocIndex = -1

;MCM Variables
bool property storyStartEnabled = true Auto Conditional
bool property allHolds = false Auto	;Currently not working

ReferenceAlias property PlayerRef Auto
ReferenceAlias property InformingGuard Auto
ReferenceAlias property LocalPWThane Auto
ReferenceAlias property PWThaneGreetPlayer Auto
ReferenceAlias property PW_HFThaneGreet Auto

Quest property WhiterunStartup Auto
ReferenceAlias property WRJarl Auto

PW_HoldQuestScript[] property HoldQuestScripts Auto
Quest[] property HoldQuests Auto


Actor player

Faction property isGuardFaction Auto

;'State' variables
Location property currentLoc Auto
Bool property isGuardApproaching = false Auto Conditional
Bool property introUnfinished = false Auto Conditional
Float property introStart = 0.0 Auto Conditional
Bool property introCompletedOnce = false Auto Conditional
Float guardApproachStart

ImageSpaceModifier property FadeToBlack auto

Scene property PlayerTakenToThane Auto
Float[] property guardInformCooldowns Auto
Float property guardInformReset = 0.125 Auto

Float updatePeriod = 8.0

bool[] property heroFameEligible Auto

Scene property eligibilityGuardFgScene Auto

PW_ActorManagerScript property actorMgr Auto

function Initialize()
	player = Game.GetPlayer()
	RegisterForSingleUpdate(3)

	heroFameEligible = new bool[9]
	guardInformCooldowns = utility.createFloatArray(9, -guardInformReset)
	
endFunction

function Startup()
	RegisterForModEvent("PW_EnterCity", "OnEnterCity")
	RegisterForModEvent("PW_LeaveCity", "OnLeaveCity")
	RegisterForModEvent("PW_BecamePublicWhore", "OnBecameWhore")
	RegisterForModEvent("PW_BecameEligible", "OnMadeEligible")
	RegisterForModEvent("PW_StatusCleared", "OnStatusCleared")
	RegisterForModEvent("PW_MakeEligibleHeroFame", "OnMadeHeroFameEligible")
	RegisterForModEvent("PW_QuestInternalsReady", "onQuestInternalsReady")
	
endFunction

event OnEnterCity(int locIndex)
	currentLocIndex = locIndex
	LocalPWThane.ForceRefTo(Tracker.pwThanes[locIndex])
	
	lastLocIndex = locIndex
	
	RegisterForSingleUpdate(updatePeriod)
endEvent

event OnLeaveCity(int locIndex)
	currentLocIndex = -1
	
	UnregisterForUpdate()	;Probably don't want to monitor while not in a city
endEvent


event OnUpdate()

	if(!Main.modEnabled || Tracker.currentLocIndex == -1)
		return
	endIf
	
	PW_Utility.pwDebug(self, 1, "OnUpdate")
	
	if(Main.playercurrentStatus == 1)
		if(!eligibilityGuardFgScene.isPlaying())
			if(Utility.GetCurrentGameTime() - guardInformCooldowns[currentLocIndex] >= guardInformReset && !Main.approachesSuspended)
				attemptStartGuardApproach()
			else
				PW_Utility.pwDebug(self, 1, "guard approach on cooldown")
			endIf
		else ;a guard is approaching
			if((Utility.GetCurrentRealTime() - guardApproachStart >= 20.0))
				PW_Utility.pwDebug(self, 1, "guard approach timed out")
				clearGuardApproach()
			else
				PW_Utility.pwDebug(self, 1, "guard is approaching")
			endIf
		endIf
		RegisterForSingleUpdate(updatePeriod)
	else
		UnregisterForUpdate()
		PW_Utility.pwDebug(self, 1, "unregister for update")
		
	endIf

endEvent

event OnMadeHeroFameEligible(int locIndex)
	pwDebug(self, 1, "intro hero fame toggled")
	heroFameEligible[locIndex] = true;
	RegisterForSingleUpdate(updatePeriod)
endEvent

event OnMadeEligible(int locIndex)
	pwDebug(self, 1, "player became eligible, re-registering for update")
	RegisterForSingleUpdate(updatePeriod)
endEvent

event OnStatusCleared(int locIndex)
	;HoldQuestScripts[locIndex].stop()
endEvent

function attemptStartGuardApproach()
	PW_Utility.pwDebug(self, 3, "attempting eligibility guard approach")
	actor guard = actorMgr.GetValidActorGuard(losNeeded = false) ;Attempt to find guard
	if(guard != none)	;If it exists...
		InformingGuard.ForceRefTo(guard)
		startCooldownHere()
		eligibilityGuardFgScene.Start()
		isGuardApproaching = true
		guardApproachStart = Utility.GetCurrentRealTime()
		PW_Utility.pwDebug(self, 3, "guard approach started: " + guard.GetLeveledActorBase().GetName())
	else
		PW_Utility.pwDebug(self, 3, "guard not found");
	endIf
endFunction

function clearGuardApproach()
	PW_Utility.pwDebug(self, 1, "clearing guard approach")
	Actor guard = InformingGuard.GetActorReference()
	InformingGuard.Clear()
	guard.EvaluatePackage()
	
	if(eligibilityGuardFgScene.isPlaying())
		eligibilityGuardFgScene.Stop()
	endIf
	
	isGuardApproaching = false
endFunction


function fadeoutPlayerToPWThane(Actor escort)

	FadeToBlack.ApplyCrossFade(1.0)
	Utility.Wait(2.0)
	Debug.MessageBox("The guard escorts you through the city, and you get the sense that you're the only one who doesn't know what's going to happen. From every corner of the city, people watch you, whispering to each other. Some look afraid, or astonished, while others look overjoyed.")
	actor thaneActor = LocalPWThane.GetActorRef()
	player.MoveTo(thaneActor, 120.0 * Math.Sin(thaneActor.GetAngleZ()), 120.0 * Math.Cos(thaneActor.GetAngleZ()))
	player.setAngle(player.GetAngleX(), player.GetAngleY(), player.GetAngleZ() + player.GetHeadingAngle(thaneActor))
	thaneActor.setAngle(thaneActor.GetAngleX(), thaneActor.GetAngleY(), thaneActor.GetAngleZ() + thaneActor.GetHeadingAngle(player))
	Utility.Wait(1.0)
	Debug.MessageBox("As you enter the Jarl's hall, another guard nods at the one escorting you. You get the feeling they're referring to you in some way but are unsure how. It feels like the entire hold is staring at you. You try to act confident but can't quite suppress a shiver.")
	Utility.Wait(1.0)
	Debug.MessageBox("The doors swing shut, and as they do, you think you hear some muffled applause from the streets outside. The guard puts a firm hand around your arm and nearly shoves you forward, putting you face to face with " + LocalPWThane.GetActorRef().GetLeveledActorBase().GetName() + ".")
	
	

	Utility.Wait(1.0)
	ImageSpaceModifier.RemoveCrossFade(1.0)

	if(heroFameEligible[Tracker.currentLocIndex])
		PW_HFThaneGreet.ForceRefTo(LocalPWThane.GetActorReference())
	else
		PWThaneGreetPlayer.ForceRefTo(LocalPWThane.GetActorRef())
	endIf
	
	introUnfinished = true
	introStart = Utility.GetCurrentGameTime()
	return
endFunction

function startCooldownHere()
;Sets the introductory guard approach on cooldown in the current hold

	guardInformCooldowns[Tracker.currentLocIndex] = Utility.GetCurrentGameTime()
	
	PW_Utility.pwDebug(self, 1, "Intro Cooldown started")
	
	;if(allHolds)
	;	int index = 0
	;	while(index <= 8)
	;		guardInformCooldowns[Tracker.currentLocIndex] = Utility.GetCurrentGameTime()
	;		index += 1
	;	endWhile
	;endIf

	sendEvent("PW_UpdateLocInfo")
	return
endFunction

event onQuestInternalsReady(int locIndex)
	HoldQuestScripts[locIndex].reset()
	HoldQuestScripts[locIndex].start()
endEvent
