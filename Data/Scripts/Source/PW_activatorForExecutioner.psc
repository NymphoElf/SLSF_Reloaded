Scriptname PW_activatorForExecutioner extends ObjectReference  
{Remotely Activate ZaZ furniture without passing the User}

Objectreference Property targetFurn Auto

Event OnActivate(ObjectReference akActionRef)
	targetFurn.activate(self)
endEvent
