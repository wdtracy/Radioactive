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
