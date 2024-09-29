Scriptname PW_CellTracking extends Quest

;Not really "cell tracking" per se; the event PW_OnCellChange is indeed called every time the player changes cells,
;but locations are tracked as opposed to the cells. (Although theoretically this could be made to identify cells too.)

Spell property PW_DetectCellChangeAbility auto
ReferenceAlias Property PlayerRef  Auto  
String currentLocName

Event OnInit()
	actor player = PlayerRef.GetActorReference()
	player.addSpell(PW_DetectCellChangeAbility)
	debug.Notification("PW is now tracking the player's cell")

	RegisterForModEvent("pwCellChanged", "PW_OnCellChange")
endevent


Event PW_OnCellChange(Form newLoc)
	if(newLoc as Location)
		;Debug.Notification("PW successfully passed the player's location through an event")
	else
		;Debug.Notification("PW failed to pass the player's location through cell change event")
	endif
	;Debug.Notification("PW: Player has moved to: " + newLoc.GetName())
endevent


;This script is currently obsolete. I keep it incase we need fine-tuned player tracking at some point