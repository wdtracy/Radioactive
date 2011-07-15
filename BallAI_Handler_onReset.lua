--------------------------------------------------------------------------------
--  Handler.......... : onReset
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function BallAI.onReset ( x, y, z )
--------------------------------------------------------------------------------
	
	-- Reset dynamics since they were adjusted as the ball slowed
    dynamics.setLinearDamping ( this.hBall ( ), this.nDefLinearDamping ( ) )
    dynamics.enableDynamics ( this.hBall ( ), false )
    
    -- Reset the special effects on the ball
    local hBallHelper = application.getCurrentUserSceneTaggedObject ( "BallHelper" )
    this.PauseEffects (  )
    this.bOnFire ( false )
    
    object.translateTo ( this.hBall ( ), x, y, z, object.kGlobalSpace, 1 )
    this.StartEffects (  )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
