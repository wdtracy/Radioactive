--------------------------------------------------------------------------------
--  Handler.......... : onSensorCollision
--  Author........... : Wade Tracy
--  Description...... : Detects when the ball hits the fire and lights the ball
--                      on fire.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function FireAI.onSensorCollision ( nSensorID, hTargetObject, nTargetSensorID )
--------------------------------------------------------------------------------
	
    local hScene = application.getCurrentUserScene ( )
    
	if(scene.getObjectTag (hScene, hTargetObject) == "BallHelper") then
        sfx.startAllParticleEmitters ( hTargetObject )
        object.setAIVariable ( hTargetObject, "BallAI", "bOnFire", true )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
