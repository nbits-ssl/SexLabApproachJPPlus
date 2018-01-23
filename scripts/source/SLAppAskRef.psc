Scriptname SLAppAskRef extends ReferenceAlias  

Event OnCellDetach()
	(SLApproachAskForSex2Quest as SLAppNPCSexQuestScript).endApproachForce()
EndEvent

Event OnDetachedFromCell()
	(SLApproachAskForSex2Quest as SLAppNPCSexQuestScript).endApproachForce()
EndEvent

Quest Property SLApproachAskForSex2Quest  Auto  
