Scriptname SLApproachBaseQuestScript extends Quest

Int Property index = -1 Auto
Int Property maxTime = 60 Auto
bool Property approachEnding = false Auto
bool Property isSkipMode = false Auto

Function register()
	index = -1
	while(index == -1)
		Utility.Wait(1.0)
		index = SLApproachMain.RegisterQuest(ApproachQuest, self, ApproachName)
	endwhile
EndFunction

Event OnUpdate()
	endApproach()
endEvent

Function startApproach(Actor akRef)
	RegisterForSingleUpdate(maxTime)
EndFunction

Bool Function isSituationValid(Actor akRef, Actor player)
	if (!isSkipMode && !player.IsInCombat()  && !akRef.IsInCombat() && !akRef.IsWeaponDrawn() && \
		SexLab.IsValidActor(akRef) && !player.IsBleedingOut() && !akRef.IsBleedingOut() && \
		!player.IsOnMount() && !player.IsSwimming() && !player.IsSneaking())

		Race akRace = akRef.GetRace()
		
		if (!SLApproachMain.enableElderRaceFlag && akRace == ElderRace)
			return false
		elseif (akRace == HorseRace) ; for Immersive Horse
			return false
		elseif (akRace == ManakinRace)
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

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	return false
EndFunction

Event OnInit() ; by SLApproachQuestAliasScript attached to Player
	;register()
EndEvent

SexLabFramework Property SexLab  Auto  
SLApproachMainScript Property SLApproachMain auto
Quest Property ApproachQuest  Auto  ; overwrite by real approach quests
string Property ApproachName Auto  ; overwrite by real approach quests
Race Property ElderRace  Auto  
Race Property HorseRace  Auto  
Race Property ManakinRace  Auto  
