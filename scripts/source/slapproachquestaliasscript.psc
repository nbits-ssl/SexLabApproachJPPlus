Scriptname SLApproachQuestAliasScript extends ReferenceAlias  

Event OnInit()
	SLApproachQuestScript.register()
EndEvent

Event OnPlayerLoadGame()
	SLApproachQuestScript.register()
EndEvent

SLApproachBaseQuestScript Property SLApproachQuestScript auto