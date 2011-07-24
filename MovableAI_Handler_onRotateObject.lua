--------------------------------------------------------------------------------
--  Handler.......... : onRotateObject
--  Author........... : Wade Tracy
--  Description...... : Code for rotating the object around the Y axis.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MovableAI.onRotateObject ( nPointX, nPointY, nDeltaX, nDeltaY, 
                                 nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
    local hUser = application.getCurrentUser ( )
    
    -- get the selector and its position
    local hSelector = hud.getComponent ( hUser, "hud.Selector" )
    local cX, cY = hud.getComponentPosition ( hSelector )
    
    -- Convert the cursor position to HUD coords.
    nPointX, nPointY = this.convertHudCoords ( nPointX, nPointY )
    
    -- Calculate the x and y distances from the center of the selector to the current
    -- mouse cursor position - use this to calculate the angle of rotation.
    local nOpposite = nPointY - cY
    local nAdjacent = nPointX - cX
    local nRotation = math.atan ( nOpposite / nAdjacent )
    
    -- Tangent has a problem determining a proper angle. atan will always return angles on the
    -- right of the y axis - check if x is negative and and 180.
    if(nAdjacent < 0) then
        nRotation = nRotation + 180
    end

    -- Rotate the selected object and the selector - seems the HUD rotations are reversed.
    object.rotateTo ( this.hObject ( ), 0, nRotation, 0, object.kGlobalSpace, 1 )
    hud.setComponentRotation ( hSelector, -nRotation )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
