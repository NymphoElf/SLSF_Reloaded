Scriptname PW_SQ_BanditsScript extends PW_SideQuestScript  Conditional

import PW_Utility

SexlabFramework property Sexlab Auto

PW_ModIntegrationsScript property mods Auto

bool property distractionEventGiven = false Auto Conditional


bool property gangbangFailed = false Auto Conditional

GlobalVariable property PW_SQ_BanditsCount Auto
GlobalVariable property PW_SQ_BanditsTotal Auto

LocationAlias property Alias_Location Auto
ReferenceAlias property turncoatBandit Auto

int property banditFavor = 0 Auto Conditional

function RegisterForEvents()
	RegisterForModEvent("PW_UpdateLocInfo", "OnPlayerLocationChanged")
	RegisterForModEvent("PW_StatusCleared", "OnStatusCleared")
	RegisterForModEvent("PW_SetEnforcedMode", "OnEnterEnforcedMode")
endFunction

event OnPlayerLocationChanged()
	if getStage() < 10
		if !Game.GetPlayer().IsInLocation(Alias_Location.GetLocation())
			stop()
		EndIf
	EndIf
endEvent

event OnStatusCleared(int locIndex)
	if(locIndex == questLocIndex)
		EndQuest()
	endIf
endEvent

event OnEnterEnforcedMode(int locIndex)
	EndQuest()
endEvent

function EndQuest()
	SetStage(201)
endFunction


function IncrementBanditsFucked()
	if (ModObjectiveGlobal(1, PW_SQ_BanditsCount, aiObjectiveID = 20, afTargetValue = PW_SQ_BanditsTotal.GetValue() as int))
		SetOutcome()
	endIf
endFunction

function IncreaseBanditFavor()
	banditFavor += 1
endfunction

function DecreaseBanditFavor()
	banditFavor -= 1
endFunction


function SetOutcome()
	if(banditFavor > 2 && Mods.usingSDPlus)
		SetStage(31)
	elseIf(banditFavor < -2 && Mods.usingSimpleSlavery)
		SetStage(32)
	else
		SetStage(30)
	endIf
endFunction

;Distraction Scene
Actor[] property banditList Auto
int banditListUsed = 0 ;highest used index
ReferenceAlias[] property BanditAliases Auto
bool findingBandits = false
int property distractedBanditCount = 0 Auto


bool property distractionEventActive = false Auto Conditional

bool property sceneConditionStartGangBang = false Auto Conditional

Scene property distractionScene Auto

bool function RegisterDistractedBandit(actor bandit)
	if(findingBandits == false) ; Means distract power was just cast, kick off a timed update to delay the scene start, so that the other bandits register first
		findingBandits = true
		banditList = new Actor[10]
		banditListUsed = 0
		RegisterForSingleUpdate(8.0)
		Debug.MessageBox("You begin calling out to distract the camp.")
	endIf

	if(banditListUsed < banditList.length - 1 && bandit != turncoatBandit.GetActorReference())
		banditList[banditListUsed] = bandit
		banditListUsed += 1
	endIf

	if(distractedBanditCount < BanditAliases.length && bandit != turncoatBandit.GetActorReference())
		BanditAliases[distractedBanditCount].forceRefTo(bandit)
		banditList[distractedBanditCount] = bandit
		distractedBanditCount += 1
		return true
	else
		return false
	endIf
		
endFunction

; Kicks off distraction scene. At this point all applicable bandit aliases should be filled
event OnUpdate()
	distractionScene.ForceStart()
endEvent

