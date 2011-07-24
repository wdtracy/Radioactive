--------------------------------------------------------------------------------
--  Function......... : ParseXML
--  Author........... : Wade Tracy
--  Description...... : Function that parses the XML settings file and sets the
--                      variables within the given AI.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.ParseXML ( )
--------------------------------------------------------------------------------
	
    -- Set up our references to our root node.
    local xRoot = xml.getRootElement ( this.hConfig ( ) )
    
    -- Get the element and the value and assign it to the game variable
    local xElement = xml.getElementFirstChildWithName ( xRoot, "BallImpulse" )
    local nImpulse = xml.getElementValue ( xElement )
    object.setAIVariable ( this.hAimCam ( ), "AimCamAI", "nImpulse", nImpulse )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
