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

	AddHeaderOption("$SLAppGeneral")
	
	cloakFrequencyOID =  AddSliderOption("$CloakFrequency", SLApproachMain.cloakFrequency,"$per0sec")
	cloakRangeOID =  AddSliderOption("$CloakRange", SLApproachMain.cloakRange)
	baseChanceMultiplierOID =  AddSliderOption("$BaseChanceMultiplier", SLApproachMain.baseChanceMultiplier, "{1}")
	totalAwarnessRangeOID = AddSliderOption("$TotalAwarnessRange", SLApproachMain.totalAwarnessRange)
	enablePromiseFlagOID = AddToggleOption("$EnablePromiseRing", SLApproachMain.enablePromiseFlag)
	enableRapeFlagOID = AddToggleOption("$EnableRape", SLApproachMain.enableRapeFlag)
	enableRelationChangeFlagOID = AddToggleOption("$EnableChangeRelationshipRank", SLApproachMain.enableRelationChangeFlag)
	enableElderRaceFlagOID = AddToggleOption("$EnableElderRace", SLApproachMain.enableElderRaceFlag)
	debugLogFlagOID = AddToggleOption("$OutputPapyrusLog", SLApproachMain.debugLogFlag)

	SetCursorPosition(1)

	AddHeaderOption("$RegisteredApproachQuests")
	
	int indexCounter = SLApproachMain.getRegisteredAmount()
	
	while(indexCounter > 0)
		indexCounter = indexCounter - 1
		AddToggleOption(SLApproachMain.getApproachQuestName(indexCounter),true)
	endwhile

	AddHeaderOption("$RegisteredQuestsOptions")

	userAddingPointPcOID =  AddSliderOption("$AddingPointsNPCPC", SLApproachMain.userAddingPointPc, "{0}")
	userAddingPointNpcOID =  AddSliderOption("$AddingPointsNPCNPC", SLApproachMain.userAddingPointNpc, "{0}")
endevent

Event OnOptionHighlight(int option)
	if (option == cloakFrequencyOID)
		SetInfoText("$BaseChanceMultiplierInfo")
	elseif (option == enableRelationChangeFlagOID)
		SetInfoText("$EnableChangeRelationshipRankInfo")
	elseif (option == enableRapeFlagOID)
		SetInfoText("$EnableRapeInfo")
	elseif (option == enablePromiseFlagOID)
		SetInfoText("$EnablePromiseRingInfo")
	elseif (option == userAddingPointPcOID)
		SetInfoText("$AddingPointsNPCPCInfo")
	elseif (option == userAddingPointNpcOID)
		SetInfoText("$AddingPointsNPCNPCInfo")
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