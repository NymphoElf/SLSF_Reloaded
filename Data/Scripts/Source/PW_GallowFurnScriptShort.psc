Scriptname PW_GallowFurnScriptShort extends ObjectReference  
{Furniture Version of the Bound Hanging Script}
;Otherwise known as PamaÅLs Ultimate GallowScript. Have Fun!

;internal Variables///////////////////////////////////////////////////////////////////////
Actor AttachedActor
string HeadAttachNode ="NPC Head [Head]"
string NeckAttachNode = "npc neck [neck]"
string RopeAttachNode = "Vert05"
string RopeAttachNode2 = "Vert06"
string DummyAttachNode="AttachDummy"

float starthealth
float health

bool sprung
bool isFemale
bool isGagged
bool playerVictim
bool autoplay

string lh ="NPC L Hand [LHnd]"
string rh ="NPC R Hand [RHnd]"
string  rf ="NPC R Foot [Rft ]"
string  lf ="NPC L Foot [Lft ]"

float dummyX
float dummyY
float dummyZ

float NeckX
float NeckY
float NeckZ

int humanSound
int deviceSound

;Functional Proprties/////////////////////////////////////////////////////////////////////////
objectreference property Trapdoor Auto
objectreference property rope Auto
objectreference property dummy Auto
objectreference property wheel Auto
objectreference property lever Auto

;optional Functionalitys///////////////////////////////////////////////////////////////////////
Bool property automaticForPlayer Auto
Bool property automaticForNPC Auto
Bool property TieFeet Auto
Bool property removeCuffsOnRelease Auto
Bool property onlyRopeShootdown Auto
Bool property nonLethal auto
float property timerPhase1 Auto
float property timerPhase2 auto
float property damageModifierPlayer auto
float property damageModifierNPC auto
float property deathCamDuration auto

;cosmetic Options/////////////////////////////////////////////////////////////////////////////
armor property collar Auto
armor property cuffs Auto

;sound Options/////////////////////////////////////////////////////////////////////////////////////
Sound Property soundFemaleRecovery  auto
Sound Property soundMaleRecovery  auto
Sound Property soundFemaleWaiting  auto
Sound Property soundMaleWaiting  auto
Sound Property soundSlowCreak  auto
Sound Property soundFastCreak  auto
Sound Property soundTrapdoor  auto
sound property soundFemaleChoking auto
sound property soundMaleChoking auto
zbfBondageShell Property zbf  Auto


;interesting Stuff beginns here///////////////////////////////////////////////////////////////////
Event OnCellLoad()
	Initialize()
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack,  bool abBashAttack, bool abHitBlocked)
	Initialize()
EndEvent

Event OnActivate(Objectreference user)
	Initialize()
EndEvent


State standby

	Event OnActivate(Objectreference user)

		if user==lever
			Trapdoor()
			return
		ElseIf user==wheel 
			;Debug.Notification("no Victim")
			;Utility.SetINIFloat("fOverShoulderPosZ:Camera", -100)
			;Game.UpdateThirdPerson()
			return
		ElseIf user == rope
			return
		endIf

		AttachedActor =user as Actor	

		CleanupConstraints()
		
		if AttachedActor.getSitstate() == 4 
			return
		EndIf

		if AttachedActor != Game.getPlayer()
			attachedActor.setrestrained(true)
			playerVictim = false
		Else
			playerVictim=true
		EndIf
			
		self.BlockActivation(true)
	
		if !autoplay
			if playerVictim && automaticForPlayer
				autoplay=true
				;game.getPlayer().setRestrained()
				;Game.DisablePlayerControls(true, true, false,false,true,true,false,false)
			EndIf
			if !playerVictim && automaticForNPC
				autoplay=true
			EndIf
		EndIf

;original------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		;dummy.enable()
		;utility.wait(0.2)
		;dummy.splineTranslateTo(dummyX+(0.0), dummyY-(30.0), dummyZ-(6.0), 0, 0, 0,100,100)
		;DummyAttach()

		;dummy.splineTranslateTo(dummyX+(0.0), dummyY-(0.0), dummyZ-(6.0), 0, 0, 0, 30,30)
