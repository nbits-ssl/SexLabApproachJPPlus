Scriptname SLApproachApplyScript extends activemagiceffect  

slapp_util Property slappUtil Auto

Event OnEffectStart(Actor akTarget, Actor playerActor)
	SLApproachMain.addActorEffectStarted()

	if((akTarget.HasLOS(Game.GetPlayer()) || akTarget.GetDistance(playerActor) <= SLApproachMain.totalAwarnessRange))
		SLApproachMain.actorAmountAware += 1
		bool init
		int indexCounter = SLApproachMain.getRegisteredAmount()
		
		while(indexCounter > 0)
			indexCounter -= 1
			SLApproachBaseQuestScript xqscript = SLApproachMain.getApproachQuestScript(indexCounter)
			if(xqscript.isSituationValid(akTarget,playerActor))
				if(xqscript.chanceRoll(akTarget, playerActor,SLApproachMain.baseChanceMultiplier))
					init = SLApproachMain.StartInitOfQuestByIndex(indexCounter)
					if(init)
						Quest xquest = SLApproachMain.getApproachQuest(indexCounter)
						xquest.Reset()
						xquest.SetStage(10)
						slappUtil.log("INIT: " + indexCounter + " - " + xquest.getstage()+ " - " + xquest.isrunning())
						
						xqscript.startApproach(akTarget)
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

SLApproachMainScript Property SLAttractionMain  Auto
