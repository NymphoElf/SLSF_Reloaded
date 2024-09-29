Scriptname PW_PunishmentPlayerScript extends ReferenceAlias  

PW_PunishmentScript property Punish Auto

ReferenceAlias property TorturerRef Auto

int numOfHits = 0
int requiredHits = 45

bool trackingHits = false

Spell property torturerShock Auto
int torturerShockExposure = 0


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	GotoState("Busy")
	Actor Player = Game.GetPlayer()
	if(akAggressor == TorturerRef.GetReference() && trackingHits)
		numOfHits += 1
	endIf

	int playerSex = Player.GetLeveledActorBase().GetSex()

	if(akSource == torturerShock && Player.GetActorBase().GetSex() == 1)
		if(Punish.activeScene == 4 && Punish.sceneStage < 4)
			if(torturerShockExposure == 0 && playerSex == 1)
				Debug.MessageBox("A burst of electricity jets out of the torturer's hand and enwreathes your whole body in lightning. Oddly the lightning does not hurt too badly - you feel as though needles are stabbing into your body in a thousand places, but it isn't as agonizing as you expected it would be.")
				Debug.MessageBox("As the spell continues to surge through you, it suddenly becomes much more intense in your breasts, filling them with a buzzing warmth.")
				torturerShockExposure += 1
			elseIf(torturerShockExposure == 3)
				Debug.MessageBox("The second pulse of lightning from the torturer causes your breasts to become incredibly warm, and sends a buzz down your spine, causing the warmth to spread to your thighs, and into your womanhood. The spell is beginning to hurt more, but for some reason the pain caused by the spell is almost... pleasant.")
				torturerShockExposure += 1
			elseIf(torturerShockExposure == 12)
				Debug.MessageBox("To your surprise, the continued shocks are beginning to feel amazing - each jolt sends a wave of stimulating pleasure through you, followed by a dull crackling pain that you begin to crave. Your nipples perk up in excitement, your pussy becomes moist, and all of the thoughts begin to rush out of your head. The spell starts to take control of you, letting you focus on nothing but physical pleasure.")
				torturerShockExposure += 1
			elseIf(torturerShockExposure == 15) ;&& player strong willed
				Debug.MessageBox("'No!' you think, trying to bring yourself to your senses. You notice that a trail of drool had trickled out of your mouth, and between bursts of the spell you try, only partially successfully, to wipe it away. This must be what the torturer wants - to reduce you to nothing more than a sex-seeking animal. 'I won't be broken like this,' you promise yourself.")
				torturerShockExposure += 1
			else
				torturerShockExposure += 1
			endIf
		endIf

		int eid = ModEvent.Create("slaUpdateExposure")
		ModEvent.pushForm(eid, Player)
		ModEvent.pushFloat(eid, 5.0)
		ModEvent.send(eid)
	endIf
	GoToState("")
EndEvent

function startTrackingHits()
	trackingHits = true
	return
endFunction

function checkHits()
	if(numOfHits >= requiredHits)
		Punish.pwDgConHitEnough = true
	endIf
	return
endFunction

function resetHits()
	numOfHits = 0
	Punish.pwDgConHitEnough = false
	return
endFunction

State Busy
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		;OnHit Busy
	EndEvent
EndState