int function DistractionSceneCYA()
	
	string pronoun = "she"
	if(Game.GetPlayer().GetLeveledActorBase().GetSex() == 0)
		pronoun = "he"	
	endIf

	int choice = cyaStart.Show()

	if (choice == 0) ;dance
		choice = cyaDance.Show()
	
		if (choice == 0)	;keep dancin
			Debug.MessageBox("You continue to dance, trying your hardest to keep the bandits' attention. Your body becomes slick with sweat, and you struggle to keep your breath as maintaining their attention demands more and more extravagant sequences." \
								+ " Some lose interest, but luckily none seem to notice the fleeing bandit, who is now well out of sight. Enticed by your movements, many of the bandits prepare to have their way with you.")
			sceneConditionStartGangBang = true
			IncreaseBanditFavor()
			
		elseIf (choice == 1) ;oh no i falled
			Debug.MessageBox("You let one of your feet catch on a rock, and let your body crash to the ground ungracefully. The camp erupts in laughter at the sight of this, and you let yourself blush in embarassment. The bandits start walking back to their tents, "\
								+ "cracking jokes about the whore who thought " + pronoun + " was a dancer. In their merriment, none of them notice the escapee vanishing over the horizon.")
			IncreaseBanditFavor()
			
		elseIf (choice == 2) ;give em what they want
			if(pronoun == "he")
				Debug.MessageBox("You start to caress and grab yourself more and more, and eventually drop to your knees and begin stroking as though the stimulation had completely overwhelmed you. The bandits watch you do this, slightly confused but very entertained, "\
									+ "for some time, while they drink. Some get a bit more hands on, grabbing at you. Once the escaping bandit is no longer visible, you end your show.")
				IncreaseBanditFavor()
				
			else
				Debug.MessageBox("You start to caress and grab yourself more and more, and eventually drop to your knees and start fingering yourself while clutching at one breast, as though the stimulation had completely overwhelmed you. The bandits watch you do this, slightly confused but very entertained, "\
									+ "for some time, while they drink. Some get involved in the process, pulling on your tits or slapping your ass. Once the escaping bandit is no longer visible, you end your show.")
				IncreaseBanditFavor()
				
			endIf

		endIf ;end dance if

	elseIf (choice == 1) ;skeever
		choice = cyaSkeever.Show()

		if (choice == 0) ;there it is again!
			Debug.MessageBox("You let out a girlish scream and point in the direction opposite the fleeing bandit, yelling that you saw it again. The bandits continue to shout insults and slurs at you, and go back to what they were doing before. "\
								+ "Some of them probably noticed the escapee, but since it's a bandit camp and not a prison, seem not to have thought anything of one leaving.")
			DecreaseBanditFavor()
			
		elseIf (choice == 1) ;yes I am a dumb whore
			Debug.MessageBox("You profusely apologize and agree that you are in fact a stupid fuckslut, who shouldn't speak unless spoken to. You ask them to show you what you're good for, and they gather around to do so.")
			sceneConditionStartGangBang = true
			IncreaseBanditFavor()
			
		elseIf (choice == 2) ;hygiene
			Debug.MessageBox("You state that dismissing a potential skeever infestation would be the end of any proper business, and explain that the fastest route to getting Ataxia is leaving food out that the rodents might nibble on. "\
								+ "It's evident that this is new knowledge to some of them, but almost all of them laugh at you regardless. After all, what would a whore know about hygiene?")
			DecreaseBanditFavor()
			
		endIf

	elseIf (choice == 2)
		choice = cyaThuum.Show()	

		if (choice == 0) ;backstory time
			Debug.MessageBox("You describe how, by official decree, you were declared a public whore. Some of the bandits laugh at you for letting this happen, while others seem skeptical that that would ever even happen. "\
								+ "One asks the boss about how much the Dragonborn would go for at the auction house.")
			IncreaseBanditFavor()
								
		elseIf (choice == 1) ;fuck me while you can
			Debug.MessageBox("You tell them that you won't always be a whore, and that they should spend every minute they can fucking a helpless, submissive Dragonborn. This resonates well with the bandits, and you see a hunger in their eyes "\
								+ "as they begin to grab you, prepared to pillage your body for all it's worth.")
			sceneConditionStartGangBang = true
			IncreaseBanditFavor()
			
		elseIf (choice == 2) ;taking charge
			Debug.MessageBox("You realize that the bandits are slightly afraid of your Thu'um, and decide to tell them that you can snap their necks with your voice alone. You feel a shift in the air, as control of the situation becomes yours. Now that they are actually listening, "\
								+ "you turn to the leader and state that they can either comply with the Jarl, or deal with you. The leader nods to one of the lackeys, who leads a pair of prisoners out of the camp, back towards the city.")
			SetStage(41)
		endIf

	endIf

	return choice
