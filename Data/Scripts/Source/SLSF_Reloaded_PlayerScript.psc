ScriptName SLSF_Reloaded_PlayerScript extends ReferenceAlias

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_ModEventListener Property Listener Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property Data Auto
SexlabFramework Property Sexlab Auto
SLSF_Reloaded_LegacyOverwrite Property LegacyOverwrite Auto

Actor Property PlayerRef Auto

Spell Property NPCScanSpell Auto

Race[] Property OrcRace Auto
Race[] Property KhajiitRace Auto
Race[] Property ArgonianRace Auto

Bool Property IsWhoreEvent = False Auto Hidden

GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto

GlobalVariable Property SLSF_Reloaded_Skooma Auto

Event OnInit()
	RegisterForUpdateGameTime(0.5)
	Mods.CheckInstalledMods()
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
EndEvent

Event OnPlayerLoadGame()
	Mods.CheckInstalledMods()
	Listener.RegisterExternalEvents()
	Data.CleanExternalModList()
	VisibilityManager.UpdateTattooSlots()
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
EndEvent

Event OnSexlabAnimationStart(Int threadID, Bool hasPlayer)
	AnimationAnalyze(threadID, hasPlayer)
EndEvent

Event OnSexlabForeplayEnd(Int threadID, Bool hasPlayer)
	AnimationAnalyze(threadID, hasPlayer)
EndEvent

