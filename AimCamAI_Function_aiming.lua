--------------------------------------------------------------------------------
--  Function......... : aiming
--  Author........... : Wade Tracy
--  Description...... : Returns true if the player is in "aiming" mode
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.aiming ( )
--------------------------------------------------------------------------------
	
    -- Return true if we are not in overhead view and the ball is not in play,
    -- ie. we are aiming.
	if( not this.bOverhead ( ) and not this.ballInPlay ( ) ) then
        return true
    else
        return false
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
