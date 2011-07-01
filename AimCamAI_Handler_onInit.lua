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
    this.hCeiling ( application.getCurrentUserSceneTaggedObject ( "Ceiling" ) )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
