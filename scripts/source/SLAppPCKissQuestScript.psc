Scriptname SLAppPCKissQuestScript extends SLApproachBaseQuestScript  Conditional

Function startApproach(Actor akRef)
	maxTime = 30
	talkingActor.ForceRefTo(akRef)
	SLAppKissToPCScene.Start()
	parent.startApproach(akRef)
EndFunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	if !(akRef.HasLOS(PlayerRef))
		return false
	elseif (SexLab.IsActorActive(PlayerRef))
		return false
	elseif (SexLab.GetGender(akRef) == 2) ; creature
		return false
	elseif !(self.isPrecheckValid(PlayerRef, akRef))
		return false
	endif
	
	int chance = akRef.GetFactionRank(ArousalFaction)
	
	chance += slappUtil.RelationCalc(akRef, PlayerRef)
	chance += slappUtil.LightLevelCalc(akRef, false) ; disableMinus
	chance += slappUtil.TimeCalc(false) ; disableMinus
	chance += 10
	
	int result = self.GetResult(chance, SLApproachMain.userAddingKissPointPc, baseChanceMultiplier)
	int roll = self.GetDiceRoll()
	slappUtil.log(ApproachName + " result: " + akRef.GetActorBase().GetName() + " : " + result)

	if !(self.isSceneValid(akRef))
		return false
	endif

	return (roll < result)
EndFunction

Function endApproach(bool force = false)
	approachEnding = true
	SLAppKissToPCScene.Stop()
	parent.endApproach()
EndFunction

Function playKiss(Actor akRef)
	Actor player = Game.GetPlayer()
	SexUtil.PlayKiss(akRef, player)
EndFunction


SLAppSexUtil Property SexUtil Auto
Faction Property ArousalFaction  Auto
ReferenceAlias Property talkingActor  Auto
Scene Property SLAppKissToPCScene  Auto  
