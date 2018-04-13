Scriptname SLApproachBaseQuestScript extends Quest

Int Property index = -1 Auto
Int Property maxTime = 60 Auto
bool Property approachEnding = false Auto
bool Property isSkipMode = false Auto

slapp_util Property slappUtil Auto

Function register()
	index = -1
	while(index == -1)
		Utility.Wait(1.0)
		index = SLApproachMain.RegisterQuest(ApproachQuest, self, ApproachName)
	endwhile
EndFunction

Event OnUpdate()
	endApproach()
endEvent

Function ready()
	self.Reset()
	self.SetStage(10)
EndFunction

Function startApproach(Actor akRef)
	RegisterForSingleUpdate(maxTime)
EndFunction

bool Function isSituationValid(Actor akRef, Actor player)
	if (!isSkipMode && \
		!player.IsInCombat()  && !akRef.IsInCombat() && !akRef.IsWeaponDrawn() && \
		!player.IsBleedingOut() && !akRef.IsBleedingOut() && \
		SexLab.IsValidActor(akRef) && !SexLab.IsActorActive(akRef) && \
		!player.IsOnMount() && !player.IsSwimming() && !player.IsSneaking() && \
		!akRef.IsEquipped(SLAppRingShame) && !akRef.GetItemCount(SLAppRingFamily))

		Race akRace = akRef.GetRace()
		
		if (!SLApproachMain.enableElderRaceFlag && akRace == ElderRace)
			return false
		elseif (akRace == HorseRace) ; for Immersive Horse
			return false
		elseif (akRace == ManakinRace)
			return false
		elseif (akRace.AllowPickpocket())
			return true
		elseif (akRef.IsPlayerTeammate())
			return true
		endif
	endif
	
	return false
EndFunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	return false
EndFunction

bool Function isPrecheckValid(Actor akRef, Actor akRef2, bool isplayer = false)
	if (!slappUtil.ValidatePromise(akRef, akRef2) || !slappUtil.ValidateShyness(akRef, akRef2))
		string debugstr = akRef.GetActorBase().GetName() + " => " + akRef2.GetActorBase().GetName()
		slappUtil.log(ApproachName + " blocked by Promise or Shyness: " + debugstr)
		return false
	elseif !(slappUtil.ValidateGender(akRef, akRef2, isplayer))
		string debugstr = akRef.GetActorBase().GetName() + " => " + akRef2.GetActorBase().GetName()
		slappUtil.log(ApproachName + " blocked by Gender check: " + debugstr)
		return false
	endif
	
	return true
EndFunction

bool Function isSceneValid(Actor akRef)
	Scene aks = akRef.GetCurrentScene()
	
	if (aks)
		string akscene = aks.GetOwningQuest().GetId()
		string log = ApproachName + ": blocked by another Scene: "
		slappUtil.log(log + akRef.GetActorBase().GetName() + " : " + akscene)
		return false
	endif
	
	return true
EndFunction

int Function GetResult(int chance, int extpoint, float baseChanceMultiplier)
	int result = slappUtil.ValidateChance((chance * baseChanceMultiplier) as Int)
	result += extpoint
	return result
EndFunction

int Function GetDiceRoll()
	return Utility.RandomInt(0, 100)
EndFunction

Function endApproach(bool force = false)
	ApproachQuest.SetStage(100)
	UnregisterForUpdate()
	SLApproachMain.EndtInitOfQuestByIndex(index)
	approachEnding = false
EndFunction

Function endApproachForce(ReferenceAlias akRef = None) ; for debug and Sex To PC's follow Scene
	slappUtil.log(ApproachName + ": endApproachForce!!")
	if (akRef)
		Actor fordebugact = akRef.GetActorRef()
		if (fordebugact)
			ActorBase fordebugname = fordebugact.GetActorBase()
			if (fordebugname)
				slappUtil.log(ApproachName + " Force Stop: " + fordebugname.GetName())
			endif
		endif
	endif
	
	self.endApproach(true)
EndFunction

Event OnInit() ; by SLApproachQuestAliasScript attached to Player
	;register()
EndEvent

SexLabFramework Property SexLab  Auto  
SLApproachMainScript Property SLApproachMain auto

; overwrite by real approach quests
Quest Property ApproachQuest  Auto
string Property ApproachName Auto
Quest Property HelperQuest  Auto  
ReferenceAlias Property HelperRef  Auto  
ReferenceAlias Property HelpRaperRef  Auto  
;------

Race Property ElderRace  Auto  
Race Property HorseRace  Auto  
Race Property ManakinRace  Auto  

Armor Property SLAppRingShame  Auto  
Armor Property SLAppRingFamily  Auto  

