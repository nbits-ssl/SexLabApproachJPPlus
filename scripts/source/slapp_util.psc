Scriptname slapp_util extends Quest

Function Log(String msg)
	; bool debugflag = true
	; bool debugflag = false

	if (SLApproachMain.debugLogFlag)
		debug.trace("[slapp] " + msg);
	endif
EndFunction

int Function RelationCalc(Actor akRef, Actor akRef2)
	int relationship = akRef.GetRelationshipRank(akRef2)
	
	if (relationship < 0)
		return -50
	endif
	return 0
EndFunction

int Function TimeCalc(bool enableMinus = true)
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

int Function LightLevelCalc(Actor akRef, bool enableMinus = true)
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
		return 20
	else
		return -30
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
	else
		bool akRefAgree = (akRef.GetItemCount(SLAppRingAgreement) > 0)
		bool targetAgree = (target.GetItemCount(SLAppRingAgreement) > 0)
		
		if (akRef.IsEquipped(SLAppRingLove) || target.IsEquipped(SLAppRingLove))
			return true
		elseif (akRef.WornHasKeyword(kSLAppPromiseRing) || akRefAgree)
			if (target.WornHasKeyword(kSLAppPromiseRing) || targetAgree)
				if (self._validatePromise(akRef, akRefAgree, target, targetAgree, SLAppRing01))
					return true
				elseif (self._validatePromise(akRef, akRefAgree, target, targetAgree, SLAppRing02))
					return true
				elseif (self._validatePromise(akRef, akRefAgree, target, targetAgree, SLAppRing03))
					return true
				elseif (self._validatePromise(akRef, akRefAgree, target, targetAgree, SLAppRing04))
					return true
				elseif (self._validatePromise(akRef, akRefAgree, target, targetAgree, SLAppRing05))
					return true
				endif
			endif
			
			return false
		elseif (target.WornHasKeyword(kSLAppPromiseRing) || targetAgree)
			return false
		else
			return true
		endif
	endif
EndFunction

bool Function _validatePromise(Actor akRef, bool akRefAgree, Actor target, bool targetAgree, Armor keyItem)
	if (akRef.IsEquipped(keyItem) && target.IsEquipped(keyItem))
		return true
	elseif (akRef.IsEquipped(keyItem) && (targetAgree && target.GetItemCount(keyItem)))
		return true
	elseif ((akRefAgree && akRef.GetItemCount(keyItem)) && target.IsEquipped(keyItem))
		return true
	elseif (akRefAgree && targetAgree && akRef.GetItemCount(keyItem) && target.GetItemCount(keyItem))
		return true
	else
		return false
	endif
EndFunction

bool Function ValidateShyness(Actor akRef, Actor target)
	if (akRef.IsEquipped(SLAppRingShyness) && !target.IsPlayerTeammate() && target != PlayerRef.GetActorRef())
		return false
	elseif (target.IsEquipped(SLAppRingShyness) && !akRef.IsPlayerTeammate())
		return false
	else
		return true
	endif
EndFunction

bool Function ValidateGender(Actor akRef, Actor target, bool isplayer = false)
	if (isplayer)
		if (SexLab.GetGender(akRef) != SexLab.GetGender(target) && akRef.IsEquipped(SLAppRingHomoStrong))
			return false
		elseif (SexLab.GetGender(akRef) == SexLab.GetGender(target) && !akRef.IsEquipped(SLAppRingHomo))
			return false
		endif
	elseif (SexLab.GetGender(akRef) == SexLab.GetGender(target))
		if !(akRef.IsEquipped(SLAppRingHomo) && target.IsEquipped(SLAppRingHomo))
			return false
		endif
	endif
	
	return true
EndFunction

int Function GetTargetGender(Actor akRef)
	int srcgender = SexLab.GetGender(akRef)
	if (akRef.IsEquipped(SLAppRingHomo))
		return -1 ; any
	elseif (srcgender != 1 && srcgender != 3) ; not female and female creature
		return 1
	else
		return 0
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
Armor Property SLAppRingShyness  Auto  
Armor Property SLAppRingHomo  Auto  
Armor Property SLAppRingHomoStrong  Auto  
Armor Property SLAppRingAgreement  Auto  

ReferenceAlias Property PlayerRef  Auto  
