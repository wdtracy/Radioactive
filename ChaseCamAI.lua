--------------------------------------------------------------------------------
--  Handler.......... : onInit
--  Author........... : Wade Tracy
--  Description...... : Initializes the ChaseCamAI. Sets handles to objects.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function ChaseCamAI.onInit (  )
--------------------------------------------------------------------------------
	
	this.hChaseCam ( this.getObject ( ) )
    this.hTarget ( application.getCurrentUserSceneTaggedObject ( "Ball" ) )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--  Handler.......... : onEnterFrame
--  Author........... : Wade Tracy
--  Description...... : Frame event handler that moves the Chase camera to
--                      follow the target object.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function ChaseCamAI.onEnterFrame (  )
--------------------------------------------------------------------------------

    -- By getting the average time frame, we can make sure that time dependent functions
    -- scale to the different frame rates on devices.
    local dt = application.getAverageFrameTime ( )

    -- Get the target location, velocity, and speed
    local targetX, targetY, targetZ = object.getTranslation ( this.hTarget ( ), object.kGlobalSpace )
    local vX, vY, vZ = dynamics.getLinearVelocity ( this.hTarget ( ), object.kGlobalSpace )
    local speed = math.vectorLength ( vX, vY, vZ )
    
    -- Code for the ChaseCam when the ball is in motion
	if( not dynamics.isIdle ( this.hTarget ( ) ) ) then
    
        -- Normalize the vector to get just direction and scale by the chase distance
        vX, vY, vZ = math.vectorNormalize ( vX, vY, vZ )
        vX, vY, vZ = math.vectorScale ( vX, vY, vZ, this.nChaseDistance ( ) )
        
        -- Add the vector to the original location so we get a point behind the ball
        local x,y,z = math.vectorAdd ( targetX, targetY, targetZ, vX, vY, vZ )
        
        -- As the ball looses speed the physics get a little erratic so the camera jerks around.
        -- This disables the chase functionality while maintaining the targeting
        if( speed > 5 ) then
        
            -- Move the camera to the new location and look at the ball.
            object.translateTo ( this.hChaseCam ( ), x, this.nChaseCamElevation ( ), z, 
                                 object.kGlobalSpace, this.nFollowFactor ( ) * dt )
            
        else
        
            -- If we are slowing down, add damping to break the motion and end the turn
            dynamics.setLinearDamping ( this.hTarget ( ), this.nBraking ( ) )
            
        end
        
        -- After positioning the camera, its time to make sure we are looking at the ball.
        object.lookAt ( this.hChaseCam ( ), targetX, targetY, targetZ, object.kGlobalSpace,
                        this.nLookFactor ( ) * dt )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------