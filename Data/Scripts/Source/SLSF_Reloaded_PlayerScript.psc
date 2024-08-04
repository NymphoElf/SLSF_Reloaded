ScriptName SLSF_Reloaded_PlayerScript extends ReferenceAlias

Import JsonUtil

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_ModEventListener Property Listener Auto
SexlabFramework Property Sexlab Auto

Actor Property PlayerRef Auto

Spell Property NPCScanSpell Auto

Race[] Property OrcRace Auto
Race[] Property KhajiitRace Auto
Race[] Property ArgonianRace Auto

String Property OldPlayerName Auto Hidden
String Property NewPlayerName Auto Hidden

GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto

Event OnInit()
	RegisterForMenu("RACESEX_MENU")
	RegisterForUpdateGameTime(0.5)
	Mods.CheckInstalledMods()
	;RegisterForModEvent("AnimationEnd", "OnSexlabAnimationEnd")
	RegisterForModEvent("AnimationStart", "OnSexlabAnimationStart")
EndEvent

Event OnPlayerLoadGame()
	;RegisterForModEvent("AnimationEnd", "OnSexlabAnimationEnd")
	Mods.CheckInstalledMods()
	Listener.RegisterExternalEvents()
	Debug.Notification("SLSFR - PlayerScript - OnPlayerLoadGame")
	RegisterForModEvent("AnimationStart", "OnSexlabAnimationStart")
EndEvent

Event OnSexlabAnimationStart()
	String PlayerLocation = LocationManager.CurrentLocationName()
	Utility.Wait(15.0) ;Give the player a short time to change the animation if needed before grabbing information about the animation. Tried to account for possible starting lag as well.
	
	If Sexlab.IsActorActive(PlayerRef) == True
		
		Int PlayerThread = Sexlab.FindPlayerController()
		sslThreadController PlayerController = Sexlab.GetController(PlayerThread)
		Actor[] Actors = PlayerController.Positions
		Int PlayerSex = PlayerRef.GetActorBase().GetSex() ;0 = Male | 1 = Female
		
		If PlayerController.Animation.HasTag("Oral")
			FameManager.GainFame("Oral", PlayerLocation)
		EndIf
		
		If PlayerController.Animation.HasTag("Anal")
			FameManager.GainFame("Anal", PlayerLocation)
		EndIf
		
		If PlayerController.Animation.HasTag("Orgy") || Actors.Length > 2
			FameManager.GainFame("Group", PlayerLocation)
		EndIf
		
		If !PlayerController.Animation.HasTag("Aggressive") && !Sexlab.IsVictim(PlayerThread, PlayerRef) && !Sexlab.IsAggressor(PlayerThread, PlayerRef)
			FameManager.GainFame("Slut", PlayerLocation)
		EndIf
		
		If (!Sexlab.IsAggressor(PlayerThread, PlayerRef) && PlayerController.Animation.HasTag("Aggressive")) || FameManager.CanGainBoundFame()
			FameManager.GainFame("Submissive", PlayerLocation)
		EndIf
		
		If Sexlab.IsVictim(PlayerThread, PlayerRef) || FameManager.CanGainBoundFame()
			FameManager.GainFame("Masochist", PlayerLocation)
		EndIf
		
		If (!Sexlab.IsVictim(PlayerThread, PlayerRef) && PlayerController.Animation.HasTag("Aggressive")) || (PlayerRef.GetActorBase().GetSex() != 0 && Sexlab.IsUsingStrapon(PlayerThread, PlayerRef))
			FameManager.GainFame("Dominant", PlayerLocation)
		EndIf
		
		If Sexlab.IsAggressor(PlayerThread, PlayerRef)
			FameManager.GainFame("Sadist", PlayerLocation)
		EndIf
		
		If (PlayerSex == 1 && Sexlab.FemaleCount(Actors) > 1) || (PlayerSex == 0 && Sexlab.FemaleCount(Actors) > 0)
			FameManager.GainFame("Likes Women", PlayerLocation)
		EndIf
		
		If (PlayerSex == 1 && Sexlab.MaleCount(Actors) > 0) || (PlayerSex == 0 && Sexlab.MaleCount(Actors) > 1)
			FameManager.GainFame("Likes Men", PlayerLocation)
		EndIf
		
		If PlayerController.Animation.HasTag("Creature") || PlayerController.Animation.HasTag("Bestiality")
			FameManager.GainFame("Bestiality", PlayerLocation)
		EndIf

		If (!Sexlab.IsVictim(PlayerThread, PlayerRef) && !Sexlab.IsAggressor(PlayerThread, PlayerRef)) && (PlayerController.Animation.HasTag("Loving") || PlayerController.Animation.HasTag("Hugging") || PlayerController.Animation.HasTag("Cuddling") || PlayerController.Animation.HasTag("Kissing"))
			FameManager.GainFame("Gentle", PlayerLocation)
		EndIf
		
		Int ActorIndex = 0
		While ActorIndex < Actors.Length && Actors.Length > 1
			If Actors[ActorIndex] != PlayerRef
				If Actors[ActorIndex].GetRace() == OrcRace[0] || Actors[ActorIndex].GetRace() == OrcRace[1]
					FameManager.GainFame("Likes Orc", PlayerLocation)
				ElseIf Actors[ActorIndex].GetRace() == KhajiitRace[0] || Actors[ActorIndex].GetRace() == KhajiitRace[1]
					FameManager.GainFame("Likes Khajiit", PlayerLocation)
				ElseIf Actors[ActorIndex].GetRace() == ArgonianRace[0] || Actors[ActorIndex].GetRace() == ArgonianRace[1]
					FameManager.GainFame("Likes Argonian", PlayerLocation)
				EndIf
			EndIf
			ActorIndex += 1
		EndWhile
	EndIf
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	LocationManager.CurrentLocation = akNewLoc
EndEvent

Event OnUpdateGameTime()
	SLSF_Reloaded_NPCScanSucess.SetValue(0)
	PlayerRef.AddSpell(NPCScanSpell, True) ;Second parameter is "Verbose" boolean. If true, get a notification. If false, don't. True for Beta.
	NPCScanSpell.Cast(PlayerRef)
	
	FameManager.RegisterForSingleUpdate(0.1)
	
	Utility.Wait(1.0) ;Add slight delay to let the previous events process before removing spell
	PlayerRef.RemoveSpell(NPCScanSpell)
EndEvent