Scriptname PW_ComponentManagerScript extends Quest
{
Manages script components, will soon monitor their status and be 
responsible for activating and deactivating them

Accesses side quests via base 'interfaces' to keep compile times quick
}

; Flag to indicate that the game is just loading, and we should postpone some papyrus strain to the next update
Int property  needsMaintenance = 2 Auto

bool property initialized = false Auto

String property CURRENT_VERSION = "1.2.0" AutoReadOnly
String property previousVersion = "0.0.0" Auto

; Array of components managed
PW_ScriptComponent[] components
PW_Quest[] quests
PW_SideQuestScript[] sideQuests

Float updatePeriod = 3.0


event OnInit()
	initialized = false
	
	needsMaintenance = 2
	
	RegisterForSingleUpdate(updatePeriod)
endEvent

function MarkForMaintenance()
	if(!initialized)
		PW_Utility.pwDebug(none, 2, "ComponentManager: ignoring MarkForMaintenance because first load")
		return
	endIf
	
	needsMaintenance = 1
	RegisterForSingleUpdate(updatePeriod)
	
endFunction

; Used during startup to postpone initialization papyrus strain
event OnUpdate()

	if(needsMaintenance >= 2)
		PW_Utility.pwDebug(none, 2, "ComponentManager: postponing initialization")
		needsMaintenance = 1
		RegisterForSingleUpdate(updatePeriod)
	elseIf(needsMaintenance == 1)
		maintenance()
		needsMaintenance = 0
		UnregisterForUpdate()
	endIf
	
endEvent

function Maintenance()
	
	; Open log - TODO make PW_Utility a Script Component and do this in its startup
	Debug.OpenUserLog("PublicWhore")
	

	PW_Utility.pwDebug(none, 2, "ComponentManager: performing maintenance")

	; Check if mod is just starting up, needs to be initialized
	if(!initialized)
		
		Debug.Notification("Public Whore v" + CURRENT_VERSION + " initializing")
		; Whenever a new script component is added, this should be updated to include it
		components = new PW_ScriptComponent[9]
		components[0] = Quest.GetQuest("PW_ActorManager")     as PW_ScriptComponent
		components[1] = Quest.GetQuest("PW_Fame")             as PW_ScriptComponent
		components[2] = Quest.GetQuest("PW_Main")             as PW_ScriptComponent
		components[3] = Quest.GetQuest("PW_ModIntegrations")  as PW_ScriptComponent
		components[4] = Quest.GetQuest("PW_Punishment")       as PW_ScriptComponent
		components[5] = Quest.GetQuest("PW_QuotaManagement")  as PW_ScriptComponent
		components[6] = Quest.GetQuest("PW_SexQueueManager")  as PW_ScriptComponent
		components[7] = Quest.GetQuest("PW_Startup")          as PW_ScriptComponent
		components[8] = Quest.GetQuest("PW_Tracker")          as PW_ScriptComponent
		
		quests = new PW_Quest[9]
		quests[0] = Quest.GetQuest("PW__DawnstarQuest")    as PW_Quest
		quests[1] = Quest.GetQuest("PW__FalkreathQuest")   as PW_Quest
		quests[2] = Quest.GetQuest("PW__MarkarthQuest")    as PW_Quest
		quests[3] = Quest.GetQuest("PW__MorthalQuest")     as PW_Quest
		quests[4] = Quest.GetQuest("PW__RiftenQuest")      as PW_Quest
		quests[5] = Quest.GetQuest("PW__SolitudeQuest")    as PW_Quest
		quests[6] = Quest.GetQuest("PW__WhiterunQuest")    as PW_Quest
		quests[7] = Quest.GetQuest("PW__WindhelmQuest")    as PW_Quest
		quests[8] = Quest.GetQuest("PW__WinterholdQuest")  as PW_Quest
		
		sideQuests = new PW_SideQuestScript[6]
		sideQuests[0] = Quest.GetQuest("PW_WhiterunStart") as PW_SideQuestScript
		sideQuests[1] = Quest.GetQuest("PW_WindhelmStart") as PW_SideQuestScript
		sideQuests[2] = Quest.GetQuest("PW_SolitudeStart") as PW_SideQuestScript
		sideQuests[3] = Quest.GetQuest("PW_SQ_Bandits")    as PW_SideQuestScript
		sideQuests[4] = Quest.GetQuest("PW_SQ_Giant")    as PW_SideQuestScript
		sideQuests[5] = Quest.GetQuest("PW_RE_Threesome")  as PW_SideQuestScript
		
		
		InitializeAll()

		previousVersion = CURRENT_VERSION
		
		initialized = true
		Debug.Notification("Public Whore v" + CURRENT_VERSION + " ready")
		
	endIf
	
	; Startup all components every time
	StartupAll()
	
endFunction

function InitializeAll()
	int i = 0
	while i < components.length
		PW_Utility.pwDebug(self, 1, "initializing " + components[i].componentName + "...")
		
		if components[i].Start()
			components[i].Initialize()
		else
			PW_Utility.pwDebug(self, 5, "FAILED to start component quest - " + components[i].componentName)
		endIf
		PW_Utility.pwDebug(self, 1, components[i].componentName + " initialized")
		
		i += 1
	endWhile
	
	PW_Utility.pwDebug(self, 3, "ComponentManager: Done initializing components")
endFunction

function StartupAll()
	int i = 0
	while i < components.length
		PW_Utility.pwDebug(self, 1, "starting up " + components[i].componentName)
		components[i].Startup()
		PW_Utility.pwDebug(self, 1, components[i].componentName + " started")
		i += 1
	endWhile
	
	;Also re-register quests for their mod events
	i = 0
	while i < quests.length
		if(quests[i].isRunning())
			quests[i].RegisterEvents()
		endIf
		i += 1
	endWhile
	
	i = 0
	while i < sideQuests.length
		if(sideQuests[i].isRunning())
			sideQuests[i].RegisterForEvents()
		endIf
		i += 1
	endWhile
	
	PW_Utility.pwDebug(self, 3, "ComponentManager: Done starting up components")
endFunction


function PrintComponents()
	
	string output = ""
	
	int i = 0
	while i < components.length
		output += components[i].componentName + "\n"
		i += 1
	endWhile
	
	Debug.MessageBox(output)
endFunction