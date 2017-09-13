Scriptname SLAppSexUtil extends Quest  

Function StartSex(ReferenceAlias askRef, ReferenceAlias ansRef, bool rape = false)
	if (ansRef.GetActorRef().IsInDialogueWithPlayer())
		return
	endif
	
	if (rape)
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
	else
		sslBaseAnimation[] anims
		actor[] sexActors = new actor[2]
		anims =  SexLab.GetAnimationsByTags(2, "MF", "aggressive")

		if(askRef.GetActorReference().GetLeveledActorBase().GetSex() == 1)
			sexActors[0] = askRef.GetActorReference()
			sexActors[1] = ansRef.GetActorReference()
		else
			sexActors[0] = ansRef.GetActorReference()
			sexActors[1] = askRef.GetActorReference()
		endif

		SexLab.StartSex(sexActors, anims)
	endif
EndFunction

SexLabFramework Property SexLab  Auto  