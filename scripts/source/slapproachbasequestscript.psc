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
	if (!player.IsInCombat()  && !akRef.IsInCombat()&& \
		SexLab.IsValidActor(akRef) && !player.IsOnMount() && \
		!player.IsSwimming() && !player.IsSneaking())

		Race akRace = akRef.GetRace()
		
		if (!SLApproachMain.enableElderRaceFlag && akRace == ElderRace)
			return false
		elseif (akRace == HorseRace) ; for Immersive Horse
			return false
		elseif (akRace.AllowPickpocket())
			return true
		elseif (akRef.IsPlayerTeammate())
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

Function endApproachForce()
EndFunction

bool Function chanceRoll(Actor akRef,Actor PlayerRef, float baseChanceMultiplier)
	return false
EndFunction

Event OnInit()
    ;register()
EndEvent

SexLabFramework Property SexLab  Auto  
SLApproachMainScript Property SLApproachMain auto
Quest Property ApproachQuest  Auto  ; overwrite by real approach quests
Race Property ElderRace  Auto  


; Faction Property CurrentFollowerFaction  Auto  
; Faction Property PotentialFollowerFaction  Auto  


Race Property HorseRace  Auto  
