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
        sfx.pauseAllTrails ( application.getCurrentUserSceneTaggedObject ( "BallHelper" ) )
        
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
