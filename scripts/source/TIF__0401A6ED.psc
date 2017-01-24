;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0401A6ED Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
QuestScript.endApproach()
QuestScript.sexRelationshipDown(talkingActor.GetActorReference(),PlayerRef.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLApproachAskForSexQuestScript Property QuestScript Auto

ReferenceAlias Property PlayerRef  Auto  

ReferenceAlias Property talkingActor Auto  
