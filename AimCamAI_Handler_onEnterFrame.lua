--------------------------------------------------------------------------------
--  Handler.......... : onEnterFrame
--  Author........... : Wade Tracy
--  Description...... : Handler for each frame.  Checks to see if the turn has
--                      ended and resets for the next turn.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onEnterFrame (  )
--------------------------------------------------------------------------------

    -- Check for the end of the turn
	if( this.turnEnds ( ) ) then
        object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onTurnEnds" )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
