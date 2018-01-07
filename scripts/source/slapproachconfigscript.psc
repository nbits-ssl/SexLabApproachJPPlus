Scriptname SLApproachConfigScript extends SKI_ConfigBase  

int cloakFrequencyOID
int cloakRangeOID 
int baseChanceMultiplierOID 
int totalAwarnessRangeOID

int debugLogFlagOID
int enablePromiseFlagOID
int enableRapeFlagOID
int enableRelationChangeFlagOID
int enableElderRaceFlagOID

int userAddingPointPcOID
int userAddingPointNpcOID

int userAddingRapePointPcOID
int userAddingRapePointNpcOID

int[] SLAppQuestScriptsOIDS

SLApproachMainScript Property SLApproachMain Auto

event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)

	AddHeaderOption("$SLAppGeneral")
	
	cloakFrequencyOID =  AddSliderOption("$CloakFrequency", SLApproachMain.cloakFrequency,"$per0sec")
	cloakRangeOID =  AddSliderOption("$CloakRange", SLApproachMain.cloakRange)
	baseChanceMultiplierOID =  AddSliderOption("$BaseChanceMultiplier", SLApproachMain.baseChanceMultiplier, "{1}")
	enablePromiseFlagOID = AddToggleOption("$EnablePromiseRing", SLApproachMain.enablePromiseFlag)
	enableRapeFlagOID = AddToggleOption("$EnableRape", SLApproachMain.enableRapeFlag)
	enableElderRaceFlagOID = AddToggleOption("$EnableElderRace", SLApproachMain.enableElderRaceFlag)
	debugLogFlagOID = AddToggleOption("$OutputPapyrusLog", SLApproachMain.debugLogFlag)

	SetCursorPosition(1)

	AddHeaderOption("$RegisteredApproachQuests")
	
	int indexCounter = 0
	int amount = SLApproachMain.getRegisteredAmount()
	SLAppQuestScriptsOIDS = new int[8]
	
	while (indexCounter != amount)
		SLApproachBaseQuestScript xscript = SLApproachMain.getApproachQuestScript(indexCounter)
		SLAppQuestScriptsOIDS[indexCounter] = AddToggleOption(xscript.ApproachName, !xscript.isSkipMode)
		indexCounter += 1
	endwhile

	AddHeaderOption("$RegisteredQuestsOptions")

	userAddingPointPcOID =  AddSliderOption("$AddingPointsNPCPC", SLApproachMain.userAddingPointPc, "{0}")
	userAddingPointNpcOID =  AddSliderOption("$AddingPointsNPCNPC", SLApproachMain.userAddingPointNpc, "{0}")

	userAddingRapePointPcOID =  AddSliderOption("$AddingRapePointsNPCPC", SLApproachMain.userAddingRapePointPc, "{0}")
	userAddingRapePointNpcOID =  AddSliderOption("$AddingRapePointsNPCNPC", SLApproachMain.userAddingRapePointNpc, "{0}")
endevent

Event OnOptionHighlight(int option)
	if (option == baseChanceMultiplierOID)
		SetInfoText("$BaseChanceMultiplierInfo")
	elseif (option == enableRapeFlagOID)
		SetInfoText("$EnableRapeInfo")
	elseif (option == enablePromiseFlagOID)
		SetInfoText("$EnablePromiseRingInfo")
	elseif (option == userAddingPointPcOID)
		SetInfoText("$AddingPointsNPCPCInfo")
	elseif (option == userAddingPointNpcOID)
		SetInfoText("$AddingPointsNPCNPCInfo")
	elseif (option == userAddingRapePointPcOID)
		SetInfoText("$AddingRapePointsNPCPCInfo")
	elseif (option == userAddingRapePointNpcOID)
		SetInfoText("$AddingRapePointsNPCNPCInfo")
	endif
EndEvent

