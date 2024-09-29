Scriptname PW_SQ_TurncoatBanditScript extends ReferenceAlias  


event OnDeath(actor killer)
	GetOwningQuest().SetObjectiveCompleted(23)
endEvent