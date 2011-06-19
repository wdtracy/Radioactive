--------------------------------------------------------------------------------
--  Handler.......... : onEnterFrame
--  Author........... : Wade Tracy
--  Description...... : Event handler that makes the overhead cam follow the
--                      target.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function OverheadCamAI.onEnterFrame (  )
--------------------------------------------------------------------------------

    -- Get the average frame time to make movements device independent
    local dt = application.getAverageFrameTime ( )
    
    local hAimCam = application.getCurrentUserSceneTaggedObject ( "AimCam" )
    local bBallInPlay = object.getAIVariable ( hAimCam, "AimCamAI", "ballInPlay" )
    local hUser = application.getCurrentUser ( )
    
    -- The overhead cam functions differently when the ball is not in play
    if( bBallInPlay ) then
    
        -- Get the location of the ball and set the camera to the same plus the zoom
        -- in the Y axis
        local tX, tY, tZ = object.getTranslation ( this.hTarget ( ), object.kGlobalSpace )
        object.translateTo ( this.hOverheadCam(), tX, tY + this.nZoom ( ), tZ, object.kGlobalSpace,
                             this.nScrollFactor ( ) * dt )
        
    -- Allow the camera to scroll when the cursor moves to the edge of the screen.
    else
        -- As the cursor approaches the edge of the screen, scroll the view in that direction
        -- using local coords to move camera relative to its current position.
        -- Since the camera is rotated 90 deg to look down, we move in x and y directions
        -- instead of x and z.
        local x,y = hud.getCursorPosition ( hUser )
        if( x < this.nScrollMarginX ( ) ) then
            object.translateTo ( this.hOverheadCam ( ), -this.nScrollValue ( ), 0, 0, 
                                 object.kLocalSpace, this.nScrollFactor ( ) * dt )
        end
        if( x > 100 - this.nScrollMarginX ( ) ) then
            object.translateTo ( this.hOverheadCam ( ), this.nScrollValue ( ), 0, 0,
                                 object.kLocalSpace, this.nScrollFactor ( ) * dt )
        end
        if( y < this.nScrollMarginY ( ) ) then
            object.translateTo ( this.hOverheadCam ( ), 0, -this.nScrollValue ( ), 0, 
                                 object.kLocalSpace, this.nScrollFactor ( ) * dt )
        end
        if( y > 100 - this.nScrollMarginY ( ) ) then
            object.translateTo ( this.hOverheadCam ( ), 0, this.nScrollValue ( ), 0, 
                                 object.kLocalSpace, this.nScrollFactor ( ) * dt )
        end
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
