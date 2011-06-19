--------------------------------------------------------------------------------
--  Handler.......... : onMouseMove
--  Author........... : Wade Tracy
--  Description...... : Mouse move event handler for a movable object
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MovableAI.onMouseMove ( nPointX, nPointY, nDeltaX, nDeltaY, 
                                 nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
    -- Get the coords of the cursor in 3D space - only interested in x and z
	local hScene = application.getCurrentUserScene ( )
    local hHitObject, hHitDist, nHitSurfaceID,x,y,z = 
        scene.getFirstHitColliderEx ( hScene, nRayPntX, nRayPntY, nRayPntZ, 
                                      nRayDirX, nRayDirY, nRayDirZ, this.nRayLength ( ) )
    
    -- Get the current location of the object - only for the Y
    local objectX,objectY,objectZ = object.getTranslation ( this.hObject ( ), object.kGlobalSpace )

    -- Move the object to the x and z coords of the cursor and the y coord of the object
    object.translateTo ( this.hObject ( ), x - this.nXOffset ( ), objectY, 
                         z - this.nZOffset ( ), object.kGlobalSpace, 1 )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
