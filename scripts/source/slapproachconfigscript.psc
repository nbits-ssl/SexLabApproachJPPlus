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

SLApproachMainScript Property SLApproachMain Auto

event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)

	AddHeaderOption("General: ")
	
	cloakFrequencyOID =  AddSliderOption("Cloak frequency:", SLApproachMain.cloakFrequency,"per {0} sec.")
	cloakRangeOID =  AddSliderOption("Cloak range:", SLApproachMain.cloakRange)
	baseChanceMultiplierOID =  AddSliderOption("Base chance multiplier:", SLApproachMain.baseChanceMultiplier, "{1}")
	totalAwarnessRangeOID = AddSliderOption("Total awarness range:", SLApproachMain.totalAwarnessRange)
	enablePromiseFlagOID = AddToggleOption("Enable promise ring", SLApproachMain.enablePromiseFlag)
	enableRapeFlagOID = AddToggleOption("Enable rape", SLApproachMain.enableRapeFlag)
	enableRelationChangeFlagOID = AddToggleOption("Enable to change relationship rank", SLApproachMain.enableRelationChangeFlag)
	enableElderRaceFlagOID = AddToggleOption("Enable ElderRace", SLApproachMain.enableElderRaceFlag)
	debugLogFlagOID = AddToggleOption("Output papyrus log", SLApproachMain.debugLogFlag)

	SetCursorPosition(1)

	AddHeaderOption("Registered approach quests: ")
	
	int indexCounter = SLApproachMain.getRegisteredAmount()
			
	while(indexCounter > 0)
		indexCounter = indexCounter - 1
		AddToggleOption(SLApproachMain.getApproachQuestName(indexCounter),true)
	endwhile

	AddHeaderOption("Registered quests options: ")

	userAddingPointPcOID =  AddSliderOption("Adding points: NPC->PC:", SLApproachMain.userAddingPointPc, "{0}")
	userAddingPointNpcOID =  AddSliderOption("Adding points: NPC->NPC:", SLApproachMain.userAddingPointNpc, "{0}")
	
endevent

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
	elseif(option == enableRelationChangeFlagOID)
		SLApproachMain.enableRelationChangeFlag = !SLApproachMain.enableRelationChangeFlag
		SetToggleOptionValue(enableRelationChangeFlagOID, SLApproachMain.enableRelationChangeFlag)
	elseif(option == enableElderRaceFlagOID)
		SLApproachMain.enableElderRaceFlag = !SLApproachMain.enableElderRaceFlag
		SetToggleOptionValue(enableElderRaceFlagOID, SLApproachMain.enableElderRaceFlag)
	endif
endevent

event OnOptionSliderOpen(int option)
	if (option == cloakFrequencyOID)
		SetSliderDialogStartValue( SLApproachMain.cloakFrequency)
		SetSliderDialogDefaultValue( SLApproachMain.cloakFrequency)
		SetSliderDialogRange(1.0, 120.0)
		SetSliderDialogInterval(1.0)
	elseif (option == cloakRangeOID )
		SetSliderDialogStartValue( SLApproachMain.cloakRange)
		SetSliderDialogDefaultValue( SLApproachMain.cloakRange)
		SetSliderDialogRange(64.0, 512.0)
		SetSliderDialogInterval(1.0)
	elseif (option == baseChanceMultiplierOID )
		SetSliderDialogStartValue( SLApproachMain.baseChanceMultiplier)
		SetSliderDialogDefaultValue( SLApproachMain.baseChanceMultiplier)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	elseif (option == totalAwarnessRangeOID )
		SetSliderDialogStartValue( SLApproachMain.totalAwarnessRange)
		SetSliderDialogDefaultValue( SLApproachMain.totalAwarnessRange)
		SetSliderDialogRange(0, 1024.0)
		SetSliderDialogInterval(1.0)
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
	elseif (option == totalAwarnessRangeOID )
		SLApproachMain.totalAwarnessRange= value as Int
		SetSliderOptionValue(totalAwarnessRangeOID , SLApproachMain.totalAwarnessRange)
	elseif (option == userAddingPointPcOID)
		SLApproachMain.userAddingPointPc = value as Int
		SetSliderOptionValue(userAddingPointPcOID , SLApproachMain.userAddingPointPc)
	elseif (option == userAddingPointNpcOID)
		SLApproachMain.userAddingPointNpc = value as Int
		SetSliderOptionValue(userAddingPointNpcOID , SLApproachMain.userAddingPointNpc)
	endif
endevent