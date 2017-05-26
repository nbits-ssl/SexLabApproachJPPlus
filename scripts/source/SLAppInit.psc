Scriptname SLAppInit extends Quest  

Event oninit()
	Actor player = game.getplayer()
	if (!player.hasspell(SLApproachToggle))
		player.addspell(SLApproachToggle)
	endif
	self.stop()
EndEvent 

SPELL Property SLApproachToggle  Auto  
