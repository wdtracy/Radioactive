--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonDown
--  Author........... : Wade Tracy
--  Description...... : Sends mouse button down event to the Aim Cam AI
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.onMouseButtonDown ( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
    
    local hScene = application.getCurrentUserScene ( )
	object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onMouseButtonDown", nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
    log.message ( "dyn: " .. scene.getDynamicsTimeStep ( hScene ) )
    log.message ( "per step: " .. scene.getDynamicsIterationsPerStep ( hScene ) )
    log.message ( "dt: " .. application.getAverageFrameTime ( ) )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
