ScriptName SLSF_Reloaded_SexAnimationAnalyzer extends ReferenceAlias

SexlabFramework Property Sexlab Auto

SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_Logger Property Logger Auto

Actor Property PlayerRef Auto

Bool Property SexSceneEnded Auto Hidden

Race[] Property OrcRace Auto
Race[] Property KhajiitRace Auto
Race[] Property ArgonianRace Auto

GlobalVariable Property SLSF_Reloaded_NPCScanSucess Auto

Spell Property NPCScanSpell Auto

Function AnimationAnalyze(Int threadID)
	SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - START")
	If VisibilityManager.IsPlayerAnonymous() == True
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Player is Anonymous. Analyze Stopped.")
		return
	EndIf
	
	String PlayerLocation = LocationManager.CurrentLocationName()
	
	If LocationManager.IsLocationValid(PlayerLocation) == False
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Location is Invalid. Analyze Stopped.")
		return
	EndIf
	
	Int PlayerThread = Sexlab.FindPlayerController()
	sslThreadController PlayerController = Sexlab.GetController(PlayerThread)
	
	Utility.Wait(10.0) ;Give the player a short time to change the animation (or cancel it) if needed before grabbing information about the animation. Tried to account for possible starting lag as well.
	
	If SexSceneEnded == True
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - 'SexSceneEnded' detected as TRUE before reaching main analysis. Analyze Stopped.")
		return
	EndIf
	
	If PlayerController.Animation.HasTag("BodySearch")
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Detected BodySearch animation. Analyze Stopped.")
		return ;Ignore BodySearch Animations
	EndIf
	
	Bool Foreplay = False
	
	If PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == True
		Foreplay = True
	ElseIf PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == False
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Detected LeadIn animation and AllowForeplayFame is FALSE. Analyze Stopped.")
		return
	EndIf
	
	Actor[] Actors = PlayerController.Positions
	
	Bool AllPartnersAreFriends = False
	Bool AllPartnersAreLovers = False
	Int PartnerRelationship = 0
	
	If Actors.Length > 1
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Actor Length is more than 1")
		Int PartnerIndex = 0
		Int KissAndTellRoll = Utility.RandomInt(1,100)
		Int FriendKissAndTell = Config.SexFameChanceByFriend as Int
		Int LoverKissAndTell = Config.SexFameChanceByLover as Int
		Bool StopPartnerCheck = False
		
		While PartnerIndex < Actors.Length && StopPartnerCheck == False
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - PartnerIndex is " + PartnerIndex)
			If Actors[PartnerIndex] != PlayerRef
				PartnerRelationship = Actors[PartnerIndex].GetRelationshipRank(PlayerRef)
				SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Checked partner relationship is " + PartnerRelationship)
				If PartnerRelationship < 1
					StopPartnerCheck = True
					AllPartnersAreFriends = False
					AllPartnersAreLovers = False
					SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - At least one partner is not a Friend or Lover. Partner Check will end.")
				ElseIf PartnerRelationship > 0 && PartnerRelationship < 4
					AllPartnersAreFriends = True
					AllPartnersAreLovers = False
					SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Currently all partners are at least FRIEND")
				ElseIf PartnerRelationship > 3 && AllPartnersAreFriends == False
					AllPartnersAreLovers = True
					SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Currently all partners are LOVER")
				EndIf
			Else
				SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - Partner index is PLAYER. Relationship check skipped.")
			EndIf
			PartnerIndex += 1
		EndWhile
		
		If (AllPartnersAreFriends == False && AllPartnersAreLovers == False)
			AnimationSubAnalyze(Actors, PlayerController, PlayerThread, Foreplay, PlayerLocation)
		ElseIf AllPartnersAreFriends == True
			If KissAndTellRoll <= FriendKissAndTell
				AnimationSubAnalyze(Actors, PlayerController, PlayerThread, Foreplay, PlayerLocation, True)
			EndIf
		ElseIf AllPartnersAreLovers == True
			If KissAndTellRoll <= LoverKissAndTell
				AnimationSubAnalyze(Actors, PlayerController, PlayerThread, Foreplay, PlayerLocation, False, True)
			EndIf
		EndIf
	Else
		If LocationManager.IsLocationValid(LocationManager.CurrentLocationName()) == True
			SLSF_Reloaded_NPCScanSucess.SetValue(0)
			NPCScanSpell.Cast(PlayerRef)
		EndIf
	EndIf
	
	Data.FameCheck()
	SLSF_Reloaded_Logger.Log("<Animation Analyzer> [Animation Analyze] - END")
