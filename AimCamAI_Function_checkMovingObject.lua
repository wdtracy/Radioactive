--------------------------------------------------------------------------------
--  Function......... : checkMovingObject
--  Author........... : Wade Tracy
--  Description...... : Check for a movable object, if one is found, set up the
--                      links to the object.  Returns true if a valid object is
--                      found.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function AimCamAI.checkMovingObject ( nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
	-- Boolean flag to see if a movable object has been clicked
    local bMovable = false
    local hHitObject, nHitDist, nHitSurfaceID, x,y,z
    
    local hScene = application.getCurrentUserScene ( )
    hHitObject, nHitDist, nHitSurfaceID, x, y, z = 
        scene.getFirstHitColliderEx ( hScene, nRayPntX, nRayPntY, nRayPntZ,
                                      nRayDirX, nRayDirY, nRayDirZ, this.nRayLength ( ) )
    -- If there's a hit
    if( hHitObject ~= nil ) then
        local sAI = object.getAIModelNameAt ( hHitObject, this.nMovableIndex ( ) )
        if( sAI ~= nil ) then
            -- Get whether the object is movable
            bMovable = object.getAIVariable ( hHitObject, sAI, "bMovable" )
        end
    end
    
    -- if the object is movable set the handle and flag
    if( bMovable ) then
        this.hMovingObject ( hHitObject )
            
        -- We are now moving an object
        this.bMovingObject ( true )
        
        -- Set the selected object, set the initial rotation of the selector to match the object,
        -- and call onMoveSelector to update the selector position.
        this.hSelectedObject ( hHitObject )
        
        local hUser = application.getCurrentUser ( )
        local hSelector = hud.getComponent ( hUser, "hud.Selector" )
        local rX, rY, rZ = object.getRotation ( this.hSelectedObject ( ), object.kGlobalSpace )
        hud.setComponentRotation ( hSelector, -rY )
        
        object.sendEvent ( this.hAimCam ( ), "AimCamAI", "onMoveSelector" )
        
        -- Get the position of the object and subtract the actual cursor location on the object.
        -- This offset will be used to keep the object from making an initial jump to the cursor location.
        local originX, originY, originZ = object.getTranslation ( this.hMovingObject ( ), object.kGlobalSpace )
        object.setAIVariable ( this.hMovingObject ( ), "MovableAI", "nXOffset", x - originX )
        object.setAIVariable ( this.hMovingObject ( ), "MovableAI", "nZOffset", z - originZ )
        
        return true
    else
        return false
    end

--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
