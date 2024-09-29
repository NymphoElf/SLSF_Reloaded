Scriptname PW_WHMIQ_Script extends PW_SideQuestScript

import PW_Utility

function RegisterForEvents()
	questLocIndex = 4
	
	RegisterForModEvent("PW_SexQueueSexEnd_RaloofSex", "OnRaloofSexEnd")
	RegisterForModEvent("PW_SexQueueSexEndNonfinal_RaloofSex", "OnRaloofSexEnd")
	RegisterForModEvent("PW_SexQueueSexStart_RaloofSex", "OnRaloofSexStart")
endFunction

function EndQuest()
	SetStage(500)
endFunction

function SetUpParty()

	;Jarls need to be handled at runtime, other nobles already placed in cell + assigned
	;Place decoy Jarls so they don't get fucked with by other mods
	ActorBase jarlAB = Alias_Jarl.GetActorReference().GetLeveledActorBase()
	if jarlAB == RealUlfricAB
		Alias_PartyJarlWindhelm.ForceRefTo(throne.PlaceAtMe(FakeUlfricAB))
	else
		Alias_PartyJarlWindhelm.ForceRefTo(throne.PlaceAtMe(FakeBrunwulfAB))
	endIf
	
	ActorBase jarlFalkreathActorBase = Tracker.GetJarl(1).GetLeveledActorBase()
	if jarlFalkreathActorBase == RealSiddgeirAB
		Alias_PartyJarlFalkreath.ForceRefTo(jarlFalkreathStartMarker.PlaceAtMe(FakeSiddgeirAB))
	else
		Alias_PartyJarlFalkreath.ForceRefTo(jarlFalkreathStartMarker.PlaceAtMe(FakeDengeirAB))
	endIf
	
	ActorBase jarlWhiterunActorBase  = Tracker.GetJarl(6).GetLeveledActorBase()
	if jarlWhiterunActorBase == RealBalgruufAB
		Alias_PartyJarlWhiterun.ForceRefTo(jarlWhiterunStartMarker.PlaceAtMe(FakeBalgruufAB))
	else
		Alias_PartyJarlWhiterun.ForceRefTo(jarlWhiterunStartMarker.PlaceAtMe(FakeVignarAB))
	endIf
	
	ActorBase jarlMarkarthActorBase  = Tracker.GetJarl(2).GetLeveledActorBase()
	if jarlMarkarthActorBase == RealIgmundAB
		Alias_PartyJarlMarkarth.ForceRefTo(jarlMarkarthStartMarker.PlaceAtMe(FakeIgmundAB))
	else
		Alias_PartyJarlMarkarth.ForceRefTo(jarlMarkarthStartMarker.PlaceAtMe(FakeThongvorAB))
	endIf
	
	
	;Prepare the player
	SendEvent("PW_StripPlayer")
	Mods.GagPlayer()
	
	
	Game.GetPlayer().MoveTo(playerStartMarker)
	Game.DisablePlayerControls()
	
	Mods.DisableDDGagDialogue(Alias_PartyJarlFalkreath.GetActorReference())
	Mods.DisableDDGagDialogue(Alias_PartyJarlWhiterun.GetActorReference())
	Mods.DisableDDGagDialogue(Alias_PartyJarlMarkarth.GetActorReference())
	Mods.DisableDDGagDialogue(Alias_PartySultan.GetActorReference())
	Mods.DisableDDGagDialogue(Alias_PartyDuke.GetActorReference())
	Mods.DisableDDGagDialogue(Alias_PartyEarl.GetActorReference())
	Mods.DisableDDGagDialogue(Alias_PartyThane.GetActorReference())
	Mods.DisableDDGagDialogue(Alias_PartyJarlWindhelm.GetActorReference())
	
	Alias_PartyJarlFalkreath.GetActorReference().AddToFaction(PW_InQuestFaction)
	Alias_PartyJarlWhiterun.GetActorReference().AddToFaction(PW_InQuestFaction)
	Alias_PartyJarlMarkarth.GetActorReference().AddToFaction(PW_InQuestFaction)
	Alias_PartyThane.GetActorReference().AddToFaction(PW_InQuestFaction)
	Alias_PartyJarlWindhelm.GetActorReference().AddToFaction(PW_InQuestFaction)
	
	