;original------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		dummy.enable()
		utility.wait(0.1)
		dummy.MoveToNode(AttachedActor, NeckAttachNode)
		utility.wait(0.1)
		neckX=dummy.GetPositionX()
		neckY=dummy.GetPositionY()
		neckZ=dummy.GetPositionZ()

		dummy.TranslateTo(dummyX, dummyY, dummyZ, 0, 0, 0, 300)
		utility.wait(0.1)
		DummyAttach()
		utility.wait(0.1)
		dummy.splineTranslateTo(dummyX, dummyY, neckZ+(-18), 0, 0, 0, 20, 20)

		;Debug.Notification("Victim Found")

		

		starthealth = AttachedActor.GetBaseActorValue("health")
		AttachedActor.EquipItem(collar, false, true)
		AttachedActor.EquipItem(cuffs, false, true)
		isFemale = attachedActor.GetLeveledActorBase().GetSex()
		isGagged = attachedActor.WornHaskeyword(zbf.zbfEffectGagSound)

		if !isGagged
			if IsFemale
				humansound = soundFemaleWaiting.play(attachedActor)
			else
				humansound = soundMaleWaiting.play(attachedActor)
			EndIf
		EndIf
;EXPERIMANTAL///////////////////////////////////////////////////////////////////////////////////////////////////////////////
;EXPERIMANTAL///////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		GotoState("waiting")

	EndEvent
	
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack,  bool abBashAttack, bool abHitBlocked)
		return
	EndEvent

EndState

State waiting
	
	Event OnBeginState()
		if autoplay
			autoplayPhase1()
		EndIf
	EndEvent

	Event OnActivate(Objectreference user)
	
		if user==wheel
			debug.sendAnimationEvent(AttachedActor, "PGU_Struggle_Loop")
			dummy.splineTranslateTo(dummyX+(0.0), dummyY-(0.0), neckZ+(-12), 0, 0, 0, 30,30)
			registerForUpdate(1.0)
			GotoState("struggling")
			return
		ElseIf user == lever
			Trapdoor()
			sprung = true
			finalize(NeckAttachNode)
			return
		ElseIf user == rope
			releaseAlive()
			return
		Else
			return
		EndIf
	EndEvent
	
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack,  bool abBashAttack, bool abHitBlocked)
			releaseAlive()
	EndEvent

	Event OnEndState()
		cleanupSound()
	EndEvent	
	
EndState

State struggling

	Event OnBeginState()
		cleanupSound()
		deviceSound = soundFastCreak.play(rope)
		Sound.SetInstanceVolume(deviceSound, 1)

		if !isGagged
			if isFemale
				humansound = soundFemaleChoking.play(AttachedActor)
			else
				humansound = soundMaleChoking.play(AttachedActor)
			EndIf
			Sound.SetInstanceVolume(humansound, 1)
		EndIf

		if !playerVictim
			attachedActor.setunconscious(true)
		EndIf

		if autoplay
			autoplayPhase2()
		EndIf

	EndEvent

	Event OnActivate(Objectreference user)
		if user == lever
			Trapdoor()
			UnregisterForUpdate()
			sprung = true
			finalize(NeckAttachNode)
			return
		ElseIf user == rope
			releaseAlive()
			return
		Else
			return
		EndIf
	EndEvent
	
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack,  bool abBashAttack, bool abHitBlocked)
		UnregisterForUpdate()
		debug.sendAnimationEvent(AttachedActor, "PGU_Gallow_Loop")
		dummy.splineTranslateTo(dummyX+(0.0), dummyY-(0.0), neckZ+(-18), 0, 0, 0, 30,30)
		if !playerVictim
			attachedActor.setRestrained(true)
			attachedActor.setunconscious(false)
		EndIf
		GotoState("waiting")
		return
	EndEvent

	Event OnEndState()
		cleanupSound()
		if !isGagged && !sprung
			if isFemale
				humansound = soundFemaleRecovery.play(AttachedActor)
			else
				humansound = soundMaleRecovery.play(AttachedActor)
			EndIf
			Sound.SetInstanceVolume(humansound, 1)
		EndIf
	EndEvent	

EndState

State dead
	
	Event OnBeginState()
		cleanupSound()
		deviceSound = soundSlowCreak.play(rope)
		Sound.SetInstanceVolume(deviceSound, 1)
		;registerForSingleUpdate(20.0)
	EndEvent
	
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack,  bool abBashAttack, bool abHitBlocked)
		if !onlyRopeShootdown
			if AttachedActor !=none
				RemoveActor()
			EndIf
			ReInitialize()
		EndIf
	EndEvent

	Event OnActivate(Objectreference user)
		if user == lever
			Trapdoor()
		ElseIf user == rope
			if AttachedActor !=none
				RemoveActor()
			EndIf
			ReInitialize()
			return
		Else
			return
		EndIf
	EndEvent

EndState