EndFunction

Function AnimationSubAnalyze(Actor[] Actors, sslThreadController PlayerController, Int PlayerThread, Bool Foreplay, String PlayerLocation, Bool Friend = False, Bool Lover = False)
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
	
	If PlayerController.Animation.HasTag("Oral") && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[3] == False) || (Lover == True && Config.FameForbiddenByLover[3] == False))
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation has ORAL Tag")
		FameManager.GainFame("Oral", PlayerLocation, Foreplay)
	EndIf
	
	If PlayerController.Animation.HasTag("Anal") && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[4] == False) || (Lover == True && Config.FameForbiddenByLover[4] == False))
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation has ANAL Tag")
		FameManager.GainFame("Anal", PlayerLocation, Foreplay)
	EndIf
	
	If (PlayerController.Animation.HasTag("Orgy") || Actors.Length > 2) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[18] == False) || (Lover == True && Config.FameForbiddenByLover[18] == False))
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation has ORGY Tag or involves move than 2 actors, and either involves at least 1 Nutral/Enemy or Group Fame is not excluded by appropriate Friend/Lover")
		FameManager.GainFame("Group", PlayerLocation, Foreplay)
	EndIf
	
	If !PlayerController.Animation.HasTag("Aggressive") && IsVictim == False && IsAggressor == False
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation has AGGRESSIVE Tag, and Player is NOT Victim or Aggressor")
		If (Mods.IsPublicWhore() == True || IsSexWorker == True) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[0] == False) || (Lover == True && Config.FameForbiddenByLover[0] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is Flagged as a Sex Worker of some kind, and either involves at least 1 Nutral/Enemy or Whore Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Whore", PlayerLocation, Foreplay)
		ElseIf ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[1] == False) || (Lover == True && Config.FameForbiddenByLover[1] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is NOT Flagged as a Sex Worker of some kind, and either involves at least 1 Nutral/Enemy or Slut Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Slut", PlayerLocation, Foreplay)
		EndIf
	EndIf
	
	If (Config.SubmissiveDefault == True || FameManager.CanGainBoundFame(PlayerLocation) || (PlayerSex == 1 && HasStrapon == False)) && Config.DominantDefault == False
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either Flagged as Submissive in MCM, can gain Bound Fame in this Location, or is a Female and NOT wearing a Strapon, and is also not Flagge as Dominant in the MCM")
		IsSubmissive = True
		If ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[8] == False) || (Lover == True && Config.FameForbiddenByLover[8] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation involves at least 1 Nutral/Enemy or Submissive Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
		EndIf
	ElseIf (Config.DominantDefault == True || (PlayerSex == 1 && HasStrapon == True) || PlayerSex == 0) && Config.SubmissiveDefault == False
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either Flagged as Dominant in MCM, is a Female and wearing a Strapon, or is a Male, and is also not Flagge as Submissive in the MCM")
		IsDominant = True
		If ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[7] == False) || (Lover == True && Config.FameForbiddenByLover[7] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation involves at least 1 Nutral/Enemy or Dominant Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
		EndIf
	EndIf
	
	If FameManager.CanGainBoundFame(PlayerLocation) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[19] == False) || (Lover == True && Config.FameForbiddenByLover[19] == False))
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player can gain BOUND Fame in Location, and animation involves at least 1 Nutral/Enemy or Bound Fame is not excluded by appropriate Friend/Lover")
		FameManager.GainFame("Bound", PlayerLocation, Foreplay)
	EndIf
	
	If (IsVictim == True && Config.VictimsAreMasochist == True) || (FameManager.CanGainBoundFame(PlayerLocation) && IsDominant == False) || (PlayerController.Animation.HasTag("Aggressive") && IsVictim == False && IsSubmissive == True)
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player can gain MASOCHIST Fame because either: the Player is a Victim and Victims can be Masochists, can gain Bound Fame in Location and is NOT Dominant, or animation is Aggressive and NOT Victim and IS Submissive")
		If ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[10] == False) || (Lover == True && Config.FameForbiddenByLover[10] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation involves at least 1 Nutral/Enemy or Masochist Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Masochist", PlayerLocation, Foreplay)
		EndIf
		GainedMasochistFame = True
	EndIf
	
	If (IsAggressor == True || (PlayerController.Animation.HasTag("Aggressive") && IsDominant == True)) && GainedMasochistFame == False
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player can gain SADIST Fame because either: the Player is the Aggressor or Player is Flagged as Dominant and animation has the Aggressive Tag, and did not gain Masochit Fame")
		If ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[9] == False) || (Lover == True && Config.FameForbiddenByLover[9] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation involves at least 1 Nutral/Enemy or Sadist Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
		EndIf
		GainedSadistFame = True
	EndIf
	
	If (PlayerSex == 1 && FemaleCount > 1) || (PlayerSex == 0 && FemaleCount > 0)
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player can gain LIKES WOMEN Fame because either: the Player is Female and the animation has another Female involved, or the Player is Male and the animation involves at least 1 Female")
		If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[13] == False) || (Lover == True && Config.FameForbiddenByLover[13] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either NOT Victim or 'Likes' fame is allowed when raped, and animation involves at least 1 Nutral/Enemy or Likes Women Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Likes Women", PlayerLocation, Foreplay)
		EndIf
	EndIf
	
	If (PlayerSex == 1 && MaleCount > 0) || (PlayerSex == 0 && MaleCount > 1)
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player can gain LIKES MEN Fame because either: the Player is Male and the animation has another Male involved, or the Player is Female and the animation involves at least 1 Male")
		If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[12] == False) || (Lover == True && Config.FameForbiddenByLover[12] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either NOT Victim or 'Likes' fame is allowed when raped, and animation involves at least 1 Nutral/Enemy or Likes Men Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Likes Men", PlayerLocation, Foreplay)
		EndIf
	EndIf
	
	If PlayerController.Animation.HasTag("Creature") || PlayerController.Animation.HasTag("Bestiality")
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation has CREATURE or BESTIALITY Tag")
		If IsVictim == False || (IsVictim == True && Config.AllowBestialityWhenRaped == True) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[17] == False) || (Lover == True && Config.FameForbiddenByLover[17] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either NOT Victim or IS Victim and Bestiality Fame is allowed when raped, and animation involves at least 1 Nutral/Enemy or Bestiality Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Bestiality", PlayerLocation, Foreplay)
		EndIf
	EndIf

	If (IsVictim == False && IsAggressor == False) && (PlayerController.Animation.HasTag("Loving") || PlayerController.Animation.HasTag("Hugging") || PlayerController.Animation.HasTag("Cuddling") || PlayerController.Animation.HasTag("Kissing"))
		SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is neither Victim nor Aggressor, and animation has LOVING, HUGGING, CUDDLING, or KISSING Tag")
		If ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[11] == False) || (Lover == True && Config.FameForbiddenByLover[11] == False))
			SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation involves at least 1 Nutral/Enemy or Gentle Fame is not excluded by appropriate Friend/Lover")
			FameManager.GainFame("Gentle", PlayerLocation, Foreplay)
		EndIf
	EndIf
	
	Int ActorIndex = 0
	While ActorIndex < Actors.Length
		If Actors[ActorIndex] != PlayerRef
			If Actors[ActorIndex].GetRace() == OrcRace[0] || Actors[ActorIndex].GetRace() == OrcRace[1]
				If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[14] == False) || (Lover == True && Config.FameForbiddenByLover[14] == False))
					SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either NOT Victim or 'Likes' fame is allowed when raped, the animation involves at least one Orc that it NOT the Player, and involves at least 1 Nutral/Enemy or Like Orc Fame is not excluded by appropriate Friend/Lover")
					FameManager.GainFame("Likes Orc", PlayerLocation, Foreplay)
				EndIf
			ElseIf Actors[ActorIndex].GetRace() == KhajiitRace[0] || Actors[ActorIndex].GetRace() == KhajiitRace[1]
				If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[15] == False) || (Lover == True && Config.FameForbiddenByLover[15] == False))
					SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either NOT Victim or 'Likes' fame is allowed when raped, the animation involves at least one Khajiit that it NOT the Player, and involves at least 1 Nutral/Enemy or Like Khajiit Fame is not excluded by appropriate Friend/Lover")
					FameManager.GainFame("Likes Khajiit", PlayerLocation, Foreplay)
				EndIf
			ElseIf Actors[ActorIndex].GetRace() == ArgonianRace[0] || Actors[ActorIndex].GetRace() == ArgonianRace[1]
				If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True) && ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[16] == False) || (Lover == True && Config.FameForbiddenByLover[16] == False))
					SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Player is either NOT Victim or 'Likes' fame is allowed when raped, the animation involves at least one Argonian that it NOT the Player, and involves at least 1 Nutral/Enemy or Like Argonian Fame is not excluded by appropriate Friend/Lover")
					FameManager.GainFame("Likes Argonian", PlayerLocation, Foreplay)
				EndIf
			EndIf
			
			;We check if DD is installed, and the player has not gained masochist fame while also making sure the player has not already gained sadist fame, then check the NPC for DD Keywords
			If Mods.IsDDInstalled == True && GainedMasochistFame == False && GainedSadistFame == False && Actors[ActorIndex].WornHasKeyword(Mods.DD_Lockable)
				SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - DD is installed, Player has not already gained Masochist or Sadist Fame from a prior check, and at least 1 NPC in current animation is wearing a 'DD Lockable' object.")
				If Actors[ActorIndex].WornHasKeyword(Mods.DD_Hood) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Harness) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Belt) \
				|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Bra) || Actors[ActorIndex].WornHasKeyword(Mods.DD_HeavyBondage) || Actors[ActorIndex].WornHasKeyword(Mods.DD_ArmCuffs) \
				|| Actors[ActorIndex].WornHasKeyword(Mods.DD_ArmCuffsFront) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Armbinder) || Actors[ActorIndex].WornHasKeyword(Mods.DD_ArmbinderElbow) \
				|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Gloves) || Actors[ActorIndex].WornHasKeyword(Mods.DD_LegCuffs) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Boots) \
				|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Gag) || Actors[ActorIndex].WornHasKeyword(Mods.DD_GagPanel) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Suit) \
				|| Actors[ActorIndex].WornHasKeyword(Mods.DD_Corset) || Actors[ActorIndex].WornHasKeyword(Mods.DD_Blindfold)
					SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - At least 1 NPC in current animation is wearing an accepted Lockable.")
					If ((Friend == False && Lover == False) || (Friend == True && Config.FameForbiddenByFriend[9] == False) || (Lover == True && Config.FameForbiddenByLover[9] == False))
						SLSF_Reloaded_Logger.Log("<Animation Analyzer> [AnimationSubAnalyze] - Animation involves at least 1 Nutral/Enemy or Sadist Fame is not excluded by appropriate Friend/Lover")
						FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
						GainedSadistFame = True
					EndIf
				EndIf
			EndIf
		EndIf
		ActorIndex += 1
	EndWhile
EndFunction