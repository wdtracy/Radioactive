--------------------------------------------------------------------------------
--  Handler.......... : onMoveSelector
--  Author........... : Wade Tracy
--  Description...... : Moves the Selector hud component to the center of the
--                      selected object (hSelectedObject)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.onMoveSelector ( )
--------------------------------------------------------------------------------
	-- Get handles to the needed objects
    local hUser = application.getCurrentUser ( )
    local hSelector = hud.getComponent ( hUser, "hud.Selector" )
    
    if(this.hSelectedObject ( )) then
        
        -- Get the center of the selected object
        local x,y,z = object.getTranslation ( this.hSelectedObject(), object.kGlobalSpace )
        
        -- Find the center of the selected object on the camera view plane
        local newX,newY = camera.projectPoint ( this.hOverhead ( ), x,y,z )
        
        -- Convert the projected point to HUD coordinates, move the Selector and make
        -- it visible.
        newX,newY = this.convertHudCoords ( newX, newY )
        hud.setComponentPosition ( hSelector, newX, newY )
        
        -- new - Position selector button based on current selector rotation.
        local hSelectorButton = hud.getComponent ( hUser, "hud.SelectorButton" )
        local rX, rY, rZ = object.getRotation ( this.hSelectedObject ( ), object.kGlobalSpace )
        local sX, sY = hud.getComponentPosition ( hSelector )
        local bX = math.cos ( rY ) * this.nSelectorButtonOffset ( ) + sX
        -- must adjust for aspect ratio to rotate in a circle.
        local bY = math.sin ( rY ) * this.nSelectorButtonOffset ( ) * 
                    application.getCurrentUserViewportAspectRatio ( ) + sY
        
        hud.setComponentPosition ( hSelectorButton, bX, bY )
        hud.setComponentVisible ( hSelector, true )
    else
        hud.setComponentVisible ( hSelector, false )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------