--------------------------------------------------------------------------------
--  Handler.......... : onTurnEnds
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onTurnEnds (  )
--------------------------------------------------------------------------------
	
    this.ballInPlay ( false )
    
	-- Reset the ball
    object.sendEvent ( this.hBall ( ), "BallAI", "onReset", this.nStartX ( ),
                       this.nStartY ( ), this.nStartZ ( ) )
    
    -- Reset the fire
    local hFire = application.getCurrentUserSceneTaggedObject ( "FireHelper" )
    object.sendEvent ( hFire, "FireAI", "onReset" )
    
    -- Reset the chase cam
    object.sendEvent ( this.hChaseCam ( ), "ChaseCamAI", "onReset", this.nStartX ( ),
                       this.nStartY ( ), this.nStartZ ( ) )
    
    -- Change the camera, the cursor visibility, and the location of the ceiling
    -- based on whether it is in overhead mode
    if( not this.bOverhead ( ) ) then
        application.setCurrentUserActiveCamera ( this.hAimCam ( ) )
        this.setCrosshairVisibility ( true )
    else
        -- Set us up for editing by showing the cursor and moving the ceiling
        local hUser = application.getCurrentUser ( )
        hud.setCursorVisible ( hUser, true )
        object.setTranslation ( this.hCeiling ( ), 0, -this.nCeilingAdjustment ( ),
                                0, object.kLocalSpace)
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
