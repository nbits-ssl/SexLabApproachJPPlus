Scriptname SLAppSexUtil extends Quest

int Function GetArousal(Actor src, Actor target) ; because for pet
	if (src.IsInFaction(arousalFaction))
		return src.GetFactionRank(arousalFaction)
	elseif (target.IsInFaction(arousalFaction))
		return target.GetFactionRank(arousalFaction)
	else
		return 0 ;  for C/C
	endif
EndFunction

Function StartSex(ReferenceAlias askRef, ReferenceAlias ansRef, bool rape = false)
	Actor askAct = askRef.GetActorRef()
	Actor ansAct = ansRef.GetActorRef()
	
	if (askAct.IsInDialogueWithPlayer() || ansAct.IsInDialogueWithPlayer())
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
		
		if (src.Is3DLoaded())
			SexLab.StartSex(sexActors, anims)
		endif
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
		
		if (src.Is3DLoaded())
			SexLab.StartSex(sexActors, anims, Victim = dst)
		endif
	endif
EndFunction

Function PlayKissNPC(ReferenceAlias askRef, ReferenceAlias ansRef)
	Actor askAct = askRef.GetActorRef()
	Actor ansAct = ansRef.GetActorRef()
	
	if !(askAct && ansAct) ; cell change (endapproach force)
		return
	endif
	
	if (askAct.IsInDialogueWithPlayer() || ansAct.IsInDialogueWithPlayer())
		return
	endif
	
	self.PlayKiss(askAct, ansAct)
EndFunction

Function PlayKiss(Actor src, Actor dst)
	if !(src && dst) ; cell change (endapproach force)
		return
	endif
	
	sslBaseAnimation[] anims
	anims =  SexLab.GetAnimationsByTags(2, "MF, kissing", "sex")
	actor[] sexActors = new actor[2]
	
	int srcSex = SexLab.GetGender(src)
	int dstSex = SexLab.GetGender(dst)
	
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
	
	if (src.Is3DLoaded())
		self._quickSex(sexActors, anims)
	endif
EndFunction

; from sexlab startsex, for playkiss
int Function _quickSex(Actor[] Positions, sslBaseAnimation[] Anims, Actor Victim = None, Actor CenterOn = None)
	bool[] stripoverwrite = new bool[33]
	int i = 0
	while (i != 33)
		stripoverwrite[i] = false
		i += 1
	endwhile

	sslThreadModel Thread = SexLab.NewThread()
	if !Thread
		return -1
	elseIf !Thread.AddActors(Positions, Victim)
		return -1
	endIf
	Thread.SetAnimations(Anims)
	Thread.DisableBedUse(true)
	Thread.DisableLeadIn()
	Thread.CenterOnObject(CenterOn)
	Thread.SetStrip(Positions[0], stripoverwrite)
	Thread.SetStrip(Positions[1], stripoverwrite)
	Thread.DisableUndressAnimation()
	Thread.DisableRedress()
	Thread.DisableRagdollEnd()
	
	if Thread.StartThread()
		return Thread.tid
	endIf
	return -1
EndFunction

Function PlayHugNPC(ReferenceAlias askRef, ReferenceAlias ansRef)
	Actor askAct = askRef.GetActorRef()
	Actor ansAct = ansRef.GetActorRef()
	
	if !(askAct && ansAct) ; cell change (endapproach force)
		return
	endif
	
	if (askAct.IsInDialogueWithPlayer() || ansAct.IsInDialogueWithPlayer())
		return
	endif
	
	self.PlayHug(askAct, ansAct, false)
EndFunction

Function PlayHug(Actor src, Actor dst, bool thirdpersonmode)
	if !(src && dst) ; cell change (endapproach force)
		return
	endif
	
	if (dst.IsWeaponDrawn())
		dst.SheatheWeapon()
	endif
	if (src.IsWeaponDrawn())
		src.SheatheWeapon()
	endif
	
	bool _isEssentialsrc = true
	bool _isEssentialdst = true
	
	if (!src.IsEssential())
		_isEssentialsrc = false
		src.GetActorBase().SetEssential(true)
	endif
	if (!dst.IsEssential())
		_isEssentialdst = false
		dst.GetActorBase().SetEssential(true)
	endif
	
	if (thirdpersonmode)
		Game.ForceThirdPerson()
	endif
	dst.PlayIdleWithTarget(HugIdle, src)
	Utility.Wait(3.0)
	
	if (!_isEssentialsrc)
		src.GetActorBase().SetEssential(false)
	endif
	if (!_isEssentialdst)
		dst.GetActorBase().SetEssential(false)
	endif
EndFunction

SexLabFramework Property SexLab  Auto
Faction Property ArousalFaction  Auto  
Idle Property HugIdle  Auto  