;Functions /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Event OnUpdate()
		
		if !Sprung
			if AttachedActor.getSitstate() !=3
				ReleaseAlive() 
				reInitialize()
				return
			EndIf
		EndIf

		health=attachedActor.GetActorValue("Health")
		
		if health <=11 || sprung
			unregisterForUpdate()
			if nonLethal
				GotoState("dead")
				if !sprung
					AttachedActor.setunconscious(true)
					AttachedActor.PushActorAway(AttachedActor, 0.5)
					AttachedActor.SetAV("Paralysis", 1)
					AttachActorBone(rope, NeckAttachNode)
				EndIf
				utility.wait(deathCamDuration)
				game.removeHavokConstraints(AttachedActor, NeckAttachNode, rope, RopeAttachNode)
				game.removeHavokConstraints(AttachedActor, HeadAttachNode, rope, RopeAttachNode)
				AttachedActor.PushActorAway(AttachedActor, 0.5)
				utility.wait(3.0)
				game.removeHavokConstraints(AttachedActor,rh,AttachedActor,lh)
				if(TieFeet)
					game.removeHavokConstraints(AttachedActor,rf,AttachedActor,lf)
				EndIf


				If playervictim
					AttachedActor.setunconscious(false)
					AttachedActor.setRestrained(false)
					AttachedActor.SetAV("Paralysis", 0)
					AttachedActor.removeItem(collar, 1, true)
					if removeCuffsOnRelease
						AttachedActor.removeItem(cuffs, 1, true)
					EndIf
					ReInitialize()	
				EndIf
				releaseAlive()			
;Experimantal////Lethal_Block+++++++++++++++++++++++++++++++++++++++++++++++
			Else
				if playerVictim
					if !sprung
						;AttachedActor.setunconscious(true)
						;AttachedActor.PushActorAway(AttachedActor, 0.5)
						;AttachedActor.SetAV("Paralysis", 1)
						;AttachActorBone(rope, NeckAttachNode)
					EndIf
					finalize(neckAttachNode)				
				Else
					AttachedActor.killessential(Game.getplayer())
					AttachActorBone(rope, NeckAttachNode)
				EndIf
				sprung=true
				UnregisterForUpdate()
				GotoState("dead")
				return
			EndIf
;Experimantal////Lethal_Block+++++++++++++++++++++++++++++++++++++++++++++++
		EndIf
		
		if playerVictim
			attachedActor.damageActorValue("Health", damageModifierPlayer)
		Else
			attachedActor.damageActorValue("Health", damageModifierNPC)
		EndIf

;		if !sprung
;			if health <=30
;				AttachedActor.killessential(Game.getplayer())
;				AttachActorBone(rope, NeckAttachNode)
;				UnregisterForUpdate()
;				GotoState("dead")
;				sprung=true
;			EndIf
;		EndIf
EndEvent

Function CleanupSound()
	Sound.StopInstance(humanSound)
	humansound=0
	Sound.StopInstance(deviceSound)
	deviceSound=0
EndFunction

Function finalize(String AAttachpoint)
	If nonLethal
		AttachedActor.setunconscious(true)
		AttachedActor.PushActorAway(AttachedActor, 0.1)
		AttachedActor.SetAV("Paralysis", 1)
		AttachActorBone(rope, NeckAttachNode)
		registerForUpdate(0.2)
		GotoState("dead")
		return
	EndIf
	If playerVictim
		Game.SetGameSettingFloat("fPlayerDeathReloadTime", deathCamDuration)
		AttachedActor.killessential(Game.getplayer())
		AttachActorBone(rope, AAttachpoint)
	Else
		AttachedActor.setunconscious(true)
		AttachedActor.PushActorAway(AttachedActor, 0.5)
		AttachedActor.SetAV("Paralysis", 1)
		AttachActorBone(rope, AAttachpoint)
		utility.wait(0.5)
		AttachedActor.KillEssential(Game.getplayer())
		AttachedActor.GetActorBase().SetEssential(false)
		AttachedActor.Kill(Game.getplayer())
		GotoState("dead")
	EndIf
EndFunction

Function AttachActorBone(objectReference attachobject, string attachpoint)
	
	;utility.wait(0.2)
	DummyRelease()
	dummy.disable()
;+++++++++++test++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	;CleanupConstraints()
;+++++++++++test++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
	;game.removeHavokConstraints(AttachedActor, NeckAttachNode, AttachedActor, NeckAttachNode)
	;utility.wait(1.0)
	game.addHavokBallAndSocketConstraint(AttachedActor, attachPoint, attachobject, RopeAttachNode, 1,-2,2)
	;utility.wait(0.2)
	game.addHavokBallAndSocketConstraint(AttachedActor,rh,AttachedActor,lh,0,0,0)

	if(TieFeet)
	game.addHavokBallAndSocketConstraint(AttachedActor,rf,AttachedActor,lf,8,0,0)
	EndIf

