Scriptname SLAppPCSexQuestScript extends SLApproachBaseQuestScript Conditional 

Scene selectedScene

Function startApproach(Actor akRef)
	maxTime = 30
	talkingActor.ForceRefTo(akRef)
	if (selectedScene == SLApproachAskForSexQuestScene)
		slappUtil.log("Selected scene is sex to pc, roll rape chance.")
		self.rollRapeChance(akRef)
	endif
	selectedScene.Start()
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
	string akRefName = akRef.GetActorBase().GetName()

	if !(akRef.HasLOS(PlayerRef))
		return false
	elseif (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		return false
	elseif (SexLab.IsActorActive(PlayerRef))
		return false
	elseif ((SexLab.GetGender(akRef) == 2) && (SexLab.GetGender(PlayerRef) == 0)) ; c/m
		return false
	elseif !(self.isSceneValid(akRef))
		return false
	elseif !(self.isPrecheckValid(akRef, PlayerRef, true))
		return false
	endif

	int chance = SexUtil.GetArousal(akRef, PlayerRef)
	if (chance < SLApproachMain.lowestArousalNPC)
		slappUtil.log(ApproachName + ": " + akRefName + " :Canceled by NPC's Arousal: " + chance)
		return false
	elseif (SexUtil.GetArousal(PlayerRef, akRef) < SLApproachMain.lowestArousalPC)
		slappUtil.log(ApproachName + ": " + akRefName + " :Canceled by PC's Arousal: ---")
		return false
	endif
	
	int pt_gll = slappUtil.LightLevelCalc(akRef)
	int pt_time = slappUtil.TimeCalc()
	int pt_nude = slappUtil.NudeCalc(PlayerRef)
	int pt_bed = slappUtil.BedCalc(PlayerRef) / 2

	; for sex ---------------------------------
	chance += slappUtil.RelationCalc(akRef, PlayerRef)
	chance += pt_gll
	chance += pt_time
	chance += pt_nude
	chance += pt_bed
	chance -= 10
	
	int roll = self.GetDiceRoll()
	int result = self.GetResult(chance, SLApproachMain.userAddingPointPc, baseChanceMultiplier)
	slappUtil.log(ApproachName + ": " + akRefName + " :Sex: " + roll + " < " + result)

	if (roll < result)
		selectedScene = SLApproachAskForSexQuestScene
		return true ; for sex
	endif
	
	if !(akRef.HasKeyword(ActorTypeNPC))
		return false
	endif
	
	; for kiss ---------------------------------
	chance -= pt_bed

	roll = self.GetDiceRoll()
	result = self.GetResult(chance, SLApproachMain.userAddingKissPointPc, baseChanceMultiplier)
	slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)

	if (roll < result)
		selectedScene = SLAppKissToPCScene
		return true ; for kiss
	endif

	; for hug ---------------------------------
	chance -= pt_time

	roll = self.GetDiceRoll()
	result = self.GetResult(chance, SLApproachMain.userAddingHugPointPc, baseChanceMultiplier)
	slappUtil.log(ApproachName + ": " + akRefName + " :Hug: " + roll + " < " + result)

	if (roll < result)
		selectedScene = SLAppHugToPCScene
		return true ; for hug
	endif
	
	return false
EndFunction

Function endApproach(bool force = false)
	int retryTime = 30
	Actor akRef = talkingActor.GetActorRef()
	
	if (!force && SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		slappUtil.log(ApproachName + ": Now following scene is playing, retry.")
		RegisterForSingleUpdate(retryTime)
	elseif (!force && akRef && akRef.IsInDialogueWithPlayer())
		slappUtil.log(ApproachName + ": Now IsInDialogueWithPlayer, retry.")
		RegisterForSingleUpdate(retryTime)
	else
		approachEnding = true
		selectedScene.Stop()
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
		HelperQuest.Stop()
		parent.endApproach()
	endif
EndFunction

Function endApproachForce(ReferenceAlias akRef = None)
	parent.endApproachForce(talkingActor)
EndFunction


Function StartSex(Actor PlayerRef, Actor akSpeaker, bool rape = false)
	SexUtil.StartSexActors(akSpeaker, PlayerRef, rape)
EndFunction

Function StartSexMulti(Actor PlayerRef, Actor akSpeaker, Actor Helper, bool rape = false)
	SexUtil.StartSexMultiActors(akSpeaker, PlayerRef, Helper, rape)
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

Function enjoyMulti(Actor akSpeaker)
	Actor PlayerRef = PlayerReference.GetActorRef()

	self.StartSexMulti(talkingActor.GetActorRef(), PlayerRef, akSpeaker)
	self.followSceneStop()
	self.endApproach()
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
	HelperQuest.Start()

	self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetActorRef(), true)
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

Function travelWithForMulti(Actor akSpeaker)
	self.SetStage(20)
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

Function playKiss(Actor akRef)
	Actor player = Game.GetPlayer()
	SexUtil.PlayKiss(akRef, player)
	self.endApproach()
EndFunction

Function playHug(Actor akRef)
	Actor player = Game.GetPlayer()
	SexUtil.PlayHug(akRef, player, SLApproachMain.enableForceThirdPersonHug)
	self.endApproach()
EndFunction


SLAppSexUtil Property SexUtil Auto

Faction Property ArousalFaction  Auto

ReferenceAlias Property talkingActor  Auto  
ReferenceAlias Property PlayerReference Auto

Scene Property SLApproachAskForSexQuestScene  Auto  
Scene Property SLApproachAskForSexQuestFollowPlayerScene Auto
Scene Property SLAppHugToPCScene  Auto
Scene Property SLAppKissToPCScene  Auto  

Armor Property SLAppRingBeast  Auto  

Keyword Property ActorTypeNPC  Auto  
