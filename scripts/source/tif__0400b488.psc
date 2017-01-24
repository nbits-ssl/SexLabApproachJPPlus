;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__0400B488 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
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
anims = SexLab.GetAnimationsByTag(2,"Aggressive")
SexLabUtil.StartSex(sexActors,anims, victim=PlayerRef.GetActorReference())
QuestScript.endApproach()
QuestScript.sexRelationshipDown(talkingActor.GetActorReference(),PlayerRef.GetActorReference(),3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property PlayerRef  Auto  

ReferenceAlias Property talkingActor  Auto  
SLApproachAskForSexQuestScript Property QuestScript Auto
SexLabFramework Property SexLab  Auto  
