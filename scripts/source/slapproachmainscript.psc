Scriptname SLApproachMainScript extends Quest  

Actor Property PlayerRef Auto
Spell Property ApproachCloak Auto
int Property cloakFrequency = 10 Auto
float Property baseChanceMultiplier = 1.0 Auto
int Property totalAwarnessRange = 256 Auto

bool Property debugLogFlag = false Auto
bool Property enablePromiseFlag = true Auto
bool Property enableRapeFlag = true Auto
bool Property enableRelationChangeFlag = false Auto

int Property userAddingPointPc = 0 Auto
int Property userAddingPointNpc = 0 Auto

bool property isDuringCloakPulse = false Auto
int Property actorsEffectStarted = 0 Auto
int Property actorsEffectFinished = 0 Auto

slapp_util Property slappUtil Auto

int myActorAmountAware = 0
int Property actorAmountAware
	int function get()
		if(isDuringCloakPulse )
			return -1
		endif
		return myActorAmountAware 
	endFunction
	function set(int value)
		myActorAmountAware = value
	endFunction
endProperty
actor[] awareActors

int my_cloakRange = 192
int Property cloakRange
	int function get()
		return my_cloakRange
	endFunction
	function set(int value)
		my_cloakRange = value
		ApproachCloak.SetNthEffectMagnitude(0,value as float)
	endFunction
endProperty

bool initilized = false

int registeredQuestsAmount
bool[] approachQuestsInitilizationArray
quest[] approachQuests
string[] approachQuestNames
SLApproachBaseQuestScript[] approachQuestSripts

Event OnInit()
    Maintenance()
EndEvent

Function initApproachQuestRegister()
	registeredQuestsAmount = 0

	approachQuestsInitilizationArray= New bool[8]
	int counter = 8
       while counter
       	counter -= 1
       	approachQuestsInitilizationArray[counter] = false           
       endwhile

	approachQuests=New Quest[8]
	approachQuestNames = new string[8]
	approachQuestSripts = new SLApproachBaseQuestScript[8]
EndFunction

Function Maintenance()
    ; Debug.Notification("SexLab Approach is starting...")
    if(!initilized)
       initApproachQuestRegister()
	awareActors = new actor[64]
    endif
    initilized = true
    PlayerRef.RemoveSpell(SLApproachCloakAbility)
    
    UnregisterForAllModEvents()
    ; Debug.Notification("SexLab Approach is running.")
    ; PlayerRef.AddSpell(SLApproachCloakAbility)
EndFunction
SPELL Property SLApproachCloakAbility  Auto  

bool Function StartInitOfQuestByIndex(int index)
    slappUtil.log("START? index = " + index + " approachQuestsInitilizationArray[index] = " + approachQuestsInitilizationArray[index])
    If(approachQuestsInitilizationArray[index])
        return false
    else
        approachQuestsInitilizationArray[index] = true
        return true
    endif
EndFunction

Function EndtInitOfQuestByIndex(int index)
    slappUtil.log("index END = " + index + " approachQuestsInitilizationArray[index] = " + approachQuestsInitilizationArray[index])
    approachQuestsInitilizationArray[index] = false
EndFunction

int Function RegisterQuest(Quest newQuest, SLApproachBaseQuestScript newQuestScript, string newQuestName, int type = 1)
	if(!initilized)
		return -1
	endif
	int indexCounter = registeredQuestsAmount - 1
	while(indexCounter >=0)
		if(approachQuestNames[indexCounter] == newQuestName)
			approachQuests[indexCounter] = newQuest
			approachQuestSripts[indexCounter] = newQuestScript
			return indexCounter
		endif
		indexCounter = indexCounter - 1
	endwhile

	if (registeredQuestsAmount<8)
		int newIndex = registeredQuestsAmount
		registeredQuestsAmount = registeredQuestsAmount +1
		
		approachQuestsInitilizationArray[newIndex] = false
		approachQuests[newIndex] = newQuest
		approachQuestSripts[newIndex] = newQuestScript
		approachQuestNames[newIndex] = newQuestName

		Debug.Notification("Sexlab Approach: Approach named "+newQuestName+" registered.")

		if(!newQuest.isRunning())
			newQuest.Start()
			debug.notification("SLApp: " + newQuestName + " - Quest Init")
		endif

		return newIndex
	endif
	Debug.Notification("Sexlab Approach: Quest registration failed due to exceeding max approach quest limit.")
	return -1
endfunction

int Function getregisteredAmount()
	return registeredQuestsAmount
endfunction

quest Function getApproachQuest(int index)
	if(index < registeredQuestsAmount && index >= 0)
		return approachQuests[index]
	endif
	Debug.Notification("Sexlab Approach: Quest retrival failed - invalid index "+index)
	Debug.Trace("Sexlab Approach: Quest retrival failed - invalid index "+index)

	return None
endfunction

SLApproachBaseQuestScript Function getApproachQuestScript(int index)
	if(index < registeredQuestsAmount && index >= 0)
		return approachQuestSripts[index]
	endif
	Debug.Notification("Sexlab Approach: Script retrival failed - invalid index "+index)
	Debug.Trace("Sexlab Approach: Script retrival failed - invalid index "+index)
	return None
endfunction

string Function getApproachQuestName(int index)
	if(index < registeredQuestsAmount && index >= 0)
		return approachQuestNames[index]
	endif
	Debug.Notification("Sexlab Approach: Quest Name retrival failed - invalid index "+index)
	Debug.Trace("Sexlab Approach: Quest Name retrival failed - invalid index "+index)

	return None
endfunction

Function addAwareActor(Actor newAwareActor)
	if(myActorAmountAware < 64)
		awareActors[ myActorAmountAware ] = newAwareActor
		myActorAmountAware = myActorAmountAware + 1
	else
		Debug.Notification("Sexlab Approach: Cannot add an aware actor. Limit exceeded.")
		Debug.Trace("Sexlab Approach: Cannot add an aware actor. Limit exceeded.")
	endif
endfunction

Actor[] Function getAwareActors()
	return awareActors
EndFunction

Function addActorEffectStarted()
	actorsEffectStarted += 1
Endfunction

Function addActorEffectFinished()
	actorsEffectFinished += 1
Endfunction

