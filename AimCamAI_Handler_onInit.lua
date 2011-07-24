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
    this.hOverhead ( application.getCurrentUserSceneTaggedObject ( "OverheadCam" ) )
    
    -- new - Calculate the starting position of the selector button and store it for
    -- later.
    local hUser = application.getCurrentUser ( )
    local hSelector = hud.getComponent ( hUser, "hud.Selector" )
    local hSelectorButton = hud.getComponent ( hUser, "hud.SelectorButton" )
    local sX, sY = hud.getComponentPosition ( hSelector )
    local bX, bY = hud.getComponentPosition ( hSelectorButton )
    this.nSelectorButtonOffset ( math.sqrt ( math.pow((sX - bX), 2) + math.pow((sY - bY), 2) ) )
    
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
