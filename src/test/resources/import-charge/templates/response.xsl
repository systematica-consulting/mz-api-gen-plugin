<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:map="java.util.Map"
                exclude-result-prefixes="map">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
  <xsl:param name="headers"/>
  <xsl:template match="/">
    <params>
      <messageId>
        <xsl:value-of select="map:get($headers, 'originalMessageId')"/>
      </messageId>
      <packageId>
        <xsl:value-of select="//*[local-name()='ImportChargesResponse']/@Id"/>
      </packageId>
      <resultCode>
        <xsl:choose>
          <xsl:when test="//*[local-name()='RequestRejected']">
            <xsl:value-of select="//*[local-name()='RequestRejected']/*[local-name()='RejectionReasonCode']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='SmevFault']">
            <xsl:value-of select="//*[local-name()='SmevFault']/*[local-name()='Code']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='RequestStatus']">
            <xsl:value-of select="//*[local-name()='RequestStatus']/*[local-name()='StatusCode']"/>
          </xsl:when>
        </xsl:choose>
      </resultCode>
      <resultDesc>
        <xsl:choose>
          <xsl:when test="//*[local-name()='RequestRejected']">
            <xsl:value-of select="//*[local-name()='RequestRejected']/*[local-name()='RejectionReasonDescription']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='SmevFault']">
            <xsl:value-of select="//*[local-name()='SmevFault']/*[local-name()='Description']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='RequestStatus']">
            <xsl:value-of select="//*[local-name()='RequestStatus']/*[local-name()='StatusDescription']"/>
          </xsl:when>
        </xsl:choose>
      </resultDesc>
      <respId>
        <xsl:value-of select="//*[local-name()='SenderProvidedResponseData']/*[local-name()='MessageID']"/>
      </respId>
      <respTimestamp>
        <xsl:value-of select="//*[local-name()='MessageMetadata']/*[local-name()='DeliveryTimestamp']"/>
      </respTimestamp>
      <respSenderId>
        <xsl:value-of select="//*[local-name()='MessageMetadata']/*[local-name()='Sender']/*[local-name()='Mnemonic']"/>
      </respSenderId>
      <packageProcessResult>
        <xsl:call-template name="importProtocols"/>
      </packageProcessResult>
    </params>
  </xsl:template>

  <xsl:template name="importProtocols">
    <xsl:for-each select="//*[local-name()='ImportProtocol']">
      <gg116EntityProcessResult>
        <xsl:attribute name="_json">asList</xsl:attribute>
        <charge>
          <xsl:value-of select="substring-after(./@entityID, 'I_')"/>
        </charge>
        <resultCode>
          <xsl:value-of select="./@code"/>
        </resultCode>
        <resultDesc>
          <xsl:value-of select="./@description"/>
        </resultDesc>
      </gg116EntityProcessResult>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>