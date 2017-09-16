Scriptname SLAppTalkingActorRef extends ReferenceAlias  

Event OnCellDetach()
	(GetOwningQuest() as SLAppPCSexQuestScript).endApproachForce()
EndEvent

Event OnDetachedFromCell()
	(GetOwningQuest() as SLAppPCSexQuestScript).endApproachForce()
EndEvent