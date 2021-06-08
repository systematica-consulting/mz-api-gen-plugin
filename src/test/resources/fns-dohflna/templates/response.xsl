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
      <xsl:variable name="response" select="//*[local-name()='DOHFLNAResponse']"/>
      <IdZapros>
        <xsl:value-of select="$response/@ИдЗапрос"/>
      </IdZapros>
      <OtchetGod>
        <xsl:value-of select="$response/*[local-name()='ДохФЛ']/@ОтчетГод"/>
      </OtchetGod>
      <DohFLNA>
        <xsl:for-each select="$response/*[local-name()='ДохФЛ']/*[local-name()='ДохФЛ_НА']">
          <fs3FNSDohflnaDohFLNA>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <INNFL>
              <xsl:value-of select="./*[local-name()='ПолучДох']/@ИННФЛ"/>
            </INNFL>
            <DataRozhd>
              <xsl:value-of select="./*[local-name()='ПолучДох']/@ДатаРожд"/>
            </DataRozhd>
            <FamilyName>
              <xsl:value-of select="./*[local-name()='ПолучДох']/*[local-name()='ФИО']/@FamilyName"/>
            </FamilyName>
            <FirstName>
              <xsl:value-of select="./*[local-name()='ПолучДох']/*[local-name()='ФИО']/@FirstName"/>
            </FirstName>
            <Patronymic>
              <xsl:value-of select="./*[local-name()='ПолучДох']/*[local-name()='ФИО']/@Patronymic"/>
            </Patronymic>
            <DocumentCode>
              <xsl:value-of select="./*[local-name()='ПолучДох']/*[local-name()='УдЛичнФЛ']/@DocumentCode"/>
            </DocumentCode>
            <SeriesNumber>
              <xsl:value-of select="./*[local-name()='ПолучДох']/*[local-name()='УдЛичнФЛ']/@SeriesNumber"/>
            </SeriesNumber>
            <NaimOrg>
              <xsl:value-of select="./*[local-name()='СвНА']/*[local-name()='СвНАЮЛ']/@НаимОрг"/>
            </NaimOrg>
            <INNYUL>
              <xsl:value-of select="./*[local-name()='СвНА']/*[local-name()='СвНАЮЛ']/@ИННЮЛ"/>
            </INNYUL>
            <KPP>
              <xsl:value-of select="./*[local-name()='СвНА']/*[local-name()='СвНАЮЛ']/@КПП"/>
            </KPP>
            <SvNAFLINNFL>
              <xsl:value-of select="./*[local-name()='СвНА']/*[local-name()='СвНАФЛ']/@ИННФЛ"/>
            </SvNAFLINNFL>
            <SvNAFLFIOFamilyName>
              <xsl:value-of
                select="./*[local-name()='СвНА']/*[local-name()='СвНАФЛ']/*[local-name()='ФИО']/@FamilyName"/>
            </SvNAFLFIOFamilyName>
            <SvNAFLFIOFirstName>
              <xsl:value-of
                select="./*[local-name()='СвНА']/*[local-name()='СвНАФЛ']/*[local-name()='ФИО']/@FirstName"/>
            </SvNAFLFIOFirstName>
            <SvNAFLFIOPatronymic>
              <xsl:value-of
                select="./*[local-name()='СвНА']/*[local-name()='СвНАФЛ']/*[local-name()='ФИО']/@Patronymic"/>
            </SvNAFLFIOPatronymic>
            <SvedDoh2NDFL>
              <xsl:for-each select="./*[local-name()='СведДох_2НДФЛ']">
                <fs3FNSDohflnaSvedDoh2NDFL>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <Stavka>
                    <xsl:value-of select="./@Ставка"/>
                  </Stavka>
                  <SvSumDoh>
                    <xsl:for-each select="./*[local-name()='ДохВыч']/*[local-name()='СвСумДох']">
                      <fs3FNSDohflnaSvSumDoh>
                        <xsl:attribute name="_json">asList</xsl:attribute>
                        <Mesyac>
                          <xsl:value-of select="./@Месяц"/>
                        </Mesyac>
                        <KodDohod>
                          <xsl:value-of select="./@КодДоход"/>
                        </KodDohod>
                        <SumDohod>
                          <xsl:value-of select="./@СумДоход"/>
                        </SumDohod>
                      </fs3FNSDohflnaSvSumDoh>
                    </xsl:for-each>
                  </SvSumDoh>
                  <SumDohObsh>
                    <xsl:value-of select="./*[local-name()='СГДНалПер']/@СумДохОбщ"/>
                  </SumDohObsh>
                  <NalBaza>
                    <xsl:value-of select="./*[local-name()='СГДНалПер']/@НалБаза"/>
                  </NalBaza>
                </fs3FNSDohflnaSvedDoh2NDFL>
              </xsl:for-each>
            </SvedDoh2NDFL>
            <SvedDohNDPrib>
              <xsl:for-each select="./*[local-name()='СведДох_НДПриб']">
                <fs3FNSDohflnaSvedDohNDPrib>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <Stavka>
                    <xsl:value-of select="./*[local-name()='ДохНалПер']/@Ставка"/>
                  </Stavka>
                  <SumDohObsh>
                    <xsl:value-of select="./*[local-name()='ДохНалПер']/@СумДохОбщ"/>
                  </SumDohObsh>
                  <NalBaza>
                    <xsl:value-of select="./*[local-name()='ДохНалПер']/@НалБаза"/>
                  </NalBaza>
                </fs3FNSDohflnaSvedDohNDPrib>
              </xsl:for-each>
            </SvedDohNDPrib>
          </fs3FNSDohflnaDohFLNA>
        </xsl:for-each>
      </DohFLNA>
    </params>
  </xsl:template>
</xsl:stylesheet>