endFunction


function SetSpeechPositions()
	Alias_PartyJarlFalkreath.GetActorReference().MoveTo(jarlFalkreathStartMarker)
	Alias_PartyJarlWhiterun.GetActorReference().MoveTo(jarlWhiterunStartMarker)
	Alias_PartyJarlMarkarth.GetActorReference().MoveTo(jarlMarkarthStartMarker)
	Alias_PartySultan.GetActorReference().MoveTo(sultanStartMarker)
	Alias_PartyDuke.GetActorReference().MoveTo(dukeStartMarker)
	Alias_PartyEarl.GetActorReference().MoveTo(earlStartMarker)
	Alias_PartyThane.GetActorReference().MoveTo(thaneStartMarker)
	Game.GetPlayer().MoveTo(playerStartMarker)
endFunction

;When the player has instinctually masturbated to the stories of her submission to the Jarl
function PostMasturbationStory()
	Debug.MessageBox("Orgasm crashes like a wave through your body, overwhelming your senses before leaving you in a room cooler and clearer than it was before. You can't bear to look at the other guests now, but you can feel that the balance of power in the room has shifted dramatically during your loss of control.")
	Debug.MessageBox("Where you were once on equal footing as these nobles, you are no doubt seen as a slutty concubine, now that you have all but confirmed the Thane's story to these men. You remember that the Jarl offered your body to them, and realize that you were never intended as anything more than an appetizer at this feast.")

	int result = postMasturbationMessage.show()
	int integrityChange = 0
	if result == 0
			integrityChange = 8
			Debug.MessageBox("You manage to shake some of the fog out of your head, and analyze the situation. The men look convinced of the story, but still suspicious. If you could get this gag off, and try to reason with them, you might be able to convince them of the truth of the situation. But it isn't looking like an easy task.")
		elseif result == 1
			integrityChange = -7  
			Debug.MessageBox("You decide to play along as the Jarl's cock-worshipping pleasure slave. The thought gives you gooseflesh and excites you. You start mentally crafting your side of story, so that everyone will believe that the Jarl rightfully conquered you.")
		else
			integrityChange = 0
			Debug.MessageBox("You decide that you shouldn't make any decisions just yet - you don't know enough about the situation right now. Acting too hastily may get you in more trouble than you're already in.")
		endIf

	PW_WHIQ_Integrity.Mod(integrityChange)
endFunction

function PreFirstGangbangStory()
	if PW_WHIQ_Integrity.GetValue() > 0
		Debug.MessageBox("You're busy scanning the room when a pair of hands grabs you by the waist. Before you can stop him, he's entered you, and it's over. Your body defies you once more, surrendering to this assault. The others gather around, waiting their turn.")
	elseif PW_WHIQ_Integrity.GetValue() < 0
		Debug.MessageBox("You see that one of the noblemen is approaching to use you, and a nervous excitement flickers within you. This is life now - you serve at " + Alias_PartyJarlWindhelm.GetActorReference().GetLeveledActorBase().GetName() + "'s pleasure. As your master's guest fucks you senseless, you think to yourself that this was the correct decision. The others gather around, waiting their turn.")
	else
		Debug.MessageBox("One of the noblemen approaches you and takes ahold of you. You shake nervously in anticipation of what's about to happen, knowing there's nothing you can do to stop him. Your body feels pliant in his grip - it does not contest his command over it. The others gather around, waiting their turn.")
	endif
endFunction

