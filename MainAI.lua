--------------------------------------------------------------------------------
--  Function......... : ParseXML
--  Author........... : Wade Tracy
--  Description...... : Function that parses the XML settings file and sets the
--                      variables within the given AI.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.ParseXML ( )
--------------------------------------------------------------------------------
	
    -- Set up our references to our root node.
    local xRoot = xml.getRootElement ( this.hConfig ( ) )
    
    -- Get the element and the value and assign it to the game variable
    local xElement = xml.getElementFirstChildWithName ( xRoot, "BallImpulse" )
    local nImpulse = xml.getElementValue ( xElement )
    object.setAIVariable ( this.hAimCam ( ), "AimCamAI", "nImpulse", nImpulse )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  State............ : GetXML
--  Author........... : Wade Tracy
--  Description...... : Attempts to load the XML settings file
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.GetXML_onEnter ( )
--------------------------------------------------------------------------------
	
    -- Currently only configured for pulling over the internet.  This should be
    -- reconfigured for different platforms.
	xml.receive ( this.hConfig ( ), "http://yourgraphicresource.com/subspace/config.xml" )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--  State............ : GetXML
--  Author........... : Wade Tracy
--  Description...... : Loop to load the XML file
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.GetXML_onLoop ( )
--------------------------------------------------------------------------------
	
	local nXMLStatus = xml.getReceiveStatus ( this.hConfig ( ) )
    if ( nXMLStatus == -3 )
    then
        log.warning ( "XML parse failed." )

        --Leave GetXML state for another state
        this.Idle ( )

    elseif ( nXMLStatus == -2 )
    then
        log.warning ( "XML not found." )

        --Leave GetXML state for another state
        this.Idle ( )

    elseif ( nXMLStatus == 1 )
    then
        log.message ( "XML completed." )
        log.message (  xml.toString ( xml.getRootElement ( this.hConfig ( ) ) )  )

        --Process XML
        this.ParseXML ( )

        --Leave GetXML state for another state
        this.Idle ( )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



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
        this.GetXML ( )
    else
        log.error ( "Unable to load the scene" )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyDown
--  Author........... : Wade Tracy
--  Description...... : Keyboard controls
--                      F3 - Reset key
--                      ESC - Quit key
--                      C - toggle camera views
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.onKeyboardKeyDown ( kKeyCode )
--------------------------------------------------------------------------------
	
	if(kKeyCode == input.kKeyEscape) then
        application.quit ( )
    elseif(kKeyCode == input.kKeyF3) then
        application.restart ( )
    elseif(kKeyCode == input.kKeyC) then
        object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onToggleCamera" )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonDown
--  Author........... : Wade Tracy
--  Description...... : Sends mouse button down event to the Aim Cam AI
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.onMouseButtonDown ( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
    
	object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onMouseButtonDown", nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonUp
--  Author........... : Wade Tracy
--  Description...... : Sends mouse button up event to the Aim Cam AI
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.onMouseButtonUp ( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
	object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onMouseButtonUp", nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Handler.......... : onMouseMove
--  Author........... : Wade Tracy
--  Description...... : Sends mouse move event to the Aim Cam AI
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.onMouseMove ( nPointX, nPointY, nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
	object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onMouseMove", nPointX, nPointY, nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
