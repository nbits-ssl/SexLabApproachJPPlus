Scriptname SLApproachBaseQuestScript extends Quest

Int property index = -1 auto
Int property maxTime = 60 auto
bool property approachEnding = false auto

; slapp_util Property slappUtil Auto
; why None object ?

Function register()
	;
EndFunction

Event OnUpdate()
	endApproach()
endEvent

Function startApproach(Actor akRef)
	RegisterForSingleUpdate(maxTime)
EndFunction

Bool Function isSituationValid(Actor akRef, Actor player)
	if(!player.IsInCombat()  && !akRef.IsInCombat()&& \
		SexLab.IsValidActor(akRef) && !player.IsOnMount() && \
		!player.IsSwimming() && !player.IsSneaking())
		
		if(akRef.GetRace().AllowPickpocket())
			return true
		elseif(akRef.IsPlayerTeammate())
			return true
		endif
	endif
	
	return false
EndFunction

Function endApproach()
	ApproachQuest.SetStage(100)
	UnregisterForUpdate()
	SLApproachMain.EndtInitOfQuestByIndex(index)
	approachEnding = false
EndFunction

bool Function chanceRoll(Actor akRef,Actor PlayerRef, float baseChanceMultiplier)
	return false
EndFunction

Event OnInit()
    ;register()
EndEvent

SLApproachMainScript Property SLApproachMain auto
Quest Property ApproachQuest  Auto  

SexLabFramework Property SexLab  Auto  

; Faction Property CurrentFollowerFaction  Auto  
; Faction Property PotentialFollowerFaction  Auto  
