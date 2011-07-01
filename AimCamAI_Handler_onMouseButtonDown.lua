--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonDown
--  Author........... : Wade Tracy
--  Description...... : Mouse button down code.  Handles firing the ball and 
--                      functionality in "edit" mode.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onMouseButtonDown ( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
    
    local dt = application.getAverageFrameTime ( )
    
    -- Only register clicks when the ball is not in play
	if( not this.ballInPlay ( ) ) then
        
        -- whether we have clicked on a movable object
        local bMoving = this.checkMovingObject ( nRayPntX, nRayPntY, nRayPntZ, 
                                                 nRayDirX, nRayDirY, nRayDirZ )
        -- If we aren't in edit mode and didn't click on a movable object launch the ball
        if( not (this.editing () and bMoving) ) then
        
            this.launchBall ( )
            
            -- Hide the cursor and crosshairs
            this.setCrosshairVisibility ( false )
            this.setCursorVisibility ( false )
            
            -- Only switch to the chase camera if we are not in overhead mode.
            if( not this.bOverhead ( ) ) then
                application.setCurrentUserActiveCamera ( this.hChaseCam ( ) )
            else
                -- Move the ceiling back into place for the ball launch
                object.setTranslation ( this.hCeiling ( ), 0, this.nCeilingAdjustment ( ),
                                        0, object.kLocalSpace )
            end
        end
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
