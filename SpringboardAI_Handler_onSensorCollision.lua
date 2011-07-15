--------------------------------------------------------------------------------
--  Handler.......... : onSensorCollision
--  Author........... : Wade Tracy
--  Description...... : Detects a collision with the ball and adds a force to it
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SpringboardAI.onSensorCollision ( nSensorID, hTargetObject, nTargetSensorID )
--------------------------------------------------------------------------------
	
    local hScene = application.getCurrentUserScene ( )
    
    -- Check that the collision was from the ball
    if(scene.getObjectTag ( hScene, hTargetObject ) == "Ball") then
    
        -- Get the Y axis of the springboard so we know in what direction the force
        -- should be applied and then scale it up by the bounce factor
        local x,y,z = object.getYAxis ( this.getObject ( ), object.kGlobalSpace )
        x,y,z = math.vectorScale ( x, y, z, this.nBounce ( ) )
        
        dynamics.addLinearImpulse ( hTargetObject, x, y, z, object.kGlobalSpace )
    end
        
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
