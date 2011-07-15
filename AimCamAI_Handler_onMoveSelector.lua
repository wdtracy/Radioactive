--------------------------------------------------------------------------------
--  Handler.......... : onMoveSelector
--  Author........... : Wade Tracy
--  Description...... : Moves the Selector hud component to the center of the
--                      selected object (hSelectedObject)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onMoveSelector ( hSelectedObject )
--------------------------------------------------------------------------------
	
    -- Get handles to the needed objects
    local hUser = application.getCurrentUser ( )
    local hSelector = hud.getComponent ( hUser, "hud.Selector" )
    
    -- Get the center of the selected object
	local x,y,z = object.getBoundingSphereCenter ( hSelectedObject )
    
    -- Find the center of the selected object on the camera view plane
    local newX,newY = camera.projectPoint ( this.hOverhead ( ), x,y,z )
    
    -- Convert the projected point to HUD coordinates, move the Selector and make
    -- it visible.
    newX,newY = this.convertHudCoords ( newX, newY )
    hud.setComponentPosition ( hSelector, newX, newY )
    hud.setComponentVisible ( hSelector, true )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------