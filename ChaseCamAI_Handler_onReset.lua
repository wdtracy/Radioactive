--------------------------------------------------------------------------------
--  Handler.......... : onReset
--  Author........... : Wade Tracy
--  Description...... : Reset the location and view of the chase camera
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function ChaseCamAI.onReset ( x, y, z )
--------------------------------------------------------------------------------
	
	-- Move the Chase cam and the ball back to the begining
    object.translateTo ( this.hChaseCam ( ), x, y, z, object.kGlobalSpace, 1 )
    object.lookAt ( this.hChaseCam ( ), x, y, z, object.kGlobalSpace, 1 )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
