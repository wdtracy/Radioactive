--------------------------------------------------------------------------------
--  Handler.......... : onInit
--  Author........... : Wade Tracy
--  Description...... : Event handler for our Main AI.  Loads the level and sets
--                      the camera, etc.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.onInit (  )
--------------------------------------------------------------------------------
	
    -- Load the first level
	if( application.setCurrentUserScene ( "Level1" ) ~= nil ) then
    
        -- Set the HUD and initial settings
        local hUser = application.getCurrentUser ( )
        if( hUser ~= nil ) then
            hud.newTemplateInstance ( hUser, "MainHUD", "hud" )
            hud.setCursorVisible ( hUser, false )
            hud.setCursorPosition ( hUser, 50, 50 )
        else
            log.error ( "Unable to access the current user" )
        end
        
        -- Set the active camera to the aiming camera
        this.hAimCam ( application.getCurrentUserSceneTaggedObject ( "AimCam" ) )
        if( this.hAimCam ( ) ~= nil ) then
            application.setCurrentUserActiveCamera ( this.hAimCam ( ) )
        else
            log.error ( "Unable to access the Aim Cam" )
        end
        
        -- Disable the dynamics so the ball does not fall to the ground immediately
        local hBall = application.getCurrentUserSceneTaggedObject ( "Ball" )
        if( hBall ~= nil ) then
            dynamics.enableDynamics ( hBall, false )
        else
            log.error ( "Can't access the ball object." )
        end
        
        -- Load the XML file -- Will need to revisit because there are several ways
        -- to load the XML depending on the platform.
        --this.GetXML ( )
    else
        log.error ( "Unable to load the scene" )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
