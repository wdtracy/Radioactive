--------------------------------------------------------------------------------
--  Function......... : launchBall
--  Author........... : Wade Tracy
--  Description...... : Handles launching the ball
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.launchBall ( )
--------------------------------------------------------------------------------
	
	-- Set the play flag
    this.ballInPlay ( true )
    
    -- Match the chase cam and ball to the aim cam rotation so they go in
    -- the aimed direction.
    object.matchRotation ( this.hBall ( ), this.hAimCam ( ), object.kGlobalSpace )
    object.matchRotation ( this.hChaseCam ( ), this.hAimCam ( ), object.kGlobalSpace )
    
    -- Launch the ball
    object.sendEvent ( this.hBall ( ), "BallAI", "onLaunch", this.nImpulse ( ) )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
