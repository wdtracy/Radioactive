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
