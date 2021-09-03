<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="*[@* or not(*)] ">
    <xsl:if test="not(*)">
      <xsl:apply-templates select="ancestor-or-self::*" mode="path"/>
      <xsl:value-of select="concat('=',.)"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="@*|*"/>
  </xsl:template>

  <xsl:template match="*" mode="path">
    <xsl:value-of select="concat('/',local-name())"/>
    <xsl:variable name="vnumPrecSiblings" select=
      "count(preceding-sibling::*[local-name()=local-name(current())])"/>
    <xsl:if test="$vnumPrecSiblings">
      <xsl:value-of select="concat('[', $vnumPrecSiblings +1, ']')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:apply-templates select="../ancestor-or-self::*" mode="path"/>
    <xsl:value-of select="concat('[@',local-name(), ']=',.)"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>
</xsl:stylesheet>