Scriptname PW_DialogueConds extends Quest  Conditional

event OnInit()
	RegisterForModEvent("PW_SetDgCond", "SetDgCond")
endEvent

event SetDgCond(string c, bool v)
	
endEvent

;DIALOGUE CONDITIONALS: Flags for very lazily interfacing between dialogue and script
bool property hasEnough = false Auto Conditional	;Checked when determining if the player has enough gold for something
bool property isFinished = false Auto Conditional	;Checked when determining if the player has finished duty
bool property overtimeReported = false Auto Conditional
bool property voluntary = false Auto Conditional
bool property isRape = false Auto Conditional	;Is the player being raped right now
bool property difficultClient = false Auto Conditional
bool property notPaying = false Auto Conditional
bool property beggar = false Auto Conditional
bool property sadisticRape = false Auto Conditional	;When a sadistic roll ends in an NPC raping the player immediately with no pay
bool property solicitFailure = false Auto Conditional	;The next solicitation will fail
bool property sadisticClient = false Auto Conditional


;Resets the solicitFailure condition
function RerollSolicitFailure()
	solicitFailure = Utility.RandomInt(0, 100) <= solicitFailChance.GetValue()
endFunction

function RerollSadisticClient()
	sadisticClient = Utility.RandomInt(0, 100) <= sadisticClientChance.GetValue()
endFunction

function RerollClientConds()
	RerollSolicitFailure()
	RerollSadisticClient()
endFunction


GlobalVariable property solicitFailChance Auto
GlobalVariable property sadisticClientChance Auto