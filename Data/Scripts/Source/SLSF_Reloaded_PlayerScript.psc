ScriptName SLSF_Reloaded_PlayerScript extends ReferenceAlias

SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_TimeManager Property TimeManager Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_ModEventListener Property Listener Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property Data Auto
SexlabFramework Property Sexlab Auto
SLSF_Reloaded_LegacyOverwrite Property LegacyOverwrite Auto

Actor Property PlayerRef Auto

Bool Property SexSceneEnded Auto Hidden

Spell Property NPCScanSpell Auto

Race[] Property OrcRace Auto
Race[] Property KhajiitRace Auto
Race[] Property ArgonianRace Auto

GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto

GlobalVariable Property SLSF_Reloaded_Skooma Auto

Event OnInit()
	RegisterForUpdateGameTime(0.5)
	Mods.CheckInstalledMods()
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
	RegisterForModEvent("HookAnimationEnd", "OnSexlabAnimationEnd")
	RegisterForMenu("Sleep/Wait Menu")
EndEvent

Event OnPlayerLoadGame()
	Mods.CheckInstalledMods()
	Listener.RegisterExternalEvents()
	Data.CleanExternalModList()
	VisibilityManager.UpdateTattooSlots()
	RegisterForModEvent("HookAnimationStart", "OnSexlabAnimationStart")
	RegisterForModEvent("HookLeadInEnd", "OnSexlabForeplayEnd")
	RegisterForModEvent("HookAnimationEnd", "OnSexlabAnimationEnd")
	RegisterForMenu("Sleep/Wait Menu")
EndEvent

Event OnMenuClose(String MenuName) ;We only registered the Sleep/Wait Menu, so that's the only one we'll capture with this event
	Float TimeDifference = Utility.GetCurrentGameTime() - FameManager.LastCheckedTime
	If TimeDifference >= 0.0199 ;~0.0199 is the time amount for an in-game half-hour
		If TimeManager.TimeManagerRunning == False ;Prevent double-up of Periodic Fame Update
			TimeManager.PeriodicFameTimer()
		EndIf
	EndIf
EndEvent

Event OnSexlabAnimationStart(Int threadID, Bool hasPlayer)
	If hasPlayer == True
		SexSceneEnded = False
		AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabForeplayEnd(Int threadID, Bool hasPlayer)
	If hasPlayer == True
		SexSceneEnded = False
		AnimationAnalyze(threadID)
	EndIf
EndEvent

Event OnSexlabAnimationEnd(Int threadID, Bool hasPlayer)
	If hasPlayer == True
		SexSceneEnded = True
	EndIf
EndEvent

