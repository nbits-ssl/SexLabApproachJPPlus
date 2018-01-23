Scriptname SLAppTalkingActorRef extends ReferenceAlias  

Event OnCellDetach()
	(GetOwningQuest() as SLApproachBaseQuestScript).endApproachForce()
EndEvent

Event OnDetachedFromCell()
	(GetOwningQuest() as SLApproachBaseQuestScript).endApproachForce()
EndEvent