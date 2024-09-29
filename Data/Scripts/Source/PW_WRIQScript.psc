Scriptname PW_WRIQScript extends PW_SideQuestScript  Conditional

GlobalVariable property PW_WRIQAsked Auto
GlobalVariable property PW_WRIQAssisted Auto
Actor[] property WRIQAskedFactionMembers Auto
Faction property PW_WRIQAskedFaction Auto

;'Sub-quest stages' to track progress through merchant quests
int property adrianneStage = 0 Auto Conditional
int property arcadiaStage = 0 Auto Conditional
int property belethorStage = 0 Auto Conditional
int property farengarStage = 0 Auto Conditional
int property huldaStage = -1 Auto Conditional

event OnInit()
	
endEvent

function RegisterForEvents()
	RegisterForModEvent("PW_StatusCleared", "OnStatusCleared")
	questLocIndex = 6
endFunction

function EndQuest()
	SetStage(50)
endFunction

event OnStatusCleared(int locIndex)
	if(locIndex == questLocIndex && GetStage() > 0)
		EndQuest()
	endIf
endEvent

function incrementAsked(actor who)
	ModObjectiveGlobal(1, PW_WRIQAsked, 20, 5)
	who.AddToFaction(PW_WRIQAskedFaction)
	WRIQAskedFactionMembers[(PW_WRIQAsked.GetValue() - 1) as int] = who
	if(PW_WRIQAsked.GetValue() >= 5)
		SetStage(25)
		int index = 0
		while(index < 5)
			WRIQAskedFactionMembers[index].RemoveFromFaction(PW_WRIQAskedFaction)
			index += 1
		endWhile
	endIf
	return
endFunction

function incrementAssisted()
	ModObjectiveGlobal(1, PW_WRIQAssisted, 30, 5)
	if(PW_WRIQAssisted.GetValue() >= 3)
		SetStage(40)
	endIf
endFunction

bool property BelSceneSexComplete = false Auto conditional
event onBelethorSceneSexEnd(int tid, bool HasPlayer)
	BelSceneSexComplete = true
endEvent

bool property FarSceneSexComplete = false Auto Conditional
event onFarengarSceneSexEnd(int tid, bool HasPlayer)
	FarSceneSexComplete = true
endEvent