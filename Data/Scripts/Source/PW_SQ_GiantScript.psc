Scriptname PW_SQ_GiantScript extends PW_SideQuestScript  Conditional


function RegisterForEvents()
	RegisterForModEvent("HookAnimationEnd_PW_SQ_Giant_FirstGiantSex", "OnGiantSexEnd")
endFunction

event OnGiantSexEnd(int tid, bool HasPlayer)
	if GetStage() == 10
		SetStage(20)
	endIf
endEvent