EndFunction


Function Initialize()
	rope.SetMotionType(2, true)
	sprung = false
	dummyX = dummy.GetPositionX()
	dummyY = dummy.GetPositionY()
	dummyZ = dummy.GetPositionZ()
	dummy.disable()
	Trapdoor.blockActivation(true)
	;Debug.Notification("Gallow Ready!")
	Self.BlockActivation(false)
	AttachedActor=none
	GotoState("standby")
EndFunction

Function ReInitialize()
	sprung = false
	dummy.enable()
	utility.wait(0.3)
	dummy.translateTo(dummyX+(0.0), dummyY-(0.0), dummyZ-(0.0), 0, 0, 0,300)
	utility.wait(0.3)
	dummy.disable()
	Trapdoor.blockActivation(true)
	Self.BlockActivation(false)
	AttachedActor=none
	GotoState("standby")
	;Debug.Notification("Gallow Ready!")
	autoplay=false
EndFunction


Function DummyAttach()
	game.addHavokBallAndSocketConstraint(dummy, DummyAttachNode, rope, RopeAttachNode2, 0, 0, 3, 0,0,0)
	;game.addHavokBallAndSocketConstraint(dummy, DummyAttachNode, rope, RopeAttachNode, 0,-2,15)
EndFunction

Function DummyRelease()
	game.removeHavokConstraints(dummy, DummyAttachNode, rope, RopeAttachNode2)
	;game.removeHavokConstraints(dummy, DummyAttachNode, rope, RopeAttachNode)
EndFunction

Function RemoveActor()
	game.removeHavokConstraints(AttachedActor, NeckAttachNode, rope, RopeAttachNode)
	game.removeHavokConstraints(AttachedActor, HeadAttachNode, rope, RopeAttachNode)
	AttachedActor.disable()
	AttachedActor.enable()
	utility.wait(0.5)
	game.addHavokBallAndSocketConstraint(AttachedActor,rh,AttachedActor,lh,0,0,0)
	if(TieFeet)
	game.addHavokBallAndSocketConstraint(AttachedActor,rf,AttachedActor,lf,8,0,0)
	EndIf
	AttachedActor = none
EndFunction

Function CleanupConstraints()
	game.removeHavokConstraints(AttachedActor, NeckAttachNode, AttachedActor, NeckAttachNode)
	game.removeHavokConstraints(AttachedActor, rf, AttachedActor, rf)
	game.removeHavokConstraints(AttachedActor, lf, AttachedActor, lf)
	game.removeHavokConstraints(AttachedActor, lh, AttachedActor, lh)
	game.removeHavokConstraints(AttachedActor, rh, AttachedActor, rh)
EndFunction

Function ReleaseAlive()
	unregisterForUpdate()
	AttachedActor.removeItem(collar, 1, true)
	if removeCuffsOnRelease
		AttachedActor.removeItem(cuffs, 1, true)
	EndIf
	If !playerVictim
		AttachedActor.setunconscious(true)
		AttachedActor.SetAV("Paralysis", 1)
		AttachedActor.PushActorAway(AttachedActor, 0.5)
		utility.wait(1.0)
		AttachedActor.setunconscious(false)
		AttachedActor.setRestrained(false)
		AttachedActor.SetAV("Paralysis", 0)
		ReInitialize()
	EndIf
EndFunction

Function Trapdoor()
	Trapdoor.BlockActivation(false)
	Trapdoor.activate(self)
	Sound.SetInstanceVolume(soundTrapDoor.Play(TrapDoor),1)
	Trapdoor.BlockActivation(true)
EndFunction

Function autoplayPhase1()
	utility.wait(2.0)
	if AttachedActor.getSitstate() !=3
		ReleaseAlive() 
		reInitialize()
		return
	EndIf
	utility.wait(timerPhase1)
	if AttachedActor.getSitstate() !=3
		ReleaseAlive() 
		reInitialize()
		return
	EndIf
	wheel.activate(wheel)
EndFunction

Function autoPlayPhase2()
	utility.wait(1.0)
	if AttachedActor.getSitstate() !=3 || AttachedActor ==none
		return
	EndIf
	utility.wait(timerPhase2)
	if AttachedActor.getSitstate() !=3 || AttachedActor ==none
		return
	EndIf

	self.activate(lever)
	autoplay=false
Endfunction
