<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="http://xml.apache.org/xalan/java"
                exclude-result-prefixes="java">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <dfna:DOHFLNARequest xmlns:dfna="urn://x-artefacts-fns-dohflna/root/260-18/4.0.1" Id="PERSONAL_SIGNATURE">
      <xsl:attribute name="ИдЗапрос">
        <xsl:choose>
          <xsl:when test="boolean(params/guid)">
            <xsl:value-of select="params/guid"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="java:java.util.UUID.randomUUID()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="ОтчетГод">
        <xsl:value-of select="params/reqOtchetGod"/>
      </xsl:attribute>
      <dfna:СвФЛ>
        <xsl:attribute name="ДатаРожд">
          <xsl:value-of select="params/DataRozhd"/>
        </xsl:attribute>
        <xsl:if test="params/INNFL">
          <xsl:attribute name="ИННФЛ">
            <xsl:value-of select="params/INNFL"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="params/SNILS">
          <xsl:attribute name="СНИЛС">
            <xsl:value-of select="params/SNILS"/>
          </xsl:attribute>
        </xsl:if>
        <dfna:ФИОФЛ>
          <xsl:attribute name="FamilyName">
            <xsl:value-of select="params/FamilyName"/>
          </xsl:attribute>
          <xsl:attribute name="FirstName">
            <xsl:value-of select="params/FirstName"/>
          </xsl:attribute>
          <xsl:if test="params/Patronymic">
            <xsl:attribute name="Patronymic">
              <xsl:value-of select="params/Patronymic"/>
            </xsl:attribute>
          </xsl:if>
        </dfna:ФИОФЛ>
        <dfna:УдЛичн>
          <xsl:attribute name="DocumentCode">
            <xsl:value-of select="params/DocumentCode//code"/>
          </xsl:attribute>
          <xsl:attribute name="SeriesNumber">
            <xsl:value-of select="params/SeriesNumber"/>
          </xsl:attribute>
        </dfna:УдЛичн>
      </dfna:СвФЛ>
    </dfna:DOHFLNARequest>
  </xsl:template>
</xsl:stylesheet>
