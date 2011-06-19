--------------------------------------------------------------------------------
--  Function......... : setCrosshairVisibility
--  Author........... : Wade Tracy
--  Description...... : Sets the crosshair visibility based on "visible"
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.setCrosshairVisibility ( visible )
--------------------------------------------------------------------------------
	
	local hUser = application.getCurrentUser ( )
    local hCrosshairs = hud.getComponent ( hUser, "hud.Crosshair" )
    hud.setComponentVisible ( hCrosshairs, visible )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