Function AnimationAnalyze(Int threadID, Bool hasPlayer)
	If VisibilityManager.IsPlayerAnonymous() == True
		return
	EndIf
	
	String PlayerLocation = LocationManager.CurrentLocationName()
	
	If LocationManager.IsLocationValid(PlayerLocation) == False
		return
	EndIf
	
	Utility.Wait(5.0) ;Give the player a short time to change the animation if needed before grabbing information about the animation. Tried to account for possible starting lag as well.
	Bool Foreplay = False
	
	If Sexlab.IsActorActive(PlayerRef) == True
		
		Int PlayerThread = Sexlab.FindPlayerController()
		sslThreadController PlayerController = Sexlab.GetController(PlayerThread)
		Actor[] Actors = PlayerController.Positions
		Int PlayerSex = PlayerRef.GetActorBase().GetSex() ;0 = Male | 1 = Female
		
		If PlayerController.Animation.HasTag("BodySearch")
			return ;Ignore BodySearch Animations
		EndIf
		
		If PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == True
			Foreplay = True
		ElseIf PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == False
			return
		EndIf
		
		IsWhoreEvent = Data.CheckWhoreEvent()
		
		If Actors.Length > 1
			If PlayerController.Animation.HasTag("Oral")
				FameManager.GainFame("Oral", PlayerLocation, Foreplay)
			EndIf
			
			If PlayerController.Animation.HasTag("Anal")
				FameManager.GainFame("Anal", PlayerLocation, Foreplay)
			EndIf
			
			If PlayerController.Animation.HasTag("Orgy") || Actors.Length > 2
				FameManager.GainFame("Group", PlayerLocation, Foreplay)
			EndIf
			
			If !PlayerController.Animation.HasTag("Aggressive") && !Sexlab.IsVictim(PlayerThread, PlayerRef) && !Sexlab.IsAggressor(PlayerThread, PlayerRef)
				If Mods.IsPublicWhore() == True || IsWhoreEvent == True
					FameManager.GainFame("Whore", PlayerLocation, Foreplay)
				Else
					FameManager.GainFame("Slut", PlayerLocation, Foreplay)
				EndIf
			EndIf
			
			If Mods.IsSexlabPlusInstalled == True
				If PlayerController.IsConsent() == True
					If PlayerController.GetSubmissive(PlayerRef) == True
						FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
					Else
						FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
					EndIf
				EndIf
			Else
				If PlayerController.Animation.HasTag("Aggressive")
					If (PlayerSex != 0 || FameManager.CanGainBoundFame(PlayerLocation) || Config.SubmissiveDefault == True) && Config.DominantDefault == False
						FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
					ElseIf (PlayerSex == 0 || (PlayerSex != 0 && Sexlab.IsUsingStrapon(PlayerThread, PlayerRef)) || Config.DominantDefault == True) && Config.SubmissiveDefault == False
						FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
					EndIf
				EndIf
			EndIf
			
			If Sexlab.IsVictim(PlayerThread, PlayerRef) || FameManager.CanGainBoundFame(PlayerLocation)
				FameManager.GainFame("Masochist", PlayerLocation, Foreplay)
			EndIf
			
			If Sexlab.IsAggressor(PlayerThread, PlayerRef)
				FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
			EndIf
			
			If (PlayerSex == 1 && Sexlab.FemaleCount(Actors) > 1) || (PlayerSex == 0 && Sexlab.FemaleCount(Actors) > 0)
				If !Sexlab.IsVictim(PlayerThread, PlayerRef) || (Sexlab.IsVictim(PlayerThread, PlayerRef) && Config.AllowLikeFameWhenRaped == True)
					FameManager.GainFame("Likes Women", PlayerLocation, Foreplay)
				EndIf
			EndIf
			
			If (PlayerSex == 1 && Sexlab.MaleCount(Actors) > 0) || (PlayerSex == 0 && Sexlab.MaleCount(Actors) > 1)
				If !Sexlab.IsVictim(PlayerThread, PlayerRef) || (Sexlab.IsVictim(PlayerThread, PlayerRef) && Config.AllowLikeFameWhenRaped == True)
					FameManager.GainFame("Likes Men", PlayerLocation, Foreplay)
				EndIf
			EndIf
			
			If PlayerController.Animation.HasTag("Creature") || PlayerController.Animation.HasTag("Bestiality")
				If !Sexlab.IsVictim(PlayerThread, PlayerRef) || (Sexlab.IsVictim(PlayerThread, PlayerRef) && Config.AllowLikeFameWhenRaped == True)
					FameManager.GainFame("Bestiality", PlayerLocation, Foreplay)
				EndIf
			EndIf

			If (!Sexlab.IsVictim(PlayerThread, PlayerRef) && !Sexlab.IsAggressor(PlayerThread, PlayerRef)) && (PlayerController.Animation.HasTag("Loving") || PlayerController.Animation.HasTag("Hugging") || PlayerController.Animation.HasTag("Cuddling") || PlayerController.Animation.HasTag("Kissing"))
				FameManager.GainFame("Gentle", PlayerLocation, Foreplay)
			EndIf
			
			Int ActorIndex = 0
			While ActorIndex < Actors.Length
				If Actors[ActorIndex] != PlayerRef
					If Actors[ActorIndex].GetRace() == OrcRace[0] || Actors[ActorIndex].GetRace() == OrcRace[1]
						If !Sexlab.IsVictim(PlayerThread, PlayerRef) || (Sexlab.IsVictim(PlayerThread, PlayerRef) && Config.AllowLikeFameWhenRaped == True)
							FameManager.GainFame("Likes Orc", PlayerLocation, Foreplay)
						EndIf
					ElseIf Actors[ActorIndex].GetRace() == KhajiitRace[0] || Actors[ActorIndex].GetRace() == KhajiitRace[1]
						If !Sexlab.IsVictim(PlayerThread, PlayerRef) || (Sexlab.IsVictim(PlayerThread, PlayerRef) && Config.AllowLikeFameWhenRaped == True)
							FameManager.GainFame("Likes Khajiit", PlayerLocation, Foreplay)
						EndIf
					ElseIf Actors[ActorIndex].GetRace() == ArgonianRace[0] || Actors[ActorIndex].GetRace() == ArgonianRace[1]
						If !Sexlab.IsVictim(PlayerThread, PlayerRef) || (Sexlab.IsVictim(PlayerThread, PlayerRef) && Config.AllowLikeFameWhenRaped == True)
							FameManager.GainFame("Likes Argonian", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf
				ActorIndex += 1
			EndWhile
		Else
			If LocationManager.IsLocationValid(LocationManager.CurrentLocationName()) == True
				RunNPCDetect()
			EndIf
		EndIf
	EndIf
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	LocationManager.CurrentLocation = akNewLoc
	FameManager.UpdateGlobals()
EndEvent

Event OnUpdateGameTime()
	FameManager.UpdateFame()
	
	Int OldSkoomaValue = SLSF_Reloaded_Skooma.GetValue() as Int
	Int NewSkoomaValue = OldSkoomaValue - 2
	
	If NewSkoomaValue < 0
		NewSkoomaValue = 0
	EndIf
	
	SLSF_Reloaded_Skooma.SetValue(NewSkoomaValue)
	
	If Config.AllowLegacyOverwrite == True
		LegacyOverwrite.OverwriteLegacyFame()
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	String ObjectName = ""
	
	If akBaseObject != none
		ObjectName = akBaseObject.GetName()
	EndIf
	
	If (akBaseObject == none || ObjectName == "")
		return
	ElseIf (ObjectName == "Skooma" || ObjectName == "Kordir's Skooma" || ObjectName == "Redwater Skooma" || ObjectName == "Double-Distilled Skooma")
		Int OldSkoomaValue = SLSF_Reloaded_Skooma.GetValue() as Int
		Int NewSkoomaValue = OldSkoomaValue + 1
		
		If NewSkoomaValue > 150
			NewSkoomaValue = 150
		EndIf
		
		SLSF_Reloaded_Skooma.SetValue(NewSkoomaValue)
	EndIf
	
	VisibilityManager.RegisterForSingleUpdate(0.1)
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If (akBaseObject == none || akBaseObject.GetName() == "")
		return
	EndIf
	
	VisibilityManager.RegisterForSingleUpdate(0.1)
EndEvent

Function RunNPCDetect()
	SLSF_Reloaded_NPCScanSucess.SetValue(0)
	NPCScanSpell.Cast(PlayerRef)
EndFunction