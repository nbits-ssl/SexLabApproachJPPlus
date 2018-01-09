Scriptname SLAppPCHugQuestScript extends SLApproachBaseQuestScript Conditional 

Function startApproach(Actor akRef)
	maxTime = 30
	talkingActor.ForceRefTo(akRef)
	SLAppHugToPCScene.Start()
	parent.startApproach(akRef)
EndFunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	if !(akRef.HasLOS(PlayerRef))
		return false
	elseif (SexLab.IsActorActive(PlayerRef))
		return false
	elseif (SexLab.GetGender(akRef) == 2) ; creature
		return false
	elseif (self.PrecheckRoll(akRef, PlayerRef))
		return false
	endif
	
	int chance = akRef.GetFactionRank(ArousalFaction)
	
	chance += slappUtil.RelationCalc(akRef, PlayerRef)
	chance += slappUtil.LightLevelCalc(akRef)
	chance += slappUtil.TimeCalc()
	chance += 10
	
	int result = self.GetResult(chance, SLApproachMain.userAddingHugPointPc, baseChanceMultiplier)
	int roll = self.GetDiceRoll()
	slappUtil.log(ApproachName + " result: " + akRef.GetActorBase().GetName() + " : " + result)

	if !(self.isSceneValid(akRef))
		return false
	endif

	return (roll < result)
EndFunction

Function endApproach(bool force = false)
	approachEnding = true
	SLAppHugToPCScene.Stop()
	parent.endApproach()
EndFunction

Function playHug(Actor akRef)
	Actor player = Game.GetPlayer()
	bool _isEssential = true
	
	if (!akRef.IsEssential())
		_isEssential = false
		akRef.GetActorBase().SetEssential(true)
	endif
	
	if (player.IsWeaponDrawn())
		player.SheatheWeapon()
	endif
	if (akRef.IsWeaponDrawn())
		akRef.SheatheWeapon()
	endif
	
	Game.ForceThirdPerson()
	player.PlayIdleWithTarget(HugIdle, akRef)
	Utility.Wait(3.0)
	
	if (!_isEssential)
		akRef.GetActorBase().SetEssential(false)
	endif
EndFunction


SLAppSexUtil Property SexUtil Auto

Faction Property ArousalFaction  Auto

ReferenceAlias Property talkingActor  Auto
Scene Property SLAppHugToPCScene  Auto  
Idle Property HugIdle  Auto  