event OnOptionSelect(int option)
	if(option == debugLogFlagOID)
		SLApproachMain.debugLogFlag = !SLApproachMain.debugLogFlag
		SetToggleOptionValue(debugLogFlagOID, SLApproachMain.debugLogFlag)
	elseif(option == enablePromiseFlagOID)
		SLApproachMain.enablePromiseFlag = !SLApproachMain.enablePromiseFlag
		SetToggleOptionValue(enablePromiseFlagOID, SLApproachMain.enablePromiseFlag)
	elseif(option == enableRapeFlagOID)
		SLApproachMain.enableRapeFlag = !SLApproachMain.enableRapeFlag
		SetToggleOptionValue(enableRapeFlagOID, SLApproachMain.enableRapeFlag)
	elseif(option == enableElderRaceFlagOID)
		SLApproachMain.enableElderRaceFlag = !SLApproachMain.enableElderRaceFlag
		SetToggleOptionValue(enableElderRaceFlagOID, SLApproachMain.enableElderRaceFlag)
	
	elseif (SLAppQuestScriptsOIDS.Find(option) > -1)
		int idx = SLAppQuestScriptsOIDS.Find(option)
		SLApproachBaseQuestScript xscript = SLApproachMain.getApproachQuestScript(idx)
		bool opt = xscript.isSkipMode
		xscript.isSkipMode = !opt
		SetToggleOptionValue(option, opt)
	endif
endevent

event OnOptionSliderOpen(int option)
	if (option == cloakFrequencyOID)
		SetSliderDialogStartValue( SLApproachMain.cloakFrequency)
		SetSliderDialogDefaultValue( SLApproachMain.cloakFrequency)
		SetSliderDialogRange(1.0, 240.0)
		SetSliderDialogInterval(1.0)
	elseif (option == cloakRangeOID)
		SetSliderDialogStartValue( SLApproachMain.cloakRange)
		SetSliderDialogDefaultValue( SLApproachMain.cloakRange)
		SetSliderDialogRange(64.0, 1024.0)
		SetSliderDialogInterval(1.0)
	elseif (option == baseChanceMultiplierOID)
		SetSliderDialogStartValue( SLApproachMain.baseChanceMultiplier)
		SetSliderDialogDefaultValue( SLApproachMain.baseChanceMultiplier)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	elseif (option == userAddingPointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingPointPc)
		SetSliderDialogDefaultValue(SLApproachMain.userAddingPointPc)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseif (option == userAddingPointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingPointNpc)
		SetSliderDialogDefaultValue(SLApproachMain.userAddingPointNpc)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseif (option == userAddingRapePointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingRapePointPc)
		SetSliderDialogDefaultValue(SLApproachMain.userAddingRapePointPc)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseif (option == userAddingRapePointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingRapePointNpc)
		SetSliderDialogDefaultValue(SLApproachMain.userAddingRapePointNpc)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	endif
endevent

event OnOptionSliderAccept(int option, float value)
	if (option == cloakFrequencyOID)
		SLApproachMain.cloakFrequency= value as Int
		SetSliderOptionValue(cloakFrequencyOID, SLApproachMain.cloakFrequency)
	elseif (option == cloakRangeOID )
		SLApproachMain.cloakRange= value as Int
		SetSliderOptionValue(cloakRangeOID , SLApproachMain.cloakRange)
	elseif (option == baseChanceMultiplierOID )
		SLApproachMain.baseChanceMultiplier= value
		SetSliderOptionValue(baseChanceMultiplierOID , SLApproachMain.baseChanceMultiplier, "{1}")
	elseif (option == userAddingPointPcOID)
		SLApproachMain.userAddingPointPc = value as Int
		SetSliderOptionValue(userAddingPointPcOID , SLApproachMain.userAddingPointPc)
	elseif (option == userAddingPointNpcOID)
		SLApproachMain.userAddingPointNpc = value as Int
		SetSliderOptionValue(userAddingPointNpcOID , SLApproachMain.userAddingPointNpc)
	elseif (option == userAddingRapePointPcOID)
		SLApproachMain.userAddingRapePointPc = value as Int
		SetSliderOptionValue(userAddingRapePointPcOID , SLApproachMain.userAddingRapePointPc)
	elseif (option == userAddingRapePointNpcOID)
		SLApproachMain.userAddingRapePointNpc = value as Int
		SetSliderOptionValue(userAddingRapePointNpcOID , SLApproachMain.userAddingRapePointNpc)
	endif
endevent