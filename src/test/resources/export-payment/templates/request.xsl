<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="http://xml.apache.org/xalan/java" exclude-result-prefixes="java">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <ns0:ExportPaymentsRequest
      xmlns:com="http://roskazna.ru/gisgmp/xsd/Common/2.1.1"
      xmlns:org="http://roskazna.ru/gisgmp/xsd/Organization/2.1.1"
      xmlns:sc="http://roskazna.ru/gisgmp/xsd/SearchConditions/2.1.1"
      xmlns:pmnt="http://roskazna.ru/gisgmp/xsd/Payment/2.1.1"
      xmlns:ns0="urn://roskazna.ru/gisgmp/xsd/services/export-payments/2.1.1">
      <xsl:choose>
        <xsl:when test="//commercial = 'true'">
          <xsl:attribute name="Id">U_<xsl:value-of select="//params/guid"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="Id">G_<xsl:value-of select="//params/guid"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="timestamp">
        <xsl:value-of select="//params/date"/>
      </xsl:attribute>
      <xsl:attribute name="senderIdentifier">
        <xsl:value-of select="//participant/senderId"/>
      </xsl:attribute>
      <xsl:if test="//participant/senderRole">
        <xsl:attribute name="senderRole">
          <xsl:value-of select="//participant/senderRole"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="//participant/originatorId">
        <xsl:attribute name="originatorId">
          <xsl:value-of select="//participant/originatorId"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="//pageLength and //pageNumber">
        <com:Paging>
          <xsl:attribute name="pageLength">
            <xsl:value-of select="//pageLength"/>
          </xsl:attribute>
          <xsl:attribute name="pageNumber">
            <xsl:value-of select="//pageNumber"/>
          </xsl:attribute>
        </com:Paging>
      </xsl:if>
      <sc:PaymentsExportConditions>
        <xsl:attribute name="kind">
          <xsl:value-of select="//kind"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="0 &lt; count(//paymentIdList/*)">
            <sc:PaymentsConditions>
              <xsl:for-each select="//paymentIdList/*">
                <sc:PaymentId>
                  <xsl:value-of select="text()"/>
                </sc:PaymentId>
              </xsl:for-each>
            </sc:PaymentsConditions>
          </xsl:when>
          <xsl:when test="0 &lt; count(//supplierBillIdList/*)">
            <sc:ChargesConditions>
              <xsl:for-each select="//supplierBillIdList/*">
                <sc:SupplierBillID>
                  <xsl:value-of select="."/>
                </sc:SupplierBillID>
              </xsl:for-each>
              <xsl:if test="//startDate and //endDate">
                <com:TimeInterval>
                  <xsl:attribute name="startDate">
                    <xsl:value-of select="//startDate"/>
                  </xsl:attribute>
                  <xsl:attribute name="endDate">
                    <xsl:value-of select="//endDate"/>
                  </xsl:attribute>
                </com:TimeInterval>
              </xsl:if>
            </sc:ChargesConditions>
          </xsl:when>
          <xsl:when test="0 &lt; count(//payerIdList/*)">
            <sc:PayersConditions>
              <xsl:for-each select="//payerIdList/*">
                <sc:PayerIdentifier>
                  <xsl:value-of select="."/>
                </sc:PayerIdentifier>
              </xsl:for-each>
              <xsl:if test="//startDate and //endDate">
                <com:TimeInterval>
                  <xsl:attribute name="startDate">
                    <xsl:value-of select="//startDate"/>
                  </xsl:attribute>
                  <xsl:attribute name="endDate">
                    <xsl:value-of select="//endDate"/>
                  </xsl:attribute>
                </com:TimeInterval>
              </xsl:if>
              <xsl:if test="0 &lt; count(//kbkList/*)">
                <com:KBKlist>
                  <xsl:for-each select="//kbkList/*">
                    <com:KBK>
                      <xsl:value-of select="."/>
                    </com:KBK>
                  </xsl:for-each>
                </com:KBKlist>
              </xsl:if>
            </sc:PayersConditions>
          </xsl:when>
          <xsl:otherwise>
            <sc:TimeConditions>
              <com:TimeInterval>
                <xsl:attribute name="startDate">
                  <xsl:value-of select="//startDate"/>
                </xsl:attribute>
                <xsl:attribute name="endDate">
                  <xsl:value-of select="//endDate"/>
                </xsl:attribute>
              </com:TimeInterval>
              <xsl:if test="0 &lt; count(//SubordinateIdList/*)">
                <xsl:for-each select="//SubordinateIdList/*">
                  <xsl:if test="starts-with(local-name(), 'TaxpayerIdentification')">
                    <sc:Beneficiary>
                      <xsl:attribute name="inn">
                        <xsl:value-of select="./inn"/>
                      </xsl:attribute>
                      <xsl:if test="./kpp">
                        <xsl:attribute name="kpp">
                          <xsl:value-of select="./kpp"/>
                        </xsl:attribute>
                      </xsl:if>
                    </sc:Beneficiary>
                  </xsl:if>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="0 &lt; count(//kbkList/*)">
                <com:KBKlist>
                  <xsl:for-each select="//kbkList/*">
                    <com:KBK>
                      <xsl:value-of select="."/>
                    </com:KBK>
                  </xsl:for-each>
                </com:KBKlist>
              </xsl:if>
            </sc:TimeConditions>
          </xsl:otherwise>
        </xsl:choose>
      </sc:PaymentsExportConditions>
    </ns0:ExportPaymentsRequest>
  </xsl:template>
</xsl:stylesheet>
