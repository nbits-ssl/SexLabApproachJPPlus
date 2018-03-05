Scriptname SLApproachApplyScript extends activemagiceffect

slapp_util Property slappUtil Auto

Event OnEffectStart(Actor akTarget, Actor playerActor)
	SLApproachMain.addActorEffectStarted()
	
	if (!akTarget.IsDead())
		bool init
		int indexCounter = SLApproachMain.getRegisteredAmount()
		
		while (indexCounter > 0)
			indexCounter -= 1
			SLApproachBaseQuestScript xqscript = SLApproachMain.getApproachQuestScript(indexCounter)
			
			if (xqscript.isSituationValid(akTarget, playerActor))
				init = SLApproachMain.StartInitOfQuestByIndex(indexCounter)
				if (init)
					if (xqscript.chanceRoll(akTarget, playerActor, SLApproachMain.baseChanceMultiplier))
						xqscript.ready()
						slappUtil.log("INIT: " + indexCounter + " - ")
						
						indexCounter = 0 ; break while loop
						xqscript.startApproach(akTarget)
					else
						SLApproachMain.EndtInitOfQuestByIndex(indexCounter)
					endif
				endif
			endif
		endwhile
	endif
	
	SLApproachMain.addActorEffectFinished()
EndEvent

SexLabFramework Property SexLab  Auto
SLApproachMainScript Property SLApproachMain  Auto  
Faction Property ArousalFaction Auto
Faction  Property SLApproachMonitorAbility Auto
