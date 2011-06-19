--------------------------------------------------------------------------------
--  Function......... : editing
--  Author........... : Wade Tracy
--  Description...... : Returns true if we are in editing mode.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.editing ( )
--------------------------------------------------------------------------------
	
    -- Returns true when we are in overhead mode and the ball is not in play.
    -- This is when we are able to move objects around the screen.
	if( this.bOverhead ( ) and not this.ballInPlay ( ) ) then
        return true
    else
        return false
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
