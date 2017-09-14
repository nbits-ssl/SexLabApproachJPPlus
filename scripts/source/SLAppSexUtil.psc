Scriptname SLAppSexUtil extends Quest  

Function StartSex(ReferenceAlias askRef, ReferenceAlias ansRef, bool rape = false)
	Actor askAct = askRef.GetActorRef()
	Actor ansAct = ansRef.GetActorRef()
	
	if (ansAct.IsInDialogueWithPlayer())
		return
	endif
	
	self.StartSexActors(askAct, ansAct, rape)
EndFunction

Function StartSexActors(Actor src, Actor dst, bool rape = false)
	sslBaseAnimation[] anims
	actor[] sexActors = new actor[2]
	
	int srcSex = SexLab.GetGender(src)
	int dstSex = SexLab.GetGender(dst)
	
	if (!rape)
		; anims =  SexLab.GetAnimationsByTags(2, "MF", "aggressive")
		
		if((srcSex == 1 && dstsex == 1) || (srcSex == 0 && srcSex == 0)) ; same sex
			sexActors[0] = dst
			sexActors[1] = src
		elseif (srcSex == 1)
			sexActors[0] = src
			sexActors[1] = dst
		else
			sexActors[0] = dst
			sexActors[1] = src
		endif
		
		SexLab.StartSex(sexActors, anims)
	else
		if (srcSex == 1) ; female
			anims =  SexLab.GetAnimationsByTags(2, "fm,cowgirl")
			sexActors[0] = src
			sexActors[1] = dst
		elseif (srcSex == 0) ; male
			anims =  SexLab.GetAnimationsByTags(2, "aggressive", "cowgirl")
			sexActors[0] = dst
			sexActors[1] = src
		else ; creature
			anims =  SexLab.GetAnimationsByTags(2, "cf")
			sexActors[0] = dst
			sexActors[1] = src
		endif
		
		SexLab.StartSex(sexActors, anims, Victim = dst)
	endif
EndFunction

SexLabFramework Property SexLab  Auto  