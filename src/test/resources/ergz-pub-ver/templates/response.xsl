<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:map="java.util.Map"
                exclude-result-prefixes="map">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
  <xsl:param name="headers"/>

  <xsl:template name="fl">
    <xsl:param name="data"/>
    <xsl:param name="type"/>

    <Type>
      <xsl:value-of select="$type"/>
    </Type>
    <FirstName>
      <xsl:value-of select="$data/*[local-name() = 'FirstName']"/>
    </FirstName>
    <LastName>
      <xsl:value-of select="$data/*[local-name() = 'LastName']"/>
    </LastName>
    <PatronymicInfo>
      <xsl:choose>
        <xsl:when test="$data/*[local-name() = 'PatronymicInfo']/*[local-name() = 'NoPatronymic']">
          <NoPatronymic>
            <xsl:value-of select="$data/*[local-name() = 'PatronymicInfo']/*[local-name() = 'NoPatronymic']"/>
          </NoPatronymic>
        </xsl:when>
        <xsl:otherwise>
          <Patronymic>
            <xsl:value-of select="$data/*[local-name() = 'PatronymicInfo']/*[local-name() = 'Patronymic']"/>
          </Patronymic>
        </xsl:otherwise>
      </xsl:choose>
    </PatronymicInfo>
    <SNILSInfo>
      <xsl:choose>
        <xsl:when test="$data/*[local-name() = 'SNILSInfo']/*[local-name() = 'NoSNILS']">
          <NoSNILS>
            <xsl:value-of select="$data/*[local-name() = 'SNILSInfo']/*[local-name() = 'NoSNILS']"/>
          </NoSNILS>
        </xsl:when>
        <xsl:otherwise>
          <SNILS>
            <xsl:value-of select="$data/*[local-name() = 'SNILSInfo']/*[local-name() = 'SNILS']"/>
          </SNILS>
        </xsl:otherwise>
      </xsl:choose>
    </SNILSInfo>
    <Address>
      <xsl:value-of select="$data/*[local-name() = 'Address']"/>
    </Address>

    <xsl:choose>
      <xsl:when test="$type='IP'">
        <OGRNIPInfo>
          <xsl:choose>
            <xsl:when test="$data/*[local-name() = 'OGRNIPInfo']/*[local-name() = 'NoOGRNIP']">
              <NoOGRNIP>
                <xsl:value-of select="$data/*[local-name() = 'OGRNIPInfo']/*[local-name() = 'NoOGRNIP']"/>
              </NoOGRNIP>
            </xsl:when>
            <xsl:otherwise>
              <OGRNIP>
                <xsl:value-of select="$data/*[local-name() = 'OGRNIPInfo']/*[local-name() = 'OGRNIP']"/>
              </OGRNIP>
            </xsl:otherwise>
          </xsl:choose>
        </OGRNIPInfo>
        <Phone>
          <xsl:value-of select="$data/*[local-name() = 'Phone']"/>
        </Phone>
      </xsl:when>
    </xsl:choose>
    <Email>
      <xsl:value-of select="$data/*[local-name() = 'Email']"/>
    </Email>
  </xsl:template>

  <xsl:template name="organization">
    <xsl:param name="data"/>
    <xsl:param name="type"/>
    <Type>
      <xsl:value-of select="$type"/>
    </Type>
    <Name>
      <xsl:value-of select="$data/*[local-name() = 'Name']"/>
    </Name>
    <INNInfo>
      <xsl:choose>
        <xsl:when test="$data/*[local-name() = 'INNInfo']/*[local-name() = 'NoINN']">
          <NoINN>
            <xsl:value-of select="$data/*[local-name() = 'INNInfo']/*[local-name() = 'NoINN']"/>
          </NoINN>
        </xsl:when>
        <xsl:otherwise>
          <INN>
            <xsl:value-of select="$data/*[local-name() = 'INNInfo']/*[local-name() = 'INN']"/>
          </INN>
        </xsl:otherwise>
      </xsl:choose>
    </INNInfo>
    <KPPInfo>
      <xsl:choose>
        <xsl:when test="$data/*[local-name() = 'KPPInfo']/*[local-name() = 'NoKPP']">
          <NoKPP>
            <xsl:value-of select="$data/*[local-name() = 'KPPInfo']/*[local-name() = 'NoKPP']"/>
          </NoKPP>
        </xsl:when>
        <xsl:otherwise>
          <KPP>
            <xsl:value-of select="$data/*[local-name() = 'KPPInfo']/*[local-name() = 'KPP']"/>
          </KPP>
        </xsl:otherwise>
      </xsl:choose>
    </KPPInfo>
    <OGRNInfo>
      <xsl:choose>
        <xsl:when test="$data/*[local-name() = 'OGRNInfo']/*[local-name() = 'NoOGRN']">
          <NoOGRN>
            <xsl:value-of select="$data/*[local-name() = 'OGRNInfo']/*[local-name() = 'NoOGRN']"/>
          </NoOGRN>
        </xsl:when>
        <xsl:otherwise>
          <OGRN>
            <xsl:value-of select="$data/*[local-name() = 'OGRNInfo']/*[local-name() = 'OGRN']"/>
          </OGRN>
        </xsl:otherwise>
      </xsl:choose>
    </OGRNInfo>
    <Address>
      <xsl:value-of select="$data/*[local-name() = 'Address']"/>
    </Address>
    <Location>
      <xsl:value-of select="$data/*[local-name() = 'Location']"/>
    </Location>
    <Phone>
      <xsl:value-of select="$data/*[local-name() = 'Phone']"/>
    </Phone>
    <Email>
      <xsl:value-of select="$data/*[local-name() = 'Email']"/>
    </Email>
  </xsl:template>

  <xsl:template match="/">
    <xsl:variable name="root" select="/*[local-name()='PublicPrintOutResponse']"/>
    <params>
      <messageId>
        <xsl:value-of select="map:get($headers, 'originalMessageId')"/>
      </messageId>
      <ReestrDate>
        <xsl:value-of select="$root/*[local-name() = 'ReestrDate']"/>
      </ReestrDate>
      <PrintOutNumber>
        <xsl:value-of select="$root/*[local-name() = 'PrintOutNumber']"/>
      </PrintOutNumber>

      <xsl:variable name="print" select="$root/*[local-name() = 'PublicPrintOut']"/>

      <ExpertOrganization>
        <xsl:call-template name="organization">
          <xsl:with-param name="data" select="$print/*[local-name() = 'ExpertOrganization']"/>
          <xsl:with-param name="type" select="'UL'"/>
        </xsl:call-template>
      </ExpertOrganization>
      <ExpertiseResultNumber>
        <xsl:value-of select="$print/*[local-name() = 'ExpertiseResultNumber']"/>
      </ExpertiseResultNumber>
      <ExpertiseResultDate>
        <xsl:value-of select="$print/*[local-name() = 'ExpertiseResultDate']"/>
      </ExpertiseResultDate>
      <ObjectName>
        <xsl:value-of select="$print/*[local-name() = 'ObjectName']"/>
      </ObjectName>
      <Result>
        <xsl:value-of select="$print/*[local-name() = 'Result']"/>
      </Result>
      <DocumentationType>
        <xsl:value-of select="$print/*[local-name() = 'DocumentationType']"/>
      </DocumentationType>
      <WorkType>
        <xsl:value-of select="$print/*[local-name() = 'WorkType']"/>
      </WorkType>
      <SubjectRFName>
        <xsl:value-of select="$print/*[local-name() = 'SubjectRF']/*[local-name() = 'Name']"/>
      </SubjectRFName>
      <SubjectRFNumber>
        <xsl:value-of select="$print/*[local-name() = 'SubjectRF']/*[local-name() = 'Number']"/>
      </SubjectRFNumber>

      <DeveloperOrganizationInfo>
        <xsl:choose>
          <xsl:when test="$print/*[local-name() = 'DeveloperOrganizationInfo']/*[local-name() = 'NoDeveloperOrganizations']">
            <NoDeveloperOrganizations>
              <xsl:value-of select="$print/*[local-name() = 'DeveloperOrganizationInfo']/*[local-name() = 'NoDeveloperOrganizations']"/>
            </NoDeveloperOrganizations>
          </xsl:when>
          <xsl:otherwise>
            <DeveloperOrganizations>
              <xsl:variable name="orgs" select="$print/*[local-name() = 'DeveloperOrganizationInfo']/*[local-name() = 'DeveloperOrganizations']/*[local-name() = 'DeveloperOrganizations']/*[local-name() = 'Organizations']/*"/>

              <xsl:for-each select="$orgs">
                <Organization>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <xsl:choose>
                    <xsl:when test="local-name()='FL'">
                      <xsl:call-template name="fl">
                        <xsl:with-param name="data" select="."/>
                        <xsl:with-param name="type" select="local-name()"/>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="local-name()='IP'">
                      <xsl:call-template name="fl">
                        <xsl:with-param name="data" select="."/>
                        <xsl:with-param name="type" select="local-name()"/>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="local-name()='UL'">
                      <xsl:call-template name="organization">
                        <xsl:with-param name="data" select="."/>
                        <xsl:with-param name="type" select="local-name()"/>
                      </xsl:call-template>
                    </xsl:when>
                  </xsl:choose>
                </Organization>
              </xsl:for-each>
            </DeveloperOrganizations>
          </xsl:otherwise>
        </xsl:choose>
        <TechnicalEmployers>
          <xsl:variable name="techs" select="$print/*[local-name() = 'DeveloperOrganizationInfo']/*[local-name() = 'DeveloperOrganizations']/*[local-name() = 'TechnicalEmployers']/*[local-name() = 'Organizations']/*"/>

          <xsl:for-each select="$techs">
            <Organization>
              <xsl:attribute name="_json">asList</xsl:attribute>
              <xsl:choose>
                <xsl:when test="local-name()='FL'">
                  <xsl:call-template name="fl">
                    <xsl:with-param name="data" select="."/>
                    <xsl:with-param name="type" select="local-name()"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="local-name()='IP'">
                  <xsl:call-template name="fl">
                    <xsl:with-param name="data" select="."/>
                    <xsl:with-param name="type" select="local-name()"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="local-name()='UL'">
                  <xsl:call-template name="organization">
                    <xsl:with-param name="data" select="."/>
                    <xsl:with-param name="type" select="local-name()"/>
                  </xsl:call-template>
                </xsl:when>
              </xsl:choose>
            </Organization>
          </xsl:for-each>
        </TechnicalEmployers>
      </DeveloperOrganizationInfo>
      <Type>
        <xsl:value-of select="$print/*[local-name() = 'Type']"/>
      </Type>
      <PreviousExpertisesInfo>
        <xsl:choose>
          <xsl:when test="$print/*[local-name() = 'NoPreviousExpertises']">
            <NoPreviousExpertises>
              <xsl:value-of select="$print/*[local-name() = 'NoPreviousExpertises']"/>
            </NoPreviousExpertises>
          </xsl:when>
          <xsl:otherwise>
            <PreviousExpertises>
              <xsl:variable name="exp" select="$print/*[local-name() = 'PreviousExpertisesInfo']/*[local-name() = 'PreviousExpertises']/*[local-name() = 'PreviousExpertise']"/>
              <xsl:for-each select="$exp">
                <PreviousExpertise>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <Number>
                    <xsl:value-of select="./*[local-name()='Number']"/>
                  </Number>
                  <Date>
                    <xsl:value-of select="./*[local-name()='Date']"/>
                  </Date>
                </PreviousExpertise>
              </xsl:for-each>
            </PreviousExpertises>
          </xsl:otherwise>
        </xsl:choose>
      </PreviousExpertisesInfo>
      <ExpertiseResultEconomyEfficiencyInfo>
        <xsl:choose>
          <xsl:when test="$print/*[local-name()='ExpertiseResultEconomyEfficiencyInfo']/*[local-name() = 'NoExpertiseResultEconomyEfficiencyInfo']">
            <NoExpertiseResultEconomyEfficiencyInfo>
              <xsl:value-of select="$print/*[local-name()='ExpertiseResultEconomyEfficiencyInfo']/*[local-name() = 'NoExpertiseResultEconomyEfficiencyInfo']"/>
            </NoExpertiseResultEconomyEfficiencyInfo>
          </xsl:when>
          <xsl:otherwise>
            <ExpertiseResultEconomyEfficiency>
              <xsl:variable name="exp" select="$print/*[local-name() = 'ExpertiseResultEconomyEfficiencyInfo']/*[local-name() = 'ExpertiseResultEconomyEfficiency']"/>
              <Number>
                <xsl:value-of select="$exp/*[local-name()='Number']"/>
              </Number>
              <Date>
                <xsl:value-of select="$exp/*[local-name()='Date']"/>
              </Date>
            </ExpertiseResultEconomyEfficiency>
          </xsl:otherwise>
        </xsl:choose>
      </ExpertiseResultEconomyEfficiencyInfo>
      <RightsInfo>
        <xsl:choose>
          <xsl:when test="$print/*[local-name()='RightsInfo']/*[local-name() = 'NoRights']">
            <NoRights>
              <xsl:value-of select="$print/*[local-name()='RightsInfo']/*[local-name() = 'NoRights']"/>
            </NoRights>
          </xsl:when>
          <xsl:otherwise>
            <Rights>
              <xsl:variable name="rights" select="$print/*[local-name() = 'RightsInfo']/*[local-name() = 'Rights']"/>
              <xsl:choose>
                <xsl:when test="$rights/*[local-name()='RightsDocument']">
                  <PublicFormationName>
                    <xsl:value-of select="$rights/*[local-name()='RightsDocument']/*[local-name() = 'PublicFormationName']"/>
                  </PublicFormationName>
                  <RightsDocumentInfo>
                    <xsl:value-of select="$rights/*[local-name()='RightsDocument']/*[local-name() = 'RightsDocumentInfo']"/>
                  </RightsDocumentInfo>
                </xsl:when>
                <xsl:otherwise>
                  <PublicFormationName>
                    <xsl:value-of select="$rights/*[local-name()='RightsOwner']/*[local-name() = 'PublicFormationName']"/>
                  </PublicFormationName>
                  <Owner>
                    <xsl:call-template name="organization">
                      <xsl:with-param name="data" select="$rights/*[local-name()='RightsOwner']/*[local-name() = 'UL']"/>
                      <xsl:with-param name="type" select="'UL'"/>
                    </xsl:call-template>
                  </Owner>
                </xsl:otherwise>
              </xsl:choose>
            </Rights>
          </xsl:otherwise>
        </xsl:choose>
      </RightsInfo>
      <PlannerOrganizationInfo>
        <xsl:choose>
          <xsl:when test="$print/*[local-name()='PlannerOrganizationsInfo']/*[local-name() = 'NoOrganizations']">
            <NoOrganizations>
              <xsl:value-of select="$print/*[local-name()='PlannerOrganizationsInfo']/*[local-name() = 'NoOrganizations']"/>
            </NoOrganizations>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="orgs" select="$print/*[local-name() = 'PlannerOrganizationsInfo']/*[local-name() = 'Organizations']/*"/>
            <xsl:for-each select="$orgs">
              <Organization>
                <xsl:attribute name="_json">asList</xsl:attribute>
                <xsl:choose>
                  <xsl:when test="local-name()='IP'">
                    <xsl:call-template name="fl">
                      <xsl:with-param name="data" select="."/>
                      <xsl:with-param name="type" select="local-name()"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="local-name()='UL'">
                    <xsl:call-template name="organization">
                      <xsl:with-param name="data" select="."/>
                      <xsl:with-param name="type" select="local-name()"/>
                    </xsl:call-template>
                  </xsl:when>
                </xsl:choose>
              </Organization>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </PlannerOrganizationInfo>
      <BuildingAddress>
        <xsl:value-of select="$print/*[local-name()='BuildingAddress']"/>
      </BuildingAddress>
    </params>
  </xsl:template>
</xsl:stylesheet>