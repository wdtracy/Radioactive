--------------------------------------------------------------------------------
--  Handler.......... : onSensorCollision
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function TeleporterAI.onSensorCollision ( nSensorID, hTargetObject, nTargetSensorID )
--------------------------------------------------------------------------------
	
	local hScene = application.getCurrentUserScene ( )
    
    if(scene.getObjectTag (hScene, hTargetObject) == "Ball") then
        -- Stop all effects on the ball
        object.sendEvent ( hTargetObject, "BallAI", "onPauseEffects" )
        object.matchTranslation ( hTargetObject, this.hDestination ( ), object.kGlobalSpace )
        object.sendEvent ( hTargetObject, "BallAI", "onStartEffects" )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
