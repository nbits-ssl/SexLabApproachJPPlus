Scriptname SLApproachMainScript extends Quest  

Actor Property PlayerRef Auto
Spell Property ApproachCloak Auto
Spell Property SLApproachCloakAbility Auto
int Property cloakFrequency = 10 Auto
float Property baseChanceMultiplier = 1.0 Auto
int Property totalAwarnessRange = 256 Auto ; no longer used

bool Property debugLogFlag = false Auto
bool Property enablePromiseFlag = false Auto
bool Property enableRapeFlag = true Auto
bool Property enableForceThirdPersonHug = true Auto
bool Property enableRelationChangeFlag = false Auto ; no longer used
bool Property enableElderRaceFlag = false Auto

int Property userAddingPointPc = 0 Auto
int Property userAddingPointNpc = 0 Auto

int Property userAddingRapePointPc = 0 Auto
int Property userAddingRapePointNpc = 0 Auto

int Property userAddingHugPointPc = 0 Auto

bool property isDuringCloakPulse = false Auto
int Property actorsEffectStarted = 0 Auto
int Property actorsEffectFinished = 0 Auto

bool Property isSkipUpdateMode = false Auto

slapp_util Property slappUtil Auto

int my_cloakRange = 192

int Property cloakRange
	int Function get()
		return my_cloakRange
	EndFunction
	Function set(int value)
		my_cloakRange = value
		ApproachCloak.SetNthEffectMagnitude(0, value as float)
	EndFunction
EndProperty

bool initilized = false

int registeredQuestsAmount
bool[] approachQuestsInitilizationArray
Quest[] approachQuests
string[] approachQuestNames
SLApproachBaseQuestScript[] approachQuestScripts

Event OnInit()
	Maintenance()
EndEvent

Function Maintenance()
	if (!initilized)
		initApproachQuestRegister()
	endif
	
	initilized = true
	PlayerRef.RemoveSpell(SLApproachCloakAbility)

	UnregisterForAllModEvents()
EndFunction

Function initApproachQuestRegister()
	registeredQuestsAmount = 0

	approachQuestsInitilizationArray = New bool[8]
	int counter = 8

	while counter
		counter -= 1
		approachQuestsInitilizationArray[counter] = false
	endwhile

	approachQuests = New Quest[8]
	approachQuestNames = new string[8]
	approachQuestScripts = new SLApproachBaseQuestScript[8]
EndFunction

bool Function StartInitOfQuestByIndex(int index)
	if (approachQuestsInitilizationArray[index])
		return false
	else
		slappUtil.log("START index = " + index + " appQuestInitArray => " + approachQuestsInitilizationArray[index])
		approachQuestsInitilizationArray[index] = true
		return true
	endif
EndFunction

Function EndtInitOfQuestByIndex(int index)
	if (index >= 0)
		slappUtil.log("END index = " + index + " appQuestInitArray => " + approachQuestsInitilizationArray[index])
		approachQuestsInitilizationArray[index] = false
	endif
EndFunction

Function clearQuestStatus()
	int idx = approachQuestsInitilizationArray.Length
	while (idx > 0)
		idx -= 1
		approachQuestsInitilizationArray[idx] = false
	endwhile
	
	int qidx = getregisteredAmount()
	while (qidx > 0)
		qidx -= 1
		approachQuestScripts[qidx].endApproachForce()
	endwhile
EndFunction

int Function RegisterQuest(Quest newQuest, SLApproachBaseQuestScript newQuestScript, string newQuestName)
	if(!initilized)
		return -1
	endif
	
	int indexCounter = registeredQuestsAmount - 1
	while (indexCounter >= 0)
		if (approachQuestNames[indexCounter] == newQuestName)
			approachQuests[indexCounter] = newQuest
			approachQuestScripts[indexCounter] = newQuestScript
			; debug.notification("Sexlab Approach: Approach named " + newQuestName + " is running.")
			return indexCounter
		endif
		indexCounter = indexCounter - 1
	endwhile
	
	if (registeredQuestsAmount < 8)
		int newIndex = registeredQuestsAmount
		registeredQuestsAmount = registeredQuestsAmount + 1
		
		approachQuests[newIndex] = newQuest
		approachQuestScripts[newIndex] = newQuestScript
		approachQuestNames[newIndex] = newQuestName
		debug.notification("Sexlab Approach: Approach named " + newQuestName + " registered.")

		if(!newQuest.isRunning())
			newQuest.Start()
			debug.notification("SexLab Approach: " + newQuestName + " - Quest Init")
		endif

		return newIndex
	endif
	
	debug.notification("Sexlab Approach: Quest registration failed due to exceeding max approach quest limit.")
	return -1
EndFunction

int Function getregisteredAmount()
	return registeredQuestsAmount
EndFunction

quest Function getApproachQuest(int index)
	if (index < registeredQuestsAmount && index >= 0)
		return approachQuests[index]
	endif
	
	debug.notification("Sexlab Approach: Quest retrival failed - invalid index " + index)
	debug.trace("Sexlab Approach: Quest retrival failed - invalid index " + index)

	return None
EndFunction

SLApproachBaseQuestScript Function getApproachQuestScript(int index)
	if (index < registeredQuestsAmount && index >= 0)
		return approachQuestScripts[index]
	endif
	
	debug.notification("Sexlab Approach: Script retrival failed - invalid index " + index)
	debug.trace("Sexlab Approach: Script retrival failed - invalid index " + index)
	
	return None
EndFunction

string Function getApproachQuestName(int index)
	if (index < registeredQuestsAmount && index >= 0)
		return approachQuestNames[index]
	endif
	
	debug.notification("Sexlab Approach: Quest Name retrival failed - invalid index " + index)
	debug.trace("Sexlab Approach: Quest Name retrival failed - invalid index " + index)

	return None
EndFunction

Function addActorEffectStarted()
	actorsEffectStarted += 1
EndFunction

Function addActorEffectFinished()
	actorsEffectFinished += 1
EndFunction