endFunction


actor[] gangbangQueue

; A mostly stripped down function that could maybe turn into something nice if it didn't fucking break all the time
; TODO use the skeleton of this for an isolated sex queueing component. Actor array goes in, sex animations and status mod events come out
function StartGangbang()

	if(banditListUsed < 2)
		gangbangFailed = true
		return
	endIf

	;/-- Create gangbang queue --/;
	gangbangQueue = new actor[6]
	int queuePos = 0

	int banditListIndex = 0
	int numPasses = 0

	;Loop until we've scanned banditList 3 times, or the queue is full
	while  (numPasses < 3 && queuePos < gangbangQueue.length) 
		;Don't want nones or consecutive duplicates
		if (banditList[banditListIndex ] != none ) 
			gangBangQueue[queuePos] = banditList[banditListIndex]
			queuePos += 1
		endIf
		
		;Increment bandit search index, and if it's reached max, loop around so we can fill the queue with the same actors. Guarantees loop exit.
		banditListIndex += 1
		if (banditListIndex >= banditListUsed)
			banditListIndex = 0
			numPasses += 1
		endIf

	endWhile

	;/-- Sanity check --/;
	int i = 0
	while (i < gangbangQueue.length)

		; If any are none, it's bad, and we want to stop now before more shit goes wrong
		if(gangbangQueue[i] == none)
			gangbangFailed = true
			return
		endIf

		i += 1
	endWhile

	;/-- Do Gangbang --/;
	StartGangBangSex()
		
endFunction

int property numGangbangs = 0 auto conditional
int gangbangIndex = 0
function StartGangbangSex()

	;RegisterForModEvent("HookAnimationEnd_pwSQBanditGangbang", "OnGangbangEnd")

	sslThreadModel Thread = Sexlab.NewThread()
	Thread.AddActor(Game.GetPlayer())

	Thread.AddActor(banditList[gangbangIndex])
	Thread.AddActor(banditList[gangbangIndex + 1])
	gangbangIndex += 2

	Thread.SetHook("pwSQBanditGangbang")
	Thread.StartThread()
endFunction


event OnGangbangEnd(int tid, bool HasPlayer)
	Utility.Wait(1.0)
	numGangBangs += 1

	if(numGangbangs < 3)
		StartGangbangSex()
	endIf
endEvent

;Called via sexlab hook
event PlayChairStory(int tid, bool HasPlayer)

	int stamina = Game.GetPlayer().GetActorValue("Stamina") as int

	fadeToBlack.ApplyCrossfade(2.0)
	Utility.Wait(3.0)
	Debug.MessageBox("The bandit fucks about as well as you would expect a bandit to, then looks at you with an 'I told you so' expression. You are then pushed down onto your hands and knees as they take their spot sitting on your back.")
	
	if(stamina<= 150)
		Debug.MessageBox("Almost immediately your strength fails, and you collapse to the ground. The bandit grunts in disappointment, but sits on you nonetheless, keeping you pinned against the ground for the remaining four hours.")
	elseIf(stamina <= 300)
		Utility.Wait(3.0)
		Debug.MessageBox("After what you hope was an hour, your arms begin to lose feeling, and your back begins to hurt. The bandit, however, seems quite comfortable.")
		Utility.Wait(3.0)
		Debug.MessageBox("You nearly fall when the bandit moves to try and dodge a bottle thrown from somewhere else in the camp. You're given a slap on the ass as a reward for remaining upright.")
		Utility.Wait(3.0)
		Debug.MessageBox("Eventually the bandit stands up, and you are free to go about your business again, your arms and back feeling broken.")
	else
		Utility.Wait(3.0)
		Debug.MessageBox("Thanks to your endurance, you manage to dutifully hold the bandit up for the entire four hours. Occasionally you get a slap on the ass, or mead poured down your throat, explained as rewards for being such a stable chair.")
	endIf
	

	fadeToBlack.Remove()
	
endEvent


Message property cyaStart Auto

Message property cyaDance Auto

Message property cyaSkeever Auto

Message property cyaThuum Auto

ImageSpaceModifier property fadeToBlack Auto
