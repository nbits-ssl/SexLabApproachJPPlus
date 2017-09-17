Scriptname SLAppNPCSexQuestScript extends SLApproachBaseQuestScript  Conditional

slapp_util Property slappUtil Auto

Function startApproach(Actor akRef)
	maxTime = 15
	if(!SSLAppAsk2.isRunning())
		SSLAppAsk2.Start()
	endif
	if(SSLAppAsk2.isRunning())
		Actor target = ansRef.GetActorRef()
		
		if (target.IsDead())
			return
		endif ; second check
		
		int chance
		if(target.IsInFaction(arousalFaction))
			chance = target.GetFactionRank(arousalFaction)
		elseif(akRef.IsInFaction(arousalFaction))
			chance = akRef.GetFactionRank(arousalFaction)
		else
			return ;  for C-C
		endif
		
		chance += slappUtil.BedCalc(target)
		chance += slappUtil.LightLevelCalc(target)
		chance += slappUtil.TimeCalc()
		chance += slappUtil.NudeCalc(target)
		chance += slappUtil.SexAnimActiveCalc(PlayerRef)
		chance += slappUtil.TeammateCalc(akRef, target)
		
		; int result = (chance * 0.3) as Int ; for debug
		int result = slappUtil.ValidateChance((chance) as Int)
		result += SLApproachMain.userAddingPointNpc
		int roll = Utility.RandomInt(0, 100)
		slappUtil.log("Ask to Other chance: ANS by : " + target.GetActorBase().GetName() + " : "  + result + " & " + roll)
		
		if(SexLab.IsActorActive(akRef))
			slappUtil.log("Sex to Other by: pass : akRef Locked by other sex")
			maxTime = 2
		elseif(SexLab.IsActorActive(target))
			slappUtil.log("Sex to Other by: pass : target Locked by other sex")
			maxTime = 2
		elseif(target.IsInDialogueWithPlayer())
			slappUtil.log("Sex to Other by: pass : target Locked by talking")
			maxTime = 2
		elseif(!SexLab.IsValidActor(target)) ;third check
			slappUtil.log("Sex to Other by: pass : target is maybe dead or not loaded or...")
			maxTime = 2
		elseif (akRef.IsEquipped(SLAppRingServant) || akRef.IsEquipped(SLAppRingSlave))
			SSLAppAsk2Scene.Start()
		elseif (roll < result)
			SSLAppAsk2Scene.Start()
		elseif(SLApproachMain.enableRapeFlag)
			if (akRef.IsEquipped(SLAppRingBeast))
				SSLAppAsk2SceneRape.Start()
			else
				int second_result = slappUtil.ValidateChance(calcChance(akRef, target) / 10)
				int second_extra = SLApproachMain.userAddingPointNpc / 10
				second_result = second_result + second_extra
				int second_roll = Utility.RandomInt(0, 100)
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

int Function calcChance(Actor akRef, Actor target)
	int chance
	if(akRef.IsInFaction(arousalFaction))
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
endFunction

