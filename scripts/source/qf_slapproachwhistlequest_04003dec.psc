;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname QF_SLApproachWhistleQuest_04003DEC Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY whistlingActor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_whistlingActor Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
if(!QuestScript.approachEnding)
QuestScript.endApproach()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SLApproachWhistleQuest.SetStage(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property SLApproachWhistleQuestScene  Auto  

Quest Property SLApproachWhistleQuest  Auto  

SLApproachMainScript Property SLApproachMain  Auto  
SLApproachWhistleQuestScript Property QuestScript Auto
