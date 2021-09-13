<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="http://xml.apache.org/xalan/java" exclude-result-prefixes="java">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <ns1:PublicPrintOutRequest xmlns:ns1="urn://x-artefacts-gis-ergz-public/2.1.0" xmlns:ns2="urn://x-artefacts-gis-ergz-types/2.1.0">
      <ns2:ExpertiseResultNumber>
        <xsl:value-of select="params/expertiseResultNumber"/>
      </ns2:ExpertiseResultNumber>
      <ns2:ExpertiseResultDate>
        <xsl:value-of select="params/expertiseResultDate"/>
      </ns2:ExpertiseResultDate>
    </ns1:PublicPrintOutRequest>
  </xsl:template>
</xsl:stylesheet>