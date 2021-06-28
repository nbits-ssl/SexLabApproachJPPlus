Scriptname SLAppQuestToggle extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SLApproachMainScript mainScript = (SLApproach_Main as SLApproachMainScript)
	
	if (mainScript.isSkipUpdateMode)
		mainScript.isSkipUpdateMode = false
		mainScript.clearQuestStatus()
		debug.notification("SexLab Approach has restarted")
	else
		mainScript.isSkipUpdateMode = true
		debug.notification("SexLab Approach has stopped")
	endif
EndEvent

Quest Property SLApproach_Main  Auto