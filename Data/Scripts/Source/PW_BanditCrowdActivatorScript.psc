Scriptname PW_BanditCrowdActivatorScript extends ObjectReference  

ObjectReference property tact Auto

event OnActivate(ObjectReference akActionRef)
	tact.Activate(Game.GetPlayer(), true)
endEvent