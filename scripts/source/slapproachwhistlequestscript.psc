Scriptname SLApproachWhistleQuestScript extends SLApproachBaseQuestScript

Function startApproach(Actor akRef)
	maxTime = 10
	whistlingActor.ForceRefTo(akRef)
	SLApproachWhistleQuestScene.Start()
	parent.startApproach(akRef)
EndFunction

ReferenceAlias Property whistlingActor  Auto  

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	int chance
	int relationship =  akRef.GetRelationshipRank(PlayerRef)
	int confidence = akRef.GetActorValue("Confidence") as Int
	int aggression = akRef.GetActorValue("Aggression") as Int
	int attraction = 100; SLAttractionMain.GetActorAttraction(akRef)
	int roll
	int relationShipModifier = 0
	if(relationship==1 || relationship == 2)
		relationShipModifier = 1
	elseif(relationship==0)
		relationShipModifier = 2
	endif

	chance =( (attraction - 50) *( confidence + 1)*(relationShipModifier)*(aggression + 1) *baseChanceMultiplier) as Int
	roll = Utility.RandomInt(0, 10000)
	;Debug.Notification("SLApp Whistle: " + chance as string + ", " + roll as string)

	if(roll<chance)
		return true
	endif
	return false
endfunction

Function endApproach()
	approachEnding = true
	SLApproachWhistleQuestScene.Stop()
	parent.endApproach()
EndFunction

Function register()
;	index = -1
;	while(index == -1)
;		Utility.Wait(1.0)
;		index = SLApproachMain.RegisterQuest(ApproachQuest, self, "Whistle", 1)
;	endwhile
EndFunction

Scene Property SLApproachWhistleQuestScene  Auto  
;SLAttractionMainScript Property SLAttractionMain  Auto