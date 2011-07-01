--------------------------------------------------------------------------------
--  Handler.......... : onEnterFrame
--  Author........... : Wade Tracy
--  Description...... : Frame event handler that moves the Chase camera to
--                      follow the target object.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function ChaseCamAI.onEnterFrame (  )
--------------------------------------------------------------------------------
    
    -- Code for the ChaseCam when the ball is in motion
	if( not dynamics.isIdle ( this.hTarget ( ) ) ) then
    
        -- By getting the average time frame, we can make sure that time dependent functions
        -- scale to the different frame rates on devices.
        local dt = application.getAverageFrameTime ( )

        -- Get the target location, velocity, and speed
        local targetX, targetY, targetZ = object.getTranslation ( this.hTarget ( ), object.kGlobalSpace )
        local vX, vY, vZ = dynamics.getLinearVelocity ( this.hTarget ( ), object.kGlobalSpace )
        local speed = object.getAIVariable ( this.hTarget ( ), "BallAI", "nSpeed" )
        
        -- Normalize the vector to get just direction and scale by the chase distance
        vX, vY, vZ = math.vectorNormalize ( vX, vY, vZ )
        vX, vY, vZ = math.vectorScale ( vX, vY, vZ, this.nChaseDistance ( ) )
        
        -- Add the vector to the original location so we get a point behind the ball
        local x,y,z = math.vectorAdd ( targetX, targetY, targetZ, vX, vY, vZ )
        
        -- As the ball looses speed the physics get a little erratic so the camera jerks around.
        -- This disables the chase functionality while maintaining the targeting
        if( speed > this.nLowSpeedThreshold ( ) ) then
        
            -- Move the camera to the new location and look at the ball.
            object.translateTo ( this.hChaseCam ( ), x, this.nChaseCamElevation ( ), z, 
                                 object.kGlobalSpace, this.nFollowFactor ( ) * dt )
        end
        
        -- After positioning the camera, its time to make sure we are looking at the ball.
        object.lookAt ( this.hChaseCam ( ), targetX, targetY, targetZ, object.kGlobalSpace,
                        this.nLookFactor ( ) * dt )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
