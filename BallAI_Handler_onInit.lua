--------------------------------------------------------------------------------
--  Handler.......... : onInit
--  Author........... : Wade Tracy
--  Description...... : Initializes the ball AI
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function BallAI.onInit (  )
--------------------------------------------------------------------------------
	
	this.hBall ( this.getObject ( ) )
    this.hBallHelper ( group.getSubObjectAt ( this.hBall ( ), 0 ) )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------