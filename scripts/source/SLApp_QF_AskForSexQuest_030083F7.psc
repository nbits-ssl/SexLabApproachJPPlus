;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname SLApp_QF_AskForSexQuest_030083F7 Extends Quest Hidden

;BEGIN ALIAS PROPERTY talkingActor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_talkingActor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
if(!QuestScript.approachEnding)
QuestScript.endApproach()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
self.SetStage(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLApproachAskForSexQuestScript Property QuestScript Auto
