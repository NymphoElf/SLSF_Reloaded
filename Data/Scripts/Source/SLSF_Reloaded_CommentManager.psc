Scriptname SLSF_Reloaded_CommentManager extends Quest  

GlobalVariable Property SLSF_AllowComment Auto
GlobalVariable Property SLSF_Reloaded_CommentFrequency Auto

Actor Property PlayerRef Auto

Event OnInit()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnUpdate()
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