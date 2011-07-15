--------------------------------------------------------------------------------
--  Handler.......... : onSensorCollision
--  Author........... : Wade Tracy
--  Description...... : Detects a collision on the gas switch and shuts off the
--                      associated fire
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function GasSwitchAI.onSensorCollision ( nSensorID, hTargetObject, nTargetSensorID )
--------------------------------------------------------------------------------
	
    -- Turns off the fire but allows the particles to die out naturally
	sfx.pauseAllParticleEmitters ( this.hFire ( ) )
    sensor.setAllActive ( this.hFire ( ), false )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
