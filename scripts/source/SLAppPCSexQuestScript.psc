Scriptname SLAppPCSexQuestScript extends SLApproachBaseQuestScript Conditional 

Function startApproach(Actor akRef)
	maxTime = 30
	talkingActor.ForceRefTo(akRef)
	self.rollRapeChance(akRef)
	SLApproachAskForSexQuestScene.Start()
	parent.startApproach(akRef)
EndFunction

bool property willRape Auto Conditional

Function rollRapeChance(Actor akRef)
	if (SLApproachMain.enableRapeFlag)
		if (akRef.IsEquipped(SLAppRingBeast))
			willRape = true
			return
		endif
		
		int chance = akRef.GetFactionRank(arousalFaction)
		chance += slappUtil.LightLevelCalc(akRef)
		chance += slappUtil.TimeCalc()
		chance += slappUtil.NudeCalc(PlayerReference.GetActorRef())
		chance -= 10
		chance = chance / 10
		chance = slappUtil.ValidateChance(chance)
		chance += SLApproachMain.userAddingRapePointPc

		int roll = Utility.RandomInt(0, 100)
		if (roll < chance)
			willRape  = true
		else
			willRape  = false
		endif
	else
		willRape = false
	endif
EndFunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	if !(akRef.HasLOS(PlayerRef))
		return false
	elseif (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		return false
	elseif (SexLab.IsActorActive(PlayerRef))
		return false
	elseif ((SexLab.GetGender(akRef) == 2) && (SexLab.GetGender(PlayerRef) == 0)) ; c/m
		return false
	elseif !(self.isPrecheckValid(PlayerRef, akRef))
		return false
	endif
	
	int chance = akRef.GetFactionRank(arousalFaction)

	chance += slappUtil.RelationCalc(akRef, PlayerRef)
	chance += slappUtil.LightLevelCalc(akRef)
	chance += slappUtil.TimeCalc()
	chance += slappUtil.NudeCalc(PlayerRef)
	chance -= 10
	
	int result = self.GetResult(chance, SLApproachMain.userAddingPointPc, baseChanceMultiplier)
	int roll = self.GetDiceRoll()
	slappUtil.log(ApproachName + ": " + akRef.GetActorBase().GetName() + " : " + result)

	if !(self.isSceneValid(akRef))
		return false
	endif

	return (roll < result)
EndFunction

Function endApproach(bool force = false)
	int retryTime = 30
	if (!force && SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		slappUtil.log(ApproachName + ": Now following scene is playing, retry.")
		RegisterForSingleUpdate(retryTime)
	else
		approachEnding = true
		SLApproachAskForSexQuestScene.Stop()
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
		parent.endApproach()
	endif
EndFunction

Function endApproachForce(ReferenceAlias akRef = None)
	parent.endApproachForce(talkingActor)
EndFunction


Function StartSex(Actor PlayerRef, Actor akSpeaker, bool rape = false)
	SexUtil.StartSexActors(akSpeaker, PlayerRef, rape)
EndFunction

Function enjoy(Actor akSpeaker)
	Actor PlayerRef = PlayerReference.GetActorRef()
	
	self.StartSex(PlayerRef, akSpeaker)
	self.followSceneStop()
	self.endApproach()
EndFunction

Function enjoyPlus(Actor akSpeaker)
	Actor PlayerRef = PlayerReference.GetActorRef()
	self.sexRelationshipUp(akSpeaker, PlayerRef)
	self.enjoy(akSpeaker)
EndFunction

Function disagree(Actor akSpeaker)
	self.followSceneStop()
	self.endApproach()
EndFunction

Function disagreePlus(Actor akSpeaker)
	Actor PlayerRef = PlayerReference.GetActorRef()
	self.sexRelationshipDown(akSpeaker, PlayerRef)
	self.disagree(akSpeaker)
EndFunction

Function rapedBy(Actor akSpeaker)
	Actor PlayerRef = PlayerReference.GetActorRef()

	self.StartSex(PlayerRef, akSpeaker, true)
	self.followSceneStop()
	self.endApproach()
EndFunction

Function rapedPlusBy(Actor akSpeaker)
	Actor PlayerRef = PlayerReference.GetActorRef()
	self.sexRelationshipDown(akSpeaker, PlayerRef)
	self.rapedBy(akSpeaker)
EndFunction

Function travelWith(Actor akSpeaker)
	self.SetStage(15)
	SLApproachAskForSexQuestFollowPlayerScene.Start()
EndFunction

Function sexRelationshipDown(Actor akRef, Actor PlayerRef)
	int relationship = akRef.GetRelationshipRank(PlayerRef) - 1
	; debug.notification("[slapp] " + relationship)
	if (relationship < -2)
		relationship = -2
	endif
	akRef.SetRelationshipRank(PlayerRef, relationship)
EndFunction

Function sexRelationshipUp(Actor akRef, Actor PlayerRef)
	int relationship = akRef.GetRelationshipRank(PlayerRef) + 1
	if (relationship > 4)
		relationship = 4
	endif
	akRef.SetRelationshipRank(PlayerRef, relationship)
EndFunction

Function followSceneStop()
	if (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
	endif
EndFunction


SLAppSexUtil Property SexUtil Auto

Faction Property ArousalFaction  Auto

ReferenceAlias Property talkingActor  Auto  
ReferenceAlias Property PlayerReference Auto

Scene Property SLApproachAskForSexQuestScene  Auto  
Scene Property SLApproachAskForSexQuestFollowPlayerScene Auto

Armor Property SLAppRingBeast  Auto  
