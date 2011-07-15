--------------------------------------------------------------------------------
--  Handler.......... : onLaunch
--  Author........... : Wade Tracy
--  Description...... : Launches the ball by enabling the dynamics, the poly
--                      trail and adds a force to the ball.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function BallAI.onLaunch ( nImpulse )
--------------------------------------------------------------------------------
	
	-- Enable poly trails and the dynamics so the ball can move
    dynamics.enableDynamics ( this.hBall ( ), true )
    
    -- Launch the ball
    dynamics.addLinearImpulse ( this.hBall ( ), 0, 0, -nImpulse, object.kLocalSpace )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