Function AnimationAnalyze(Int threadID)
	If VisibilityManager.IsPlayerAnonymous() == True
		return
	EndIf
	
	String PlayerLocation = LocationManager.CurrentLocationName()
	
	If LocationManager.IsLocationValid(PlayerLocation) == False
		return
	EndIf
	
	Utility.Wait(10.0) ;Give the player a short time to change the animation (or cancel it) if needed before grabbing information about the animation. Tried to account for possible starting lag as well.
	
	If SexSceneEnded == True
		return
	EndIf
	
	Int PlayerThread = Sexlab.FindPlayerController()
	sslThreadController PlayerController = Sexlab.GetController(PlayerThread)
	
	If PlayerController.Animation.HasTag("BodySearch")
		return ;Ignore BodySearch Animations
	EndIf
	
	Bool Foreplay = False
	
	If PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == True
		Foreplay = True
	ElseIf PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == False
		return
	EndIf
	
	Actor[] Actors = PlayerController.Positions
	Int PlayerSex = PlayerRef.GetActorBase().GetSex() ;0 = Male | 1 = Female
	
	Bool IsAggressor = Sexlab.IsAggressor(PlayerThread, PlayerRef)
	Bool IsVictim = Sexlab.IsVictim(PlayerThread, PlayerRef)
	Bool HasStrapon = Sexlab.IsUsingStrapon(PlayerThread, PlayerRef)
	
	Int MaleCount = Sexlab.MaleCount(Actors)
	Int FemaleCount = Sexlab.FemaleCount(Actors)
	
	Bool IsSexWorker = Data.CheckSexWorker()
	Bool IsSubmissive = False
	Bool IsDominant = False
	
	Bool GainedSadistFame = False
	Bool GainedMasochistFame = False
	
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
		
		If !PlayerController.Animation.HasTag("Aggressive") && IsVictim == False && IsAggressor == False
			If Mods.IsPublicWhore() == True || IsSexWorker == True
				FameManager.GainFame("Whore", PlayerLocation, Foreplay)
			Else
				FameManager.GainFame("Slut", PlayerLocation, Foreplay)
			EndIf
		EndIf
		
		If Mods.IsSexlabPlusInstalled == True
			If PlayerController.IsConsent() == True
				If PlayerController.GetSubmissive(PlayerRef) == True
					IsSubmissive = True
					FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
				Else
					IsDominant = True
					FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
				EndIf
			EndIf
		Else
			If (Config.SubmissiveDefault == True || FameManager.CanGainBoundFame(PlayerLocation) || (PlayerSex == 1 && HasStrapon == False)) && Config.DominantDefault == False
				IsSubmissive = True
				FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
			ElseIf (Config.DominantDefault == True || (PlayerSex == 1 && HasStrapon == True) || PlayerSex == 0) && Config.SubmissiveDefault == False
				IsDominant = True
				FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
			EndIf
		EndIf
		
		If (IsVictim == True && Config.VictimsAreMasochist == True) || (FameManager.CanGainBoundFame(PlayerLocation) && IsDominant == False) || (PlayerController.Animation.HasTag("Aggressive") && IsVictim == False && IsSubmissive == True)
			FameManager.GainFame("Masochist", PlayerLocation, Foreplay)
			GainedMasochistFame = True
		EndIf
		
		If (IsAggressor == True || (PlayerController.Animation.HasTag("Aggressive") && IsDominant == True)) && GainedMasochistFame == False
			FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
			GainedSadistFame = True
		EndIf
		
		If (PlayerSex == 1 && FemaleCount > 1) || (PlayerSex == 0 && FemaleCount > 0)
			If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
				FameManager.GainFame("Likes Women", PlayerLocation, Foreplay)
			EndIf
		EndIf
		
		If (PlayerSex == 1 && MaleCount > 0) || (PlayerSex == 0 && MaleCount > 1)
			If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
				FameManager.GainFame("Likes Men", PlayerLocation, Foreplay)
			EndIf
		EndIf
		
		If PlayerController.Animation.HasTag("Creature") || PlayerController.Animation.HasTag("Bestiality")
			If IsVictim == False || (IsVictim == True && Config.AllowBestialityWhenRaped == True)
				FameManager.GainFame("Bestiality", PlayerLocation, Foreplay)
			EndIf
		EndIf

		If (IsVictim == False && IsAggressor == False) && (PlayerController.Animation.HasTag("Loving") || PlayerController.Animation.HasTag("Hugging") || PlayerController.Animation.HasTag("Cuddling") || PlayerController.Animation.HasTag("Kissing"))
			FameManager.GainFame("Gentle", PlayerLocation, Foreplay)
		EndIf
		
		Int ActorIndex = 0
		While ActorIndex < Actors.Length
			If Actors[ActorIndex] != PlayerRef
				If Actors[ActorIndex].GetRace() == OrcRace[0] || Actors[ActorIndex].GetRace() == OrcRace[1]
					If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
						FameManager.GainFame("Likes Orc", PlayerLocation, Foreplay)
					EndIf
				ElseIf Actors[ActorIndex].GetRace() == KhajiitRace[0] || Actors[ActorIndex].GetRace() == KhajiitRace[1]
					If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
						FameManager.GainFame("Likes Khajiit", PlayerLocation, Foreplay)
					EndIf
				ElseIf Actors[ActorIndex].GetRace() == ArgonianRace[0] || Actors[ActorIndex].GetRace() == ArgonianRace[1]
					If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
						FameManager.GainFame("Likes Argonian", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				;We check if DD is installed, and the player has not gained masochist fame while also making sure the player has not already gained sadist fame, then check the NPC for DD Keywords
				If Mods.IsDDInstalled == True && GainedMasochistFame == False && GainedSadistFame == False && Actors[ActorIndex].WornHasKeyword(Mods.DD_Lockable)
					If Actors[ActorIndex].WornHasKeyword(Mods.DD_Hood) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Harness) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Belt) \
					|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Bra) || Actors[ActorIndex].WornHasKeyword(Mods.DD_HeavyBondage) || Actors[ActorIndex].WornHasKeyword(Mods.DD_ArmCuffs) \
					|| Actors[ActorIndex].WornHasKeyword(Mods.DD_ArmCuffsFront) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Armbinder) || Actors[ActorIndex].WornHasKeyword(Mods.DD_ArmbinderElbow) \
					|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Gloves) || Actors[ActorIndex].WornHasKeyword(Mods.DD_LegCuffs) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Boots) \
					|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Gag) || Actors[ActorIndex].WornHasKeyword(Mods.DD_GagPanel) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Suit) \
					|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Corset) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Blindfold)
						FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
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
	
	Data.FameCheck()
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	LocationManager.CurrentLocation = akNewLoc
	FameManager.UpdateGlobals()
EndEvent

Event OnUpdateGameTime()
	If TimeManager.TimeManagerRunning == False ;Prevent double-up of Periodic Fame Update
		TimeManager.PeriodicFameTimer()
	EndIf
	
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