Scriptname PW_StorageUtilBridge   
{Is this necessary? I don't know. Here it is just in case}

bool function isPlayerSDEnslaved() global
	return StorageUtil.GetIntValue(Game.GetPlayer(), "_SD_iEnslaved") as bool
endFunction