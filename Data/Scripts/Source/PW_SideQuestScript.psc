Scriptname PW_SideQuestScript extends Quest Conditional
;Interface base class inherited by any content-type quest


int property questLocIndex = 6 Auto Conditional ;Location index the quest is for


;Ends the quest
;Override this in the derived class with specific cleanup instructions
function EndQuest()
	PW_Utility.pwDebug(self, 4, "calling base PW_SideQuestScript EndQuest(), this probably isn't intentional!")
	Stop()
endFunction

;Registers this quest for any necessary mod events
;Must be overridden in derived class
function RegisterForEvents()
endFunction