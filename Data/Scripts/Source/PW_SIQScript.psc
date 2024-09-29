Scriptname PW_SIQScript extends PW_SideQuestScript Conditional

ReferenceAlias property waitMarker Auto 
ReferenceAlias property RainenAlias Auto

ObjectReference property RainenSpawnMarker Auto

ActorBase property RainenAB Auto

Scene property RainenTravelToBP Auto

int property rainenDelayCount = 0 Auto Conditional		;How many times Rainen has been delayed
int property playerInsightLevel = 0 Auto Conditional	;How attuned the PC is to Vedia's plot

function RegisterForEvents()
	RegisterForModEvent("PW_StatusCleared", "OnStatusCleared")
	questLocIndex = 5
endFunction

event OnStatusCleared(int locIndex)
	if(locIndex == questLocIndex && GetStage() > 0)
		EndQuest()
	endIf
endEvent

function EndQuest()
	SetStage(100)
endFunction

event OnUpdateGameTime()
{Received when Rainen should be approaching the Blue Palace, makes Rainen approach the Blue Palace}
	if(Game.GetPlayer().GetDistance(waitMarker.GetReference()) <= 900 || Game.GetPlayer().HasLOS(waitMarker.GetReference()))
		RainenAlias.ForceRefTo(RainenSpawnMarker.PlaceAtMe(RainenAB))
		SetObjectiveCompleted(0)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1)
		RainenTravelToBP.ForceStart()
	else
		SetObjectiveFailed(0)
		SetStage(110)
	endIf
endEvent