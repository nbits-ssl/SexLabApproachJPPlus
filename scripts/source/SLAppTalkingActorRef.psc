Scriptname SLAppTalkingActorRef extends ReferenceAlias  

Event OnCellDetach()
	(GetOwningQuest() as SLApproachBaseQuestScript).endApproachForce(None)
EndEvent

Event OnDetachedFromCell()
	(GetOwningQuest() as SLApproachBaseQuestScript).endApproachForce(None)
EndEvent