;When the player has subsequently been gangbanged by the Jarl and friends
function PostFirstGangbangStory()
	int currentIntegrity = PW_WHIQ_Integrity.GetValue() as int
	int integrityChange = 0
	
	Debug.MessageBox(Alias_PartyJarlWindhelm.GetActorReference().GetLeveledActorBase().GetName() + " triumphantly finishes inside you, and you fall to the floor, exhausted, your body trembling from the pleasure forced out of it.")
	Debug.MessageBox("After some time you collect enough energy to stand up again. The noblemen, no longer preoccupied with you, have gone about feasting and drinking. Thane Enrensen is in the corner of the room once more - he beckons you over.")

endFunction

function Stage40IncrementGuestsTended()
	ModObjectiveGlobal(1, tended, 40, 4)
	
	if tended.GetValue() >= 4
		SetStage(50)
	endIf
endFunction

function Stage50Story()

	; Max integrity is 12 here, average is probably 6-9 if going resistant

	int integrity = PW_WHIQ_Integrity.GetValue() as int
	
	
	Debug.MessageBox("As the hours go by, you witness all manner of contests and bets, and are an object of many of them. You occasionally hear trade deals being discussed, or agreements being made - it seems that the plot to use you for Windhelm's gain is going perfectly to Enrensen's plan.")
	Utility.Wait(1.0)
	
	if integrity >= 9
		Debug.MessageBox("You're confident that they will not break your will, though, and resolve to push back whenever you can. As you're pondering how to turn this situation around, Enrensen grabs you by the arm and pulls you to the corner of the room.")
		Utility.Wait(1.0)
		Debug.MessageBox("\"You aren't playing your role very well. Fortunately I was prepared for this,\" he says, and then clamps an iron hand over your mouth. As you're trying to decipher how that move benefitted him, you hear a snapping sound below - you scream into his hand as you feel a sharp pain in your vagina, and look down to see that he's given you a piercing with a faintly glowing soulgem hanging off of it.")
		Mods.EquipVaginalPiercing()
		Utility.Wait(1.0)
		Debug.MessageBox("\"There we go,\" he whispers, cleaning the site of the piercing, and giving you a spin and a shove back out into the clamor.")
		Utility.Wait(1.0)
		Debug.MessageBox("You go back to \"tending\" to the guests and providing evidence for your ultimatum. You're unsure how the piercing was supposed to have broken your resolve, as the pain has already faded.")
		Utility.Wait(3.0)
		
		Debug.MessageBox("Eventually you find yourself surrounded by the men again, all of your holes being filled and stretched at once. Between involuntarily moans and orgasms you make an effort to look uncomfortable, and protest whenever your mouth isn't stuffed.")
		Utility.Wait(1.0)
		Debug.MessageBox("Their stamina seems to have no limit, but you can see the guilt and doubt begin to creep into their expressions, subtly. You will get out of this, you tell yourself. You are stronger than they g--")
		Debug.MessageBox("BZZZZZT")
		PW_WHIQ_Integrity.SetValue(-99)
		Debug.MessageBox("Your eyes widen as the piercing begins vibrating hard against your clitoris, bringing you to a climax that makes you scream like a whore, and instantly dashing your hopes of restoring your reputation. It no longer matters what the truth is. There is no longer any debate that you're a cock-addicted slut - the only way to avoid further humiliation now is to be just that, and hope they don't demand anything too degrading of you.")
		Utility.Wait(4.0)
		Debug.MessageBox("After being fucked for several more minutes, you find yourself left on the floor once again, panting. Thane Enrensen pulls you to your feet and announces a toast.")
		
	elseif integrity >= 6 && integrity < 9
		Debug.MessageBox("Eventually you find yourself surrounded by the men again, all of your holes being filled and stretched at once. Between involuntarily moans and orgasms you make an effort to look uncomfortable, and protest whenever your mouth isn't stuffed.")
		Utility.Wait(1.0)
		Debug.MessageBox("Their stamina seems to have no limit, but you can see the guilt and doubt begin to creep into their expressions, subtly. You will get out of this, you tell yourself. You are stronger than they gave you credit for.")
		Utility.Wait(1.0)
		Debug.MessageBox("When they finish using you they seem all but convinced that your protests were genuine. Thane Enrensen calls for a toast, likely in an attempt to boost spirits again, but the damage is done. The noblemen look upon him with mistrust. Now is your chance.")
		Utility.Wait(1.0)
		
	elseif integrity < 6 && integrity >= 0
		Debug.MessageBox("Eventually you find yourself surrounded by the men again, all of your holes being filled and stretched at once. Between moans and orgasms you try to remain vigilant, looking for opportunities to escape, but they don't come.")
		Utility.Wait(1.0)
		Debug.MessageBox("Their stamina seems limitless, yet your resolve is slipping faster than ever. You realize that today will permanently define your legacy - most all of Skyrim will think of a Jarl's tamed, submissive little pet when they think of you from now on. The thought fills you with dread, but also... excitement? No, impossible. That would be depraved. But there are worse fates...")
		Utility.Wait(1.0)
		Debug.MessageBox("After each man finishes in you a few more times, Thane Enrensen calls for a toast. You take your place at the foot of your master's throne.")
		Utility.Wait(1.0)
		
	elseif integrity < 0 && integrity >= -12
		Debug.MessageBox("Eventually you find yourself surrounded by the men again, all of your holes being filled and stretched at once. You've come to accept, and even crave, this treatment. The men keep your entire body working at every moment, and the constant stimulation allows you no time to feel humiliated by your degradation.")
		Utility.Wait(1.0)
		Debug.MessageBox("You catch " + Alias_PartyJarlWindhelm.GetActorReference().GetLeveledActorBase().GetName() + "'s gaze briefly through the wall of muscle surrounding you. He has an accomplished look on his face. He's won today, thoroughly. After all of the foes you've slain, accolades you've acquired, heroic deeds you've done... you know you'll ultimately be remembered for your humiliating downfall at the hands of the mighty Jarl of Windhelm.")
		Utility.Wait(1.0)
		Debug.MessageBox("You feel butterflies in your stomach thinking about it - it's all so humiliating and wrong, and yet for that very reason you're beginning to find it exciting. You find yourself climaxing harder than you have all night, while you imagine still being the palace slave a decade from now, your legacy completely erased and the world knowing you as a weak, mindless slut.")
		Utility.Wait(1.0)
		Debug.MessageBox("While you debate whether these are fantasies or actual desires, cumming harder and harder all the while, the men finish up with you. Thane Enrensen calls a toast, and you take your place beneath your master, where you seem to belong now.")
		Utility.Wait(1.0)
	
	else
		Debug.MessageBox("Eventually you find yourself surrounded by the men again, all of your holes being filled and stretched at once. You do your best to please your master's guests, trying to tighten up for them, and moaning and gasping at every movement.")
		Utility.Wait(1.0)
		Debug.MessageBox(Alias_PartyJarlWindhelm.GetActorReference().GetLeveledActorBase().GetName() + " stares down at you from the throne, proud of the slave-slut he's revealed you to be. You get hot when he looks at you - it's the look of a man inspecting his property.")
		Utility.Wait(1.0)
		Debug.MessageBox("You're proud to be his property, and thankful to him for defeating you. Before today, people looked up to you, perhaps even considered you the image of a powerful woman. You think it so deviously, orgasmically, wrongly right that you would have your legacy destroyed in such a humiliating way, and be reduced to nothing but the pathetic slave you've always known you could be. You orgasm harder and harder thinking about it.")
		Utility.Wait(1.0)
		Debug.MessageBox("When the men are finished with you, you want more. You need more. Thane Enrensen calls a toast, and you hurry to your place beneath your master, standing so that your breasts are on full display for the guests, hoping they will entice someone.")
		Utility.Wait(1.0)
		
	endIf

