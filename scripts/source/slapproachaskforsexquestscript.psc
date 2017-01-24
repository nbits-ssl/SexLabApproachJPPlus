Scriptname SLApproachAskForSexQuestScript extends SLApproachBaseQuestScript Conditional

slapp_util Property slappUtil Auto

Function startApproach(Actor akRef)
	maxTime = 120
	talkingActor.ForceRefTo(akRef)
	rollRapeChance(akRef)
	SLApproachAskForSexQuestScene.Start()
	parent.startApproach(akRef)
EndFunction

bool property willRape  Auto Conditional

Function rollRapeChance(Actor akRef)
	if(SLApproachMain.enableRapeFlag)
		int amountAware = SLApproachMain.actorAmountAware
		if(amountAware <=0)
			slappUtil.log("Wrong amount of aware actors : " + amountAware)
			Utility.Wait(0.1)
			amountAware = 1
		endif

		int chance = akRef.GetFactionRank(arousalFaction)
		chance += slappUtil.LightLevelCalc(akRef)
		chance += slappUtil.TimeCalc()
		chance += slappUtil.NudeCalc(PlayerReference.GetActorRef())
		chance -= 10
		chance = chance / 10
		chance = slappUtil.ValidateChance(chance)
		chance += SLApproachMain.userAddingPointPc / 10

		int roll = Utility.RandomInt(0, 100)
		if(roll < chance)
			willRape  = true
		else
			willRape  = false
		endif
	else
		willRape = false
	endif
Endfunction

Function sexRelationshipDown(Actor akRef, Actor PlayerRef, int multiplier = 1)
	if(SLApproachMain.enableRelationChangeFlag)
		int relationship = akRef.GetRelationshipRank(PlayerRef)
		int roll = Utility.RandomInt(0, 100) * multiplier

		if (relationship == 4 && roll<5)
			relationship = 3
		elseif (relationship == 3 && roll<10)
			relationship = 2
		elseif (relationship == 2 && roll<15)
			relationship = 1
		elseif (relationship == 1 && roll<25)
			relationship = 0
		elseif (relationship == 0 && roll<50)
			relationship = -1
		elseif (relationship == -1)
			relationship = -2
		endif

		akRef.SetRelationshipRank(PlayerRef,relationship)
	endif
Endfunction

Function sexRelationshipUp(Actor akRef, Actor PlayerRef)
	if(SLApproachMain.enableRelationChangeFlag)
		int relationship = akRef.GetRelationshipRank(PlayerRef)
		int roll = Utility.RandomInt(0, 100)

		if (relationship == -2 || relationship == -3 || relationship == -4)
			relationship = relationship + 1
		elseif (relationship == -1 && roll<50)
			relationship = 0
		elseif (relationship == 0 && roll<25)
			relationship = 1
		elseif (relationship == 1 && roll<15)
			relationship = 2
		elseif (relationship == 2 && roll<10)
			relationship = 3
		elseif (relationship == 3 && roll<5)
			relationship = 4
		endif

		akRef.SetRelationshipRank(PlayerRef,relationship)
	endif
Endfunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	if(!slappUtil.ValidatePromise(akRef, PlayerRef))
		slappUtil.log("Ask to Sex blocked by Promise: " + akRef.GetActorBase().GetName())
		return false
	endif
	
	if(SexLab.IsActorActive(PlayerRef))
		return false
	endif

	int chance = akRef.GetFactionRank(arousalFaction)
	int relationship =  akRef.GetRelationshipRank(PlayerReference.GetActorReference())
	
	if(akRef.GetActorBase().GetSex() == PlayerRef.GetActorBase().GetSex())
		chance -= 50
	endif
	
	if(relationship < 0)
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
		if(akscene != "SSLAppAsk2" && akscene != "SLApproachAskForSexQuest")
			slappUtil.log("Ask for Sex result: Blocked by another Scene: " + akRef.GetActorBase().GetName() + " : " + akscene)
			return false
		endif
	endif

	if(roll < result)
		return true
	else
		return false
	endif
endfunction

Function register()
	index = -1
	while(index == -1)
		Utility.Wait(1.0)
		 index = SLApproachMain.RegisterQuest(ApproachQuest, self, "Ask for sex", 1)
	endwhile
EndFunction

Function endApproach()
	;int retryTime = 30
	;if(SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
	;	RegisterForSingleUpdate(retryTime)
	;	slappUtil.log("Ask for Sex : Now following scene is playing, retry.")
	;else
		approachEnding = true
		SLApproachAskForSexQuestScene.Stop()
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
		parent.endApproach()
	;endif
Endfunction

ReferenceAlias Property talkingActor  Auto  
Scene Property SLApproachAskForSexQuestScene  Auto  
Scene Property SLApproachAskForSexQuestFollowPlayerScene Auto
ReferenceAlias Property PlayerReference Auto
SLApproachMainScript Property SLAttractionMain  Auto
Faction Property ArousalFaction  Auto
Keyword Property kArmorCuirass Auto
Keyword Property kClothingBody Auto