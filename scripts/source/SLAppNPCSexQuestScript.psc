Scriptname SLAppNPCSexQuestScript extends SLApproachBaseQuestScript  Conditional

Scene selectedScene

Function startApproach(Actor akRef)
	maxTime = 15
	if (!SSLAppAsk2.isRunning())
		SSLAppAsk2.Start()
	endif
	
	if (SSLAppAsk2.isRunning())
		Actor target = ansRef.GetActorRef()
		
		if (SexLab.IsActorActive(akRef) || SexLab.IsActorActive(target) || \
			target.IsInCombat() || target.IsWeaponDrawn() || target.IsBleedingOut() || \
			target.IsInDialogueWithPlayer() || target.IsDead() || !SexLab.IsValidActor(target))
			
			slappUtil.log(ApproachName + " Pass: akRef or target has Locked by some reason")
			maxTime = 2
		elseif (selectedScene == SSLAppAsk2Scene) ; sex
			int chance = self.calcChance(target, akRef)
			chance += slappUtil.BedCalc(target)
			chance += slappUtil.TimeCalc()

			int result = self.GetResult(chance, SLApproachMain.userAddingPointNpc, 1.0)
			int roll = self.GetDiceRoll()

			slappUtil.log(ApproachName + " Ans: " + target.GetActorBase().GetName() + " : " + roll + " < " + result)
		
			if (target.IsEquipped(SLAppRingServant) || target.IsEquipped(SLAppRingSlave) || roll < result)
				SSLAppAsk2Scene.Start()
				HelperQuest.Start()
			elseif (SLApproachMain.enableRapeFlag)
				if (akRef.IsEquipped(SLAppRingBeast))
					SSLAppAsk2SceneRape.Start()
					HelperQuest.Start()
				else
					result = slappUtil.ValidateChance(self.calcChance(akRef, target) / 10)
					result += SLApproachMain.userAddingRapePointNpc
					roll = self.GetDiceRoll()
					slappUtil.log(ApproachName + " Rape: " + akRef.GetActorBase().GetName() + " : " + roll + " < " + result)
				
					if (roll < result)
						SSLAppAsk2SceneRape.Start()
						HelperQuest.Start()
					else
						SSLAppAsk2SceneDisagree.Start()
					endif
				endif
			else ; disable rape
				SSLAppAsk2SceneDisagree.Start()
			endif
		elseif (selectedScene == SSLAppAsk2Kiss)
			SSLAppAsk2Kiss.Start()
		elseif (selectedScene == SSLAppAsk2Hug)
			SSLAppAsk2Hug.Start()
		endif
			
		askRef.GetActorRef().EvaluatePackage()
	else
		slappUtil.log(ApproachName + " SSLAppAsk2 isn't running.")
	endif
	
	parent.startApproach(akRef)
EndFunction

