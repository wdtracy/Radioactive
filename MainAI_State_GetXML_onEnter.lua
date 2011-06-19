--------------------------------------------------------------------------------
--  State............ : GetXML
--  Author........... : Wade Tracy
--  Description...... : Attempts to load the XML settings file
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.GetXML_onEnter ( )
--------------------------------------------------------------------------------
	
    -- Currently only configured for pulling over the internet.  This should be
    -- reconfigured for different platforms.
	xml.receive ( this.hConfig ( ), "http://yourgraphicresource.com/subspace/config.xml" )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
