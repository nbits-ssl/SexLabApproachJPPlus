Scriptname SLAppAskRef extends ReferenceAlias  

Event OnCellDetach()
	(SLApproachAskForSex2Quest as SLAppNPCSexQuestScript).endApproach()
EndEvent

Event OnDetachedFromCell()
	(SLApproachAskForSex2Quest as SLAppNPCSexQuestScript).endApproach()
EndEvent

Quest Property SLApproachAskForSex2Quest  Auto  
