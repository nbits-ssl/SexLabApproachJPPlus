Scriptname SLApproachApplyScript extends activemagiceffect  

slapp_util Property slappUtil Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;akTarget.AddSpell(SLApproachMonitorAbility)
	;Debug.Trace("SexLab Approach Cloak Pulse... started " + akTarget.GetLeveledActorBase().GetName())
	SLApproachMain.addActorEffectStarted()
	Actor playerActor = akCaster

	;if(!SLAttractionMain.HasStatsAssigned(akTarget))
	;	SLAttractionMain.AssignNewStatsToActor(akTarget)
	;endif
	if((akTarget.HasLOS(Game.GetPlayer()) || akTarget.GetDistance(playerActor) <= SLApproachMain.totalAwarnessRange))
			SLApproachMain.actorAmountAware= SLApproachMain.actorAmountAware+ 1
			bool init
			int indexCounter = SLApproachMain.getRegisteredAmount()
			while(indexCounter > 0)
				indexCounter = indexCounter - 1
				if(SLApproachMain.getApproachQuestScript(indexCounter).isSituationValid(akTarget,playerActor))
					if(SLApproachMain.getApproachQuestScript(indexCounter).chanceRoll(akTarget, playerActor,SLApproachMain.baseChanceMultiplier))
						init = SLApproachMain.StartInitOfQuestByIndex(indexCounter)
						if(init)
							Quest xquest = SLApproachMain.getApproachQuest(indexCounter)
							xquest.Reset()
							xquest.SetStage(10)
							slappUtil.log("INIT: " + indexCounter + " - " + xquest.getstage()+ " - " + xquest.isrunning())

							SLApproachMain.getApproachQuestScript(indexCounter).startApproach(akTarget)
							;Debug.Notification("SexLab Approach AS: init"+SLApproachMain.getApproachQuestName(indexCounter)+":"+akTarget.GetLeveledActorBase().GetName())
						else
							;Debug.Notification("SexLab Approach AS: init failed "+SLApproachMain.getApproachQuestName(indexCounter)+":"+akTarget.GetLeveledActorBase().GetName())
							SLApproachMain.getApproachQuestScript(indexCounter).addActor(akTarget)
						endif
					else
						;Debug.Notification("SexLab Approach AS: roll failed "+SLApproachMain.getApproachQuestName(indexCounter))
					Endif
				endif
			endwhile
	endif
	SLApproachMain.addActorEffectFinished()
	;Debug.Notification("SexLab Approach AS: finished " + akTarget.GetLeveledActorBase().GetName())
EndEvent

SexLabFramework Property SexLab  Auto
SLApproachMainScript Property SLApproachMain  Auto  
;SLAttractionMainScript Property SLAttractionMain  Auto
Faction Property ArousalFaction Auto
Faction  Property SLApproachMonitorAbility Auto

SLApproachMainScript Property SLAttractionMain  Auto
