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
    
    -- If we are in overhead mode, switch to Chase or Aim cam
	if( this.bOverhead ( ) ) then
        if( this.ballInPlay ( ) ) then
            hCurrentCam = application.getCurrentUserSceneTaggedObject ( "ChaseCam" )
        else
            hCurrentCam = application.getCurrentUserSceneTaggedObject ( "AimCam" )
            this.setCrosshairVisibility ( true )
        end
        
        this.centerMouse ( )
        this.setCursorVisibility ( false )
        this.bOverhead ( false )
    -- If in chase or aim cam, switch to Overhead
    else
        -- Store the overhead cam
        hCurrentCam = application.getCurrentUserSceneTaggedObject ( "OverheadCam" )
        
        this.setCrosshairVisibility ( false )
        this.bOverhead ( true )
        
        if( this.editing ( ) ) then
            this.setCursorVisibility ( true )
        end
    end
    
    -- Set the camera
    application.setCurrentUserActiveCamera ( hCurrentCam )
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
