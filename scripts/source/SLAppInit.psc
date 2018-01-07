Scriptname SLAppInit extends Quest  

Event OnInit()
	Actor player = Game.GetPlayer()
	if (!player.HasSpell(SLApproachToggle))
		player.AddSpell(SLApproachToggle)
	endif
	self.Stop()
EndEvent 

SPELL Property SLApproachToggle  Auto  
