Scriptname SLApproachConfigScript extends SKI_ConfigBase  

int cloakFrequencyOID
int cloakRangeOID 
int baseChanceMultiplierOID 
int totalAwarnessRangeOID

int debugLogFlagOID
int enablePromiseFlagOID
int enableRapeFlagOID
int enableForceThirdPersonHugOID
int enableRelationChangeFlagOID ; no longer used
int enableElderRaceFlagOID
int enablePetsFlagOID
int enablePlayerHorseFlagOID

int lowestArousalPCOID
int lowestArousalNPCOID

int dialogueArousalOID

int userAddingPointPcOID
int userAddingPointNpcOID

int userAddingRapePointPcOID
int userAddingRapePointNpcOID

int userAddingHugPointPcOID
int userAddingHugPointNpcOID

int userAddingKissPointPcOID
int userAddingKissPointNpcOID

int multiplayPercentOID

int[] SLAppQuestScriptsOIDS

SLApproachMainScript Property SLApproachMain Auto

int Function GetVersion()
	return 1
EndFunction 

Event OnVersionUpdate(int a_version)
	OnConfigInit()
EndEvent

Event OnGameReload()
	if !(Pages) ; I didn't know to define pages...
		OnConfigInit()
	endif
EndEvent

Event OnConfigInit()
	Pages = new string[2]
	Pages[0] = "$SLAppGeneral"
	Pages[1] = "$SLAppQuests"
EndEvent

event OnPageReset(string page)
	if (page == "" || page == "$SLAppGeneral")
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)

		AddHeaderOption("$SLAppGeneral")
		
		cloakFrequencyOID =  AddSliderOption("$CloakFrequency", SLApproachMain.cloakFrequency, "$per0sec")
		cloakRangeOID =  AddSliderOption("$CloakRange", SLApproachMain.cloakRange)
		baseChanceMultiplierOID =  AddSliderOption("$BaseChanceMultiplier", SLApproachMain.baseChanceMultiplier, "{1}")

		AddHeaderOption("$SLAppONOFF")

		enableRapeFlagOID = AddToggleOption("$EnableRape", SLApproachMain.enableRapeFlag)
		enablePetsFlagOID = AddToggleOption("$EnablePets", SLApproachMain.enablePetsFlag)
		enablePlayerHorseFlagOID = AddToggleOption("$EnablePlayerHorse", SLApproachMain.enablePlayerHorseFlag)
		enableElderRaceFlagOID = AddToggleOption("$EnableElderRace", SLApproachMain.enableElderRaceFlag)
		enablePromiseFlagOID = AddToggleOption("$EnablePromiseRing", SLApproachMain.enablePromiseFlag)

		SetCursorPosition(1)

		AddHeaderOption("$SLAppArousal")
		
		lowestArousalPCOID = AddSliderOption("$LowestArousalPC", SLApproachMain.lowestArousalPC)
		lowestArousalNPCOID = AddSliderOption("$LowestArousalNPC", SLApproachMain.lowestArousalNPC)
		dialogueArousalOID = AddSliderOption("$DialogueArousal", SLApproachDialogArousal.GetValue())
		
		AddHeaderOption("$SLAppETC")
		
		enableForceThirdPersonHugOID = AddToggleOption("$EnableForceThirdPersonHug", SLApproachMain.enableForceThirdPersonHug)
		debugLogFlagOID = AddToggleOption("$OutputPapyrusLog", SLApproachMain.debugLogFlag)

	elseif (page == "$SLAppQuests")
		SetCursorFillMode(TOP_TO_BOTTOM)

		SetCursorPosition(0)
		AddHeaderOption("$RegisteredApproachQuests")
		
		int indexCounter = 0
		int amount = SLApproachMain.getRegisteredAmount()
		SLAppQuestScriptsOIDS = new int[8]
		
		while (indexCounter != amount)
			SLApproachBaseQuestScript xscript = SLApproachMain.getApproachQuestScript(indexCounter)
			SLAppQuestScriptsOIDS[indexCounter] = AddToggleOption(xscript.ApproachName, !xscript.isSkipMode)
			indexCounter += 1
		endwhile

		AddEmptyOption()
		AddHeaderOption("$RegisteredQuestsCommonOptions")

		multiplayPercentOID =  AddSliderOption("$SLAppMultiplayPercent", SLApproachMultiplayPercent.GetValue())

		SetCursorPosition(1)
		AddHeaderOption("$RegisteredQuestsOptions")

		userAddingPointPcOID =  AddSliderOption("$AddingPointsNPCPC", SLApproachMain.userAddingPointPc, "{0}")
		userAddingRapePointPcOID =  AddSliderOption("$AddingRapePointsNPCPC", SLApproachMain.userAddingRapePointPc, "{0}")
		userAddingHugPointPcOID =  AddSliderOption("$AddingHugPointsNPCPC", SLApproachMain.userAddingHugPointPc, "{0}")
		userAddingKissPointPcOID =  AddSliderOption("$AddingKissPointsNPCPC", SLApproachMain.userAddingKissPointPc, "{0}")

		userAddingPointNpcOID =  AddSliderOption("$AddingPointsNPCNPC", SLApproachMain.userAddingPointNpc, "{0}")
		userAddingRapePointNpcOID =  AddSliderOption("$AddingRapePointsNPCNPC", SLApproachMain.userAddingRapePointNpc, "{0}")
		userAddingHugPointNpcOID =  AddSliderOption("$AddingHugPointsNPCNPC", SLApproachMain.userAddingHugPointNpc, "{0}")
		userAddingKissPointNpcOID =  AddSliderOption("$AddingKissPointsNPCNPC", SLApproachMain.userAddingKissPointNpc, "{0}")
	endif