endFunction

event OnRaloofSexStart(form unused)
	timesFuckedRaloof += 1

	if timesFuckedRaloof == 1
		Debug.MessageBox("As Raloof's massive dick slides into your readied cunt, you realize the odds of this contest were stacked from the start. Stars immediately streak through your eyes and you feel faint. The horse cock pushes deep into your womb and then keeps going further. You scream in anguish as Raloof stretches your pussy to its brink, and pumps in and out of you with cruel, indifferent force. Your legs go numb, and you wonder if you're being split in half by this beast. You hear the noblemen laughing at you.")
	elseif timesFuckedRaloof == 2
		Debug.MessageBox("Your whole body trembles violently as you realize Raloof is not finished with you. He mounts you again - the pain is not as bad now that he's already left his mark on you, but it isn't exactly bearable either. Through tears you see your master watching from the throne, and try to compose yourself to please him. ")
	elseif timesFuckedRaloof == 3
		Debug.MessageBox("Your head is spinning now - your body can't take much more pain. You don't know how Raloof has any more seed to shoot into you, but he's entering you again. You beg for it to end but that only seems to amuse the onlookers.")
	endIf
	
	
endEvent

event OnRaloofSexEnd(form unused)

	if timesFuckedRaloof == 1
		Debug.MessageBox("What seems like a gallon of horse cum explodes into you, to the applause of the guests.")
	elseif timesFuckedRaloof == 3
		Debug.MessageBox("As another load blasts out of Raloof's cock, the rapid expansion of your womb becomes too much to bear, and you go limp. You've lost the contest to Raloof, and will have to be bred by him daily as per your master's wishes. You wonder if horses go to Sovngarde, and how you could endure being torn up like this for eternity.")
	elseif timesFuckedRaloof == 4
		Debug.MessageBox("Raloof finally huffs, and stops pummelling your half-conscious body. It seems he's finally had enough of you.")
	endIf
