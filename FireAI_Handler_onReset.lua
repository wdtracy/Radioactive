--------------------------------------------------------------------------------
--  Handler.......... : onReset
--  Author........... : Wade Tracy
--  Description...... : Reload the particle effects and the sensor.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function FireAI.onReset (  )
--------------------------------------------------------------------------------
	
    sfx.startAllParticleEmitters ( this.hFire ( ) )
    sensor.setAllActive ( this.hFire ( ), true )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------