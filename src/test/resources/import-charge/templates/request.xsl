<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <req:ImportChargesRequest xmlns:org="http://roskazna.ru/gisgmp/xsd/Organization/2.1.1"
                              xmlns:com="http://roskazna.ru/gisgmp/xsd/Common/2.1.1"
                              xmlns:chg="http://roskazna.ru/gisgmp/xsd/Charge/2.1.1"
                              xmlns:pkg="http://roskazna.ru/gisgmp/xsd/Package/2.1.1"
                              xmlns:req="urn://roskazna.ru/gisgmp/xsd/services/import-charges/2.1.1"
                              xmlns:rfd="http://roskazna.ru/gisgmp/xsd/Refund/2.1.1"
                              xmlns:pmnt="http://roskazna.ru/gisgmp/xsd/Payment/2.1.1">
      <xsl:attribute name="Id">G_<xsl:value-of select="//params/guid"/>
      </xsl:attribute>
      <xsl:attribute name="timestamp">
        <xsl:value-of select="//date"/>
      </xsl:attribute>
      <xsl:attribute name="senderIdentifier">
        <xsl:value-of select="//participant/senderId"/>
      </xsl:attribute>
      <xsl:if test="//participant/senderRole">
        <xsl:attribute name="senderRole">
          <xsl:value-of select="//participant/senderRole"/>
        </xsl:attribute>
      </xsl:if>
      <pkg:ChargesPackage>
        <xsl:choose>
          <xsl:when test="//importedChanges/params">
            <xsl:apply-templates select="//importedChanges/params"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="//charges/params"/>
          </xsl:otherwise>
        </xsl:choose>
      </pkg:ChargesPackage>
    </req:ImportChargesRequest>
  </xsl:template>

  <!--Начисления-->
  <xsl:template match="//charges/params" xmlns:com="http://roskazna.ru/gisgmp/xsd/Common/2.1.1"
                xmlns:chg="http://roskazna.ru/gisgmp/xsd/Charge/2.1.1"
                xmlns:pkg="http://roskazna.ru/gisgmp/xsd/Package/2.1.1"
                xmlns:req="urn://roskazna.ru/gisgmp/xsd/services/import-charges/2.1.1"
                xmlns:org="http://roskazna.ru/gisgmp/xsd/Organization/2.1.1">
    <pkg:ImportedCharge>
      <xsl:attribute name="Id">I_<xsl:value-of select="./guid"/>
      </xsl:attribute>
      <xsl:attribute name="originatorId">
        <xsl:value-of select="//participant/originatorId"/>
      </xsl:attribute>
      <xsl:attribute name="supplierBillID">
        <xsl:value-of select="./supplierBillId"/>
      </xsl:attribute>
      <xsl:attribute name="billDate">
        <xsl:value-of select="./billDate"/>
      </xsl:attribute>
      <xsl:if test="./billValidUntil">
        <xsl:attribute name="validUntil">
          <xsl:value-of select="substring-before(./billValidUntil, 'T')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="totalAmount">
        <xsl:value-of select="number(translate(normalize-space(./totalAmount), '  .' , ''))"/>
      </xsl:attribute>
      <xsl:attribute name="purpose">
        <xsl:value-of select="./billFor"/>
      </xsl:attribute>
      <xsl:attribute name="kbk">
        <xsl:value-of select="./KBK"/>
      </xsl:attribute>
      <xsl:attribute name="oktmo">
        <xsl:value-of select="./OKTMO"/>
      </xsl:attribute>
      <xsl:if test="./origin">
        <xsl:attribute name="origin">
          <xsl:value-of select="./origin"/>
        </xsl:attribute>
      </xsl:if>
      <org:Payee>
        <xsl:attribute name="name">
          <xsl:value-of select="./organization/name"/>
        </xsl:attribute>
        <xsl:attribute name="inn">
          <xsl:value-of select="./organization/INN"/>
        </xsl:attribute>
        <xsl:attribute name="kpp">
          <xsl:value-of select="./organization/KPP"/>
        </xsl:attribute>
        <xsl:if test="./organization/OGRN">
          <xsl:attribute name="ogrn">
            <xsl:value-of select="./organization/OGRN"/>
          </xsl:attribute>
        </xsl:if>

        <com:OrgAccount>
          <xsl:attribute name="accountNumber">
            <xsl:value-of select="./organization/bank/account"/>
          </xsl:attribute>
          <com:Bank>
            <xsl:if test="./organization/bank/name">
              <xsl:attribute name="name">
                <xsl:value-of select="./organization/bank/name"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="bik">
              <xsl:value-of select="./organization/bank/BIK"/>
            </xsl:attribute>
            <xsl:if test="normalize-space(./organization/bank/corrAccount)!=''">
              <xsl:attribute name="correspondentBankAccount">
                <xsl:value-of select="./organization/bank/corrAccount"/>
              </xsl:attribute>
            </xsl:if>
          </com:Bank>
        </com:OrgAccount>
      </org:Payee>
      <chg:Payer>
        <xsl:attribute name="payerIdentifier">
          <xsl:value-of select="./payerId/payerId"/>
        </xsl:attribute>
        <xsl:attribute name="payerName">
          <xsl:value-of select="./payerName"/>
        </xsl:attribute>
      </chg:Payer>
      <chg:BudgetIndex>
        <xsl:attribute name="status">
          <xsl:value-of select="./budgetIndex/status"/>
        </xsl:attribute>
        <xsl:attribute name="paytReason">
          <xsl:value-of select="./budgetIndex/purpose"/>
        </xsl:attribute>
        <xsl:attribute name="taxPeriod">
          <xsl:value-of select="./budgetIndex/taxPeriod"/>
        </xsl:attribute>
        <xsl:attribute name="taxDocNumber">
          <xsl:value-of select="./budgetIndex/taxDocNumber"/>
        </xsl:attribute>
        <xsl:attribute name="taxDocDate">
          <xsl:value-of select="./budgetIndex/taxDocDate"/>
        </xsl:attribute>
      </chg:BudgetIndex>
      <xsl:if test="./additionalData/params/name[text()='discountSizePercent'] or
                    ./additionalData/params/name[text()='discountSizeMultiplier'] or
                    ./additionalData/params/name[text()='discountSize']">
        <xsl:choose>
          <xsl:when test="./additionalData/params/name[text()='discountSizePercent']">
            <!-- Процент скидки-->
            <com:DiscountSize>
              <com:Value>
                <xsl:value-of select="./additionalData/params/value[../name[text()='discountSizePercent']]"/>
              </com:Value>
              <xsl:call-template name="discountExpiry"/>
            </com:DiscountSize>
          </xsl:when>
          <xsl:when test="./additionalData/params/name[text()='discountSizeMultiplier']">
            <!--Коэффициент скидки-->
            <com:MultiplierSize>
              <com:Value>
                <xsl:value-of select="./additionalData/params/value[../name[text()='discountSizeMultiplier']]"/>
              </com:Value>
              <xsl:call-template name="discountExpiry"/>
            </com:MultiplierSize>
          </xsl:when>
          <xsl:otherwise>
            <!-- Фиксированный размер скидки-->
            <com:DiscountFixed>
              <com:Value>
                <xsl:value-of select="./additionalData/params/value[../name[text()='discountSize']]"/>
              </com:Value>
              <xsl:call-template name="discountExpiry"/>
            </com:DiscountFixed>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:apply-templates select="./additionalData/params"/>
    </pkg:ImportedCharge>
  </xsl:template>

  <!--Изменения-->
  <xsl:template match="//importedChanges/params" xmlns:com="http://roskazna.ru/gisgmp/xsd/Common/2.1.1"
                xmlns:chg="http://roskazna.ru/gisgmp/xsd/Charge/2.1.1"
                xmlns:pkg="http://roskazna.ru/gisgmp/xsd/Package/2.1.1"
                xmlns:req="urn://roskazna.ru/gisgmp/xsd/services/import-charges/2.1.1">
    <pkg:ImportedChange>
      <xsl:attribute name="Id">I_<xsl:value-of select="./guid"/>
      </xsl:attribute>
      <xsl:attribute name="originatorId">
        <xsl:value-of select="//participant/originatorId"/>
      </xsl:attribute>
      <pkg:SupplierBillId>
        <xsl:value-of select="./supplierBillId"/>
      </pkg:SupplierBillId>

      <xsl:apply-templates select="./changes/params"/>

      <com:ChangeStatus>
        <com:Meaning>
          <xsl:value-of select="./changeStatus/meaning"/>
        </com:Meaning>
        <xsl:if test="./changeStatus/reason">
          <com:Reason>
            <xsl:value-of select="./changeStatus/reason"/>
          </com:Reason>
        </xsl:if>
        <xsl:if test="./changeStatus/changeDate">
          <com:ChangeDate>
            <xsl:value-of select="./changeStatus/changeDate"/>
          </com:ChangeDate>
        </xsl:if>
      </com:ChangeStatus>
    </pkg:ImportedChange>
  </xsl:template>

  <xsl:template match="//changes/params" xmlns:pkg="http://roskazna.ru/gisgmp/xsd/Package/2.1.1">
    <pkg:Change>
      <xsl:attribute name="fieldNum">
        <xsl:value-of select="./fieldNum"/>
      </xsl:attribute>
      <xsl:apply-templates select="./changeValues/params"/>
    </pkg:Change>
  </xsl:template>

  <xsl:template match="//changeValues/params" xmlns:pkg="http://roskazna.ru/gisgmp/xsd/Package/2.1.1">
    <pkg:ChangeValue>
      <xsl:if test="./name">
        <xsl:attribute name="name">
          <xsl:value-of select="./name"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="value">
        <xsl:choose>
          <xsl:when test="../../fieldNum = '7'">
            <xsl:value-of select="number(translate(./value, '.', ''))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="./value"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </pkg:ChangeValue>
  </xsl:template>

  <xsl:template name="discountExpiry" xmlns:com="http://roskazna.ru/gisgmp/xsd/Common/2.1.1">
    <com:Expiry>
      <xsl:choose>
        <xsl:when test="./additionalData/params/name[text()='discountDate']">
          <xsl:value-of select="./additionalData/params/value[../name[text()='discountDate']]"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </com:Expiry>
  </xsl:template>

  <xsl:template match="//charges/params/additionalData/params" xmlns:com="http://roskazna.ru/gisgmp/xsd/Common/2.1.1">
    <!-- Скидки заполняются отдельно-->
    <xsl:if
      test="./name != 'discountDate' and ./name != 'discountSize' and ./name != 'discountSizePercent' and ./name !='discountSizeMultiplier'">
      <com:AdditionalData>
        <com:Name>
          <xsl:value-of select="./name"/>
        </com:Name>
        <com:Value>
          <xsl:value-of select="./value"/>
        </com:Value>
      </com:AdditionalData>
    </xsl:if>
  </xsl:template>

  <xsl:template name="businessProcessMetadata"/>

  <xsl:template name="personalSignature" xmlns:ns="urn://x-artefacts-smev-gov-ru/services/message-exchange/types/1.2">
    <ns:PersonalSignature/>
  </xsl:template>