endEvent

function ReturnPlayerItems()
endFunction

ReferenceAlias property Alias_Jarl Auto
ReferenceAlias property Alias_PartyThane Auto
ReferenceAlias property Alias_PartyPlayer Auto
ReferenceAlias property Alias_PartyJarlWindhelm Auto
ReferenceAlias property Alias_PartyJarlWhiterun Auto
ReferenceAlias property Alias_PartyJarlFalkreath Auto
ReferenceAlias property Alias_PartyJarlMarkarth Auto
ReferenceAlias property Alias_PartySultan Auto
ReferenceAlias property Alias_PartyDuke Auto
ReferenceAlias property Alias_PartyEarl Auto

ObjectReference property throne Auto

ObjectReference property playerStartMarker Auto

ObjectReference property thaneStartMarker Auto
ObjectReference property jarlWhiterunStartMarker Auto
ObjectReference property jarlFalkreathStartMarker Auto
ObjectReference property jarlMarkarthStartMarker Auto
ObjectReference property sultanStartMarker Auto
ObjectReference property dukeStartMarker Auto
ObjectReference property earlStartMarker Auto

GlobalVariable property PW_WHIQ_Integrity Auto
GlobalVariable property tended Auto

Message property postMasturbationMessage Auto
Message property stage50ResistantMessage Auto

Idle Property playerIdle  Auto  

int property timesFuckedRaloof = 0 Auto

PW_TrackerScript property Tracker Auto
PW_ModIntegrationsScript property Mods Auto

ActorBase property RealUlfricAB Auto
ActorBase property RealBalgruufAB Auto
ActorBase property RealVignarAB Auto
ActorBase property RealSiddgeirAB Auto
ActorBase property RealDengeirAB Auto
ActorBase property RealIgmundAB Auto
ActorBase property RealThongvorAB Auto
ActorBase property RealBrunwulfAB Auto

ActorBase property FakeUlfricAB Auto
ActorBase property FakeBalgruufAB Auto
ActorBase property FakeVignarAB Auto
ActorBase property FakeSiddgeirAB Auto
ActorBase property FakeDengeirAB Auto
ActorBase property FakeIgmundAB Auto
ActorBase property FakeThongvorAB Auto
ActorBase property FakeBrunwulfAB Auto

Faction property PW_InQuestFaction Auto