bool Function chanceRoll(Actor akRef, Actor Player, float baseChanceMultiplier)
	string akRefName = akRef.GetActorBase().GetName()
	
	int queststage = self.GetStage()
	if (queststage >= 10 && queststage < 100)
		return false
	elseif (SSLAppAsk2Scene.IsPlaying() || SSLAppAsk2SceneDisagree.IsPlaying() || SSLAppAsk2SceneRape.IsPlaying() || \
			SSLAppAsk2Hug.IsPlaying() || SSLAppAsk2Kiss.IsPlaying())
			return false
			
	elseif (akRef.GetItemCount(SLAppRingEngagement))
		return false
	elseif !(self.isSceneValid(akRef))
		return false
	endif

	int gender = slappUtil.GetTargetGender(akRef)
	Actor target = SexLab.FindAvailableActor(akRef, 1000.0, gender, Player)

	if (target && !target.IsDead())
		if (!akRef.GetRace().AllowPickpocket() && !target.IsPlayerTeammate()) ; Pet/Horse only approach teammates
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
		elseif (ansRef.GetActorRef() == akRef) ; why check in this time? when wrote?
			return false
		endif

		int chance = SexUtil.GetArousal(akRef, target)
		if (chance < SLApproachMain.lowestArousalNPC)
			slappUtil.log(ApproachName + ": " + akRefName + " :Canceled by NPC's Arousal: " + chance)
			return false
		endif
		
		slappUtil.log(ApproachName + " ChanceRoll: " + akRefName + " - " + target.GetBaseObject().GetName())
		int pt_bed = slappUtil.BedCalc(target)
		int pt_time = slappUtil.TimeCalc()
		
		; for sex ---------------------------------
		chance = self.calcChance(akRef, target, chance)
		chance += pt_bed
		chance += pt_time
		
		int result = self.GetResult(chance, SLApproachMain.userAddingPointNpc, baseChanceMultiplier)
		int roll = self.GetDiceRoll()
		slappUtil.log(ApproachName + ": " + akRefName + " :Sex: " + roll + " < " + result)

		if (roll < result)
			self.fillAlias(akRef, target)
			selectedScene = SSLAppAsk2Scene
			return true
		endif
		
		if !(akRef.HasKeyword(ActorTypeNPC))
			return false
		endif
		
		; for kiss ---------------------------------
		chance -= pt_bed
		
		result = self.GetResult(chance, SLApproachMain.userAddingKissPointNpc, baseChanceMultiplier)
		roll = self.GetDiceRoll()
		slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)

		if (roll < result)
			self.fillAlias(akRef, target)
			selectedScene = SSLAppAsk2Kiss
			return true
		endif
		
		; for hug ---------------------------------
		chance -= pt_time
		
		result = self.GetResult(chance, SLApproachMain.userAddingHugPointNpc, baseChanceMultiplier)
		roll = self.GetDiceRoll()
		slappUtil.log(ApproachName + ": " + akRefName + " :Hug: " + roll + " < " + result)

		if (roll < result)
			self.fillAlias(akRef, target)
			selectedScene = SSLAppAsk2Hug
			return true
		endif
		
		return false
	else
		slappUtil.log(ApproachName + " None target: " + akRefName)
		return false
	endif
EndFunction

Function fillAlias(Actor akRef, Actor target)
	askRef.ForceRefTo(akRef)
	ansRef.ForceRefTo(target)
EndFunction

bool Function modSpecificCheck(Actor akRef, Actor target)
		; for HBC
		if(akRef.GetActorBase().GetName() == "Dummy" || target.GetBaseObject().GetName() == "Dummy")
			return false
		endif
		
		return true
EndFunction

int Function calcChance(Actor akRef, Actor target, int prechance = 0)
	int chance
	if (prechance == 0)
		chance = SexUtil.GetArousal(akRef, target)
	else
		chance = prechance
	endif

	chance += slappUtil.LightLevelCalc(target)
	chance += slappUtil.NudeCalc(target)
	chance += slappUtil.SexAnimActiveCalc(PlayerRef)
	chance += slappUtil.TeammateCalc(akRef, target)

	return chance
EndFunction

Function endApproach(bool force = false)
	slappUtil.log("Sex to Other by: endApproach")
	approachEnding = true
	
	if (selectedScene == SSLAppAsk2Scene)
		SSLAppAsk2Scene.Stop()
		SSLAppAsk2SceneRape.Stop()
		SSLAppAsk2SceneDisagree.Stop()
	elseif (selectedScene == SSLAppAsk2Kiss)
		SSLAppAsk2Kiss.Stop()
	else
		SSLAppAsk2Hug.Stop()
	endif
		
	SSLAppAsk2.Stop()
	HelperQuest.Stop()
	parent.endApproach()
EndFunction


SLAppSexUtil Property SexUtil  Auto  

Quest Property SSLAppAsk2  Auto  

ReferenceAlias Property askRef  Auto  
ReferenceAlias Property ansRef  Auto  

Faction Property ArousalFaction  Auto  

Scene Property SSLAppAsk2Scene  Auto  
Scene Property SSLAppAsk2SceneDisagree  Auto  
Scene Property SSLAppAsk2SceneRape  Auto  

Scene Property SSLAppAsk2Kiss  Auto  
Scene Property SSLAppAsk2Hug  Auto  

Actor Property PlayerRef  Auto  

Armor Property SLAppRingServant  Auto  
Armor Property SLAppRingSlave  Auto  
Armor Property SLAppRingBeast  Auto  
Armor Property SLAppRingHomo  Auto  
Armor Property SLAppRingEngagement  Auto  

Keyword Property ActorTypeNPC  Auto  
