--------------------------------------------------------------------------------
--  Function......... : turnEnds
--  Author........... : Wade Tracy
--  Description...... : Determines whether the ball has come to rest and the
--                      turn has ended
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.turnEnds ( )
--------------------------------------------------------------------------------
	
    -- if the ball is idle and is still in play, return true
	if( dynamics.isIdle ( this.hBall ( ) ) and this.ballInPlay ( ) ) then
        return true
    else
        return false
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
