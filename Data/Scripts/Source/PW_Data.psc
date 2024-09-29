Scriptname PW_Data extends Quest  
{Serves as a pool for data shared between many scripts}

bool[] property dueForPunishment Auto
int[] property alertLevel Auto					;Alert level in each hold
float[] property alertLevelStarts Auto			;Game time that the current alert level was set in each hold

