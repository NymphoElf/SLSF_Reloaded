Scriptname PW_WHMIQPostQuest_MasterScript extends ReferenceAlias  

event OnDeath(actor akKiller)
	GetOwningQuest().Stop()
endEvent