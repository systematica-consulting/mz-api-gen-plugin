<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ns="urn://roskazna.ru/gisgmp/xsd/services/export-payments/2.1.1"
                xmlns:ns1="http://roskazna.ru/gisgmp/xsd/Payment/2.1.1"
                xmlns:ns2="http://roskazna.ru/gisgmp/xsd/Organization/2.1.1"
                xmlns:ns3="http://roskazna.ru/gisgmp/xsd/Common/2.1.1"
                xmlns:map="java.util.Map"
                exclude-result-prefixes="map">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
  <xsl:param name="headers"/>

  <xsl:template match="/">
    <params>
      <messageId>
        <xsl:value-of select="map:get($headers, 'originalMessageId')"/>
      </messageId>
      <respId>
        <xsl:value-of select="//*[local-name()='ExportPaymentsResponse']/@Id"/>
      </respId>
      <respSenderId>
        <xsl:value-of select="//*[local-name()='ExportPaymentsResponse']/@RqId"/>
      </respSenderId>
      <respTimestamp>
        <xsl:value-of select="//*[local-name()='ExportPaymentsResponse']/@timestamp"/>
      </respTimestamp>
      <hasMore>
        <xsl:value-of select="//*[local-name()='ExportPaymentsResponse']/@hasMore"/>
      </hasMore>

      <resultCode>
        <xsl:choose>
          <xsl:when test="//*[local-name()='RequestRejected']">
            <xsl:value-of select="//*[local-name()='RequestRejected']/*[local-name()='RejectionReasonCode']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='SmevFault']">
            <xsl:value-of select="//*[local-name()='SmevFault']/*[local-name()='Code']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='RequestStatus']">
            <xsl:value-of select="//*[local-name()='RequestStatus']/*[local-name()='StatusCode']"/>
          </xsl:when>
        </xsl:choose>
      </resultCode>
      <resultDesc>
        <xsl:choose>
          <xsl:when test="//*[local-name()='RequestRejected']">
            <xsl:value-of select="//*[local-name()='RequestRejected']/*[local-name()='RejectionReasonDescription']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='SmevFault']">
            <xsl:value-of select="//*[local-name()='SmevFault']/*[local-name()='Description']"/>
          </xsl:when>
          <xsl:when test="//*[local-name()='RequestStatus']">
            <xsl:value-of select="//*[local-name()='RequestStatus']/*[local-name()='StatusDescription']"/>
          </xsl:when>
        </xsl:choose>
      </resultDesc>

      <paymentInfos>
        <xsl:apply-templates select="//*[local-name()='PaymentInfo']"/>
      </paymentInfos>
    </params>
  </xsl:template>

  <xsl:template match="*[local-name()='PaymentInfo']">
    <gg116PaymentInfo>
      <payment>
        <supplierBillId>
          <xsl:choose>
            <xsl:when test="@supplierBillID != '0'">
              <xsl:value-of select="@supplierBillID"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="./ns:AcknowledgmentInfo/ns:SupplierBillID"/>
            </xsl:otherwise>
          </xsl:choose>
        </supplierBillId>
        <forcedAck>
          <xsl:choose>
            <xsl:when test="@supplierBillID != '0'">false</xsl:when>
            <xsl:otherwise>true</xsl:otherwise>
          </xsl:choose>
        </forcedAck>
        <narrative>
          <xsl:value-of select="@purpose"/>
        </narrative>
        <amount>
          <xsl:choose>
            <xsl:when test="string-length(@amount) > 2">
              <xsl:value-of
                select="concat(substring(@amount, 0, string-length(@amount) - 1), '.', substring(@amount, string-length(@amount) - 1))"/>
            </xsl:when>
            <xsl:when test="@amount = '0'">0.00</xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@amount"/>
            </xsl:otherwise>
          </xsl:choose>
        </amount>
        <receiptDate>
          <xsl:value-of select="@receiptDate"/>
        </receiptDate>
        <paymentDate>
          <xsl:value-of select="@paymentDate"/>
        </paymentDate>
        <budgetIndex>
          <status>
            <xsl:value-of select="./ns1:BudgetIndex/@status"/>
          </status>
          <purpose>
            <xsl:value-of select="./ns1:BudgetIndex/@paytReason"/>
          </purpose>
          <taxPeriod>
            <xsl:value-of select="./ns1:BudgetIndex/@taxPeriod"/>
          </taxPeriod>
          <taxDocNumber>
            <xsl:value-of select="./ns1:BudgetIndex/@taxDocNumber"/>
          </taxDocNumber>
          <taxDocDate>
            <xsl:value-of select="./ns1:BudgetIndex/@taxDocDate"/>
          </taxDocDate>
        </budgetIndex>
        <accDocNo>
          <xsl:value-of select="./ns1:AccDoc/@accDocNo"/>
        </accDocNo>
        <accDocDate>
          <xsl:value-of select="./ns1:AccDoc/@accDocDate"/>
        </accDocDate>
        <paymentIdData>
          <xsl:choose>
            <xsl:when test="./ns1:PaymentOrg/ns2:Bank">
              <bank>
                <imported>true</imported>
                <name>
                  <xsl:value-of select="./ns1:PaymentOrg/ns2:Bank/@name"/>
                </name>
                <BIK>
                  <xsl:value-of select="./ns1:PaymentOrg/ns2:Bank/@bik"/>
                </BIK>
                <corrAccount>
                  <xsl:value-of select="./ns1:PaymentOrg/ns2:Bank/@correspondentBankAccount"/>
                </corrAccount>
              </bank>
            </xsl:when>
            <xsl:when test="./ns1:PaymentOrg/ns2:UFK">
              <ufk>
                <xsl:value-of select="./ns1:PaymentOrg/ns2:UFK"/>
              </ufk>
            </xsl:when>
            <xsl:when test="./ns1:PaymentOrg/ns2:Other">
              <other>
                <xsl:value-of select="./ns1:PaymentOrg/ns2:Other"/>
              </other>
            </xsl:when>
          </xsl:choose>
          <systemIdentifier>
            <xsl:value-of select="@paymentId"/>
          </systemIdentifier>
        </paymentIdData>
        <additionalData>
          <xsl:for-each select="./ns3:AdditionalData">
            <gg116AdditionalData>
              <xsl:attribute name="_json">asList</xsl:attribute>
              <name>
                <xsl:value-of select="./ns3:Name"/>
              </name>
              <value>
                <xsl:value-of select="./ns3:Value"/>
              </value>
            </gg116AdditionalData>
          </xsl:for-each>
        </additionalData>
        <!--<recipientServicesId></recipientServicesId>-->
        <!--<payerPA></payerPA>-->
        <changeStatus>
          <xsl:value-of select="./ns3:ChangeStatusInfo/ns3:Meaning"/>
        </changeStatus>
        <changeReason>
          <xsl:value-of select="./ns3:ChangeStatusInfo/ns3:Reason"/>
        </changeReason>
        <KBK>
          <xsl:value-of select="@kbk"/>
        </KBK>
        <OKTMO>
          <xsl:value-of select="@oktmo"/>
        </OKTMO>
        <transKind>
          <xsl:value-of select="@transKind"/>
        </transKind>
        <!--<transContent></transContent>-->
        <!--<paytCondition></paytCondition>-->
        <!--<acptTerm></acptTerm>-->
        <!--<maturityDate></maturityDate>-->
        <docDispatchDate>
          <xsl:value-of select="@deliveryDate"/>
        </docDispatchDate>
        <!--<priority></priority>-->
        <xsl:if test="./ns1:Payer">
          <payerId>
            <xsl:value-of select="./ns1:Payer/@payerIdentifier"/>
          </payerId>
          <payerName>
            <xsl:value-of select="./ns1:Payer/@payerName"/>
          </payerName>
          <payerAccount>
            <xsl:value-of select="./ns1:Payer/@payerAccount"/>
          </payerAccount>
        </xsl:if>
        <payeeName>
          <xsl:value-of select="./ns2:Payee/@name"/>
        </payeeName>
        <payeeINN>
          <xsl:value-of select="./ns2:Payee/@inn"/>
        </payeeINN>
        <payeeKPP>
          <xsl:value-of select="./ns2:Payee/@kpp"/>
        </payeeKPP>
        <payeeAccount>
          <xsl:value-of select="./ns2:Payee/ns3:OrgAccount/@accountNumber"/>
        </payeeAccount>
        <payeeBank>
          <imported>true</imported>
          <name>
            <xsl:value-of select="./ns2:Payee/ns3:OrgAccount/ns3:Bank/@name"/>
          </name>
          <BIK>
            <xsl:value-of select="./ns2:Payee/ns3:OrgAccount/ns3:Bank/@bik"/>
          </BIK>
          <corrAccount>
            <xsl:value-of select="./ns2:Payee/ns3:OrgAccount/ns3:Bank/@correspondentBankAccount"/>
          </corrAccount>
        </payeeBank>
        <xsl:if test="./ns1:PartialPayt">
          <partialPaytNo>
            <xsl:value-of select="./ns1:PartialPayt/@paytNo"/>
          </partialPaytNo>
          <partialPaytTransKind>
            <xsl:value-of select="./ns1:PartialPayt/@transKind"/>
          </partialPaytTransKind>
          <sumResidualPayt>
            <xsl:value-of select="./ns1:PartialPayt/@sumResidualPayt"/>
          </sumResidualPayt>
          <partialAccDocNo>
            <xsl:value-of select="./ns1:PartialPayt/ns1:AccDoc/@accDocNo"/>
          </partialAccDocNo>
          <partialAccDocDate>
            <xsl:value-of select="./ns1:PartialPayt/ns1:AccDoc/@accDocDate"/>
          </partialAccDocDate>
        </xsl:if>
        <!--<paymentStatus></paymentStatus>-->
      </payment>
      <changeStatusInfo>
        <!--<gg2ChangeStatus>-->
        <meaning>
          <xsl:value-of select="./ns3:ChangeStatusInfo/ns3:Meaning"/>
        </meaning>
        <reason>
          <xsl:value-of select="./ns3:ChangeStatusInfo/ns3:Reason"/>
        </reason>
        <changeDate>
          <xsl:value-of select="./ns3:ChangeStatusInfo/ns3:ChangeDate"/>
        </changeDate>
        <!--</gg2ChangeStatus>-->
      </changeStatusInfo>
    </gg116PaymentInfo>


  </xsl:template>
</xsl:stylesheet>