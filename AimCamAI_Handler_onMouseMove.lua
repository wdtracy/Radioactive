--------------------------------------------------------------------------------
--  Handler.......... : onMouseMove
--  Author........... : Wade Tracy
--  Description...... : Event handler for when the mouse moves.  Handles aiming
--                      and moving of the objects in the level.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onMouseMove ( nPointX, nPointY, nDeltaX, nDeltaY, 
                                nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------

    -- If we are currently moving an object...
    if( this.bMovingObject ( ) ) then
        object.sendEvent ( this.hMovingObject ( ), "MovableAI", "onMouseMove", nPointX, nPointY,
                           nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
    else
        -- Change to aiming
        if( this.aiming ( ) ) then
            -- Use localspace for the X axis rotation
            object.rotate ( this.hAimCam (), nDeltaY * 60, 0, 0, object.kLocalSpace )
            object.rotate ( this.hAimCam ( ), 0, -nDeltaX * 60, 0, object.kGlobalSpace )
        end
        
        -- Only center the mouse if not in edit mode
        if( not this.editing (  ) ) then
            if( nPointX ~= 0 or
                nPointY ~= 0 ) then
                this.centerMouse ( )
            end
        end
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
