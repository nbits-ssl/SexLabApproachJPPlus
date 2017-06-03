Scriptname slapp_util extends Quest

Function Log(String msg)
	; bool debugflag = true
	; bool debugflag = false

	if (SLApproachMain.debugLogFlag)
		debug.trace("[slapp] " + msg);
	endif
EndFunction

int Function TimeCalc()
	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time)
	Time *= 24
	int hour = (Time as Int)
	
	if(hour >= 22 || hour < 2)
		return 25
	elseif(hour >= 20 || hour < 4)
		return 20
	elseif(hour >= 18 || hour < 6)
		return 15
	elseif (hour > 8 || hour < 16)
		return -25
	endif
	
	return 0
EndFunction

int Function LightLevelCalc(Actor akRef)
	int anslightlevel = akRef.GetLightLevel() as int
	
	if(anslightlevel < 50)
		return 25
	elseif(anslightlevel < 60)
		return 20
	elseif(anslightlevel < 75)
		return 15
	elseif (anslightlevel > 150)
		return -50
	elseif (anslightlevel > 100)
		return -25
	endif

	return 0
EndFunction

int Function BedCalc(Actor akRef)
	if(SexLab.FindBed(akRef, 1000.0))
		return 0
	else
		return -40
	endif
EndFunction

int Function NudeCalc(Actor akRef)
	if(!akRef.WornHasKeyword(kArmorCuirass) && !akRef.WornHasKeyword(kClothingBody))
		return 40
	else
		return 0
	endif
EndFunction

int Function SexAnimActiveCalc(Actor akRef)
	if(SexLab.IsActorActive(akRef))
		return 40
	else
		return 0
	endif
EndFunction

int Function TeammateCalc(Actor akRef, Actor target)
	if(akRef.IsPlayerTeammate())
		if(target.IsPlayerTeammate())
			return 0
		else
			return -20
		endif
	endif

	if(target.IsPlayerTeammate())
		if(!akRef.IsPlayerTeammate())
			return -20
		endif
	endif
	
	return 0
EndFunction

bool Function ValidatePromise(Actor akRef, Actor target)
	if (!SLApproachMain.enablePromiseFlag)
		return true
	elseif (akRef.IsEquipped(SLAppRingLove) || target.IsEquipped(SLAppRingLove))
		return true
	elseif (akRef.WornHasKeyword(kSLAppPromiseRing))
		if (target.WornHasKeyword(kSLAppPromiseRing))
			if(akRef.IsEquipped(SLAppRing01) && target.IsEquipped(SLAppRing01))
				return true
			elseif(akRef.IsEquipped(SLAppRing02) && target.IsEquipped(SLAppRing02))
				return true
			elseif(akRef.IsEquipped(SLAppRing03) && target.IsEquipped(SLAppRing03))
				return true
			elseif(akRef.IsEquipped(SLAppRing04) && target.IsEquipped(SLAppRing04))
				return true
			elseif(akRef.IsEquipped(SLAppRing05) && target.IsEquipped(SLAppRing05))
				return true
			endif
		endif
		
		return false
	elseif(target.WornHasKeyword(kSLAppPromiseRing))
		return false
	else
		return true
	endif
EndFunction

int Function ValidateChance(int x)
	if (x < 0)
		return 0
	elseif (x > 100)
		return 100
	else
		return x
	endif
EndFunction

Function StartSexTopicInfo(ReferenceAlias akRef, ReferenceAlias target)
	Actor[] sexActors = new Actor[2]
	if(akRef.GetActorReference().GetLeveledActorBase().GetSex() == 1)
		sexActors[0] = akRef.GetActorReference()
		sexActors[1] = target.GetActorReference()
	else
		sexActors[0] = target.GetActorReference()
		sexActors[1] = akRef.GetActorReference()
	endif
	sslBaseAnimation[] anims
	SexLab.StartSex(sexActors, anims)
EndFunction

SLApproachMainScript Property SLApproachMain Auto

SexLabFramework Property SexLab  Auto
Keyword Property kArmorCuirass Auto
Keyword Property kClothingBody Auto
Keyword Property kSLAppPromiseRing  Auto

Armor Property SLAppRing01  Auto  
Armor Property SLAppRing02  Auto  
Armor Property SLAppRing03  Auto  
Armor Property SLAppRing04  Auto  
Armor Property SLAppRing05  Auto  
Armor Property SLAppRingLove  Auto  
