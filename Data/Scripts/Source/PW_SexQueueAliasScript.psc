Scriptname PW_SexQueueAliasScript  extends ReferenceAlias

import PW_Utility

string hook = ""

bool isRapist = false

string animTags = ""

function ForceRefWithHook(ObjectReference who, bool rape = false, string aksHook = "", string aksAnimTags = "")
	if who as actor
		pwDebug(none, 1, "queue alias set to " + (who as actor).GetLeveledActorBase().GetName() + " with hook (" + aksHook + ")" + " and tags (" + aksAnimTags + ")")
		
		ForceRefTo(who)
	
		hook = aksHook
		isRapist = rape
		animTags = aksAnimTags
	endIf
endFunction

function Clear()
	hook = ""
	animTags = ""
	isRapist = false
	parent.Clear()
endFunction

string function GetCallBackHook()
	return hook
endFunction

string function GetAnimTags()
	return animTags
endFunction

bool function GetIsRapist()
	return isRapist
endFunction