Scriptname SLAppAskRef extends ReferenceAlias  

Event OnCellDetach()
	(SLApproachAskForSex2Quest as SLAppNPCSexQuestScript).endApproachForce(None)
EndEvent

Event OnDetachedFromCell()
	(SLApproachAskForSex2Quest as SLAppNPCSexQuestScript).endApproachForce(None)
EndEvent

Quest Property SLApproachAskForSex2Quest  Auto  
