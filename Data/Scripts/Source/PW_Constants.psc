Scriptname PW_Constants   extends Quest

{Contains frequently used values}

string property QUOTA_STRING_CLIENTS = "clients" autoReadOnly
string property QUOTA_STRING_GOLD = "gold" autoReadOnly
string property QUOTA_STRING_NONE = "none" autoReadOnly

int property FAME_TYPE_BESTIALITY = 0 AutoReadOnly
int property FAME_TYPE_EXHIBITIONIST = 1 AutoReadOnly
int property FAME_TYPE_SLUT = 2 AutoReadOnly
int property FAME_TYPE_SUBMISSIVE = 3 AutoReadOnly
int property FAME_TYPE_WHORE = 4 AutoReadOnly

int property LOG_STARTUP = 0 AutoReadOnly
int property LOG_TRACE = 1 AutoReadOnly
int property LOG_DEBUG = 2 AutoReadOnly
int property LOG_WARNING = 3 AutoReadOnly
int property LOG_ERROR = 4 AutoReadOnly
int property LOG_FATAL = 5 AutoReadOnly

PW_Constants function GetConstants() global
	return Game.GetFormFromFile(0x04061856, "Public Whore.esp") as PW_Constants
endFunction

string function getCityName(int index) global
	if (index == 0)
		return "Dawnstar"
	elseIf(index == 1)
		return "Falkreath"
	elseIf(index == 2)
		return "Markarth"
	elseIf(index == 3)
		return "Morthal"
	elseIf(index == 4)
		return "Riften"
	elseIf(index == 5)
		return "Solitude"
	elseIf(index == 6)
		return "Whiterun"
	elseIf(index == 7)
		return "Windhelm"
	elseIf(index == 8)
		return "Winterhold"
	else
		return "Nowhere"
	endIf
endFunction

string function getHoldName(int index) global
	if (index == 0)
		return "The Pale"
	elseIf(index == 1)
		return "Falkreath"
	elseIf(index == 2)
		return "The Reach"
	elseIf(index == 3)
		return "Hjaalmarch"
	elseIf(index == 4)
		return "The Rift"
	elseIf(index == 5)
		return "Haafingar"
	elseIf(index == 6)
		return "Whiterun"
	elseIf(index == 7)
		return "Eastmarch"
	elseIf(index == 8)
		return "Winterhold"
	else
		return "Nowhere"
	endIf
endFunction