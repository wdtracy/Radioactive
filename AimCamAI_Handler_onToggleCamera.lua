--------------------------------------------------------------------------------
--  Handler.......... : onToggleCamera
--  Author........... : Wade Tracy
--  Description...... : Event handler for when the camera is toggled from Chase
--                      to Overhead and vice versa.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onToggleCamera (  )
--------------------------------------------------------------------------------
    
    local hCurrentCam
    local hUser = application.getCurrentUser ( )
    
    -- If we are in overhead mode, switch to Chase or Aim cam
	if( this.bOverhead ( ) ) then
        if( this.ballInPlay ( ) ) then
            hCurrentCam = application.getCurrentUserSceneTaggedObject ( "ChaseCam" )
        else
            -- Ball is not in play so show the crosshairs and move the ceiling back
            hCurrentCam = application.getCurrentUserSceneTaggedObject ( "AimCam" )
            this.setCrosshairVisibility ( true )
            object.setTranslation ( this.hCeiling ( ), 0, this.nCeilingAdjustment ( ),
                                    0, object.kLocalSpace )
        end
        
        -- Show the ceiling if not in overhead mode
        local hCeiling = application.getCurrentUserSceneTaggedObject ( "Ceiling" )
        object.setVisible ( hCeiling, true )
        
        this.centerMouse ( )
        this.setCursorVisibility ( false )
        this.bOverhead ( false )
        
        -- Hide the selector and de-select the object.
        local hSelector = hud.getComponent ( hUser, "hud.Selector" )
        hud.setComponentVisible ( hSelector, false )
        this.hSelectedObject ( nil )
        
    -- If in chase or aim cam, switch to Overhead
    else
        -- Store the overhead cam
        hCurrentCam = application.getCurrentUserSceneTaggedObject ( "OverheadCam" )
        
        -- Hide the ceiling in overhead mode
        local hCeiling = application.getCurrentUserSceneTaggedObject ( "Ceiling" )
        object.setVisible ( hCeiling, false )
        
        this.setCrosshairVisibility ( false )
        this.bOverhead ( true )
        
        -- We are in editing mode so show cursor and get the ceiling out of the way
        if( this.editing ( ) ) then
            this.setCursorVisibility ( true )
            object.setTranslation ( this.hCeiling ( ), 0, -this.nCeilingAdjustment ( ),
                                    0, object.kLocalSpace )
        end
    end
    
    -- Set the camera
    application.setCurrentUserActiveCamera ( hCurrentCam )
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
