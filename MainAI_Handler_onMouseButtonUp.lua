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