endevent

Event OnOptionHighlight(int option)
	if (option == baseChanceMultiplierOID)
		SetInfoText("$BaseChanceMultiplierInfo")
	elseif (option == enableRapeFlagOID)
		SetInfoText("$EnableRapeInfo")
	elseif (option == enablePetsFlagOID)
		SetInfoText("$EnablePetsInfo")
	elseif (option == enablePlayerHorseFlagOID)
		SetInfoText("$EnablePlayerHorseInfo")
	elseif (option == enableForceThirdPersonHugOID)
		SetInfoText("$EnableForceThirdPersonHugInfo")
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
	elseif (option == userAddingHugPointPcOID)
		SetInfoText("$AddingHugPointsNPCPCInfo")
	elseif (option == userAddingHugPointNpcOID)
		SetInfoText("$AddingHugPointsNPCNPCInfo")
	elseif (option == userAddingKissPointPcOID)
		SetInfoText("$AddingKissPointsNPCPCInfo")
	elseif (option == userAddingKissPointNpcOID)
		SetInfoText("$AddingKissPointsNPCNPCInfo")
	elseif (option == lowestArousalPCOID)
		SetInfoText("$LowestArousalPCInfo")
	elseif (option == lowestArousalNPCOID)
		SetInfoText("$LowestArousalNPCInfo")
	elseif (option == dialogueArousalOID)
		SetInfoText("$DialogueArousalInfo")
	elseif (option == multiplayPercentOID)
		SetInfoText("$SLAppMultiplayPercentInfo")
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
	elseif(option == enablePetsFlagOID)
		SLApproachMain.enablePetsFlag = !SLApproachMain.enablePetsFlag
		SetToggleOptionValue(enablePetsFlagOID, SLApproachMain.enablePetsFlag)
	elseif(option == enablePlayerHorseFlagOID)
		SLApproachMain.enablePlayerHorseFlag = !SLApproachMain.enablePlayerHorseFlag
		SetToggleOptionValue(enablePlayerHorseFlagOID, SLApproachMain.enablePlayerHorseFlag)
	elseif(option == enableForceThirdPersonHugOID)
		SLApproachMain.enableForceThirdPersonHug = !SLApproachMain.enableForceThirdPersonHug
		SetToggleOptionValue(option, SLApproachMain.enableForceThirdPersonHug)
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
		SetSliderDialogStartValue(SLApproachMain.cloakFrequency)
		SetSliderDialogDefaultValue(13)
		SetSliderDialogRange(10, 240)
		SetSliderDialogInterval(1)
	elseif (option == cloakRangeOID)
		SetSliderDialogStartValue(SLApproachMain.cloakRange)
		SetSliderDialogDefaultValue(192)
		SetSliderDialogRange(64, 512)
		SetSliderDialogInterval(1)
	elseif (option == baseChanceMultiplierOID)
		SetSliderDialogStartValue(SLApproachMain.baseChanceMultiplier)
		SetSliderDialogDefaultValue(0.8)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
		
	elseif (option == userAddingPointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingPointPc)
		SetSliderDialogDefaultValue(-20)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)
	elseif (option == userAddingPointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingPointNpc)
		SetSliderDialogDefaultValue(-10)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)
		
	elseif (option == userAddingRapePointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingRapePointPc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)
	elseif (option == userAddingRapePointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingRapePointNpc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)

	elseif (option == userAddingHugPointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingHugPointPc)
		SetSliderDialogDefaultValue(-20)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)
	elseif (option == userAddingHugPointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingHugPointNpc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)

	elseif (option == userAddingKissPointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingKissPointPc)
		SetSliderDialogDefaultValue(-10)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)
	elseif (option == userAddingKissPointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingKissPointNpc)
		SetSliderDialogDefaultValue(-20)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)

	elseif (option == lowestArousalPCOID)
		SetSliderDialogStartValue(SLApproachMain.lowestArousalPC)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (option == lowestArousalNPCOID)
		SetSliderDialogStartValue(SLApproachMain.lowestArousalNPC)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)

	elseif (option == dialogueArousalOID)
		SetSliderDialogStartValue(SLApproachDialogArousal.GetValue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (option == multiplayPercentOID)
		SetSliderDialogStartValue(SLApproachMultiplayPercent.GetValue())
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endif
endevent

event OnOptionSliderAccept(int option, float value)
	if (option == cloakFrequencyOID)
		SLApproachMain.cloakFrequency= value as Int
		SetSliderOptionValue(cloakFrequencyOID, SLApproachMain.cloakFrequency, "$per0sec")
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
		
	elseif (option == userAddingHugPointPcOID)
		SLApproachMain.userAddingHugPointPc = value as Int
		SetSliderOptionValue(userAddingHugPointPcOID, SLApproachMain.userAddingHugPointPc)
	elseif (option == userAddingHugPointNpcOID)
		SLApproachMain.userAddingHugPointNpc = value as Int
		SetSliderOptionValue(userAddingHugPointNpcOID, SLApproachMain.userAddingHugPointNpc)
		
	elseif (option == userAddingKissPointPcOID)
		SLApproachMain.userAddingKissPointPc = value as Int
		SetSliderOptionValue(userAddingKissPointPcOID, SLApproachMain.userAddingKissPointPc)
	elseif (option == userAddingKissPointNpcOID)
		SLApproachMain.userAddingKissPointNpc = value as Int
		SetSliderOptionValue(userAddingKissPointNpcOID, SLApproachMain.userAddingKissPointNpc)
		
	elseif (option == lowestArousalPCOID)
		SLApproachMain.lowestArousalPC = value as Int
		SetSliderOptionValue(lowestArousalPCOID, SLApproachMain.lowestArousalPC)
	elseif (option == lowestArousalNPCOID)
		SLApproachMain.lowestArousalNPC = value as Int
		SetSliderOptionValue(lowestArousalNPCOID, SLApproachMain.lowestArousalNPC)

	elseif (option == dialogueArousalOID)
		SLApproachDialogArousal.SetValue(value as Int)
		SetSliderOptionValue(dialogueArousalOID, SLApproachDialogArousal.GetValue())
	elseif (option == multiplayPercentOID)
		SLApproachMultiplayPercent.SetValue(value as Int)
		SetSliderOptionValue(multiplayPercentOID, SLApproachMultiplayPercent.GetValue())

	endif
endevent

GlobalVariable Property SLApproachDialogArousal auto
GlobalVariable Property SLApproachMultiplayPercent  Auto  
