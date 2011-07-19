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
    local hUser = application.getCurrentUser ( )
    
    -- Only register clicks when the ball is not in play
	if( not this.ballInPlay ( ) ) then
    --
        local hRotateButton = hud.getComponent ( hUser, "hud.SelectorButton" )
        if((this.hSelectedObject ( ) ~= nil) and this.mouseOverComponent ( hRotateButton )) then
            this.bRotatingObject ( true )
    --
        else
            -- whether we have clicked on a movable object
            local bMoving = this.checkMovingObject ( nRayPntX, nRayPntY, nRayPntZ, 
                                                     nRayDirX, nRayDirY, nRayDirZ )
            -- If we aren't in edit mode and didn't click on a movable object launch the ball
            if( not (this.editing () and bMoving) ) then
            
                this.launchBall ( )
                
                -- Hide the cursor, selector and crosshairs
                this.setCrosshairVisibility ( false )
                this.setCursorVisibility ( false )
                local hSelector = hud.getComponent ( hUser, "hud.Selector" )
                hud.setComponentVisible ( hSelector, false )
                this.hSelectedObject ( nil )
                
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
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
