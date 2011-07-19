--------------------------------------------------------------------------------
--  Function......... : mouseOverComponent
--  Author........... : Wade Tracy
--  Description...... : Checks to see if the cursor is over the specified
--                      component.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.mouseOverComponent ( hComponent )
--------------------------------------------------------------------------------
	
    -- Get the upper left and bottom right corners of the component.
	local x1, y1 = hud.getComponentScreenSpaceTopLeftCorner ( hComponent )
    local x2, y2 = hud.getComponentScreenSpaceBottomRightCorner ( hComponent )
    
    -- Get the cursor position
    local hUser = application.getCurrentUser ( )
    local cursorX, cursorY = hud.getCursorPosition ( hUser )
    
    -- Check if the cursor is over the component.
    if(cursorX > x1 and cursorX < x2 and cursorY < y1 and cursorY > y2) then
        return true
    else
        return false
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
