Scriptname PW_SQ_BanditScript extends ReferenceAlias  


Event OnDeath(Actor akKiller)
	GetOwningQuest().setStage(200)

EndEvent
