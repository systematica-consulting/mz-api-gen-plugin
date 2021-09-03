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
      <xsl:variable name="resp" select="/*[local-name()='PensionsOnDateResponse']"/>
      <FamilyName>
        <xsl:value-of select="$resp/*[local-name() = 'FamilyName']"/>
      </FamilyName>
      <FirstName>
        <xsl:value-of select="$resp/*[local-name() = 'FirstName']"/>
      </FirstName>
      <Patronymic>
        <xsl:value-of select="$resp/*[local-name() = 'Patronymic']"/>
      </Patronymic>
      <Snils>
        <xsl:value-of select="$resp/*[local-name() = 'Snils']"/>
      </Snils>
      <BirthDate>
        <xsl:value-of select="$resp/*[local-name() = 'BirthDate']"/>
      </BirthDate>
      <Gender>
        <xsl:value-of select="$resp/*[local-name() = 'Gender']"/>
      </Gender>
      <ActualDate>
        <xsl:value-of select="$resp/*[local-name() = 'ActualDate']"/>
      </ActualDate>
      <ExistData>
        <xsl:value-of select="$resp/*[local-name() = 'ExistData']"/>
      </ExistData>
      <AppDate>
        <xsl:value-of select="$resp/*[local-name() = 'AppDate']"/>
      </AppDate>
      <TotalPaymentsSum>
        <xsl:value-of select="$resp/*[local-name() = 'TotalPaymentsSum']"/>
      </TotalPaymentsSum>
      <NumberOfPayments>
        <xsl:value-of select="$resp/*[local-name() = 'NumberOfPayments']"/>
      </NumberOfPayments>

      <Payments>
        <xsl:for-each select="//*[local-name() = 'Payments']/*[local-name() = 'Payment']">
          <Payment>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <Type>
              <xsl:value-of select="*[local-name() = 'Type']"/>
            </Type>
            <Base>
              <xsl:value-of select="*[local-name() = 'Base']"/>
            </Base>
            <Sum>
              <xsl:value-of select="*[local-name() = 'Sum']"/>
            </Sum>
            <Payments>
              <xsl:for-each select="*[local-name() = 'PaymentDetail']">
                <Payment>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <Type>
                    <xsl:value-of select="*[local-name() = 'Type']"/>
                  </Type>
                  <Base>
                    <xsl:value-of select="*[local-name() = 'Base']"/>
                  </Base>
                  <Sum>
                    <xsl:value-of select="*[local-name() = 'Sum']"/>
                  </Sum>
                </Payment>
              </xsl:for-each>
            </Payments>
          </Payment>
        </xsl:for-each>
      </Payments>
    </params>

  </xsl:template>
</xsl:stylesheet>