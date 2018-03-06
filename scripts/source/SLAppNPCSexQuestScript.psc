Scriptname SLAppNPCSexQuestScript extends SLApproachBaseQuestScript  Conditional

Function startApproach(Actor akRef)
	maxTime = 15
	if (!SSLAppAsk2.isRunning())
		SSLAppAsk2.Start()
	endif
	
	if (SSLAppAsk2.isRunning())
		Actor target = ansRef.GetActorRef()
		
		int chance = self.calcChance(akRef, target)
		int result = self.GetResult(chance, SLApproachMain.userAddingPointNpc, 1.0)
		int roll = self.GetDiceRoll()

		slappUtil.log("Ask to Other chance: ANS by : " + target.GetActorBase().GetName() + " : "  + result + " & " + roll)
		
		if (SexLab.IsActorActive(akRef) || SexLab.IsActorActive(target) || \
			target.IsInCombat() || target.IsWeaponDrawn() || target.IsBleedingOut() || \
			target.IsInDialogueWithPlayer() || target.IsDead() || !SexLab.IsValidActor(target))
		
			slappUtil.log("Sex to Other by: pass : akRef or target has Locked by some reason")
			maxTime = 2
			
		elseif (akRef.IsEquipped(SLAppRingServant) || akRef.IsEquipped(SLAppRingSlave) || roll < result)
			SSLAppAsk2Scene.Start()
		elseif (SLApproachMain.enableRapeFlag)
			if (akRef.IsEquipped(SLAppRingBeast))
				SSLAppAsk2SceneRape.Start()
			else
				int second_result = slappUtil.ValidateChance(self.calcChance(akRef, target) / 10)
				int second_extra = SLApproachMain.userAddingRapePointNpc
				second_result = second_result + second_extra
				int second_roll = self.GetDiceRoll()
				slappUtil.log("Ask to Other rape chance: ANS by : "  + akRef.GetActorBase().GetName() + " : " + second_result + " & " + second_roll)
			
				if (second_roll < second_result)
					SSLAppAsk2SceneRape.Start()
				else
					SSLAppAsk2SceneDisagree.Start()
				endif
			endif
		else ; disable rape
			SSLAppAsk2SceneDisagree.Start()
		endif
		
		askRef.GetActorRef().EvaluatePackage()
	else
		slappUtil.log("Sex to Other: SSLAppAsk2 isn't running.")
	endif
	
	parent.startApproach(akRef)
EndFunction

bool Function chanceRoll(Actor akRef, Actor Player, float baseChanceMultiplier)
	string akRefName = akRef.GetActorBase().GetName()
	
	int queststage = self.GetStage()
	if (queststage >= 10 && queststage < 100)
		return false
	elseif (SSLAppAsk2Scene.IsPlaying() || SSLAppAsk2SceneDisagree.IsPlaying() || SSLAppAsk2SceneRape.IsPlaying())
		return false
	elseif (akRef.GetItemCount(SLAppRingEngagement))
		return false
	elseif !(self.isSceneValid(akRef))
		return false
	endif

	int gender = slappUtil.GetTargetGender(akRef)
	Actor target = SexLab.FindAvailableActor(akRef, 1000.0, gender, Player)

	if (target && !target.IsDead())
		if (!akRef.GetRace().AllowPickpocket() && !target.IsPlayerTeammate()) ; Pet only approach teammates
			return false
		elseif (!SLApproachMain.enableElderRaceFlag && target.GetRace() == ElderRace)
			return false
		elseif (target.GetRace() == ManakinRace)
			return false
		elseif (target.GetItemCount(SLAppRingFamily) || target.GetItemCount(SLAppRingEngagement))
			return false
		elseif !(self.isPrecheckValid(akRef, target))
			return false
		elseif !(self.isSceneValid(target))
			return false
		elseif !(self.modSpecificCheck(akRef, target))
			return false
		endif
		
		slappUtil.log("Sex to Other by: " + akRefName + " - " + target.GetBaseObject().GetName())
		
		int chance = self.calcChance(akRef, target)
		int result = self.GetResult(chance, SLApproachMain.userAddingPointNpc, baseChanceMultiplier)
		int roll = self.GetDiceRoll()
		slappUtil.log("Ask to Other chance: ASK by : "  + akRefName + " : " + result + " & " + roll)
		
		if (roll < result && ansRef.GetActorRef() != akRef)
			askRef.ForceRefTo(akRef)
			ansRef.ForceRefTo(target)
			return true
		else
			return false
		endif
	else
		slappUtil.log("Ask to Other, None target :"  + akRefName)
		return false
	endif
EndFunction

bool Function modSpecificCheck(Actor akRef, Actor target)
		; for HBC
		if(akRef.GetActorBase().GetName() == "Dummy" || target.GetBaseObject().GetName() == "Dummy")
			return false
		endif
		
		return true
EndFunction

int Function calcChance(Actor akRef, Actor target)
	int chance
	if (akRef.IsInFaction(arousalFaction))
		chance = akRef.GetFactionRank(arousalFaction)
	elseif(target.IsInFaction(arousalFaction))
		chance = target.GetFactionRank(arousalFaction)
	else
		return 0 ;  for C/C
	endif

	chance += slappUtil.BedCalc(target)
	chance += slappUtil.LightLevelCalc(target)
	chance += slappUtil.TimeCalc()
	chance += slappUtil.NudeCalc(target)
	chance += slappUtil.SexAnimActiveCalc(PlayerRef)
	chance += slappUtil.TeammateCalc(akRef, target)

	return chance
EndFunction

Function endApproach(bool force = false)
	slappUtil.log("Sex to Other by: endApproach")
	approachEnding = true
	SSLAppAsk2Scene.Stop()
	SSLAppAsk2SceneRape.Stop()
	SSLAppAsk2SceneDisagree.Stop()
	SSLAppAsk2.Stop()
	parent.endApproach()
EndFunction


Quest Property SSLAppAsk2  Auto  

ReferenceAlias Property askRef  Auto  
ReferenceAlias Property ansRef  Auto  

Faction Property ArousalFaction  Auto  

Scene Property SSLAppAsk2Scene  Auto  
Scene Property SSLAppAsk2SceneDisagree  Auto  
Scene Property SSLAppAsk2SceneRape  Auto  

Actor Property PlayerRef  Auto  

Armor Property SLAppRingServant  Auto  
Armor Property SLAppRingSlave  Auto  
Armor Property SLAppRingBeast  Auto  
Armor Property SLAppRingHomo  Auto  
Armor Property SLAppRingEngagement  Auto  
