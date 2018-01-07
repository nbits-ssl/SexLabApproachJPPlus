Scriptname SLAppPCHugQuestScript extends SLApproachBaseQuestScript Conditional 

slapp_util Property slappUtil Auto

Function startApproach(Actor akRef)
	maxTime = 30
	talkingActor.ForceRefTo(akRef)
	SLAppHugToPCScene.Start()
	parent.startApproach(akRef)
EndFunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	if !(akRef.HasLOS(PlayerRef))
		return false
	elseif (!slappUtil.ValidatePromise(akRef, PlayerRef) || !slappUtil.ValidateShyness(akRef, PlayerRef))
		slappUtil.log("Ask to Sex blocked by Promise or Shyness: " + akRef.GetActorBase().GetName())
		return false
	elseif (SexLab.IsActorActive(PlayerRef))
		return false
	elseif (akRef.IsEquipped(SLAppRingShame))
		return false
	elseif (akRef.GetItemCount(SLAppRingFamily))
		return false
	elseif (SexLab.GetGender(akRef) == 2) ; creature
		return false
	elseif !(slappUtil.ValidateGender(PlayerRef, akRef, true))
		return false
	endif
	
	int chance = akRef.GetFactionRank(ArousalFaction)
	int relationship = akRef.GetRelationshipRank(PlayerRef)
	
	if (relationship < 0)
		chance -= 50
	endif
	
	chance += slappUtil.LightLevelCalc(akRef)
	chance += slappUtil.TimeCalc()
	chance += 10
	
	int result = slappUtil.ValidateChance((chance * baseChanceMultiplier) as Int)
	result += SLApproachMain.userAddingPointPc
	int roll = Utility.RandomInt(0, 100)
	slappUtil.log("Hug to PC result: " + akRef.GetActorBase().GetName() + " : " + result)

	Scene aks = akRef.GetCurrentScene()
	if(aks)
		string akscene = aks.GetOwningQuest().GetId()
		slappUtil.log("Hug to PC result: Blocked by another Scene: " + akRef.GetActorBase().GetName() + " : " + akscene)
		return false
	endif

	if(roll < result)
		return true
	else
		return false
	endif
EndFunction

Function endApproach()
	approachEnding = true
	SLAppHugToPCScene.Stop()
	parent.endApproach()
EndFunction

Function endApproachForce()
	slappUtil.log("Hug to PC : endApproachForce() !!")
	
	Actor fordebugact = talkingActor.GetActorRef()
	if (fordebugact)
		ActorBase fordebugname = fordebugact.GetActorBase()
		if (fordebugname)
			slappUtil.log("Hug To PC Force Stop: " + fordebugname.GetName())
		endif
	endif
	
	self.endApproach()
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

Armor Property SLAppRingShame  Auto  
Armor Property SLAppRingFamily  Auto  