</xsl:stylesheet>
  <!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

  <metaInformation>
    <scenarios>
      <scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\test\resources\request-our.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
                urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
                customvalidator="">
        <advancedProp name="bSchemaAware" value="true"/>
        <advancedProp name="xsltVersion" value="2.0"/>
        <advancedProp name="iWhitespace" value="0"/>
        <advancedProp name="bWarnings" value="true"/>
        <advancedProp name="bXml11" value="false"/>
        <advancedProp name="bUseDTD" value="false"/>
        <advancedProp name="bXsltOneIsOkay" value="true"/>
        <advancedProp name="bTinyTree" value="true"/>
        <advancedProp name="bGenerateByteCode" value="true"/>
        <advancedProp name="bExtensions" value="true"/>
        <advancedProp name="iValidation" value="0"/>
        <advancedProp name="iErrorHandling" value="fatal"/>
        <advancedProp name="sInitialTemplate" value=""/>
        <advancedProp name="sInitialMode" value=""/>
      </scenario>
    </scenarios>
    <MapperMetaTag>
      <MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
      <MapperBlockPosition></MapperBlockPosition>
      <TemplateContext></TemplateContext>
      <MapperFilter side="source"></MapperFilter>
    </MapperMetaTag>
  </metaInformation>
  -->