bool Function chanceRoll(Actor akRef, Actor Player, float baseChanceMultiplier)
	int queststage = self.GetStage()
	if(queststage >= 10 && queststage < 100)
		; slappUtil.log("Sex to Other by: pass : " + akRef.GetActorBase().GetName() + " - " + self.GetStage()) 
		return false
	elseif (SSLAppAsk2Scene.IsPlaying() || SSLAppAsk2SceneDisagree.IsPlaying() || SSLAppAsk2SceneRape.IsPlaying())
		slappUtil.log("Sex to Other by: pass : Scene Locked")
		return false
	elseif (SexLab.IsActorActive(akRef))
		slappUtil.log("Sex to Other by: pass : akRef Locked by other sex")
		return false
	elseif (akRef.IsEquipped(SLAppRingShame))
		return false
	endif
	
	Scene aks = akRef.GetCurrentScene()
	if(aks)
		string akscene = aks.GetOwningQuest().GetId()
		;if(akscene != "SSLAppAsk2" && akscene != "SLApproachAskForSexQuest")
			slappUtil.log("Sex to Other blocked by other scene (Ask): " + akRef.GetActorBase().GetName() + " : " + akscene)
			return false
		;endif
	endif

	int gender = -1
	int srcgender = SexLab.GetGender(akRef)
	if (srcgender != 1 && srcgender != 3) ; not female and female creature
		gender = 1
	else
		gender = 0
	endif
	
	Actor target = SexLab.FindAvailableActor(akRef, 1000.0, gender, Player)
	if(target)
		if (target.IsDead())
			return false ; first check
		elseif (!akRef.GetRace().AllowPickpocket() && !target.IsPlayerTeammate()) ; Pet only approach teammates
			return false
		elseif (!SLApproachMain.enableElderRaceFlag && target.GetRace() == ElderRace)
			return false
		endif
		
		slappUtil.log("Sex to Other by: " + akRef.GetActorBase().GetName() + " - " + target.GetBaseObject().GetName() + " - stage " + self.GetStage())
		
		if(!slappUtil.ValidatePromise(akRef, target))
			slappUtil.log("Sex to Other blocked by Promise: " + akRef.GetActorBase().GetName() + " $ " + target.GetActorBase().GetName())
			return false
		endif
		
		Scene ans = target.GetCurrentScene()
		if(ans)
			string anscene = ans.GetOwningQuest().GetId()
			;if(anscene != "SSLAppAsk2" && anscene != "SLApproachAskForSexQuest")
				slappUtil.log("Sex to Other blocked by other scene (Ans): " + akRef.GetActorBase().GetName() + " : " + anscene)
				return false
			;endif
		endif

		; for HBC
		if(akRef.GetActorBase().GetName() == "Dummy" || target.GetBaseObject().GetName() == "Dummy")
			return false
		endif
		
		int chance = calcChance(akRef, target)
		int result = slappUtil.ValidateChance((chance * baseChanceMultiplier) as Int)
		result += SLApproachMain.userAddingPointNpc
		int roll = Utility.RandomInt(0, 100)
		slappUtil.log("Ask to Other chance: ASK by : "  + akRef.GetActorBase().GetName() + " : " + result + " & " + roll)
		
		if (roll < result && ansRef.GetActorRef() != akRef)
			; bool tryref = askRef.ForceRefIfEmpty(akRef)
			; if(!tryref)
			; 	slappUtil.log("Ask to other: already ref to")
			; 	return false
			; endif
			
			askRef.ForceRefTo(akRef)
			ansRef.ForceRefTo(target)
			
			return true
		else
			return false
		endif
	else
		slappUtil.log("Ask to Other, None target :"  + akRef.GetActorBase().GetName())
		return false
	endif
endfunction

Function endApproach()
	slappUtil.log("Sex to Other by: endApproach")
	approachEnding = true
	SSLAppAsk2Scene.Stop()
	SSLAppAsk2SceneRape.Stop()
	SSLAppAsk2SceneDisagree.Stop()
	SSLAppAsk2.Stop()
	parent.endApproach()
EndFunction

Function endApproachForce()
	slappUtil.log("Ask to Other: endApproachForce() !!")
	Actor fordebugact = askRef.GetActorRef()
	if (fordebugact)
		ActorBase fordebugname = fordebugact.GetActorBase()
		if (fordebugname)
			slappUtil.log("Ask to Other Force Stop: " + fordebugname.GetName())
		endif
	endif
	self.endApproach()
EndFunction

Function register()
	index = -1
	while(index == -1)
		Utility.Wait(1.0)
		index = SLApproachMain.RegisterQuest(ApproachQuest, self, "Ask to Other", 1)
	endwhile
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
Armor Property SLAppRingShame  Auto  
Armor Property SLAppRingBeast  Auto  
