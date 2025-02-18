Scriptname SLSF_Reloaded_CommentManager extends Quest  

SLSF_Reloaded_ModIntegration Property Mods Auto
SLSF_Reloaded_MCM Property Config Auto
SLSF_Reloaded_VisibilityManager Property VisibilityManager Auto

GlobalVariable Property SLSF_AllowComment Auto
GlobalVariable Property SLSF_Reloaded_CommentFrequency Auto
GlobalVariable Property WICommentChanceNaked Auto

Actor Property PlayerRef Auto

Event OnInit()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnUpdate()
	NakedCommentPublicWhoreCheck()
	
	If VisibilityManager.IsPlayerAnonymous() == True
		SLSF_AllowComment.SetValue(0.0)
		RegisterForSingleUpdate(10.0)
		return
	EndIf
	
    If PlayerRef.GetCombatState() != 0
        RegisterForSingleUpdate(6.0)
    Else
        Int CommentChance = SLSF_Reloaded_CommentFrequency.GetValue() as Int
        Int CommentRoll = Utility.RandomInt(1, 100)
        If CommentRoll <= CommentChance
            SLSF_AllowComment.SetValue(1.0)
        Else
            SLSF_AllowComment.SetValue(0.0)
        EndIf
        RegisterForSingleUpdate(2.0)
    EndIf
EndEvent

Function NakedCommentPublicWhoreCheck()
	If Mods.IsPublicWhore() == True && Config.DisableNakedCommentsWhilePW == True
		WICommentChanceNaked.SetValue(-1)
	ElseIf Mods.IsANDInstalled == False
		WICommentChanceNaked.SetValue(100)
	EndIf
EndFunction