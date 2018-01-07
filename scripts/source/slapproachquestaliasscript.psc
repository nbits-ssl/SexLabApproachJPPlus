Scriptname SLApproachQuestAliasScript extends ReferenceAlias  

Event OnInit()
	(GetOwningQuest() as SLApproachBaseQuestScript).register()
EndEvent

Event OnPlayerLoadGame()
	(GetOwningQuest() as SLApproachBaseQuestScript).register()
EndEvent
