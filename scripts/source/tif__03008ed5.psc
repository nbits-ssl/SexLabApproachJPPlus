;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__03008ED5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor[] sexActors = new Actor[2]
if(PlayerRef.GetActorReference().GetLeveledActorBase().GetSex() == 1)
	sexActors[0] = PlayerRef.GetActorReference()
	sexActors[1] = talkingActor.GetActorReference()
else
	sexActors[0] = talkingActor.GetActorReference()
	sexActors[1] = PlayerRef.GetActorReference()
endif
sslBaseAnimation[] anims
SexLabUtil.StartSex(sexActors,anims)
QuestScript.endApproach()
QuestScript.sexRelationshipUp(talkingActor.GetActorReference(),PlayerRef.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property PlayerRef  Auto  

ReferenceAlias Property talkingActor  Auto  

SLApproachAskForSexQuestScript Property QuestScript Auto

Scene Property FollowPlayerScene  Auto  
