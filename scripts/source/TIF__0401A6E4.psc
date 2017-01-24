;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__0401A6E4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
QuestScript.endApproach()
QuestScript.sexRelationshipDown(talkingActor.GetActorReference(),PlayerRef.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLApproachAskForSexQuestScript Property QuestScript Auto

ReferenceAlias Property talkingActor  Auto  

ReferenceAlias Property PlayerRef  Auto  
