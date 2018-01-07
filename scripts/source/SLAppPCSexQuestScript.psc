Scriptname SLAppPCSexQuestScript extends SLApproachBaseQuestScript Conditional 

slapp_util Property slappUtil Auto

Function startApproach(Actor akRef)
	maxTime = 30
	talkingActor.ForceRefTo(akRef)
	rollRapeChance(akRef)
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
	elseif (!slappUtil.ValidatePromise(akRef, PlayerRef) || !slappUtil.ValidateShyness(akRef, PlayerRef))
		slappUtil.log("Ask to Sex blocked by Promise or Shyness: " + akRef.GetActorBase().GetName())
		return false
	elseif (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		return false
	elseif (SexLab.IsActorActive(PlayerRef))
		return false
	elseif (akRef.IsEquipped(SLAppRingShame))
		return false
	elseif (akRef.GetItemCount(SLAppRingFamily))
		return false
	elseif ((SexLab.GetGender(akRef) == 2) && (SexLab.GetGender(PlayerRef) == 0)) ; c/m
		return false
	elseif !(slappUtil.ValidateGender(PlayerRef, akRef, true))
		return false
	endif
	
	int chance = akRef.GetFactionRank(arousalFaction)
	int relationship =  akRef.GetRelationshipRank(PlayerRef)
	
	if (relationship < 0)
		chance -= 50
	endif
	
	chance += slappUtil.LightLevelCalc(akRef)
	chance += slappUtil.TimeCalc()
	chance += slappUtil.NudeCalc(PlayerRef)
	chance -= 10
	
	int result = slappUtil.ValidateChance((chance * baseChanceMultiplier) as Int)
	result += SLApproachMain.userAddingPointPc
	int roll = Utility.RandomInt(0, 100)
	slappUtil.log("Ask for Sex result: " + akRef.GetActorBase().GetName() + " : " + result)

	Scene aks = akRef.GetCurrentScene()
	if(aks)
		string akscene = aks.GetOwningQuest().GetId()
		slappUtil.log("Ask for Sex result: Blocked by another Scene: " + akRef.GetActorBase().GetName() + " : " + akscene)
		return false
	endif

	if(roll < result)
		return true
	else
		return false
	endif
EndFunction

Function endApproach()
	int retryTime = 30
	if (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		slappUtil.log("Ask for Sex : Now following scene is playing, retry.")
		RegisterForSingleUpdate(retryTime)
	else
		self._endApproach()
	endif
EndFunction

Function endApproachForce()
	slappUtil.log("Ask for Sex : endApproachForce() !!")
	
	Actor fordebugact = talkingActor.GetActorRef()
	if (fordebugact)
		ActorBase fordebugname = fordebugact.GetActorBase()
		if (fordebugname)
			slappUtil.log("Ask to Other Force Stop: " + fordebugname.GetName())
		endif
	endif
	
	self._endApproach()
EndFunction

Function _endApproach()
	approachEnding = true
	SLApproachAskForSexQuestScene.Stop()
	SLApproachAskForSexQuestFollowPlayerScene.Stop()
	parent.endApproach()
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
	debug.notification("[slapp] " + relationship)
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

Armor Property SLAppRingShame  Auto  
Armor Property SLAppRingBeast  Auto  
Armor Property SLAppRingFamily  Auto  
