;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname QF_SLApproachAskForSex2Quest_04012AFD Extends Quest Hidden

;BEGIN ALIAS PROPERTY initialActor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_initialActor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TargetActor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TargetActor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
self.SetStage(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
if(!QuestScript.approachEnding)
QuestScript.endApproach()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLApproachMainScript Property SLApproachMain  Auto  
SLApprochAskForSex2QuestScript Property QuestScript Auto

Quest Property SLAPSex2Quest  Auto  

Scene Property SLApproachAskForSex2QuestSceneAgree  Auto  
