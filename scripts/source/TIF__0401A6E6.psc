;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0401A6E6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if(GetOwningQuest().GetStage() != 10)
debug.trace("SexLab Approach: wrong quest stage :" + GetOwningQuest().GetStage() )
endif
GetOwningQuest().SetStage(15)
if(GetOwningQuest().GetStage() != 15)
debug.trace("SexLab Approach: setting quest stage to 15 failed :" + GetOwningQuest().GetStage() )
endif
FollowPlayerScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property FollowPlayerScene  Auto  
