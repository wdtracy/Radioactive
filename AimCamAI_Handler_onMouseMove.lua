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
   
    if( this.editing ( ) ) then
        -- If we are currently moving an object...
        if( this.bMovingObject ( ) ) then
            object.sendEvent ( this.hMovingObject ( ), "MovableAI", "onMouseMove", nPointX, nPointY,
                               nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
    --    
        elseif( this.bRotatingObject ( ) ) then
            object.sendEvent ( this.hSelectedObject ( ), "MovableAI", "onRotateObject", nPointX, nPointY,
                               nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
        end
    --
    -- Not in edit mode
    else
        -- We are aiming
        if( this.aiming ( ) ) then
            -- Rotate camera with mouse move
            -- Use localspace for the X axis rotation
            object.rotate ( this.hAimCam (), nDeltaY * this.nRotationSensitivity ( ),
                            0, 0, object.kLocalSpace )
            object.rotate ( this.hAimCam ( ), 0, -nDeltaX * this.nRotationSensitivity ( ),
                            0, object.kGlobalSpace )
        end
        
        -- Center the cursor
        if( nPointX ~= 0 or
            nPointY ~= 0 ) then
            this.centerMouse ( )
        end
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
