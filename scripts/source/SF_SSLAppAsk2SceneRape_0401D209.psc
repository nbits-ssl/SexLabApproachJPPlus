;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_SSLAppAsk2SceneRape_0401D209 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if (!ansRef.GetActorRef().IsInDialogueWithPlayer())
	sslBaseAnimation[] anims
	actor[] sexActors = new actor[2]

	if(askRef.GetActorReference().GetLeveledActorBase().GetSex() == 1)
		anims =  SexLab.GetAnimationsByTags(2, "fm,cowgirl")
		sexActors[0] = askRef.GetActorReference()
		sexActors[1] = ansRef.GetActorReference()
	elseif(askRef.GetActorReference().GetLeveledActorBase().GetSex() == 0)
		anims =  SexLab.GetAnimationsByTags(2, "aggressive", "cowgirl")
		sexActors[0] = ansRef.GetActorReference()
		sexActors[1] = askRef.GetActorReference()
	else ; creature
		anims =  SexLab.GetAnimationsByTags(2, "cf")
		sexActors[0] = ansRef.GetActorReference()
		sexActors[1] = askRef.GetActorReference()
	endif

	SexLab.StartSex(sexActors, anims, Victim = ansRef.GetActorReference())
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property askRef  Auto  
ReferenceAlias Property ansRef  Auto  
SexLabFramework Property SexLab  Auto  
