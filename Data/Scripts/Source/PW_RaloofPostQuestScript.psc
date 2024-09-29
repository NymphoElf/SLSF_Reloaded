Scriptname PW_RaloofPostQuestScript extends ReferenceAlias 

Function RegisterEvents()
	RegisterForModEvent("PW_DailyUpdate", "OnDailyUpdate")
endFunction

Event OnDailyUpdate()
	RegisterForSingleLOSGain(GetActorReference(), Game.GetPlayer())
endEvent

Event OnGainLOS(Actor raloof, ObjectReference player)
	Debug.Notification("Raloof is going to breed you again")
	sexQueue.enqueue(raloof)
endEvent

PW_SexQueueScript property sexQueue Auto

