Scriptname SLApproachPlayerAliasScript extends ReferenceAlias  

SLApproachMainScript Property SLApproachMain Auto
Spell Property CloakAbility Auto
Actor player

Event OnPlayerLoadGame()
	SLApproachMain.Maintenance()
	UnregisterForUpdate()
	player = Game.GetPlayer()
	RegisterForSingleUpdate(1)
EndEvent

Event OnInit()
	player = Game.GetPlayer()
	RegisterForSingleUpdate(1)
EndEvent

Event OnUpdate()
	if (!SLApproachMain.isSkipUpdateMode)
		int tooSlowBySeconds = 0
		while (SLApproachMain.actorsEffectStarted > SLApproachMain.actorsEffectFinished)
			tooSlowBySeconds = tooSlowBySeconds  + 3
			;debug.notification("SexLab Approach: started: " + SLApproachMain.actorsEffectStarted + " finished: "+ SLApproachMain.actorsEffectFinished)
			Utility.Wait(1.0)
		endwhile
		
		if (tooSlowBySeconds > 0)
			debug.trace("Sexlab Approach: Papyrus too slow for cloak frequency setting by " + tooSlowBySeconds  + " seconds.")
		endif
		
		if (Game.IsActivateControlsEnabled() && Game.IsFightingControlsEnabled() && Game.IsMovementControlsEnabled() && Game.IsSneakingControlsEnabled())
			SLApproachMain.actorsEffectStarted = 0
			SLApproachMain.actorsEffectFinished = 0
			;Debug.Notification("SexLab Approach: Cloak!")
			SLApproachMain.isDuringCloakPulse = true
			SLApproachMain.actorAmountAware = 0
			player.AddSpell(CloakAbility, false)
			player.RemoveSpell(CloakAbility)
			SLApproachMain.isDuringCloakPulse = false
		endif
	endif
	
	RegisterForSingleUpdate(SLApproachMain.cloakFrequency)
EndEvent