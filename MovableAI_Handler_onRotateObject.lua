--------------------------------------------------------------------------------
--  Handler.......... : onRotateObject
--  Author........... : Wade Tracy
--  Description...... : Code for rotating the object around the Y axis.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MovableAI.onRotateObject ( nPointX, nPointY, nDeltaX, nDeltaY, 
                                 nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
    local dt = application.getAverageFrameTime ( )
    
	local objectX, objectY, objectZ = object.getBoundingSphereCenter ( this.hObject ( ) )
    
    -- Calculate rotation vector
    -- Rotate object
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
