--------------------------------------------------------------------------------
--  Handler.......... : onEnterFrame
--  Author........... : Wade Tracy
--  Description...... : Adjusts the braking applied to the ball.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function BallAI.onEnterFrame (  )
--------------------------------------------------------------------------------
	
	if( not dynamics.isIdle ( this.hBall ( ) ) ) then
    
        -- Calculate speed of the ball
        local vX, vY, vZ = dynamics.getLinearVelocity ( this.hBall ( ), object.kGlobalSpace )
        this.nSpeed ( math.vectorLength ( vX, vY, vZ ) )
        
        -- As the ball looses speed the physics get a little erratic so the camera jerks around.
        -- This disables the chase functionality while maintaining the targeting
        if( this.nSpeed ( ) < this.nLowSpeedThreshold ( ) ) then
            -- If we are slowing down, add damping to break the motion and end the turn
            dynamics.setLinearDamping ( this.hBall ( ), this.nBraking ( ) )
        end
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
