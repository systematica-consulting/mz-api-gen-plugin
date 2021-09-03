<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:benefits="http://kvs.pfr.com/benefits-common/1.0.0"
                xmlns:tns="http://kvs.pfr.com/pensions-on-date/1.0.1"
                xmlns:smev="urn://x-artefacts-smev-gov-ru/supplementary/commons/1.0.1"
>
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>

  <xsl:template name="format-date">
    <xsl:param name="date"/>
    <xsl:if test="$date != ''">
      <xsl:value-of
        select="concat(substring($date, 1, 4), '-', substring($date, 6, 2), '-',substring($date, 9, 2))"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="/">

    <tns:PensionsOnDateRequest>
      <smev:FamilyName>
        <xsl:value-of select="params/reqFamilyName"/>
      </smev:FamilyName>
      <smev:FirstName>
        <xsl:value-of select="params/reqFirstName"/>
      </smev:FirstName>
      <xsl:if test="params/reqPatronymic">
        <smev:Patronymic>
          <xsl:value-of select="params/reqPatronymic"/>
        </smev:Patronymic>
      </xsl:if>
      <benefits:Snils>
        <xsl:value-of select="params/reqSnils"/>
      </benefits:Snils>
      <benefits:BirthDate>
        <xsl:call-template name="format-date">
          <xsl:with-param name="date" select="params/reqBirthDate"/>
        </xsl:call-template>
      </benefits:BirthDate>
      <benefits:Gender>
        <xsl:value-of select="params/reqGender"/>
      </benefits:Gender>
      <benefits:AppDate>
        <xsl:call-template name="format-date">
          <xsl:with-param name="date" select="params/reqAppDate"/>
        </xsl:call-template>
      </benefits:AppDate>
    </tns:PensionsOnDateRequest>
  </xsl:template>
</xsl:stylesheet>
