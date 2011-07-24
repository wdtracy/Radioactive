--------------------------------------------------------------------------------
--  State............ : GetXML
--  Author........... : Wade Tracy
--  Description...... : Loop to load the XML file
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function MainAI.GetXML_onLoop ( )
--------------------------------------------------------------------------------
	
	local nXMLStatus = xml.getReceiveStatus ( this.hConfig ( ) )
    if ( nXMLStatus == -3 )
    then
        log.warning ( "XML parse failed." )

        --Leave GetXML state for another state
        this.Idle ( )

    elseif ( nXMLStatus == -2 )
    then
        log.warning ( "XML not found." )

        --Leave GetXML state for another state
        this.Idle ( )

    elseif ( nXMLStatus == 1 )
    then
        log.message ( "XML completed." )
        log.message (  xml.toString ( xml.getRootElement ( this.hConfig ( ) ) )  )

        --Process XML
        this.ParseXML ( )

        --Leave GetXML state for another state
        this.Idle ( )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
