ScriptName SLSF_Reloaded_SexAnimationAnalyzer extends ReferenceAlias

SexlabFramework Property Sexlab Auto

SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto
SLSF_Reloaded_LocationManager Property LocationManager Auto
SLSF_Reloaded_FameManager Property FameManager Auto
SLSF_Reloaded_PlayerScript Property PlayerScript Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_DataManager Property Data Auto
SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_Logger Property Logger Auto

Actor Property PlayerRef Auto

Bool Property SexSceneEnded Auto Hidden

Race[] Property OrcRace Auto
Race[] Property KhajiitRace Auto
Race[] Property ArgonianRace Auto

Function AnimationAnalyze(Int threadID)
	Logger.Log("SLSF Reloaded - Animation Analyze started")
	If VisibilityManager.IsPlayerAnonymous() == True
		Logger.Log("SLSF Reloaded - Animation Analyze: Player is Anonymous. Analyze Stopped.")
		return
	EndIf
	
	String PlayerLocation = LocationManager.CurrentLocationName()
	
	If LocationManager.IsLocationValid(PlayerLocation) == False
		Logger.Log("SLSF Reloaded - Animation Analyze: Location is Invalid. Analyze Stopped.")
		return
	EndIf
	
	Int PlayerThread = Sexlab.FindPlayerController()
	sslThreadController PlayerController = Sexlab.GetController(PlayerThread)
	
	Utility.Wait(10.0) ;Give the player a short time to change the animation (or cancel it) if needed before grabbing information about the animation. Tried to account for possible starting lag as well.
	
	If SexSceneEnded == True
		Logger.Log("SLSF Reloaded - Animation Analyze: 'SexSceneEnded' detected as TRUE. Analyze Stopped.")
		return
	EndIf
	
	If PlayerController.Animation.HasTag("BodySearch")
		Logger.Log("SLSF Reloaded - Animation Analyze: Detected BodySearch animation. Analyze Stopped.")
		return ;Ignore BodySearch Animations
	EndIf
	
	Bool Foreplay = False
	
	If PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == True
		Foreplay = True
	ElseIf PlayerController.Animation.HasTag("LeadIn") && Config.AllowForeplayFame == False
		Logger.Log("SLSF Reloaded - Animation Analyze: Detected LeadIn animation and AllowForeplayFame is FALSE. Analyze Stopped.")
		return
	EndIf
	
	Actor[] Actors = PlayerController.Positions
	Int PlayerSex = PlayerRef.GetActorBase().GetSex() ;0 = Male | 1 = Female
	Bool AllPartnersAreFriends = False
	Bool AllPartnersAreLovers = False
	Int PartnerRelationship = 0
	
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
		Logger.Log("SLSF Reloaded - Animation Analyze: Actor Length is more than 1")
		Int PartnerIndex = 0
		Int KissAndTellRoll = Utility.RandomInt(1,100)
		Int FriendKissAndTell = Config.SexFameChanceByFriend as Int
		Int LoverKissAndTell = Config.SexFameChanceByLover as Int
		Bool StopPartnerCheck = False
		
		While PartnerIndex < Actors.Length && StopPartnerCheck == False
			Logger.Log("SLSF Reloaded - Animation Analyze: PartnerIndex is " + PartnerIndex)
			If Actors[PartnerIndex] != PlayerRef
				PartnerRelationship = Actors[PartnerIndex].GetRelationshipRank(PlayerRef)
				Logger.Log("SLSF Reloaded - Animation Analyze: Checked partner relationship is " + PartnerRelationship)
				If PartnerRelationship < 1
					StopPartnerCheck = True
					AllPartnersAreFriends = False
					AllPartnersAreLovers = False
					Logger.Log("SLSF Reloaded - Animation Analyze: At least one partner is not a Friend or Lover. Partner Check will end.")
				ElseIf PartnerRelationship > 0 && PartnerRelationship < 4
					AllPartnersAreFriends = True
					AllPartnersAreLovers = False
					Logger.Log("SLSF Reloaded - Animation Analyze: Currently all partners are at least FRIEND")
				ElseIf PartnerRelationship > 3 && AllPartnersAreFriends == False
					AllPartnersAreLovers = True
					Logger.Log("SLSF Reloaded - Animation Analyze: Currently all partners are LOVER")
				EndIf
			Else
				Logger.Log("SLSF Reloaded - Animation Analyze: Partner index is PLAYER. Relationship check skipped.")
			EndIf
			PartnerIndex += 1
		EndWhile
		
		If (AllPartnersAreFriends == False && AllPartnersAreLovers == False)
		
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
			
			If (Config.SubmissiveDefault == True || FameManager.CanGainBoundFame(PlayerLocation) || (PlayerSex == 1 && HasStrapon == False)) && Config.DominantDefault == False
				IsSubmissive = True
				FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
			ElseIf (Config.DominantDefault == True || (PlayerSex == 1 && HasStrapon == True) || PlayerSex == 0) && Config.SubmissiveDefault == False
				IsDominant = True
				FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
			EndIf
			
			If FameManager.CanGainBoundFame(PlayerLocation)
				FameManager.GainFame("Bound", PlayerLocation, Foreplay)
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
		
		ElseIf AllPartnersAreFriends == True
		
			If KissAndTellRoll <= FriendKissAndTell
				If PlayerController.Animation.HasTag("Oral")
					If Config.FameForbiddenByFriend[3] == False
						FameManager.GainFame("Oral", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If PlayerController.Animation.HasTag("Anal")
					If Config.FameForbiddenByFriend[4] == False
						FameManager.GainFame("Anal", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If PlayerController.Animation.HasTag("Orgy") || Actors.Length > 2
					If Config.FameForbiddenByFriend[18] == False
						FameManager.GainFame("Group", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If !PlayerController.Animation.HasTag("Aggressive") && IsVictim == False && IsAggressor == False
					If Mods.IsPublicWhore() == True || IsSexWorker == True
						If Config.FameForbiddenByFriend[0] == False
							FameManager.GainFame("Whore", PlayerLocation, Foreplay)
						EndIf
					Else
						If Config.FameForbiddenByFriend[1] == False
							FameManager.GainFame("Slut", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf
				
				If (Config.SubmissiveDefault == True || FameManager.CanGainBoundFame(PlayerLocation) || (PlayerSex == 1 && HasStrapon == False)) && Config.DominantDefault == False
					IsSubmissive = True
					If Config.FameForbiddenByFriend[8] == False
						FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
					EndIf
				ElseIf (Config.DominantDefault == True || (PlayerSex == 1 && HasStrapon == True) || PlayerSex == 0) && Config.SubmissiveDefault == False
					IsDominant = True
					If Config.FameForbiddenByFriend[7] == False
						FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If FameManager.CanGainBoundFame(PlayerLocation)
					If Config.FameForbiddenByFriend[19] == False
						FameManager.GainFame("Bound", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If (IsVictim == True && Config.VictimsAreMasochist == True) || (FameManager.CanGainBoundFame(PlayerLocation) && IsDominant == False) || (PlayerController.Animation.HasTag("Aggressive") && IsVictim == False && IsSubmissive == True)
					If Config.FameForbiddenByFriend[10] == False
						FameManager.GainFame("Masochist", PlayerLocation, Foreplay)
					EndIf
					GainedMasochistFame = True
				EndIf
				
				If (IsAggressor == True || (PlayerController.Animation.HasTag("Aggressive") && IsDominant == True)) && GainedMasochistFame == False
					If Config.FameForbiddenByFriend[9] == False
						FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
					EndIf
					GainedSadistFame = True
				EndIf
				
				If (PlayerSex == 1 && FemaleCount > 1) || (PlayerSex == 0 && FemaleCount > 0)
					If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
						If Config.FameForbiddenByFriend[13] == False
							FameManager.GainFame("Likes Women", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf
				
				If (PlayerSex == 1 && MaleCount > 0) || (PlayerSex == 0 && MaleCount > 1)
					If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
						If Config.FameForbiddenByFriend[12] == False
							FameManager.GainFame("Likes Men", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf
				
				If PlayerController.Animation.HasTag("Creature") || PlayerController.Animation.HasTag("Bestiality")
					If IsVictim == False || (IsVictim == True && Config.AllowBestialityWhenRaped == True)
						If Config.FameForbiddenByFriend[17] == False
							FameManager.GainFame("Bestiality", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf

				If (IsVictim == False && IsAggressor == False) && (PlayerController.Animation.HasTag("Loving") || PlayerController.Animation.HasTag("Hugging") || PlayerController.Animation.HasTag("Cuddling") || PlayerController.Animation.HasTag("Kissing"))
					If Config.FameForbiddenByFriend[11] == False
						FameManager.GainFame("Gentle", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				Int ActorIndex = 0
				While ActorIndex < Actors.Length
					If Actors[ActorIndex] != PlayerRef
						If Actors[ActorIndex].GetRace() == OrcRace[0] || Actors[ActorIndex].GetRace() == OrcRace[1]
							If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
								If Config.FameForbiddenByFriend[14] == False
									FameManager.GainFame("Likes Orc", PlayerLocation, Foreplay)
								EndIf
							EndIf
						ElseIf Actors[ActorIndex].GetRace() == KhajiitRace[0] || Actors[ActorIndex].GetRace() == KhajiitRace[1]
							If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
								If Config.FameForbiddenByFriend[15] == False
									FameManager.GainFame("Likes Khajiit", PlayerLocation, Foreplay)
								EndIf
							EndIf
						ElseIf Actors[ActorIndex].GetRace() == ArgonianRace[0] || Actors[ActorIndex].GetRace() == ArgonianRace[1]
							If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
								If Config.FameForbiddenByFriend[16] == False
									FameManager.GainFame("Likes Argonian", PlayerLocation, Foreplay)
								EndIf
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
								If Config.FameForbiddenByFriend[9] == False
									FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
								EndIf
							EndIf
						EndIf
					EndIf
					ActorIndex += 1
				EndWhile
			EndIf
			
		ElseIf AllPartnersAreLovers == True
		
			If KissAndTellRoll <= LoverKissAndTell
				If PlayerController.Animation.HasTag("Oral")
					If Config.FameForbiddenByLover[3] == False
						FameManager.GainFame("Oral", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If PlayerController.Animation.HasTag("Anal")
					If Config.FameForbiddenByLover[4] == False
						FameManager.GainFame("Anal", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If PlayerController.Animation.HasTag("Orgy") || Actors.Length > 2
					If Config.FameForbiddenByLover[18] == False
						FameManager.GainFame("Group", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If (Config.SubmissiveDefault == True || FameManager.CanGainBoundFame(PlayerLocation) || (PlayerSex == 1 && HasStrapon == False)) && Config.DominantDefault == False
					IsSubmissive = True
					If Config.FameForbiddenByLover[8] == False
						FameManager.GainFame("Submissive", PlayerLocation, Foreplay)
					EndIf
				ElseIf (Config.DominantDefault == True || (PlayerSex == 1 && HasStrapon == True) || PlayerSex == 0) && Config.SubmissiveDefault == False
					IsDominant = True
					If Config.FameForbiddenByLover[7] == False
						FameManager.GainFame("Dominant", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If FameManager.CanGainBoundFame(PlayerLocation)
					If Config.FameForbiddenByLover[19] == False
						FameManager.GainFame("Bound", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				If (IsVictim == True && Config.VictimsAreMasochist == True) || (FameManager.CanGainBoundFame(PlayerLocation) && IsDominant == False) || (PlayerController.Animation.HasTag("Aggressive") && IsVictim == False && IsSubmissive == True)
					If Config.FameForbiddenByLover[10] == False
						FameManager.GainFame("Masochist", PlayerLocation, Foreplay)
					EndIf
					GainedMasochistFame = True
				EndIf
				
				If (IsAggressor == True || (PlayerController.Animation.HasTag("Aggressive") && IsDominant == True)) && GainedMasochistFame == False
					If Config.FameForbiddenByLover[9] == False
						FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
					EndIf
					GainedSadistFame = True
				EndIf
				
				If (PlayerSex == 1 && FemaleCount > 1) || (PlayerSex == 0 && FemaleCount > 0)
					If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
						If Config.FameForbiddenByLover[13] == False
							FameManager.GainFame("Likes Women", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf
				
				If (PlayerSex == 1 && MaleCount > 0) || (PlayerSex == 0 && MaleCount > 1)
					If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
						If Config.FameForbiddenByLover[12] == False
							FameManager.GainFame("Likes Men", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf
				
				If PlayerController.Animation.HasTag("Creature") || PlayerController.Animation.HasTag("Bestiality")
					If IsVictim == False || (IsVictim == True && Config.AllowBestialityWhenRaped == True)
						If Config.FameForbiddenByLover[17] == False
							FameManager.GainFame("Bestiality", PlayerLocation, Foreplay)
						EndIf
					EndIf
				EndIf

				If (IsVictim == False && IsAggressor == False) && (PlayerController.Animation.HasTag("Loving") || PlayerController.Animation.HasTag("Hugging") || PlayerController.Animation.HasTag("Cuddling") || PlayerController.Animation.HasTag("Kissing"))
					If Config.FameForbiddenByLover[11] == False
						FameManager.GainFame("Gentle", PlayerLocation, Foreplay)
					EndIf
				EndIf
				
				Int ActorIndex = 0
				While ActorIndex < Actors.Length
					If Actors[ActorIndex] != PlayerRef
						If Actors[ActorIndex].GetRace() == OrcRace[0] || Actors[ActorIndex].GetRace() == OrcRace[1]
							If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
								If Config.FameForbiddenByLover[14] == False
									FameManager.GainFame("Likes Orc", PlayerLocation, Foreplay)
								EndIf
							EndIf
						ElseIf Actors[ActorIndex].GetRace() == KhajiitRace[0] || Actors[ActorIndex].GetRace() == KhajiitRace[1]
							If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
								If Config.FameForbiddenByLover[15] == False
									FameManager.GainFame("Likes Khajiit", PlayerLocation, Foreplay)
								EndIf
							EndIf
						ElseIf Actors[ActorIndex].GetRace() == ArgonianRace[0] || Actors[ActorIndex].GetRace() == ArgonianRace[1]
							If IsVictim == False || (IsVictim == True && Config.AllowLikeFameWhenRaped == True)
								If Config.FameForbiddenByLover[16] == False
									FameManager.GainFame("Likes Argonian", PlayerLocation, Foreplay)
								EndIf
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
								If Config.FameForbiddenByLover[9] == False
									FameManager.GainFame("Sadist", PlayerLocation, Foreplay)
								EndIf
							EndIf
						EndIf
					EndIf
					ActorIndex += 1
				EndWhile
			EndIf
		EndIf
	Else
		If LocationManager.IsLocationValid(LocationManager.CurrentLocationName()) == True
			PlayerScript.RunNPCDetect()
		EndIf
	EndIf
	
	Data.FameCheck()
	Logger.Log("SLSF Reloaded - Animation Analyze finished.")
EndFunction