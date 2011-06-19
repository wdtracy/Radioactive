--------------------------------------------------------------------------------
--  Function......... : aiming
--  Author........... : Wade Tracy
--  Description...... : Returns true if the player is in "aiming" mode
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.aiming ( )
--------------------------------------------------------------------------------
	
    -- Return true if we are not in overhead view and the ball is not in play,
    -- ie. we are aiming.
	if( not this.bOverhead ( ) and not this.ballInPlay ( ) ) then
        return true
    else
        return false
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Function......... : centerMouse
--  Author........... : Wade Tracy
--  Description...... : Returns the cursor to the center of the screen.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.centerMouse ( )
--------------------------------------------------------------------------------
	
	local hUser = application.getCurrentUser ( )
    
    -- Screen coords are in percents when dealing with the HUD.
	hud.setCursorPosition ( hUser, 50, 50 )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--  Function......... : editing
--  Author........... : Wade Tracy
--  Description...... : Returns true if we are in editing mode.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.editing ( )
--------------------------------------------------------------------------------
	
    -- Returns true when we are in overhead mode and the ball is not in play.
    -- This is when we are able to move objects around the screen.
	if( this.bOverhead ( ) and not this.ballInPlay ( ) ) then
        return true
    else
        return false
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Function......... : setCrosshairVisibility
--  Author........... : Wade Tracy
--  Description...... : Sets the crosshair visibility based on "visible"
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.setCrosshairVisibility ( visible )
--------------------------------------------------------------------------------
	
	local hUser = application.getCurrentUser ( )
    local hCrosshairs = hud.getComponent ( hUser, "hud.Crosshair" )
    hud.setComponentVisible ( hCrosshairs, visible )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Function......... : setCursorVisibility
--  Author........... : Wade Tracy
--  Description...... : Set the visibility of the cursor based on "visibility"
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.setCursorVisibility ( visibility )
--------------------------------------------------------------------------------
	
	local hUser = application.getCurrentUser ( )
    hud.setCursorVisible ( hUser, visibility )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--  Function......... : turnEnds
--  Author........... : Wade Tracy
--  Description...... : Determines whether the ball has come to rest and the
--                      turn has ended
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.turnEnds ( )
--------------------------------------------------------------------------------
	
    -- if the ball is idle and is still in play, return true
	if( dynamics.isIdle ( this.hBall ( ) ) and this.ballInPlay ( ) ) then
        return true
    else
        return false
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--  Handler.......... : onInit
--  Author........... : Wade Tracy
--  Description...... : Initialization code for the Aim Cam AI.  Get references
--                      to objects.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onInit (  )
--------------------------------------------------------------------------------
	
	this.hBall ( application.getCurrentUserSceneTaggedObject ( "Ball" ) )
    this.hAimCam ( this.getObject ( ) )
    this.hChaseCam ( application.getCurrentUserSceneTaggedObject ( "ChaseCam" ) )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  Handler.......... : onEnterFrame
--  Author........... : Wade Tracy
--  Description...... : Handler for each frame.  Checks to see if the turn has
--                      ended and resets for the next turn.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onEnterFrame (  )
--------------------------------------------------------------------------------
    
    -- Check for the end of the turn
	if( this.turnEnds ( ) ) then
        this.ballInPlay ( false )
        
        -- Reset dynamics since they were adjusted as the ball slowed
        dynamics.setLinearDamping ( this.hBall ( ), this.nDefLinearDamping ( ) )
        dynamics.enableDynamics ( this.hBall ( ), false )
        
        -- Move the Chase cam and the ball back to the begining
        object.translateTo ( this.hBall ( ), this.nStartX ( ), this.nStartY ( ),
                             this.nStartZ ( ), object.kGlobalSpace, 1 )
        object.translateTo ( this.hChaseCam ( ), this.nStartX ( ), this.nStartY ( ), 
                             this.nStartZ ( ), object.kGlobalSpace, 1 )
        object.lookAt ( this.hChaseCam ( ), this.nStartX ( ), this.nStartY ( ), 
                        this.nStartZ ( ), object.kGlobalSpace, 1 )
        
        -- Change the camera and the cursor visibility based on whether it is in
        -- overhead mode
        if( not this.bOverhead ( ) ) then
            application.setCurrentUserActiveCamera ( this.hAimCam ( ) )
            this.setCrosshairVisibility ( true )
        else
			local hUser = application.getCurrentUser ( )
            hud.setCursorVisible ( hUser, true )
        end
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------




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
        -- Boolean flag to see if a movable object has been clicked
        local bMovable = false
        local hHitObject, nHitDist, nHitSurfaceID, x,y,z
        
        -- Only do these checks in edit mode
        if( this.editing (  ) ) then
            local hScene = application.getCurrentUserScene ( )
            hHitObject, nHitDist, nHitSurfaceID, x, y, z = 
                scene.getFirstHitColliderEx ( hScene, nRayPntX, nRayPntY, nRayPntZ,
                                              nRayDirX, nRayDirY, nRayDirZ, this.nRayLength ( ) )
            -- If there's a hit
            if( hHitObject ~= nil ) then
                local sAI = object.getAIModelNameAt ( hHitObject, this.nMovableIndex ( ) )
                if( sAI ~= nil ) then
                    -- Get whether the object is movable
                    bMovable = object.getAIVariable ( hHitObject, sAI, "bMovable" )
                end
            end
        end
        
        -- if the object is movable set the handle and flag
        if( bMovable ) then
            this.hMovingObject ( hHitObject )
            
            -- We are now moving an object
            this.bMovingObject ( true )
            
            -- Get the position of the object and subtract the actual cursor location on the object.
			-- This offset will be used to keep the object from making an initial jump to the cursor location.
            local originX, originY, originZ = object.getTranslation ( this.hMovingObject ( ), object.kGlobalSpace )
            object.setAIVariable ( this.hMovingObject ( ), "MovableAI", "nXOffset", x - originX )
            object.setAIVariable ( this.hMovingObject ( ), "MovableAI", "nZOffset", z - originZ )
            
        -- If the object is not movable or there was no object - launch the ball
        else
            -- Set the play flag and enable the dynamics so the ball can move
            this.ballInPlay ( true )
            dynamics.enableDynamics ( this.hBall ( ), true )
            
            -- Match the chase cam and ball to the aim cam rotation so they go in
            -- the aimed direction.
            object.matchRotation ( this.hBall ( ), this.hAimCam ( ), object.kGlobalSpace )
            object.matchRotation ( this.hChaseCam ( ), this.hAimCam ( ), object.kGlobalSpace )
            
            -- Launch the ball
            dynamics.addLinearImpulse ( this.hBall ( ), 0, 0, -this.nImpulse ( ), object.kLocalSpace )
            
            this.setCrosshairVisibility ( false )
            this.setCursorVisibility ( false )
            
            -- Only switch to the chase camera if we are not in overhead mode.
            if( not this.bOverhead ( ) ) then
                application.setCurrentUserActiveCamera ( this.hChaseCam ( ) )
            end
        end
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------





--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonUp
--  Author........... : Wade Tracy
--  Description...... : The mouse button up event handler.  Ends moving objects.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onMouseButtonUp ( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
    -- End moving the object.
	if( this.bMovingObject ( ) ) then
        this.hMovingObject ( nil )
        this.bMovingObject ( false )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------



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
