--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyDown
--  Author........... : Wade Tracy
--  Description...... : Keyboard controls
--                      F3 - Reset key
--                      ESC - Quit key
--                      C - toggle camera views
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.onKeyboardKeyDown ( kKeyCode )
--------------------------------------------------------------------------------
	
	if(kKeyCode == input.kKeyEscape) then
        application.quit ( )
    elseif(kKeyCode == input.kKeyF3) then
        application.restart ( )
    elseif(kKeyCode == input.kKeyC) then
        object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onToggleCamera" )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
