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
