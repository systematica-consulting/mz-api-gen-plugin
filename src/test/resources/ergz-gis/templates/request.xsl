<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.w3.org/2001/XMLSchema" xmlns:egrz="urn://x-artefacts-gis-ergz/1.1.1" xmlns:egrzt="urn://x-artefacts-gis-ergz-types/1.1.1" version="1.0">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
  <xsl:template name="format-date">
    <xsl:param name="date" />
    <xsl:if test="$date != ''">
      <xsl:value-of select="concat(substring($date, 1, 4), '-', substring($date, 6, 2), '-',substring($date, 9, 2))" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="/">
    <egrz:FullPrintOutRequest>
      <egrz:ExpertiseResultNumber>
        <xsl:value-of select="params/ExpertiseResultNumber" />
      </egrz:ExpertiseResultNumber>
      <egrz:ExpertiseResultDate>
        <xsl:call-template name="format-date">
          <xsl:with-param name="date">
            <xsl:value-of select="params/ExpertiseResultDate" />
          </xsl:with-param>
        </xsl:call-template>
      </egrz:ExpertiseResultDate>
      <egrz:SignedExpertiseDocuments>
        <xsl:for-each select="params/SignedExpertiseDocuments/DetachedSignAttachment">
          <egrzt:DetachedSignAttachment>
            <egrzt:Document attachmentId="{Document}"/>
            <egrzt:Signature attachmentId="{Signature}"/>
          </egrzt:DetachedSignAttachment>
        </xsl:for-each>
      </egrz:SignedExpertiseDocuments>
    </egrz:FullPrintOutRequest>
  </xsl:template>
</xsl:stylesheet>