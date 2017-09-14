Scriptname SLAppSexUtil extends Quest  

Function StartSex(ReferenceAlias askRef, ReferenceAlias ansRef, bool rape = false)
	Actor askAct = askRef.GetActorRef()
	Actor ansAct = ansRef.GetActorRef()
	
	if (ansAct.IsInDialogueWithPlayer())
		return
	endif
	
	sslBaseAnimation[] anims
	actor[] sexActors = new actor[2]
	
	if (rape)
		if(askAct.GetActorBase().GetSex() == 1)
			anims =  SexLab.GetAnimationsByTags(2, "fm,cowgirl")
			sexActors[0] = askAct
			sexActors[1] = ansAct
		elseif(askAct.GetActorBase().GetSex() == 0)
			anims =  SexLab.GetAnimationsByTags(2, "aggressive", "cowgirl")
			sexActors[0] = ansAct
			sexActors[1] = askAct
		else ; creature
			anims =  SexLab.GetAnimationsByTags(2, "cf")
			sexActors[0] = ansAct
			sexActors[1] = askAct
		endif
		
		SexLab.StartSex(sexActors, anims, Victim = ansAct)
	else
		anims =  SexLab.GetAnimationsByTags(2, "MF", "aggressive")

		if(askAct.GetActorBase().GetSex() == 1)
			sexActors[0] = askAct
			sexActors[1] = ansAct
		else
			sexActors[0] = ansAct
			sexActors[1] = askAct
		endif

		SexLab.StartSex(sexActors, anims)
	endif
EndFunction

SexLabFramework Property SexLab  Auto  