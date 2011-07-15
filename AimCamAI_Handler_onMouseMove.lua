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
    -- added these variables
    local hScene = application.getCurrentUserScene ( )
    local hUser = application.getCurrentUser ( )
   
    if( this.editing ( ) ) then
        -- If we are currently moving an object...
        if( this.bMovingObject ( ) ) then
            object.sendEvent ( this.hMovingObject ( ), "MovableAI", "onMouseMove", nPointX, nPointY,
                               nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
        -- added this entire else block
        else
            -- See what is under the cursor
            local hHitObject = scene.getFirstHitCollider ( hScene, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ, 100 )
            local bMovable
            
            -- if we have a valid object, 
            if( hHitObject ~= nil ) then
                local sAI = object.getAIModelNameAt ( hHitObject, 0 )
                if( sAI ~= nil ) then
                    bMovable = object.getAIVariable ( hHitObject, sAI, "bMovable" )
                end
            end
            if( bMovable ) then
                object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onMoveSelector", hHitObject )
            end
        end
    else
        if( this.aiming ( ) ) then
            -- Use localspace for the X axis rotation
            object.rotate ( this.hAimCam (), nDeltaY * this.nRotationSensitivity ( ),
                            0, 0, object.kLocalSpace )
            object.rotate ( this.hAimCam ( ), 0, -nDeltaX * this.nRotationSensitivity ( ),
                            0, object.kGlobalSpace )
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
