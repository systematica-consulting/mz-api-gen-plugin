<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:map="java.util.Map"
                exclude-result-prefixes="map">
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
  <xsl:param name="headers"/>

  <xsl:template match="/">
    <xsl:variable name="SvUL" select="//*[local-name()='СвЮЛ']"/>
    <params>
      <messageId>
        <xsl:value-of select="map:get($headers, 'originalMessageId')"/>
      </messageId>
      <IdDok>
        <xsl:value-of select="//*[local-name()='Документ']/@ИдДок"/>
      </IdDok>
      <KodObr _json="as_{//*[local-name()='КодОбр']}">
        <xsl:value-of select="//*[local-name()='КодОбр']"/>
      </KodObr>
      <DataVyp>
        <xsl:value-of select="$SvUL/@ДатаВып"/>
      </DataVyp>
      <OGRN>
        <xsl:value-of select="$SvUL/@ОГРН"/>
      </OGRN>
      <DataOGRN>
        <xsl:value-of select="$SvUL/@ДатаОГРН"/>
      </DataOGRN>
      <INN>
        <xsl:value-of select="$SvUL/@ИНН"/>
      </INN>
      <KPP>
        <xsl:value-of select="$SvUL/@КПП"/>
      </KPP>
      <SprOPF>
        <xsl:value-of select="$SvUL/@СпрОПФ"/>
      </SprOPF>
      <KodOPF _json="as_{$SvUL/@КодОПФ}">
        <xsl:value-of select="$SvUL/@КодОПФ"/>
      </KodOPF>
      <PolnNaimOPF>
        <xsl:value-of select="$SvUL/@ПолнНаимОПФ"/>
      </PolnNaimOPF>
      <xsl:if test="$SvUL/*[local-name()= 'СвПолном']">
        <xsl:variable name="SvPolnom" select="$SvUL/*[local-name()= 'СвПолном']"/>
        <SvPolnom>
          <GRNDataGRN>
            <xsl:value-of select="$SvPolnom/*[local-name()='ГРНДата']/@ГРН"/>
          </GRNDataGRN>
          <GRNDataDataZapisi>
            <xsl:value-of select="$SvPolnom/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
          </GRNDataDataZapisi>
          <GRNDataIsprGRN>
            <xsl:value-of select="$SvPolnom/*[local-name()='ГРНДатаИспр']/@ГРН"/>
          </GRNDataIsprGRN>
          <GRNDataIsprDataZapisi>
            <xsl:value-of select="$SvPolnom/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
          </GRNDataIsprDataZapisi>
          <VidPolnom>
            <xsl:value-of select="$SvPolnom/@ВидПолном"/>
          </VidPolnom>
        </SvPolnom>
      </xsl:if>
      <SvKorpDog>
        <xsl:for-each select="$SvUL/*[local-name()= 'СвКорпДог']">
          <smevSvKorpDog>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <VidSvedKorpDog>
              <xsl:value-of select="@ВидСведКорпДог"/>
            </VidSvedKorpDog>
          </smevSvKorpDog>
        </xsl:for-each>
      </SvKorpDog>
      <NaimYULPoln>
        <xsl:value-of select="$SvUL/*[local-name()='СвНаимЮЛ']/@НаимЮЛПолн"/>
      </NaimYULPoln>
      <NaimYULSokr>
        <xsl:value-of select="$SvUL/*[local-name()='СвНаимЮЛ']/@НаимЮЛСокр"/>
      </NaimYULSokr>
      <GRN>
        <xsl:value-of select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
      </GRN>
      <DataZapisi>
        <xsl:value-of select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </DataZapisi>
      <GRNDataIsprGRN>
        <xsl:value-of select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </GRNDataIsprGRN>
      <GRNDataIsprDataZapisi>
        <xsl:value-of select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </GRNDataIsprDataZapisi>
      <SvNaimYULKodOKIN>
        <xsl:for-each select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()= 'СвНаимЮЛКодОКИН']">
          <smevSvNaimYULKodOKIN>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <KodOKIN>
              <xsl:value-of select="@КодОКИН"/>
            </KodOKIN>
            <NaimOKIN>
              <xsl:value-of select="@НаимОКИН"/>
            </NaimOKIN>
          </smevSvNaimYULKodOKIN>
        </xsl:for-each>
      </SvNaimYULKodOKIN>
      <xsl:if test="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']">
        <xsl:variable name="SvNaimYULPolnIn" select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']"/>
        <SvNaimYULPolnIn>
          <GRNDataGRN>
            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
          </GRNDataGRN>
          <GRNDataDataZapisi>
            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
          </GRNDataDataZapisi>
          <GRNDataIsprGRN>
            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
          </GRNDataIsprGRN>
          <GRNDataIsprDataZapisi>
            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
          </GRNDataIsprDataZapisi>
          <NaimPoln>
            <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
          </NaimPoln>
        </SvNaimYULPolnIn>
      </xsl:if>
      <xsl:if test="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()= 'СвНаимЮЛСокр']">
        <xsl:variable name="SvNaimYULSokr" select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()= 'СвНаимЮЛСокр']"/>
        <SvNaimYULSokr>
          <GRNDataGRN>
            <xsl:value-of select="$SvNaimYULSokr/*[local-name()='ГРНДата']/@ГРН"/>
          </GRNDataGRN>
          <GRNDataDataZapisi>
            <xsl:value-of select="$SvNaimYULSokr/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
          </GRNDataDataZapisi>
          <GRNDataIsprGRN>
            <xsl:value-of select="$SvNaimYULSokr/*[local-name()='ГРНДатаИспр']/@ГРН"/>
          </GRNDataIsprGRN>
          <GRNDataIsprDataZapisi>
            <xsl:value-of select="$SvNaimYULSokr/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
          </GRNDataIsprDataZapisi>
          <NaimSokr>
            <xsl:value-of select="$SvNaimYULSokr/@НаимСокр"/>
          </NaimSokr>
        </SvNaimYULSokr>
      </xsl:if>
      <xsl:if test="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()= 'СвНаимЮЛСокрИн']">
        <xsl:variable name="SvNaimYULSokrIn" select="$SvUL/*[local-name()='СвНаимЮЛ']/*[local-name()= 'СвНаимЮЛСокрИн']"/>
        <SvNaimYULSokrIn>
          <GRNDataGRN>
            <xsl:value-of select="$SvNaimYULSokrIn/*[local-name()='ГРНДата']/@ГРН"/>
          </GRNDataGRN>
          <GRNDataDataZapisi>
            <xsl:value-of select="$SvNaimYULSokrIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
          </GRNDataDataZapisi>
          <GRNDataIsprGRN>
            <xsl:value-of select="$SvNaimYULSokrIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
          </GRNDataIsprGRN>
          <GRNDataIsprDataZapisi>
            <xsl:value-of select="$SvNaimYULSokrIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
          </GRNDataIsprDataZapisi>
          <NaimSokr>
            <xsl:value-of select="$SvNaimYULSokrIn/@НаимСокр"/>
          </NaimSokr>
        </SvNaimYULSokrIn>
      </xsl:if>
      <xsl:variable name="SvAdresUL" select="$SvUL/*[local-name() = 'СвАдресЮЛ']"/>
      <xsl:if test="$SvAdresUL/*[local-name() = 'СвАдрЮЛФИАС']">
        <xsl:variable name="SvAdrYULFIAS" select="$SvAdresUL/*[local-name() = 'СвАдрЮЛФИАС']"/>
        <SvAdrYULFIAS>
          <GRNDataGRN>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ГРНДата']/@ГРН"/>
          </GRNDataGRN>
          <GRNDataDataZapisi>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
          </GRNDataDataZapisi>
          <GRNDataIsprGRN>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ГРНДатаИспр']/@ГРН"/>
          </GRNDataIsprGRN>
          <GRNDataIsprDataZapisi>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
          </GRNDataIsprDataZapisi>
          <GorodSelPoselenVidKod>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ГородСелПоселен']/@ВидКод"/>
          </GorodSelPoselenVidKod>
          <GorodSelPoselenNaim>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ГородСелПоселен']/@Наим"/>
          </GorodSelPoselenNaim>
          <ZdaniyeNomer>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='Здание']/@Номер"/>
          </ZdaniyeNomer>
          <ZdaniyeTip>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='Здание']/@Тип"/>
          </ZdaniyeTip>
          <MunitsipRayonVidKod>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='МуниципРайон']/@ВидКод"/>
          </MunitsipRayonVidKod>
          <MunitsipRayonNaim>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='МуниципРайон']/@Наим"/>
          </MunitsipRayonNaim>
          <NaimRegion>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='НаимРегион']"/>
          </NaimRegion>
          <NaselenPunktVid>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='НаселенПункт']/@Вид"/>
          </NaselenPunktVid>
          <NaselenPunktNaim>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='НаселенПункт']/@Наим"/>
          </NaselenPunktNaim>
          <PomeshchZdaniyaNomer>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ПомещЗдания']/@Номер"/>
          </PomeshchZdaniyaNomer>
          <PomeshchZdaniyaTip>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ПомещЗдания']/@Тип"/>
          </PomeshchZdaniyaTip>
          <PomeshchKvartiryNomer>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ПомещКвартиры']/@Номер"/>
          </PomeshchKvartiryNomer>
          <PomeshchKvartiryTip>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ПомещКвартиры']/@Тип"/>
          </PomeshchKvartiryTip>
          <Region>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='Регион']"/>
          </Region>
          <ElPlanStrukturNaim>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ЭлПланСтруктур']/@Наим"/>
          </ElPlanStrukturNaim>
          <ElPlanStrukturTip>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ЭлПланСтруктур']/@Тип"/>
          </ElPlanStrukturTip>
          <ElUlDorSetiNaim>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ЭлУлДорСети']/@Наим"/>
          </ElUlDorSetiNaim>
          <ElUlDorSetiTip>
            <xsl:value-of select="$SvAdrYULFIAS/*[local-name()='ЭлУлДорСети']/@Тип"/>
          </ElUlDorSetiTip>
          <IdNom>
            <xsl:value-of select="$SvAdrYULFIAS/@ИдНом"/>
          </IdNom>
          <Indeks>
            <xsl:value-of select="$SvAdrYULFIAS/@Индекс"/>
          </Indeks>
        </SvAdrYULFIAS>
      </xsl:if>
      <xsl:if test="$SvAdresUL/*[local-name()= 'СвМНЮЛ']">
        <xsl:variable name="SvMNYUL" select="$SvAdresUL/*[local-name()= 'СвМНЮЛ']"/>
        <SvMNYUL>
          <GRNDataGRN>
            <xsl:value-of select="$SvMNYUL/*[local-name()='ГРНДата']/@ГРН"/>
          </GRNDataGRN>
          <GRNDataDataZapisi>
            <xsl:value-of select="$SvMNYUL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
          </GRNDataDataZapisi>
          <GRNDataIsprGRN>
            <xsl:value-of select="$SvMNYUL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
          </GRNDataIsprGRN>
          <GRNDataIsprDataZapisi>
            <xsl:value-of select="$SvMNYUL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
          </GRNDataIsprDataZapisi>
          <GorodSelPoselenVidKod>
            <xsl:value-of select="$SvMNYUL/*[local-name()='ГородСелПоселен']/@ВидКод"/>
          </GorodSelPoselenVidKod>
          <GorodSelPoselenNaim>
            <xsl:value-of select="$SvMNYUL/*[local-name()='ГородСелПоселен']/@Наим"/>
          </GorodSelPoselenNaim>
          <MunitsipRayonVidKod>
            <xsl:value-of select="$SvMNYUL/*[local-name()='МуниципРайон']/@ВидКод"/>
          </MunitsipRayonVidKod>
          <MunitsipRayonNaim>
            <xsl:value-of select="$SvMNYUL/*[local-name()='МуниципРайон']/@Наим"/>
          </MunitsipRayonNaim>
          <NaimRegion>
            <xsl:value-of select="$SvMNYUL/*[local-name()='НаимРегион']"/>
          </NaimRegion>
          <NaselenPunktVid>
            <xsl:value-of select="$SvMNYUL/*[local-name()='НаселенПункт']/@Вид"/>
          </NaselenPunktVid>
          <NaselenPunktNaim>
            <xsl:value-of select="$SvMNYUL/*[local-name()='НаселенПункт']/@Наим"/>
          </NaselenPunktNaim>
          <Region>
            <xsl:value-of select="$SvMNYUL/*[local-name()='Регион']"/>
          </Region>
          <IdNom>
            <xsl:value-of select="$SvMNYUL/@ИдНом"/>
          </IdNom>
        </SvMNYUL>
      </xsl:if>
      <xsl:variable name="AdresRF" select="$SvAdresUL/*[local-name()='АдресРФ']"/>
      <AdresRFIndex _json="as_{$AdresRF/@Индекс}">
        <xsl:value-of select="$AdresRF/@Индекс"/>
      </AdresRFIndex>
      <AdresRFKodRegion _json="as_{$AdresRF/@КодРегион}">
        <xsl:value-of select="$AdresRF/@КодРегион"/>
      </AdresRFKodRegion>
      <AdresRFKodAdrKladr _json="as_{$AdresRF/@КодАдрКладр}">
        <xsl:value-of select="$AdresRF/@КодАдрКладр"/>
      </AdresRFKodAdrKladr>
      <AdresRFDom>
        <xsl:value-of select="$AdresRF/@Дом"/>
      </AdresRFDom>
      <AdresRFKorpus>
        <xsl:value-of select="$AdresRF/@Корпус"/>
      </AdresRFKorpus>
      <AdresRFKvart>
        <xsl:value-of select="$AdresRF/@Кварт"/>
      </AdresRFKvart>
      <AdresRFRegion>
        <xsl:value-of select="$AdresRF/*[local-name()='Регион']/@НаимРегион"/>
      </AdresRFRegion>
      <AdresRFRajon>
        <xsl:value-of select="$AdresRF/*[local-name()='Район']/@НаимРайон"/>
      </AdresRFRajon>
      <AdresRFGorod>
        <xsl:value-of select="$AdresRF/*[local-name()='Город']/@НаимГород"/>
      </AdresRFGorod>
      <AdresRFNaselPunkt>
        <xsl:value-of select="$AdresRF/*[local-name()='НаселПункт']/@НаимНаселПункт"/>
      </AdresRFNaselPunkt>
      <AdresRFUlica>
        <xsl:value-of select="$AdresRF/*[local-name()='Улица']/@НаимУлица"/>
      </AdresRFUlica>
      <SvNedAdresYUL>
        <xsl:for-each select="$SvAdresUL/*[local-name()='СвНедАдресЮЛ']">
          <smevInvalidAddressUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <PriznNedAdresYUL>
              <xsl:value-of select="@ПризнНедАдресЮЛ"/>
            </PriznNedAdresYUL>
            <TekstNedAdresYUL>
              <xsl:value-of select="@ТекстНедАдресЮЛ"/>
            </TekstNedAdresYUL>
            <NaimSuda>
              <xsl:value-of select="*[local-name()='РешСудНедАдр']/@НаимСуда"/>
            </NaimSuda>
            <Nomer>
              <xsl:value-of select="*[local-name()='РешСудНедАдр']/@Номер"/>
            </Nomer>
            <Data>
              <xsl:value-of select="*[local-name()='РешСудНедАдр']/@Дата"/>
            </Data>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
          </smevInvalidAddressUL>
        </xsl:for-each>
      </SvNedAdresYUL>
      <xsl:variable name="SvReshIzmMN" select="$SvAdresUL/*[local-name()='СвРешИзмМН']"/>
      <TekstReshIzmMN>
        <xsl:value-of select="$SvReshIzmMN/@ТекстРешИзмМН"/>
      </TekstReshIzmMN>
      <SvReshIzmMNRegion>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='Регион']/@НаимРегион"/>
      </SvReshIzmMNRegion>
      <SvReshIzmMNRajon>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='Район']/@НаимРайон"/>
      </SvReshIzmMNRajon>
      <SvReshIzmMNGorod>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='Город']/@НаимГород"/>
      </SvReshIzmMNGorod>
      <SvReshIzmMNNaselPunkt>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='НаселПункт']/@НаимНаселПункт"/>
      </SvReshIzmMNNaselPunkt>
      <SvReshIzmMNGRNDataGRN>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='ГРНДата']/@ГРН"/>
      </SvReshIzmMNGRNDataGRN>
      <SvReshIzmMNGRNDataDataZapisi>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvReshIzmMNGRNDataDataZapisi>
      <SvReshIzmMNGRNDataIsprGRN>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvReshIzmMNGRNDataIsprGRN>
      <SvReshIzmMNGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvReshIzmMN/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvReshIzmMNGRNDataIsprDataZapisi>
      <SvAdrElPochtyEmail>
        <xsl:value-of select="$SvUL/*[local-name()='СвАдрЭлПочты']/@E-mail"/>
      </SvAdrElPochtyEmail>
      <SvAdrElPochtyGRNDataGRN>
        <xsl:value-of select="$SvUL/*[local-name()='СвАдрЭлПочты']/*[local-name()='ГРНДата']/@ГРН"/>
      </SvAdrElPochtyGRNDataGRN>
      <SvAdrElPochtyGRNDataDataZapisi>
        <xsl:value-of select="$SvUL/*[local-name()='СвАдрЭлПочты']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvAdrElPochtyGRNDataDataZapisi>
      <SvAdrElPochtyGRNDataIsprGRN>
        <xsl:value-of select="$SvUL/*[local-name()='СвАдрЭлПочты']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvAdrElPochtyGRNDataIsprGRN>
      <SvAdrElPochtyGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvUL/*[local-name()='СвАдрЭлПочты']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvAdrElPochtyGRNDataIsprDataZapisi>
      <xsl:variable name="SvObrYUL" select="$SvUL/*[local-name()='СвОбрЮЛ']"/>
      <SvObrYULOGRN>
        <xsl:value-of select="$SvObrYUL/@ОГРН"/>
      </SvObrYULOGRN>
      <SvObrYULDataOGRN>
        <xsl:value-of select="$SvObrYUL/@ДатаОГРН"/>
      </SvObrYULDataOGRN>
      <SvObrYULRegNom>
        <xsl:value-of select="$SvObrYUL/@РегНом"/>
      </SvObrYULRegNom>
      <SvObrYULDataReg>
        <xsl:value-of select="$SvObrYUL/@ДатаРег"/>
      </SvObrYULDataReg>
      <SvObrYULNaimRO>
        <xsl:value-of select="$SvObrYUL/@НаимРО"/>
      </SvObrYULNaimRO>
      <SvObrYULKodSpObrYUL _json="as_{$SvObrYUL/*[local-name()='СпОбрЮЛ']/@КодСпОбрЮЛ}">
        <xsl:value-of select="$SvObrYUL/*[local-name()='СпОбрЮЛ']/@КодСпОбрЮЛ"/>
      </SvObrYULKodSpObrYUL>
      <SvObrYULNaimSpObrYUL>
        <xsl:value-of select="$SvObrYUL/*[local-name()='СпОбрЮЛ']/@НаимСпОбрЮЛ"/>
      </SvObrYULNaimSpObrYUL>
      <SvObrYULGRNDataGRN>
        <xsl:value-of select="$SvObrYUL/*[local-name()='ГРНДата']/@ГРН"/>
      </SvObrYULGRNDataGRN>
      <SvObrYULGRNDataDataZapisi>
        <xsl:value-of select="$SvObrYUL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvObrYULGRNDataDataZapisi>
      <SvObrYULGRNDataIsprGRN>
        <xsl:value-of select="$SvObrYUL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvObrYULGRNDataIsprGRN>
      <SvObrYULGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvObrYUL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvObrYULGRNDataIsprDataZapisi>
      <xsl:if test="$SvObrYUL/*[local-name()= 'СвРегИнЮЛ']">
        <xsl:variable name="SvRegInYUL" select="$SvObrYUL/*[local-name()= 'СвРегИнЮЛ']"/>
        <SvRegInYUL>
          <INNYUL>
            <xsl:value-of select="$SvRegInYUL/@ИННЮЛ"/>
          </INNYUL>
          <KodIOStrReg>
            <xsl:value-of select="$SvRegInYUL/@КодИОСтрРег"/>
          </KodIOStrReg>
          <NaimStran>
            <xsl:value-of select="$SvRegInYUL/@НаимСтран"/>
          </NaimStran>
          <NaimYULPolnLat>
            <xsl:value-of select="$SvRegInYUL/@НаимЮЛПолнЛат"/>
          </NaimYULPolnLat>
          <NaimYULPolnRus>
            <xsl:value-of select="$SvRegInYUL/@НаимЮЛПолнРус"/>
          </NaimYULPolnRus>
          <OKSM>
            <xsl:value-of select="$SvRegInYUL/@ОКСМ"/>
          </OKSM>
          <RegNomer>
            <xsl:value-of select="$SvRegInYUL/@РегНомер"/>
          </RegNomer>
        </SvRegInYUL>
      </xsl:if>
      <SvObrYULStatusMKF>
        <xsl:value-of select="$SvObrYUL/@СтатусМКФ"/>
      </SvObrYULStatusMKF>
      <xsl:variable name="SvRegOrg" select="$SvUL/*[local-name()='СвРегОрг']"/>
      <SvRegOrgKodNO _json="as_{$SvRegOrg/@КодНО}">
        <xsl:value-of select="$SvRegOrg/@КодНО"/>
      </SvRegOrgKodNO>
      <SvRegOrgNaimNO>
        <xsl:value-of select="$SvRegOrg/@НаимНО"/>
      </SvRegOrgNaimNO>
      <SvRegOrgAdrRO>
        <xsl:value-of select="$SvRegOrg/@АдрРО"/>
      </SvRegOrgAdrRO>
      <SvRegOrgGRNDataGRN>
        <xsl:value-of select="$SvRegOrg/*[local-name()='ГРНДата']/@ГРН"/>
      </SvRegOrgGRNDataGRN>
      <SvRegOrgGRNDataDataZapisi>
        <xsl:value-of select="$SvRegOrg/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvRegOrgGRNDataDataZapisi>
      <SvStatus>
        <xsl:for-each select="$SvUL/*[local-name()='СвСтатус']">
          <smevStatusUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <KodStatusYUL _json="as_{*[local-name()='СвСтатус']/@КодСтатусЮЛ}">
              <xsl:value-of select="*[local-name()='СвСтатус']/@КодСтатусЮЛ"/>
            </KodStatusYUL>
            <NaimStatusYUL>
              <xsl:value-of select="*[local-name()='СвСтатус']/@НаимСтатусЮЛ"/>
            </NaimStatusYUL>
            <SrokLikvOOO>
              <xsl:value-of select="*[local-name()='СвСтатус']/@СрокЛиквООО"/>
            </SrokLikvOOO>
            <DataResh>
              <xsl:value-of select="*[local-name()='СвРешИсклЮЛ']/@ДатаРеш"/>
            </DataResh>
            <NomerResh>
              <xsl:value-of select="*[local-name()='СвРешИсклЮЛ']/@НомерРеш"/>
            </NomerResh>
            <DataPublikacii>
              <xsl:value-of select="*[local-name()='СвРешИсклЮЛ']/@ДатаПубликации"/>
            </DataPublikacii>
            <NomerZHurnala>
              <xsl:value-of select="*[local-name()='СвРешИсклЮЛ']/@НомерЖурнала"/>
            </NomerZHurnala>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
          </smevStatusUL>
        </xsl:for-each>
      </SvStatus>
      <xsl:variable name="SvPrekrYUL" select="$SvUL/*[local-name()='СвПрекрЮЛ']"/>
      <DataPrekrYUL>
        <xsl:value-of select="$SvPrekrYUL/@ДатаПрекрЮЛ"/>
      </DataPrekrYUL>
      <KodSpPrekrYUL _json="as_{$SvPrekrYUL/*[local-name()='СпПрекрЮЛ']/@КодСпПрекрЮЛ}">
        <xsl:value-of select="$SvPrekrYUL/*[local-name()='СпПрекрЮЛ']/@КодСпПрекрЮЛ"/>
      </KodSpPrekrYUL>
      <NaimSpPrekrYUL>
        <xsl:value-of select="$SvPrekrYUL/*[local-name()='СпПрекрЮЛ']/@НаимСпПрекрЮЛ"/>
      </NaimSpPrekrYUL>
      <SvPrekrYULSvRegOrgKodNO _json="as_{$SvPrekrYUL/*[local-name()='СвРегОрг']/@КодНО}">
        <xsl:value-of select="$SvPrekrYUL/*[local-name()='СвРегОрг']/@КодНО"/>
      </SvPrekrYULSvRegOrgKodNO>
      <SvPrekrYULSvRegOrgNaimNO>
        <xsl:value-of select="$SvPrekrYUL/*[local-name()='СвРегОрг']/@НаимНО"/>
      </SvPrekrYULSvRegOrgNaimNO>
      <SvPrekrYULGRNDataGRN>
        <xsl:value-of select="$SvPrekrYUL/*[local-name()='ГРНДата']/@ГРН"/>
      </SvPrekrYULGRNDataGRN>
      <SvPrekrYULGRNDataDataZapisi>
        <xsl:value-of select="$SvPrekrYUL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvPrekrYULGRNDataDataZapisi>
      <xsl:variable name="SvUchetNO" select="$SvUL/*[local-name()='СвУчетНО']"/>
      <SvUchetNOINN>
        <xsl:value-of select="$SvUchetNO/@ИНН"/>
      </SvUchetNOINN>
      <SvUchetNOKPP>
        <xsl:value-of select="$SvUchetNO/@КПП"/>
      </SvUchetNOKPP>
      <SvUchetNODataPostUch>
        <xsl:value-of select="$SvUchetNO/@ДатаПостУч"/>
      </SvUchetNODataPostUch>
      <SvUchetNOKodNO _json="as_{$SvUchetNO/*[local-name()='СвНО']/@КодНО}">
        <xsl:value-of select="$SvUchetNO/*[local-name()='СвНО']/@КодНО"/>
      </SvUchetNOKodNO>
      <SvUchetNONaimNO>
        <xsl:value-of select="$SvUchetNO/*[local-name()='СвНО']/@НаимНО"/>
      </SvUchetNONaimNO>
      <SvUchetNOGRNDataGRN>
        <xsl:value-of select="$SvUchetNO/*[local-name()='ГРНДата']/@ГРН"/>
      </SvUchetNOGRNDataGRN>
      <SvUchetNOGRNDataDataZapisi>
        <xsl:value-of select="$SvUchetNO/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvUchetNOGRNDataDataZapisi>
      <SvUchetNOGRNDataIsprGRN>
        <xsl:value-of select="$SvUchetNO/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvUchetNOGRNDataIsprGRN>
      <SvUchetNOGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvUchetNO/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvUchetNOGRNDataIsprDataZapisi>
      <xsl:variable name="SvRegPF" select="$SvUL/*[local-name()='СвРегПФ']"/>
      <RegNomPF>
        <xsl:value-of select="$SvRegPF/@РегНомПФ"/>
      </RegNomPF>
      <SvRegPFDataReg>
        <xsl:value-of select="$SvRegPF/@ДатаРег"/>
      </SvRegPFDataReg>
      <KodPF _json="as_{$SvRegPF/*[local-name()='СвОргПФ']/@КодПФ}">
        <xsl:value-of select="$SvRegPF/*[local-name()='СвОргПФ']/@КодПФ"/>
      </KodPF>
      <NaimPF>
        <xsl:value-of select="$SvRegPF/*[local-name()='СвОргПФ']/@НаимПФ"/>
      </NaimPF>
      <SvRegPFGRNDataGRN>
        <xsl:value-of select="$SvRegPF/*[local-name()='ГРНДата']/@ГРН"/>
      </SvRegPFGRNDataGRN>
      <SvRegPFGRNDataDataZapisi>
        <xsl:value-of select="$SvRegPF/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvRegPFGRNDataDataZapisi>
      <SvRegPFGRNDataIsprGRN>
        <xsl:value-of select="$SvRegPF/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvRegPFGRNDataIsprGRN>
      <SvRegPFGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvRegPF/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvRegPFGRNDataIsprDataZapisi>
      <xsl:variable name="SvRegFSS" select="$SvUL/*[local-name()='СвРегФСС']"/>
      <RegNomFSS>
        <xsl:value-of select="$SvRegFSS/@РегНомФСС"/>
      </RegNomFSS>
      <DataReg>
        <xsl:value-of select="$SvRegFSS/@ДатаРег"/>
      </DataReg>
      <KodFSS _json="as_{$SvRegFSS/*[local-name()='СвОргФСС']/@КодФСС}">
        <xsl:value-of select="$SvRegFSS/*[local-name()='СвОргФСС']/@КодФСС"/>
      </KodFSS>
      <NaimFSS>
        <xsl:value-of select="$SvRegFSS/*[local-name()='СвОргФСС']/@НаимФСС"/>
      </NaimFSS>
      <SvRegFSSGRNDataGRN>
        <xsl:value-of select="$SvRegFSS/*[local-name()='ГРНДата']/@ГРН"/>
      </SvRegFSSGRNDataGRN>
      <SvRegFSSGRNDataDataZapisi>
        <xsl:value-of select="$SvRegFSS/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvRegFSSGRNDataDataZapisi>
      <SvRegFSSGRNDataIsprGRN>
        <xsl:value-of select="$SvRegFSS/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvRegFSSGRNDataIsprGRN>
      <SvRegFSSGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvRegFSS/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvRegFSSGRNDataIsprDataZapisi>
      <xsl:variable name="SvUstKap" select="$SvUL/*[local-name()='СвУстКап']"/>
      <NaimVidKap>
        <xsl:value-of select="$SvUstKap/@НаимВидКап"/>
      </NaimVidKap>
      <SumKap>
        <xsl:value-of select="$SvUstKap/@СумКап"/>
      </SumKap>
      <CHislit>
        <xsl:value-of select="$SvUstKap/*[local-name()='ДоляРубля']/@Числит"/>
      </CHislit>
      <Znamenat>
        <xsl:value-of select="$SvUstKap/*[local-name()='ДоляРубля']/@Знаменат"/>
      </Znamenat>
      <SvUstKapGRNDataGRN>
        <xsl:value-of select="$SvUstKap/*[local-name()='ГРНДата']/@ГРН"/>
      </SvUstKapGRNDataGRN>
      <SvUstKapGRNDataDataZapisi>
        <xsl:value-of select="$SvUstKap/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvUstKapGRNDataDataZapisi>
      <SvUstKapGRNDataIsprGRN>
        <xsl:value-of select="$SvUstKap/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvUstKapGRNDataIsprGRN>
      <SvUstKapGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvUstKap/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvUstKapGRNDataIsprDataZapisi>
      <VelUmUK>
        <xsl:value-of select="$SvUstKap/*[local-name()='СведУмУК']/@ВелУмУК"/>
      </VelUmUK>
      <SvedUmUKDataResh>
        <xsl:value-of select="$SvUstKap/*[local-name()='СведУмУК']/@ДатаРеш"/>
      </SvedUmUKDataResh>
      <SvedUmUKGRNDataGRN>
        <xsl:value-of select="$SvUstKap/*[local-name()='СведУмУК']/*[local-name()='ГРНДата']/@ГРН"/>
      </SvedUmUKGRNDataGRN>
      <SvedUmUKGRNDataDataZapisi>
        <xsl:value-of select="$SvUstKap/*[local-name()='СведУмУК']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvedUmUKGRNDataDataZapisi>
      <SvedUmUKGRNDataIsprGRN>
        <xsl:value-of select="$SvUstKap/*[local-name()='СведУмУК']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvedUmUKGRNDataIsprGRN>
      <SvedUmUKGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvUstKap/*[local-name()='СведУмУК']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvedUmUKGRNDataIsprDataZapisi>
      <xsl:variable name="SvTipUstav" select="$SvUL/*[local-name()='СвТипУстав']"/>
      <NomTipUstav>
        <xsl:value-of select="$SvTipUstav/@НомТипУстав"/>
      </NomTipUstav>
      <NaimGOUtvTU>
        <xsl:value-of select="$SvTipUstav/*[local-name()='СвНПАУтвТУ']/@НаимГОУтвТУ"/>
      </NaimGOUtvTU>
      <VidNPA>
        <xsl:value-of select="$SvTipUstav/*[local-name()='СвНПАУтвТУ']/@ВидНПА"/>
      </VidNPA>
      <NaimNPA>
        <xsl:value-of select="$SvTipUstav/*[local-name()='СвНПАУтвТУ']/@НаимНПА"/>
      </NaimNPA>
      <NomerNPA>
        <xsl:value-of select="$SvTipUstav/*[local-name()='СвНПАУтвТУ']/@НомерНПА"/>
      </NomerNPA>
      <DataNPA>
        <xsl:value-of select="$SvTipUstav/*[local-name()='СвНПАУтвТУ']/@ДатаНПА"/>
      </DataNPA>
      <NomerPril>
        <xsl:value-of select="$SvTipUstav/*[local-name()='СвНПАУтвТУ']/@НомерПрил"/>
      </NomerPril>
      <SvTipUstavGRNDataGRN>
        <xsl:value-of select="$SvTipUstav/*[local-name()='ГРНДата']/@ГРН"/>
      </SvTipUstavGRNDataGRN>
      <SvTipUstavGRNDataDataZapisi>
        <xsl:value-of select="$SvTipUstav/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvTipUstavGRNDataDataZapisi>
      <SvTipUstavGRNDataIsprGRN>
        <xsl:value-of select="$SvTipUstav/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvTipUstavGRNDataIsprGRN>
      <SvTipUstavGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvTipUstav/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvTipUstavGRNDataIsprDataZapisi>
      <SvUprOrg>
        <xsl:for-each select="$SvUL/*[local-name()='СвУпрОрг']">
          <smevManagOrg>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <OGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
            </NaimYULPoln>
            <SvYULEGRYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvYULEGRYULGRNDataGRN>
            <SvYULEGRYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvYULEGRYULGRNDataDataZapisi>
            <SvYULEGRYULGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvYULEGRYULGRNDataIsprGRN>
            <SvYULEGRYULGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvYULEGRYULGRNDataIsprDataZapisi>
            <OKSM>
              <xsl:value-of select="*[local-name()='СвРегИн']/@ОКСМ"/>
            </OKSM>
            <NaimStran>
              <xsl:value-of select="*[local-name()='СвРегИн']/@НаимСтран"/>
            </NaimStran>
            <DataReg>
              <xsl:value-of select="*[local-name()='СвРегИн']/@ДатаРег"/>
            </DataReg>
            <RegNomer>
              <xsl:value-of select="*[local-name()='СвРегИн']/@РегНомер"/>
            </RegNomer>
            <NaimRegOrg>
              <xsl:value-of select="*[local-name()='СвРегИн']/@НаимРегОрг"/>
            </NaimRegOrg>
            <AdrStr>
              <xsl:value-of select="*[local-name()='СвРегИн']/@АдрСтр"/>
            </AdrStr>
            <KodNPStrReg>
              <xsl:value-of select="*[local-name()='СвРегИн']/@КодНПСтрРег"/>
            </KodNPStrReg>
            <SvRegInGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvRegInGRNDataGRN>
            <SvRegInGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvRegInGRNDataDataZapisi>
            <SvRegInGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvRegInGRNDataIsprGRN>
            <SvRegInGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvRegInGRNDataIsprDataZapisi>
            <SvNedDanUprOrg>
              <xsl:for-each select="*[local-name()='СвНедДанУпрОрг']">
                <smevInvalidManag>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <PriznNedDanUprOrg>
                    <xsl:value-of select="@ПризнНедДанУпрОрг"/>
                  </PriznNedDanUprOrg>
                  <TekstNedDanUprOrg>
                    <xsl:value-of select="@ТекстНедДанУпрОрг"/>
                  </TekstNedDanUprOrg>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУпрОрг']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУпрОрг']/@Номер"/>
                  </Nomer>
                  <DataResheniya>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУпрОрг']/@Дата"/>
                  </DataResheniya>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevInvalidManag>
              </xsl:for-each>
            </SvNedDanUprOrg>
            <NaimPredYUL>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/@НаимПредЮЛ"/>
            </NaimPredYUL>
            <SvPredYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvPredYULGRNDataGRN>
            <SvPredYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvPredYULGRNDataDataZapisi>
            <SvPredYULGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvPredYULGRNDataIsprGRN>
            <SvPredYULGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvPredYULGRNDataIsprDataZapisi>
            <Indeks>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/@Индекс"/>
            </Indeks>
            <KodRegion _json="as_{*[local-name()='СвАдрРФ']/@КодРегион}">
              <xsl:value-of select="*[local-name()='СвАдрРФ']/@КодРегион"/>
            </KodRegion>
            <KodAdrKladr _json="as_{*[local-name()='СвАдрРФ']/@КодАдрКладр}">
              <xsl:value-of select="*[local-name()='СвАдрРФ']/@КодАдрКладр"/>
            </KodAdrKladr>
            <Dom>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/@Дом"/>
            </Dom>
            <Korpus>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/@Корпус"/>
            </Korpus>
            <Kvart>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/@Кварт"/>
            </Kvart>
            <Region>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='Регион']/@НаимРегион"/>
            </Region>
            <Rajon>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='Район']/@НаимРайон"/>
            </Rajon>
            <Gorod>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='Город']/@НаимГород"/>
            </Gorod>
            <NaselPunkt>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='НаселПункт']/@НаимНаселПункт"/>
            </NaselPunkt>
            <Ulica>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='Улица']/@НаимУлица"/>
            </Ulica>
            <SvAdrRFGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvAdrRFGRNDataGRN>
            <SvAdrRFGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvAdrRFGRNDataDataZapisi>
            <SvAdrRFGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvAdrRFGRNDataIsprGRN>
            <SvAdrRFGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвАдрРФ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvAdrRFGRNDataIsprDataZapisi>
            <NomTel>
              <xsl:value-of select="*[local-name()='СвНомТел']/@НомТел"/>
            </NomTel>
            <SvNomTelGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvNomTelGRNDataGRN>
            <SvNomTelGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvNomTelGRNDataDataZapisi>
            <SvNomTelGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvNomTelGRNDataIsprGRN>
            <SvNomTelGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvNomTelGRNDataIsprDataZapisi>
            <PredInYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </PredInYULGRNDataGRN>
            <PredInYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </PredInYULGRNDataDataZapisi>
            <Familiya>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
            </Familiya>
            <Imya>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/@Имя"/>
            </Imya>
            <Otchestvo>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/@Отчество"/>
            </Otchestvo>
            <INNFL>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
            </INNFL>
            <PredInYULSvFLGRNDataGRN>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </PredInYULSvFLGRNDataGRN>
            <PredInYULSvFLGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </PredInYULSvFLGRNDataDataZapisi>
            <PredInYULSvFLGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </PredInYULSvFLGRNDataIsprGRN>
            <PredInYULSvFLGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </PredInYULSvFLGRNDataIsprDataZapisi>
            <PredInYULSvNomTelNomTel>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвНомТел']/@НомТел"/>
            </PredInYULSvNomTelNomTel>
            <PredInYULSvNomTelGRNDataGRN>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвНомТел']/*[local-name()='ГРНДата']/@ГРН"/>
            </PredInYULSvNomTelGRNDataGRN>
            <PredInYULSvNomTelGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвНомТел']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </PredInYULSvNomTelGRNDataDataZapisi>
            <PredInYULSvNomTelGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвНомТел']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </PredInYULSvNomTelGRNDataIsprGRN>
            <PredInYULSvNomTelGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ПредИнЮЛ']/*[local-name()='СвНомТел']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </PredInYULSvNomTelGRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвАкРАФП']">
              <xsl:variable name="SvAkRAFP" select="*[local-name()= 'СвАкРАФП']"/>
              <SvAkRAFP>
                <GRNDataGRN>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <NomerRAFP>
                  <xsl:value-of select="$SvAkRAFP/@НомерРАФП"/>
                </NomerRAFP>
              </SvAkRAFP>
            </xsl:if>
          </smevManagOrg>
        </xsl:for-each>
      </SvUprOrg>
      <SvedDolzhnFL>
        <xsl:for-each select="$SvUL/*[local-name()='СведДолжнФЛ']">
          <smevPerson>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <Familiya>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Фамилия"/>
            </Familiya>
            <Imya>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Имя"/>
            </Imya>
            <Otchestvo>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Отчество"/>
            </Otchestvo>
            <INNFL>
              <xsl:value-of select="*[local-name()='СвФЛ']/@ИННФЛ"/>
            </INNFL>
            <SvFLGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvFLGRNDataGRN>
            <SvFLGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvFLGRNDataDataZapisi>
            <SvFLGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvFLGRNDataIsprGRN>
            <SvFLGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvFLGRNDataIsprDataZapisi>
            <OGRNIP>
              <xsl:value-of select="*[local-name()='СвДолжн']/@ОГРНИП"/>
            </OGRNIP>
            <VidDolzhn>
              <xsl:value-of select="*[local-name()='СвДолжн']/@ВидДолжн"/>
            </VidDolzhn>
            <NaimVidDolzhn>
              <xsl:value-of select="*[local-name()='СвДолжн']/@НаимВидДолжн"/>
            </NaimVidDolzhn>
            <NaimDolzhn>
              <xsl:value-of select="*[local-name()='СвДолжн']/@НаимДолжн"/>
            </NaimDolzhn>
            <SvDolzhnGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвДолжн']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvDolzhnGRNDataGRN>
            <SvDolzhnGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвДолжн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvDolzhnGRNDataDataZapisi>
            <SvDolzhnGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвДолжн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvDolzhnGRNDataIsprGRN>
            <SvDolzhnGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвДолжн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvDolzhnGRNDataIsprDataZapisi>
            <NomTel>
              <xsl:value-of select="*[local-name()='СвНомТел']/@НомТел"/>
            </NomTel>
            <SvNomTelGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvNomTelGRNDataGRN>
            <SvNomTelGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvNomTelGRNDataDataZapisi>
            <SvNomTelGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvNomTelGRNDataIsprGRN>
            <SvNomTelGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвНомТел']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvNomTelGRNDataIsprDataZapisi>
            <SvNedDanDolzhnFL>
              <xsl:for-each select="*[local-name()='СвНедДанДолжнФЛ']">
                <smevInvalidPerson>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <PriznNedDanDolzhnFL>
                    <xsl:value-of select="@ПризнНедДанДолжнФЛ"/>
                  </PriznNedDanDolzhnFL>
                  <TekstNedDanDolzhnFL>
                    <xsl:value-of select="@ТекстНедДанДолжнФЛ"/>
                  </TekstNedDanDolzhnFL>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСудНедДанДолжнФЛ']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСудНедДанДолжнФЛ']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСудНедДанДолжнФЛ']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevInvalidPerson>
              </xsl:for-each>
            </SvNedDanDolzhnFL>
            <SvDiskv>
              <xsl:for-each select="*[local-name()='СвДискв']">
                <smevDisqualification>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <DataNachDiskv>
                    <xsl:value-of select="@ДатаНачДискв"/>
                  </DataNachDiskv>
                  <DataOkonchDiskv>
                    <xsl:value-of select="@ДатаОкончДискв"/>
                  </DataOkonchDiskv>
                  <DataResh>
                    <xsl:value-of select="@ДатаРеш"/>
                  </DataResh>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevDisqualification>
              </xsl:for-each>
            </SvDiskv>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвПолФЛ']">
              <xsl:variable name="SvPolFL" select="*[local-name()= 'СвПолФЛ']"/>
              <SvZalogDerzhFLSvPolFL>
                <GRNDataGRN>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <Pol>
                  <xsl:value-of select="$SvPolFL/@Пол"/>
                </Pol>
              </SvZalogDerzhFLSvPolFL>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвГраждФЛ']">
              <xsl:variable name="SvGrazhdFL" select="*[local-name()= 'СвГраждФЛ']"/>
              <SvZalogDerzhFLSvGrazhdFL>
                <GRNDataGRN>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <KodGrazhd>
                  <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                </KodGrazhd>
                <NaimStran>
                  <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                </NaimStran>
                <OKSM>
                  <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                </OKSM>
              </SvZalogDerzhFLSvGrazhdFL>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвФИОЗАГС']">
              <xsl:variable name="SvFIOZAGS" select="*[local-name()= 'СвФИОЗАГС']"/>
              <SvFIOZAGS>
                <GRNDataGRN>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <Imya>
                  <xsl:value-of select="$SvFIOZAGS/@Имя"/>
                </Imya>
                <Otchestvo>
                  <xsl:value-of select="$SvFIOZAGS/@Отчество"/>
                </Otchestvo>
                <Familiya>
                  <xsl:value-of select="$SvFIOZAGS/@Фамилия"/>
                </Familiya>
              </SvFIOZAGS>
            </xsl:if>
          </smevPerson>
        </xsl:for-each>
      </SvedDolzhnFL>
      <UchrYULRos>
        <xsl:for-each select="$SvUL/*[local-name()='СвУчредит']/*[local-name()='УчрЮЛРос']">
          <smevFounderRus>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <OGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
            </NaimYULPoln>
            <NaimINNYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </NaimINNYULGRNDataGRN>
            <NaimINNYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </NaimINNYULGRNDataDataZapisi>
            <NaimINNYULGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </NaimINNYULGRNDataIsprGRN>
            <NaimINNYULGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </NaimINNYULGRNDataIsprDataZapisi>
            <RegNom>
              <xsl:value-of select="*[local-name()='СвРегСтарые']/@РегНом"/>
            </RegNom>
            <DataReg>
              <xsl:value-of select="*[local-name()='СвРегСтарые']/@ДатаРег"/>
            </DataReg>
            <NaimRO>
              <xsl:value-of select="*[local-name()='СвРегСтарые']/@НаимРО"/>
            </NaimRO>
            <SvRegStaryeGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвРегСтарые']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvRegStaryeGRNDataGRN>
            <SvRegStaryeGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвРегСтарые']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvRegStaryeGRNDataDataZapisi>
            <SvRegStaryeGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвРегСтарые']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvRegStaryeGRNDataIsprGRN>
            <SvRegStaryeGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвРегСтарые']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvRegStaryeGRNDataIsprDataZapisi>
            <SvNedDanUchr>
              <xsl:for-each select="*[local-name()='СвНедДанУчр']">
                <smevInvalidFounder>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <PriznNedDanUchr>
                    <xsl:value-of select="@ПризнНедДанУчр"/>
                  </PriznNedDanUchr>
                  <TekstNedDanUchr>
                    <xsl:value-of select="@ТекстНедДанУчр"/>
                  </TekstNedDanUchr>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevInvalidFounder>
              </xsl:for-each>
            </SvNedDanUchr>
            <NominStoim>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/@НоминСтоим"/>
            </NominStoim>
            <Procent>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='Процент']"/>
            </Procent>
            <DrobDesyat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробДесят']"/>
            </DrobDesyat>
            <DrobProst>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Числит"/>/<xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Знаменат"/>
            </DrobProst>
            <DolyaUstKapGRNDataGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ГРН"/>
            </DolyaUstKapGRNDataGRN>
            <DolyaUstKapGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataDataZapisi>
            <DolyaUstKapGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </DolyaUstKapGRNDataIsprGRN>
            <DolyaUstKapGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()='ДоляУстКап']/*[local-name()= 'ДоляРубля']">
              <xsl:variable name="DolyaRublya" select="*[local-name()='ДоляУстКап']/*[local-name()= 'ДоляРубля']"/>
              <DolyaRublya>
                <Znamenat>
                  <xsl:value-of select="$DolyaRublya/@Знаменат"/>
                </Znamenat>
                <Chislit>
                  <xsl:value-of select="$DolyaRublya/@Числит"/>
                </Chislit>
              </DolyaRublya>
            </xsl:if>
            <SvObrem>
              <xsl:for-each select="*[local-name()='СвОбрем']">
                <smevEncum>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <VidObremeneniya>
                    <xsl:value-of select="@ВидОбрем"/>
                  </VidObremeneniya>
                  <SrokObremeneniya>
                    <xsl:value-of select="@СрокОбременения"/>
                  </SrokObremeneniya>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСуд']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <SvZalogDerzhFLGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhFLGRNDataPervGRN>
                  <SvZalogDerzhFLGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLGRNDataPervDataZapisi>
                  <Familiya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
                  </Familiya>
                  <Imya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Имя"/>
                  </Imya>
                  <Otchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Отчество"/>
                  </Otchestvo>
                  <INNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
                  </INNFL>
                  <SvZalogDerzhFLSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhFLSvNotUdDogZalNomer>
                  <SvZalogDerzhFLSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhFLSvNotUdDogZalData>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']">
                    <xsl:variable name="SvPolFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']"/>
                    <SvZalogDerzhFLSvPolFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <Pol>
                        <xsl:value-of select="$SvPolFL/@Пол"/>
                      </Pol>
                    </SvZalogDerzhFLSvPolFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']">
                    <xsl:variable name="SvGrazhdFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']"/>
                    <SvZalogDerzhFLSvGrazhdFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <KodGrazhd>
                        <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                      </KodGrazhd>
                      <NaimStran>
                        <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                      </NaimStran>
                      <OKSM>
                        <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                      </OKSM>
                    </SvZalogDerzhFLSvGrazhdFL>
                  </xsl:if>
                  <SvZalogDerzhYULGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataPervGRN>
                  <SvZalogDerzhYULGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataPervDataZapisi>
                  <OGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                  </OGRN>
                  <INN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <SvZalogDerzhYULGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataGRN>
                  <SvZalogDerzhYULGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataDataZapisi>
                  <SvZalogDerzhYULGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataIsprGRN>
                  <SvZalogDerzhYULGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataIsprDataZapisi>
                  <OKSM>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
                  </OKSM>
                  <NaimStran>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
                  </NaimStran>
                  <DataReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
                  </DataReg>
                  <RegNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
                  </RegNomer>
                  <NaimRegOrg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <AdrStr>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
                  </AdrStr>
                  <SvZalogDerzhYULSvRegInGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataGRN>
                  <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                  <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                  <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                  <SvZalogDerzhYULSvRegInKodNPStrReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
                  </SvZalogDerzhYULSvRegInKodNPStrReg>
                  <SvZalogDerzhYULSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhYULSvNotUdDogZalNomer>
                  <SvZalogDerzhYULSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhYULSvNotUdDogZalData>
                  <SvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotariusFamiliya>
                  <SvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotariusImya>
                  <SvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotariusOtchestvo>
                  <SvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotariusINNFL>
                  <SvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotariusGRNDataGRN>
                  <SvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataDataZapisi>
                  <SvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotariusGRNDataIsprGRN>
                  <SvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()= 'СвНаимЮЛПолнИн']">
                    <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()= 'СвНаимЮЛПолнИн']"/>
                    <SvNaimYULPolnIn>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <NaimPoln>
                        <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                      </NaimPoln>
                    </SvNaimYULPolnIn>
                  </xsl:if>
                </smevEncum>
              </xsl:for-each>
            </SvObrem>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <xsl:for-each select="*[local-name()='СвДовУпрЮЛ']">
              <OGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@ОГРН"/>
              </OGRN>
              <INN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@ИНН"/>
              </INN>
              <NaimYULPoln>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@НаимЮЛПолн"/>
              </NaimYULPoln>
              <NaimINNDovUprGRNDataGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДата']/@ГРН"/>
              </NaimINNDovUprGRNDataGRN>
              <NaimINNDovUprGRNDataDataZapisi>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
              </NaimINNDovUprGRNDataDataZapisi>
              <NaimINNDovUprGRNDataIsprGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
              </NaimINNDovUprGRNDataIsprGRN>
              <NaimINNDovUprGRNDataIsprDataZapisi>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
              </NaimINNDovUprGRNDataIsprDataZapisi>
              <GRNDataPervGRN>
                <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
              </GRNDataPervGRN>
              <GRNDataPervDataZapisi>
                <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
              </GRNDataPervDataZapisi>
              <DataOtkrNasl>
                <xsl:value-of select="@ДатаОткрНасл"/>
              </DataOtkrNasl>
              <xsl:if test="*[local-name()= 'СвНаимЮЛПолнИн']">
                <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()= 'СвНаимЮЛПолнИн']"/>
                <SvNaimYULPolnIn>
                  <GRNDataGRN>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <NaimPoln>
                    <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                  </NaimPoln>
                </SvNaimYULPolnIn>
              </xsl:if>
              <xsl:if test="*[local-name()= 'СвРегИн']">
                <xsl:variable name="SvRegIn" select="*[local-name()= 'СвРегИн']"/>
                <SvRegIn>
                  <GRNDataGRN>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <AdrStr>
                    <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                  </AdrStr>
                  <DataReg>
                    <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                  </DataReg>
                  <KodNPStrReg>
                    <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                  </KodNPStrReg>
                  <NaimRegOrg>
                    <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <NaimStran>
                    <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                  </NaimStran>
                  <OKSM>
                    <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                  </OKSM>
                  <RegNomer>
                    <xsl:value-of select="$SvRegIn/@РегНомер"/>
                  </RegNomer>
                </SvRegIn>
              </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="*[local-name()='СвДовУпрФЛ']">
              <SvDovUprFL>
                <OGRNIP>
                  <xsl:value-of select="@ОГРНИП"/>
                </OGRNIP>
                <SvFLFamiliya>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Фамилия"/>
                </SvFLFamiliya>
                <SvFLImya>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Имя"/>
                </SvFLImya>
                <SvFLOtchestvo>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Отчество"/>
                </SvFLOtchestvo>
                <SvFLINNFL>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@ИННФЛ"/>
                </SvFLINNFL>
                <SvFLGRNDataGRN>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                </SvFLGRNDataGRN>
                <SvFLGRNDataDataZapisi>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </SvFLGRNDataDataZapisi>
                <SvFLGRNDataIsprGRN>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </SvFLGRNDataIsprGRN>
                <SvFLGRNDataIsprDataZapisi>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </SvFLGRNDataIsprDataZapisi>
                <SvFLGRNDataPervGRN>
                  <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                </SvFLGRNDataPervGRN>
                <SvFLGRNDataPervDataZapisi>
                  <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                </SvFLGRNDataPervDataZapisi>
                <xsl:if test="*[local-name()= 'СвПолФЛ']">
                  <xsl:variable name="SvPolFL" select="*[local-name()= 'СвПолФЛ']"/>
                  <SvZalogDerzhFLSvPolFL>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <Pol>
                      <xsl:value-of select="$SvPolFL/@Пол"/>
                    </Pol>
                  </SvZalogDerzhFLSvPolFL>
                </xsl:if>
                <xsl:if test="*[local-name()= 'СвГраждФЛ']">
                  <xsl:variable name="SvGrazhdFL" select="*[local-name()= 'СвГраждФЛ']"/>
                  <SvZalogDerzhFLSvGrazhdFL>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <KodGrazhd>
                      <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                    </KodGrazhd>
                    <NaimStran>
                      <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                    </NaimStran>
                    <OKSM>
                      <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                    </OKSM>
                  </SvZalogDerzhFLSvGrazhdFL>
                </xsl:if>
              </SvDovUprFL>
            </xsl:for-each>
            <xsl:if test="*[local-name()= 'СвОбъемПрав']">
              <xsl:variable name="SvObyemPrav" select="*[local-name()= 'СвОбъемПрав']"/>
              <SvObyemPrav>
                <GRNDataGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <ObyemPrav>
                  <xsl:value-of select="$SvObyemPrav/@ОбъемПрав"/>
                </ObyemPrav>
              </SvObyemPrav>
            </xsl:if>
            <SvUpravZal>
              <xsl:for-each select="*[local-name()= 'СвУправЗал']">
                <smevSvUpravZal>
                  <GRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </GRNDataPervGRN>
                  <GRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </GRNDataPervDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataGRN>
                  <SvDogUpravZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprGRN>
                  <SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                  <SvDogUpravZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvDogUpravZalSvNotariusINNFL>
                  <SvDogUpravZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvDogUpravZalSvNotariusImya>
                  <SvDogUpravZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvDogUpravZalSvNotariusOtchestvo>
                  <SvDogUpravZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvDogUpravZalSvNotariusFamiliya>
                  <SvDogUpravZalData>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Дата"/>
                  </SvDogUpravZalData>
                  <SvDogUpravZalNomer>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Номер"/>
                  </SvDogUpravZalNomer>
                  <SvNotUdDogZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataGRN>
                  <SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                  <SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                  <SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                  <SvNotUdDogZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotUdDogZalSvNotariusINNFL>
                  <SvNotUdDogZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotUdDogZalSvNotariusImya>
                  <SvNotUdDogZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotUdDogZalSvNotariusOtchestvo>
                  <SvNotUdDogZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotUdDogZalSvNotariusFamiliya>
                  <SvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvNotUdDogZalData>
                  <SvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvNotUdDogZalNomer>
                  <xsl:if test="*[local-name()= 'СвУпрЗалФЛ']">
                    <xsl:variable name="SvUprZalFL" select="*[local-name()= 'СвУпрЗалФЛ']"/>
                    <SvUprZalFL>
                      <SvFLGRNDataGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </SvFLGRNDataGRN>
                      <SvFLGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </SvFLGRNDataDataZapisi>
                      <SvFLGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </SvFLGRNDataIsprGRN>
                      <SvFLGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </SvFLGRNDataIsprDataZapisi>
                      <SvFLINNFL>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@ИННФЛ"/>
                      </SvFLINNFL>
                      <SvFLImya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Имя"/>
                      </SvFLImya>
                      <SvFLOtchestvo>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Отчество"/>
                      </SvFLOtchestvo>
                      <SvFLFamiliya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Фамилия"/>
                      </SvFLFamiliya>
                      <OGRNIP>
                        <xsl:value-of select="$SvUprZalFL/@ОГРНИП"/>
                      </OGRNIP>
                    </SvUprZalFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()= 'СвУпрЗалЮЛ']">
                    <xsl:variable name="SvUprZalYUL" select="*[local-name()= 'СвУпрЗалЮЛ']"/>
                    <SvUprZalYUL>
                      <NaimINNYULGRNDataGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </NaimINNYULGRNDataGRN>
                      <NaimINNYULGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataDataZapisi>
                      <NaimINNYULGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </NaimINNYULGRNDataIsprGRN>
                      <NaimINNYULGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataIsprDataZapisi>
                      <NaimINNYULINN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                      </NaimINNYULINN>
                      <NaimINNYULNaimYULPoln>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                      </NaimINNYULNaimYULPoln>
                      <NaimINNYULOGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                      </NaimINNYULOGRN>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']">
                        <xsl:variable name="SvNaimYULPolnIn" select="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                        <SvNaimYULPolnIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <NaimPoln>
                            <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                          </NaimPoln>
                        </SvNaimYULPolnIn>
                      </xsl:if>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвРегИн']">
                        <xsl:variable name="SvRegIn" select="$SvUprZalYUL/*[local-name()= 'СвРегИн']"/>
                        <SvRegIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <AdrStr>
                            <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                          </AdrStr>
                          <DataReg>
                            <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                          </DataReg>
                          <KodNPStrReg>
                            <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                          </KodNPStrReg>
                          <NaimRegOrg>
                            <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                          </NaimRegOrg>
                          <NaimStran>
                            <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                          </NaimStran>
                          <OKSM>
                            <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                          </OKSM>
                          <RegNomer>
                            <xsl:value-of select="$SvRegIn/@РегНомер"/>
                          </RegNomer>
                        </SvRegIn>
                      </xsl:if>
                    </SvUprZalYUL>
                  </xsl:if>
                </smevSvUpravZal>
              </xsl:for-each>
            </SvUpravZal>
          </smevFounderRus>
        </xsl:for-each>
      </UchrYULRos>
      <UchrDogInvTov>
        <xsl:for-each select="$SvUL/*[local-name()='СвУчредит']/*[local-name()= 'УчрДогИнвТов']">
          <smevUchrDogInvTov>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <NominStoim>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/@НоминСтоим"/>
            </NominStoim>
            <Procent>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='РазмерДоли']/*[local-name()='Процент']"/>
            </Procent>
            <DrobDesyat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='РазмерДоли']/*[local-name()='ДробДесят']"/>
            </DrobDesyat>
            <DrobProst>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='РазмерДоли']/*[local-name()='ДробПрост']/@Числит"/>/<xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Знаменат"/>
            </DrobProst>
            <xsl:if test="*[local-name()='ДоляУстКап']/*[local-name()= 'ДоляРубля']">
              <xsl:variable name="DolyaRublya" select="*[local-name()='ДоляУстКап']/*[local-name()= 'ДоляРубля']"/>
              <DolyaRublya>
                <Znamenat>
                  <xsl:value-of select="$DolyaRublya/@Знаменат"/>
                </Znamenat>
                <Chislit>
                  <xsl:value-of select="$DolyaRublya/@Числит"/>
                </Chislit>
              </DolyaRublya>
            </xsl:if>
            <DolyaUstKapGRNDataGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ГРН"/>
            </DolyaUstKapGRNDataGRN>
            <DolyaUstKapGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataDataZapisi>
            <DolyaUstKapGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </DolyaUstKapGRNDataIsprGRN>
            <DolyaUstKapGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()= 'ИнПрДогИнвТов']">
              <xsl:variable name="InPrDogInvTov" select="*[local-name()= 'ИнПрДогИнвТов']"/>
              <InPrDogInvTov>
                <GRNDataGRN>
                  <xsl:value-of select="$InPrDogInvTov/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$InPrDogInvTov/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$InPrDogInvTov/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$InPrDogInvTov/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <FIONotariusImya>
                  <xsl:value-of select="$InPrDogInvTov/*[local-name()='ФИОНотариус']/@Имя"/>
                </FIONotariusImya>
                <FIONotariusOtchestvo>
                  <xsl:value-of select="$InPrDogInvTov/*[local-name()='ФИОНотариус']/@Отчество"/>
                </FIONotariusOtchestvo>
                <FIONotariusFamiliya>
                  <xsl:value-of select="$InPrDogInvTov/*[local-name()='ФИОНотариус']/@Фамилия"/>
                </FIONotariusFamiliya>
                <Data>
                  <xsl:value-of select="$InPrDogInvTov/@Дата"/>
                </Data>
                <NaimDog>
                  <xsl:value-of select="$InPrDogInvTov/@НаимДог"/>
                </NaimDog>
                <NomerDog>
                  <xsl:value-of select="$InPrDogInvTov/@НомерДог"/>
                </NomerDog>
              </InPrDogInvTov>
            </xsl:if>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <SvNedDanUchr>
              <xsl:for-each select="*[local-name()='СвНедДанУчр']">
                <smevInvalidFounder>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <PriznNedDanUchr>
                    <xsl:value-of select="@ПризнНедДанУчр"/>
                  </PriznNedDanUchr>
                  <TekstNedDanUchr>
                    <xsl:value-of select="@ТекстНедДанУчр"/>
                  </TekstNedDanUchr>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevInvalidFounder>
              </xsl:for-each>
            </SvNedDanUchr>
            <SvObrem>
              <xsl:for-each select="*[local-name()='СвОбрем']">
                <smevEncum>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <VidObremeneniya>
                    <xsl:value-of select="@ВидОбрем"/>
                  </VidObremeneniya>
                  <SrokObremeneniya>
                    <xsl:value-of select="@СрокОбременения"/>
                  </SrokObremeneniya>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСуд']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <SvZalogDerzhFLGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhFLGRNDataPervGRN>
                  <SvZalogDerzhFLGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLGRNDataPervDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']">
                    <xsl:variable name="SvPolFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']"/>
                    <SvZalogDerzhFLSvPolFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <Pol>
                        <xsl:value-of select="$SvPolFL/@Пол"/>
                      </Pol>
                    </SvZalogDerzhFLSvPolFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']">
                    <xsl:variable name="SvGrazhdFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']"/>
                    <SvZalogDerzhFLSvGrazhdFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <KodGrazhd>
                        <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                      </KodGrazhd>
                      <NaimStran>
                        <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                      </NaimStran>
                      <OKSM>
                        <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                      </OKSM>
                    </SvZalogDerzhFLSvGrazhdFL>
                  </xsl:if>
                  <Familiya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
                  </Familiya>
                  <Imya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Имя"/>
                  </Imya>
                  <Otchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Отчество"/>
                  </Otchestvo>
                  <INNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
                  </INNFL>
                  <SvZalogDerzhFLSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhFLSvNotUdDogZalNomer>
                  <SvZalogDerzhFLSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhFLSvNotUdDogZalData>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>

                  <SvZalogDerzhYULGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataPervGRN>
                  <SvZalogDerzhYULGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataPervDataZapisi>
                  <OGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                  </OGRN>
                  <INN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <SvZalogDerzhYULGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataGRN>
                  <SvZalogDerzhYULGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataDataZapisi>
                  <SvZalogDerzhYULGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataIsprGRN>
                  <SvZalogDerzhYULGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataIsprDataZapisi>
                  <OKSM>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
                  </OKSM>
                  <NaimStran>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
                  </NaimStran>
                  <DataReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
                  </DataReg>
                  <RegNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
                  </RegNomer>
                  <NaimRegOrg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <AdrStr>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
                  </AdrStr>
                  <SvZalogDerzhYULSvRegInGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataGRN>
                  <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                  <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                  <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                  <SvZalogDerzhYULSvRegInKodNPStrReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
                  </SvZalogDerzhYULSvRegInKodNPStrReg>
                  <SvZalogDerzhYULSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhYULSvNotUdDogZalNomer>
                  <SvZalogDerzhYULSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhYULSvNotUdDogZalData>
                  <SvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotariusFamiliya>
                  <SvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotariusImya>
                  <SvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotariusOtchestvo>
                  <SvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotariusINNFL>
                  <SvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotariusGRNDataGRN>
                  <SvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataDataZapisi>
                  <SvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotariusGRNDataIsprGRN>
                  <SvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']">
                    <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                    <SvZalogDerzhYULSvNaimYULPolnIn>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <NaimPoln>
                        <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                      </NaimPoln>
                    </SvZalogDerzhYULSvNaimYULPolnIn>
                  </xsl:if>
                </smevEncum>
              </xsl:for-each>
            </SvObrem>
            <xsl:if test="*[local-name()= 'СвОбъемПрав']">
              <xsl:variable name="SvObyemPrav" select="*[local-name()= 'СвОбъемПрав']"/>
              <SvObyemPrav>
                <GRNDataGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <ObyemPrav>
                  <xsl:value-of select="$SvObyemPrav/@ОбъемПрав"/>
                </ObyemPrav>
              </SvObyemPrav>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвУпТовИнЮЛ']">
              <xsl:variable name="SvUpTovInYUL" select="*[local-name()= 'СвУпТовИнЮЛ']"/>
              <SvUpTovInYUL>
                <OGRN>
                  <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                </OGRN>
                <INN>
                  <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ИНН"/>
                </INN>
                <NaimYULPoln>
                  <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                </NaimYULPoln>
                <NaimINNYULGRNDataGRN>
                  <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                </NaimINNYULGRNDataGRN>
                <NaimINNYULGRNDataDataZapisi>
                  <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </NaimINNYULGRNDataDataZapisi>
                <NaimINNYULGRNDataIsprGRN>
                  <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </NaimINNYULGRNDataIsprGRN>
                <NaimINNYULGRNDataIsprDataZapisi>
                  <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </NaimINNYULGRNDataIsprDataZapisi>
              </SvUpTovInYUL>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвАкРАФП']">
              <xsl:variable name="SvAkRAFP" select="*[local-name()= 'СвАкРАФП']"/>
              <SvAkRAFP>
                <GRNDataGRN>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvAkRAFP/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <NomerRAFP>
                  <xsl:value-of select="$SvAkRAFP/@НомерРАФП"/>
                </NomerRAFP>
              </SvAkRAFP>
            </xsl:if>
            <NaimPredYUL>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/@НаимПредЮЛ"/>
            </NaimPredYUL>
            <SvPredYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvPredYULGRNDataGRN>
            <SvPredYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvPredYULGRNDataDataZapisi>
            <SvPredYULGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvPredYULGRNDataIsprGRN>
            <SvPredYULGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвПредЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvPredYULGRNDataIsprDataZapisi>
            <OKSM>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
            </OKSM>
            <NaimStran>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
            </NaimStran>
            <DataReg>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
            </DataReg>
            <RegNomer>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
            </RegNomer>
            <NaimRegOrg>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
            </NaimRegOrg>
            <AdrStr>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
            </AdrStr>
            <SvZalogDerzhYULSvRegInGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvZalogDerzhYULSvRegInGRNDataGRN>
            <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
            <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
            <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
            <SvZalogDerzhYULSvRegInKodNPStrReg>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
            </SvZalogDerzhYULSvRegInKodNPStrReg>
            <xsl:if test="*[local-name()= 'СвУпТовЮЛ']">
              <xsl:variable name="SvUpTovYUL" select="*[local-name()= 'СвУпТовЮЛ']"/>
              <SvUpTovYUL>
                <GRNDataGRN>
                  <xsl:value-of select="$SvUpTovYUL/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvUpTovYUL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvUpTovYUL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvUpTovYUL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <INN>
                  <xsl:value-of select="$SvUpTovYUL/@ИНН"/>
                </INN>
                <NaimYULPoln>
                  <xsl:value-of select="$SvUpTovYUL/@НаимЮЛПолн"/>
                </NaimYULPoln>
                <OGRN>
                  <xsl:value-of select="$SvUpTovYUL/@ОГРН"/>
                </OGRN>
              </SvUpTovYUL>
            </xsl:if>
            <SvUpravZal>
              <xsl:for-each select="*[local-name()= 'СвУправЗал']">
                <smevSvUpravZal>
                  <GRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </GRNDataPervGRN>
                  <GRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </GRNDataPervDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataGRN>
                  <SvDogUpravZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprGRN>
                  <SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                  <SvDogUpravZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvDogUpravZalSvNotariusINNFL>
                  <SvDogUpravZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvDogUpravZalSvNotariusImya>
                  <SvDogUpravZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvDogUpravZalSvNotariusOtchestvo>
                  <SvDogUpravZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvDogUpravZalSvNotariusFamiliya>
                  <SvDogUpravZalData>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Дата"/>
                  </SvDogUpravZalData>
                  <SvDogUpravZalNomer>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Номер"/>
                  </SvDogUpravZalNomer>
                  <SvNotUdDogZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataGRN>
                  <SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                  <SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                  <SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                  <SvNotUdDogZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotUdDogZalSvNotariusINNFL>
                  <SvNotUdDogZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotUdDogZalSvNotariusImya>
                  <SvNotUdDogZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotUdDogZalSvNotariusOtchestvo>
                  <SvNotUdDogZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotUdDogZalSvNotariusFamiliya>
                  <SvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvNotUdDogZalData>
                  <SvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvNotUdDogZalNomer>
                  <xsl:if test="*[local-name()= 'СвУпрЗалФЛ']">
                    <xsl:variable name="SvUprZalFL" select="*[local-name()= 'СвУпрЗалФЛ']"/>
                    <SvUprZalFL>
                      <SvFLGRNDataGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </SvFLGRNDataGRN>
                      <SvFLGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </SvFLGRNDataDataZapisi>
                      <SvFLGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </SvFLGRNDataIsprGRN>
                      <SvFLGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </SvFLGRNDataIsprDataZapisi>
                      <SvFLINNFL>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@ИННФЛ"/>
                      </SvFLINNFL>
                      <SvFLImya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Имя"/>
                      </SvFLImya>
                      <SvFLOtchestvo>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Отчество"/>
                      </SvFLOtchestvo>
                      <SvFLFamiliya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Фамилия"/>
                      </SvFLFamiliya>
                      <OGRNIP>
                        <xsl:value-of select="$SvUprZalFL/@ОГРНИП"/>
                      </OGRNIP>
                    </SvUprZalFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()= 'СвУпрЗалЮЛ']">
                    <xsl:variable name="SvUprZalYUL" select="*[local-name()= 'СвУпрЗалЮЛ']"/>
                    <SvUprZalYUL>
                      <NaimINNYULGRNDataGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </NaimINNYULGRNDataGRN>
                      <NaimINNYULGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataDataZapisi>
                      <NaimINNYULGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </NaimINNYULGRNDataIsprGRN>
                      <NaimINNYULGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataIsprDataZapisi>
                      <NaimINNYULINN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                      </NaimINNYULINN>
                      <NaimINNYULNaimYULPoln>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                      </NaimINNYULNaimYULPoln>
                      <NaimINNYULOGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                      </NaimINNYULOGRN>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']">
                        <xsl:variable name="SvNaimYULPolnIn" select="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                        <SvNaimYULPolnIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <NaimPoln>
                            <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                          </NaimPoln>
                        </SvNaimYULPolnIn>
                      </xsl:if>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвРегИн']">
                        <xsl:variable name="SvRegIn" select="$SvUprZalYUL/*[local-name()= 'СвРегИн']"/>
                        <SvRegIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <AdrStr>
                            <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                          </AdrStr>
                          <DataReg>
                            <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                          </DataReg>
                          <KodNPStrReg>
                            <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                          </KodNPStrReg>
                          <NaimRegOrg>
                            <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                          </NaimRegOrg>
                          <NaimStran>
                            <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                          </NaimStran>
                          <OKSM>
                            <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                          </OKSM>
                          <RegNomer>
                            <xsl:value-of select="$SvRegIn/@РегНомер"/>
                          </RegNomer>
                        </SvRegIn>
                      </xsl:if>
                    </SvUprZalYUL>
                  </xsl:if>
                </smevSvUpravZal>
              </xsl:for-each>
            </SvUpravZal>
          </smevUchrDogInvTov>
        </xsl:for-each>
      </UchrDogInvTov>
      <UchrYULIn>
        <xsl:for-each select="$SvUL/*[local-name()='СвУчредит']/*[local-name()='УчрЮЛИн']">
          <smevFounderInt>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <OGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
            </NaimYULPoln>
            <NaimINNYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </NaimINNYULGRNDataGRN>
            <NaimINNYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </NaimINNYULGRNDataDataZapisi>
            <NaimINNYULGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </NaimINNYULGRNDataIsprGRN>
            <NaimINNYULGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </NaimINNYULGRNDataIsprDataZapisi>
            <OKSM>
              <xsl:value-of select="*[local-name()='СвРегИн']/@ОКСМ"/>
            </OKSM>
            <NaimStran>
              <xsl:value-of select="*[local-name()='СвРегИн']/@НаимСтран"/>
            </NaimStran>
            <DataReg>
              <xsl:value-of select="*[local-name()='СвРегИн']/@ДатаРег"/>
            </DataReg>
            <RegNomer>
              <xsl:value-of select="*[local-name()='СвРегИн']/@РегНомер"/>
            </RegNomer>
            <NaimRegOrg>
              <xsl:value-of select="*[local-name()='СвРегИн']/@НаимРегОрг"/>
            </NaimRegOrg>
            <AdrStr>
              <xsl:value-of select="*[local-name()='СвРегИн']/@АдрСтр"/>
            </AdrStr>
            <SvRegInGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvRegInGRNDataGRN>
            <SvRegInGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvRegInGRNDataDataZapisi>
            <SvRegInGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvRegInGRNDataIsprGRN>
            <SvRegInGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvRegInGRNDataIsprDataZapisi>
            <SvRegInKodNPStrReg>
              <xsl:value-of select="*[local-name()='СвРегИн']/@КодНПСтрРег"/>
            </SvRegInKodNPStrReg>
            <SvNedDanUchr>
              <xsl:for-each select="*[local-name()='СвНедДанУчр']">
                <smevInvalidFounder>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <PriznNedDanUchr>
                    <xsl:value-of select="@ПризнНедДанУчр"/>
                  </PriznNedDanUchr>
                  <TekstNedDanUchr>
                    <xsl:value-of select="@ТекстНедДанУчр"/>
                  </TekstNedDanUchr>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevInvalidFounder>
              </xsl:for-each>
            </SvNedDanUchr>
            <NominStoim>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/@НоминСтоим"/>
            </NominStoim>
            <Procent>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='РазмерДоли']/*[local-name()='Процент']"/>
            </Procent>
            <DrobDesyat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='РазмерДоли']/*[local-name()='ДробДесят']"/>
            </DrobDesyat>
            <DrobProst>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='РазмерДоли']/*[local-name()='ДробПрост']/@Числит"/>/<xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Знаменат"/>
            </DrobProst>
            <xsl:if test="*[local-name()='ДоляУстКап']/*[local-name()= 'ДоляРубля']">
              <xsl:variable name="DolyaRublya" select="*[local-name()='ДоляУстКап']/*[local-name()= 'ДоляРубля']"/>
              <DolyaRublya>
                <Znamenat>
                  <xsl:value-of select="$DolyaRublya/@Знаменат"/>
                </Znamenat>
                <Chislit>
                  <xsl:value-of select="$DolyaRublya/@Числит"/>
                </Chislit>
              </DolyaRublya>
            </xsl:if>
            <DolyaUstKapGRNDataGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ГРН"/>
            </DolyaUstKapGRNDataGRN>
            <DolyaUstKapGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataDataZapisi>
            <DolyaUstKapGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </DolyaUstKapGRNDataIsprGRN>
            <DolyaUstKapGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataIsprDataZapisi>
            <SvObrem>
              <xsl:for-each select="*[local-name()='СвОбрем']">
                <smevEncum>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <VidObremeneniya>
                    <xsl:value-of select="@ВидОбрем"/>
                  </VidObremeneniya>
                  <SrokObremeneniya>
                    <xsl:value-of select="@СрокОбременения"/>
                  </SrokObremeneniya>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСуд']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <SvZalogDerzhFLGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhFLGRNDataPervGRN>
                  <SvZalogDerzhFLGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLGRNDataPervDataZapisi>
                  <Familiya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
                  </Familiya>
                  <Imya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Имя"/>
                  </Imya>
                  <Otchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Отчество"/>
                  </Otchestvo>
                  <INNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
                  </INNFL>
                  <SvZalogDerzhFLSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhFLSvNotUdDogZalNomer>
                  <SvZalogDerzhFLSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhFLSvNotUdDogZalData>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']">
                    <xsl:variable name="SvPolFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']"/>
                    <SvZalogDerzhFLSvPolFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <Pol>
                        <xsl:value-of select="$SvPolFL/@Пол"/>
                      </Pol>
                    </SvZalogDerzhFLSvPolFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']">
                    <xsl:variable name="SvGrazhdFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']"/>
                    <SvZalogDerzhFLSvGrazhdFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <KodGrazhd>
                        <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                      </KodGrazhd>
                      <NaimStran>
                        <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                      </NaimStran>
                      <OKSM>
                        <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                      </OKSM>
                    </SvZalogDerzhFLSvGrazhdFL>
                  </xsl:if>
                  <SvZalogDerzhYULGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataPervGRN>
                  <SvZalogDerzhYULGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataPervDataZapisi>
                  <OGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                  </OGRN>
                  <INN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <SvZalogDerzhYULGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataGRN>
                  <SvZalogDerzhYULGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataDataZapisi>
                  <SvZalogDerzhYULGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataIsprGRN>
                  <SvZalogDerzhYULGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataIsprDataZapisi>
                  <OKSM>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
                  </OKSM>
                  <NaimStran>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
                  </NaimStran>
                  <DataReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
                  </DataReg>
                  <RegNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
                  </RegNomer>
                  <NaimRegOrg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <AdrStr>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
                  </AdrStr>
                  <SvZalogDerzhYULSvRegInGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataGRN>
                  <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                  <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                  <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                  <SvZalogDerzhYULSvRegInKodNPStrReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
                  </SvZalogDerzhYULSvRegInKodNPStrReg>
                  <SvZalogDerzhYULSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhYULSvNotUdDogZalNomer>
                  <SvZalogDerzhYULSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhYULSvNotUdDogZalData>
                  <SvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotariusFamiliya>
                  <SvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotariusImya>
                  <SvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotariusOtchestvo>
                  <SvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotariusINNFL>
                  <SvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotariusGRNDataGRN>
                  <SvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataDataZapisi>
                  <SvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotariusGRNDataIsprGRN>
                  <SvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']">
                    <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                    <SvNaimYULPolnIn>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <NaimPoln>
                        <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                      </NaimPoln>
                    </SvNaimYULPolnIn>
                  </xsl:if>
                </smevEncum>
              </xsl:for-each>
            </SvObrem>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <xsl:for-each select="*[local-name()='СвДовУпрЮЛ']">
              <OGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@ОГРН"/>
              </OGRN>
              <INN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@ИНН"/>
              </INN>
              <NaimYULPoln>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@НаимЮЛПолн"/>
              </NaimYULPoln>
              <NaimINNDovUprGRNDataGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДата']/@ГРН"/>
              </NaimINNDovUprGRNDataGRN>
              <NaimINNDovUprGRNDataDataZapisi>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
              </NaimINNDovUprGRNDataDataZapisi>
              <NaimINNDovUprGRNDataIsprGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
              </NaimINNDovUprGRNDataIsprGRN>
              <NaimINNDovUprGRNDataIsprDataZapisi>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
              </NaimINNDovUprGRNDataIsprDataZapisi>
              <GRNDataPervGRN>
                <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
              </GRNDataPervGRN>
              <GRNDataPervDataZapisi>
                <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
              </GRNDataPervDataZapisi>
              <DataOtkrNasl>
                <xsl:value-of select="@ДатаОткрНасл"/>
              </DataOtkrNasl>
              <xsl:if test="*[local-name()= 'СвНаимЮЛПолнИн']">
                <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()= 'СвНаимЮЛПолнИн']"/>
                <SvNaimYULPolnIn>
                  <GRNDataGRN>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <NaimPoln>
                    <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                  </NaimPoln>
                </SvNaimYULPolnIn>
              </xsl:if>
              <xsl:if test="*[local-name()= 'СвРегИн']">
                <xsl:variable name="SvRegIn" select="*[local-name()= 'СвРегИн']"/>
                <SvRegIn>
                  <GRNDataGRN>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <AdrStr>
                    <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                  </AdrStr>
                  <DataReg>
                    <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                  </DataReg>
                  <KodNPStrReg>
                    <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                  </KodNPStrReg>
                  <NaimRegOrg>
                    <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <NaimStran>
                    <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                  </NaimStran>
                  <OKSM>
                    <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                  </OKSM>
                  <RegNomer>
                    <xsl:value-of select="$SvRegIn/@РегНомер"/>
                  </RegNomer>
                </SvRegIn>
              </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="*[local-name()='СвДовУпрФЛ']">
              <SvDovUprFL>
                <OGRNIP>
                  <xsl:value-of select="@ОГРНИП"/>
                </OGRNIP>
                <SvFLFamiliya>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Фамилия"/>
                </SvFLFamiliya>
                <SvFLImya>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Имя"/>
                </SvFLImya>
                <SvFLOtchestvo>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Отчество"/>
                </SvFLOtchestvo>
                <SvFLINNFL>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@ИННФЛ"/>
                </SvFLINNFL>
                <SvFLGRNDataGRN>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                </SvFLGRNDataGRN>
                <SvFLGRNDataDataZapisi>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </SvFLGRNDataDataZapisi>
                <SvFLGRNDataIsprGRN>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </SvFLGRNDataIsprGRN>
                <SvFLGRNDataIsprDataZapisi>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </SvFLGRNDataIsprDataZapisi>
                <SvFLGRNDataPervGRN>
                  <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                </SvFLGRNDataPervGRN>
                <SvFLGRNDataPervDataZapisi>
                  <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                </SvFLGRNDataPervDataZapisi>
                <xsl:if test="*[local-name()= 'СвПолФЛ']">
                  <xsl:variable name="SvPolFL" select="*[local-name()= 'СвПолФЛ']"/>
                  <SvZalogDerzhFLSvPolFL>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <Pol>
                      <xsl:value-of select="$SvPolFL/@Пол"/>
                    </Pol>
                  </SvZalogDerzhFLSvPolFL>
                </xsl:if>
                <xsl:if test="*[local-name()= 'СвГраждФЛ']">
                  <xsl:variable name="SvGrazhdFL" select="*[local-name()= 'СвГраждФЛ']"/>
                  <SvZalogDerzhFLSvGrazhdFL>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <KodGrazhd>
                      <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                    </KodGrazhd>
                    <NaimStran>
                      <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                    </NaimStran>
                    <OKSM>
                      <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                    </OKSM>
                  </SvZalogDerzhFLSvGrazhdFL>
                </xsl:if>
              </SvDovUprFL>
            </xsl:for-each>
            <xsl:if test="*[local-name()= 'СвНаимЮЛПолнИн']">
              <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()= 'СвНаимЮЛПолнИн']"/>
              <SvNaimYULPolnIn>
                <GRNDataGRN>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <NaimPoln>
                  <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                </NaimPoln>
              </SvNaimYULPolnIn>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвОбъемПрав']">
              <xsl:variable name="SvObyemPrav" select="*[local-name()= 'СвОбъемПрав']"/>
              <SvObyemPrav>
                <GRNDataGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <ObyemPrav>
                  <xsl:value-of select="$SvObyemPrav/@ОбъемПрав"/>
                </ObyemPrav>
              </SvObyemPrav>
            </xsl:if>
            <SvUpravZal>
              <xsl:for-each select="*[local-name()= 'СвУправЗал']">
                <smevSvUpravZal>
                  <GRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </GRNDataPervGRN>
                  <GRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </GRNDataPervDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataGRN>
                  <SvDogUpravZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprGRN>
                  <SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                  <SvDogUpravZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvDogUpravZalSvNotariusINNFL>
                  <SvDogUpravZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvDogUpravZalSvNotariusImya>
                  <SvDogUpravZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvDogUpravZalSvNotariusOtchestvo>
                  <SvDogUpravZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvDogUpravZalSvNotariusFamiliya>
                  <SvDogUpravZalData>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Дата"/>
                  </SvDogUpravZalData>
                  <SvDogUpravZalNomer>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Номер"/>
                  </SvDogUpravZalNomer>
                  <SvNotUdDogZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataGRN>
                  <SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                  <SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                  <SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                  <SvNotUdDogZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotUdDogZalSvNotariusINNFL>
                  <SvNotUdDogZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotUdDogZalSvNotariusImya>
                  <SvNotUdDogZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotUdDogZalSvNotariusOtchestvo>
                  <SvNotUdDogZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotUdDogZalSvNotariusFamiliya>
                  <SvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvNotUdDogZalData>
                  <SvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvNotUdDogZalNomer>
                  <xsl:if test="*[local-name()= 'СвУпрЗалФЛ']">
                    <xsl:variable name="SvUprZalFL" select="*[local-name()= 'СвУпрЗалФЛ']"/>
                    <SvUprZalFL>
                      <SvFLGRNDataGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </SvFLGRNDataGRN>
                      <SvFLGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </SvFLGRNDataDataZapisi>
                      <SvFLGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </SvFLGRNDataIsprGRN>
                      <SvFLGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </SvFLGRNDataIsprDataZapisi>
                      <SvFLINNFL>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@ИННФЛ"/>
                      </SvFLINNFL>
                      <SvFLImya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Имя"/>
                      </SvFLImya>
                      <SvFLOtchestvo>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Отчество"/>
                      </SvFLOtchestvo>
                      <SvFLFamiliya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Фамилия"/>
                      </SvFLFamiliya>
                      <OGRNIP>
                        <xsl:value-of select="$SvUprZalFL/@ОГРНИП"/>
                      </OGRNIP>
                    </SvUprZalFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()= 'СвУпрЗалЮЛ']">
                    <xsl:variable name="SvUprZalYUL" select="*[local-name()= 'СвУпрЗалЮЛ']"/>
                    <SvUprZalYUL>
                      <NaimINNYULGRNDataGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </NaimINNYULGRNDataGRN>
                      <NaimINNYULGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataDataZapisi>
                      <NaimINNYULGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </NaimINNYULGRNDataIsprGRN>
                      <NaimINNYULGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataIsprDataZapisi>
                      <NaimINNYULINN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                      </NaimINNYULINN>
                      <NaimINNYULNaimYULPoln>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                      </NaimINNYULNaimYULPoln>
                      <NaimINNYULOGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                      </NaimINNYULOGRN>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']">
                        <xsl:variable name="SvNaimYULPolnIn" select="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                        <SvNaimYULPolnIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <NaimPoln>
                            <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                          </NaimPoln>
                        </SvNaimYULPolnIn>
                      </xsl:if>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвРегИн']">
                        <xsl:variable name="SvRegIn" select="$SvUprZalYUL/*[local-name()= 'СвРегИн']"/>
                        <SvRegIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <AdrStr>
                            <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                          </AdrStr>
                          <DataReg>
                            <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                          </DataReg>
                          <KodNPStrReg>
                            <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                          </KodNPStrReg>
                          <NaimRegOrg>
                            <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                          </NaimRegOrg>
                          <NaimStran>
                            <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                          </NaimStran>
                          <OKSM>
                            <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                          </OKSM>
                          <RegNomer>
                            <xsl:value-of select="$SvRegIn/@РегНомер"/>
                          </RegNomer>
                        </SvRegIn>
                      </xsl:if>
                    </SvUprZalYUL>
                  </xsl:if>
                </smevSvUpravZal>
              </xsl:for-each>
            </SvUpravZal>
          </smevFounderInt>
        </xsl:for-each>
      </UchrYULIn>
      <UchrFL>
        <xsl:for-each select="$SvUL/*[local-name()='СвУчредит']/*[local-name()='УчрФЛ']">
          <smevFounderFL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <OGRNIP>
              <xsl:value-of select="@ОГРНИП"/>
            </OGRNIP>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <Familiya>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Фамилия"/>
            </Familiya>
            <Imya>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Имя"/>
            </Imya>
            <Otchestvo>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Отчество"/>
            </Otchestvo>
            <INNFL>
              <xsl:value-of select="*[local-name()='СвФЛ']/@ИННФЛ"/>
            </INNFL>
            <SvFLGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvFLGRNDataGRN>
            <SvFLGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvFLGRNDataDataZapisi>
            <SvFLGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvFLGRNDataIsprGRN>
            <SvFLGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvFLGRNDataIsprDataZapisi>
            <SvNedDanUchr>
              <xsl:for-each select="*[local-name()='СвНедДанУчр']">
                <smevInvalidFounder>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <PriznNedDanUchr>
                    <xsl:value-of select="@ПризнНедДанУчр"/>
                  </PriznNedDanUchr>
                  <TekstNedDanUchr>
                    <xsl:value-of select="@ТекстНедДанУчр"/>
                  </TekstNedDanUchr>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevInvalidFounder>
              </xsl:for-each>
            </SvNedDanUchr>
            <NominStoim>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/@НоминСтоим"/>
            </NominStoim>
            <Procent>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='Процент']"/>
            </Procent>
            <DrobDesyat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробДесят']"/>
            </DrobDesyat>
            <DrobProst>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Числит"/>/<xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Знаменат"/>
            </DrobProst>
            <DolyaUstKapGRNDataGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ГРН"/>
            </DolyaUstKapGRNDataGRN>
            <DolyaUstKapGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataDataZapisi>
            <DolyaUstKapGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </DolyaUstKapGRNDataIsprGRN>
            <DolyaUstKapGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataIsprDataZapisi>
            <CHislit>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ДоляРубля']/@Числит"/>
            </CHislit>
            <Znamenat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ДоляРубля']/@Знаменат"/>
            </Znamenat>
            <SvObrem>
              <xsl:for-each select="*[local-name()='СвОбрем']">
                <smevEncum>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <VidObremeneniya>
                    <xsl:value-of select="@ВидОбрем"/>
                  </VidObremeneniya>
                  <SrokObremeneniya>
                    <xsl:value-of select="@СрокОбременения"/>
                  </SrokObremeneniya>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСуд']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <SvZalogDerzhFLGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhFLGRNDataPervGRN>
                  <SvZalogDerzhFLGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLGRNDataPervDataZapisi>
                  <Familiya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
                  </Familiya>
                  <Imya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Имя"/>
                  </Imya>
                  <Otchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Отчество"/>
                  </Otchestvo>
                  <INNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
                  </INNFL>
                  <SvZalogDerzhFLSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhFLSvNotUdDogZalNomer>
                  <SvZalogDerzhFLSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhFLSvNotUdDogZalData>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']">
                    <xsl:variable name="SvPolFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']"/>
                    <SvZalogDerzhFLSvPolFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <Pol>
                        <xsl:value-of select="$SvPolFL/@Пол"/>
                      </Pol>
                    </SvZalogDerzhFLSvPolFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']">
                    <xsl:variable name="SvGrazhdFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']"/>
                    <SvZalogDerzhFLSvGrazhdFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <KodGrazhd>
                        <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                      </KodGrazhd>
                      <NaimStran>
                        <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                      </NaimStran>
                      <OKSM>
                        <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                      </OKSM>
                    </SvZalogDerzhFLSvGrazhdFL>
                  </xsl:if>
                  <SvZalogDerzhYULGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataPervGRN>
                  <SvZalogDerzhYULGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataPervDataZapisi>
                  <OGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                  </OGRN>
                  <INN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <SvZalogDerzhYULGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataGRN>
                  <SvZalogDerzhYULGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataDataZapisi>
                  <SvZalogDerzhYULGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataIsprGRN>
                  <SvZalogDerzhYULGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataIsprDataZapisi>
                  <OKSM>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
                  </OKSM>
                  <NaimStran>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
                  </NaimStran>
                  <DataReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
                  </DataReg>
                  <RegNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
                  </RegNomer>
                  <NaimRegOrg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <AdrStr>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
                  </AdrStr>
                  <SvZalogDerzhYULSvRegInGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataGRN>
                  <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                  <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                  <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                  <SvZalogDerzhYULSvRegInKodNPStrReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
                  </SvZalogDerzhYULSvRegInKodNPStrReg>
                  <SvZalogDerzhYULSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhYULSvNotUdDogZalNomer>
                  <SvZalogDerzhYULSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhYULSvNotUdDogZalData>
                  <SvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotariusFamiliya>
                  <SvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotariusImya>
                  <SvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotariusOtchestvo>
                  <SvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotariusINNFL>
                  <SvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotariusGRNDataGRN>
                  <SvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataDataZapisi>
                  <SvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotariusGRNDataIsprGRN>
                  <SvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']">
                    <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                    <SvZalogDerzhYULSvNaimYULPolnIn>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <NaimPoln>
                        <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                      </NaimPoln>
                    </SvZalogDerzhYULSvNaimYULPolnIn>
                  </xsl:if>
                </smevEncum>
              </xsl:for-each>
            </SvObrem>
            <xsl:for-each select="*[local-name()='СвДовУпрЮЛ']">
              <OGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@ОГРН"/>
              </OGRN>
              <INN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@ИНН"/>
              </INN>
              <NaimYULPoln>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/@НаимЮЛПолн"/>
              </NaimYULPoln>
              <NaimINNDovUprGRNDataGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДата']/@ГРН"/>
              </NaimINNDovUprGRNDataGRN>
              <NaimINNDovUprGRNDataDataZapisi>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
              </NaimINNDovUprGRNDataDataZapisi>
              <NaimINNDovUprGRNDataIsprGRN>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
              </NaimINNDovUprGRNDataIsprGRN>
              <NaimINNDovUprGRNDataIsprDataZapisi>
                <xsl:value-of select="*[local-name()='НаимИННДовУпр']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
              </NaimINNDovUprGRNDataIsprDataZapisi>
              <GRNDataPervGRN>
                <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
              </GRNDataPervGRN>
              <GRNDataPervDataZapisi>
                <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
              </GRNDataPervDataZapisi>
              <DataOtkrNasl>
                <xsl:value-of select="@ДатаОткрНасл"/>
              </DataOtkrNasl>
              <xsl:if test="*[local-name()= 'СвНаимЮЛПолнИн']">
                <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()= 'СвНаимЮЛПолнИн']"/>
                <SvNaimYULPolnIn>
                  <GRNDataGRN>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <NaimPoln>
                    <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                  </NaimPoln>
                </SvNaimYULPolnIn>
              </xsl:if>
              <xsl:if test="*[local-name()= 'СвРегИн']">
                <xsl:variable name="SvRegIn" select="*[local-name()= 'СвРегИн']"/>
                <SvRegIn>
                  <GRNDataGRN>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <AdrStr>
                    <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                  </AdrStr>
                  <DataReg>
                    <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                  </DataReg>
                  <KodNPStrReg>
                    <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                  </KodNPStrReg>
                  <NaimRegOrg>
                    <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <NaimStran>
                    <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                  </NaimStran>
                  <OKSM>
                    <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                  </OKSM>
                  <RegNomer>
                    <xsl:value-of select="$SvRegIn/@РегНомер"/>
                  </RegNomer>
                </SvRegIn>
              </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="*[local-name()='СвДовУпрФЛ']">
              <SvDovUprFL>
                <SvFLFamiliya>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Фамилия"/>
                </SvFLFamiliya>
                <SvFLImya>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Имя"/>
                </SvFLImya>
                <SvFLOtchestvo>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@Отчество"/>
                </SvFLOtchestvo>
                <SvFLINNFL>
                  <xsl:value-of select="*[local-name()='СвФЛ']/@ИННФЛ"/>
                </SvFLINNFL>
                <SvFLGRNDataGRN>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                </SvFLGRNDataGRN>
                <SvFLGRNDataDataZapisi>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </SvFLGRNDataDataZapisi>
                <SvFLGRNDataIsprGRN>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </SvFLGRNDataIsprGRN>
                <SvFLGRNDataIsprDataZapisi>
                  <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </SvFLGRNDataIsprDataZapisi>
                <SvFLGRNDataPervGRN>
                  <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                </SvFLGRNDataPervGRN>
                <SvFLGRNDataPervDataZapisi>
                  <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                </SvFLGRNDataPervDataZapisi>
                <xsl:if test="*[local-name()= 'СвПолФЛ']">
                  <xsl:variable name="SvPolFL" select="*[local-name()= 'СвПолФЛ']"/>
                  <SvZalogDerzhFLSvPolFL>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <Pol>
                      <xsl:value-of select="$SvPolFL/@Пол"/>
                    </Pol>
                  </SvZalogDerzhFLSvPolFL>
                </xsl:if>
                <xsl:if test="*[local-name()= 'СвГраждФЛ']">
                  <xsl:variable name="SvGrazhdFL" select="*[local-name()= 'СвГраждФЛ']"/>
                  <SvZalogDerzhFLSvGrazhdFL>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <KodGrazhd>
                      <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                    </KodGrazhd>
                    <NaimStran>
                      <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                    </NaimStran>
                    <OKSM>
                      <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                    </OKSM>
                  </SvZalogDerzhFLSvGrazhdFL>
                </xsl:if>
              </SvDovUprFL>
            </xsl:for-each>
            <LitsoUprNasl>
              <xsl:for-each select="*[local-name()= 'ЛицоУпрНасл']">
                <smevLitsoUprNasl>
                  <OGRNIP>
                    <xsl:value-of select="@ОГРНИП"/>
                  </OGRNIP>
                  <xsl:if test="*[local-name()= 'СвПолФЛ']">
                    <xsl:variable name="SvPolFL" select="*[local-name()= 'СвПолФЛ']"/>
                    <SvZalogDerzhFLSvPolFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <Pol>
                        <xsl:value-of select="$SvPolFL/@Пол"/>
                      </Pol>
                    </SvZalogDerzhFLSvPolFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()= 'СвГраждФЛ']">
                    <xsl:variable name="SvGrazhdFL" select="*[local-name()= 'СвГраждФЛ']"/>
                    <SvZalogDerzhFLSvGrazhdFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <KodGrazhd>
                        <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                      </KodGrazhd>
                      <NaimStran>
                        <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                      </NaimStran>
                      <OKSM>
                        <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                      </OKSM>
                    </SvZalogDerzhFLSvGrazhdFL>
                  </xsl:if>
                </smevLitsoUprNasl>
              </xsl:for-each>
            </LitsoUprNasl>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвГраждФЛ']">
              <xsl:variable name="SvGrazhdFL" select="*[local-name()= 'СвГраждФЛ']"/>
              <SvZalogDerzhFLSvGrazhdFL>
                <GRNDataGRN>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <KodGrazhd>
                  <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                </KodGrazhd>
                <NaimStran>
                  <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                </NaimStran>
                <OKSM>
                  <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                </OKSM>
              </SvZalogDerzhFLSvGrazhdFL>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвОбъемПрав']">
              <xsl:variable name="SvObyemPrav" select="*[local-name()= 'СвОбъемПрав']"/>
              <SvObyemPrav>
                <GRNDataGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <ObyemPrav>
                  <xsl:value-of select="$SvObyemPrav/@ОбъемПрав"/>
                </ObyemPrav>
              </SvObyemPrav>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвПолФЛ']">
              <xsl:variable name="SvPolFL" select="*[local-name()= 'СвПолФЛ']"/>
              <SvZalogDerzhFLSvPolFL>
                <GRNDataGRN>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <Pol>
                  <xsl:value-of select="$SvPolFL/@Пол"/>
                </Pol>
              </SvZalogDerzhFLSvPolFL>
            </xsl:if>
            <SvUpravZal>
              <xsl:for-each select="*[local-name()= 'СвУправЗал']">
                <smevSvUpravZal>
                  <GRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </GRNDataPervGRN>
                  <GRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </GRNDataPervDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataGRN>
                  <SvDogUpravZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprGRN>
                  <SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                  <SvDogUpravZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvDogUpravZalSvNotariusINNFL>
                  <SvDogUpravZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvDogUpravZalSvNotariusImya>
                  <SvDogUpravZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvDogUpravZalSvNotariusOtchestvo>
                  <SvDogUpravZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvDogUpravZalSvNotariusFamiliya>
                  <SvDogUpravZalData>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Дата"/>
                  </SvDogUpravZalData>
                  <SvDogUpravZalNomer>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Номер"/>
                  </SvDogUpravZalNomer>
                  <SvNotUdDogZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataGRN>
                  <SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                  <SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                  <SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                  <SvNotUdDogZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotUdDogZalSvNotariusINNFL>
                  <SvNotUdDogZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotUdDogZalSvNotariusImya>
                  <SvNotUdDogZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotUdDogZalSvNotariusOtchestvo>
                  <SvNotUdDogZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotUdDogZalSvNotariusFamiliya>
                  <SvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvNotUdDogZalData>
                  <SvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvNotUdDogZalNomer>
                  <xsl:if test="*[local-name()= 'СвУпрЗалФЛ']">
                    <xsl:variable name="SvUprZalFL" select="*[local-name()= 'СвУпрЗалФЛ']"/>
                    <SvUprZalFL>
                      <SvFLGRNDataGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </SvFLGRNDataGRN>
                      <SvFLGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </SvFLGRNDataDataZapisi>
                      <SvFLGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </SvFLGRNDataIsprGRN>
                      <SvFLGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </SvFLGRNDataIsprDataZapisi>
                      <SvFLINNFL>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@ИННФЛ"/>
                      </SvFLINNFL>
                      <SvFLImya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Имя"/>
                      </SvFLImya>
                      <SvFLOtchestvo>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Отчество"/>
                      </SvFLOtchestvo>
                      <SvFLFamiliya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Фамилия"/>
                      </SvFLFamiliya>
                      <OGRNIP>
                        <xsl:value-of select="$SvUprZalFL/@ОГРНИП"/>
                      </OGRNIP>
                    </SvUprZalFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()= 'СвУпрЗалЮЛ']">
                    <xsl:variable name="SvUprZalYUL" select="*[local-name()= 'СвУпрЗалЮЛ']"/>
                    <SvUprZalYUL>
                      <NaimINNYULGRNDataGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </NaimINNYULGRNDataGRN>
                      <NaimINNYULGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataDataZapisi>
                      <NaimINNYULGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </NaimINNYULGRNDataIsprGRN>
                      <NaimINNYULGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataIsprDataZapisi>
                      <NaimINNYULINN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                      </NaimINNYULINN>
                      <NaimINNYULNaimYULPoln>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                      </NaimINNYULNaimYULPoln>
                      <NaimINNYULOGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                      </NaimINNYULOGRN>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']">
                        <xsl:variable name="SvNaimYULPolnIn" select="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                        <SvNaimYULPolnIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <NaimPoln>
                            <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                          </NaimPoln>
                        </SvNaimYULPolnIn>
                      </xsl:if>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвРегИн']">
                        <xsl:variable name="SvRegIn" select="$SvUprZalYUL/*[local-name()= 'СвРегИн']"/>
                        <SvRegIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <AdrStr>
                            <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                          </AdrStr>
                          <DataReg>
                            <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                          </DataReg>
                          <KodNPStrReg>
                            <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                          </KodNPStrReg>
                          <NaimRegOrg>
                            <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                          </NaimRegOrg>
                          <NaimStran>
                            <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                          </NaimStran>
                          <OKSM>
                            <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                          </OKSM>
                          <RegNomer>
                            <xsl:value-of select="$SvRegIn/@РегНомер"/>
                          </RegNomer>
                        </SvRegIn>
                      </xsl:if>
                    </SvUprZalYUL>
                  </xsl:if>
                </smevSvUpravZal>
              </xsl:for-each>
            </SvUpravZal>
            <xsl:if test="*[local-name()= 'СвФИОЗАГС']">
              <xsl:variable name="SvFIOZAGS" select="*[local-name()= 'СвФИОЗАГС']"/>
              <SvFIOZAGS>
                <GRNDataGRN>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvFIOZAGS/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <Imya>
                  <xsl:value-of select="$SvFIOZAGS/@Имя"/>
                </Imya>
                <Otchestvo>
                  <xsl:value-of select="$SvFIOZAGS/@Отчество"/>
                </Otchestvo>
                <Familiya>
                  <xsl:value-of select="$SvFIOZAGS/@Фамилия"/>
                </Familiya>
              </SvFIOZAGS>
            </xsl:if>
          </smevFounderFL>
        </xsl:for-each>
      </UchrFL>
      <UchrRFSubMO>
        <xsl:for-each select="$SvUL/*[local-name()='СвУчредит']/*[local-name()='УчрРФСубМО']">
          <smevFounderRegion>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <KodUchrRFSubMO _json="as_{*[local-name()='ВидНаимУчр']/@КодУчрРФСубМО}">
              <xsl:value-of select="*[local-name()='ВидНаимУчр']/@КодУчрРФСубМО"/>
            </KodUchrRFSubMO>
            <NaimMO>
              <xsl:value-of select="*[local-name()='ВидНаимУчр']/@НаимМО"/>
            </NaimMO>
            <KodRegion _json="as_{*[local-name()='ВидНаимУчр']/@КодРегион}">
              <xsl:value-of select="*[local-name()='ВидНаимУчр']/@КодРегион"/>
            </KodRegion>
            <NaimRegion>
              <xsl:value-of select="*[local-name()='ВидНаимУчр']/@НаимРегион"/>
            </NaimRegion>
            <SvNedDanUchr>
              <xsl:for-each select="*[local-name()='СвНедДанУчр']">
                <smevInvalidFounder>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <PriznNedDanUchr>
                    <xsl:value-of select="@ПризнНедДанУчр"/>
                  </PriznNedDanUchr>
                  <TekstNedDanUchr>
                    <xsl:value-of select="@ТекстНедДанУчр"/>
                  </TekstNedDanUchr>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСудНедДанУчр']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                </smevInvalidFounder>
              </xsl:for-each>
            </SvNedDanUchr>
            <NominStoim>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/@НоминСтоим"/>
            </NominStoim>
            <Procent>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='Процент']"/>
            </Procent>
            <DrobDesyat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробДесят']"/>
            </DrobDesyat>
            <DrobProst>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Числит"/>/<xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Знаменат"/>
            </DrobProst>
            <DolyaUstKapGRNDataGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ГРН"/>
            </DolyaUstKapGRNDataGRN>
            <DolyaUstKapGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataDataZapisi>
            <DolyaUstKapGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </DolyaUstKapGRNDataIsprGRN>
            <DolyaUstKapGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataIsprDataZapisi>
            <OGRN>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
            </NaimYULPoln>
            <NaimINNYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </NaimINNYULGRNDataGRN>
            <NaimINNYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </NaimINNYULGRNDataDataZapisi>
            <NaimINNYULGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </NaimINNYULGRNDataIsprGRN>
            <NaimINNYULGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </NaimINNYULGRNDataIsprDataZapisi>
            <SvOrgOsushPrGRNDataPervGRN>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </SvOrgOsushPrGRNDataPervGRN>
            <SvOrgOsushPrDataZapisi>
              <xsl:value-of select="*[local-name()='СвОргОсущПр']/*[local-name()='SvOrgOsushPrDataZapisi']/@ДатаЗаписи"/>
            </SvOrgOsushPrDataZapisi>
            <SvFLOsushPrGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvFLOsushPrGRNDataGRN>
            <SvFLOsushPrGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvFLOsushPrGRNDataDataZapisi>
            <Familiya>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/@Фамилия"/>
            </Familiya>
            <Imya>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/@Имя"/>
            </Imya>
            <Otchestvo>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/@Отчество"/>
            </Otchestvo>
            <INNFL>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/@ИННФЛ"/>
            </INNFL>
            <SvFLGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvFLGRNDataGRN>
            <SvFLGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvFLGRNDataDataZapisi>
            <SvFLGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvFLGRNDataIsprGRN>
            <SvFLGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛОсущПр']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvFLGRNDataIsprDataZapisi>
            <SvObrem>
              <xsl:for-each select="*[local-name()='СвОбрем']">
                <smevEncum>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <VidObremeneniya>
                    <xsl:value-of select="@ВидОбрем"/>
                  </VidObremeneniya>
                  <SrokObremeneniya>
                    <xsl:value-of select="@СрокОбременения"/>
                  </SrokObremeneniya>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСуд']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <SvZalogDerzhFLGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhFLGRNDataPervGRN>
                  <SvZalogDerzhFLGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLGRNDataPervDataZapisi>
                  <Familiya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
                  </Familiya>
                  <Imya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Имя"/>
                  </Imya>
                  <Otchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Отчество"/>
                  </Otchestvo>
                  <INNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
                  </INNFL>
                  <SvZalogDerzhFLSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhFLSvNotUdDogZalNomer>
                  <SvZalogDerzhFLSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhFLSvNotUdDogZalData>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']">
                    <xsl:variable name="SvPolFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']"/>
                    <SvZalogDerzhFLSvPolFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <Pol>
                        <xsl:value-of select="$SvPolFL/@Пол"/>
                      </Pol>
                    </SvZalogDerzhFLSvPolFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']">
                    <xsl:variable name="SvGrazhdFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']"/>
                    <SvZalogDerzhFLSvGrazhdFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <KodGrazhd>
                        <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                      </KodGrazhd>
                      <NaimStran>
                        <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                      </NaimStran>
                      <OKSM>
                        <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                      </OKSM>
                    </SvZalogDerzhFLSvGrazhdFL>
                  </xsl:if>
                  <SvZalogDerzhYULGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataPervGRN>
                  <SvZalogDerzhYULGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataPervDataZapisi>
                  <OGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                  </OGRN>
                  <INN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <SvZalogDerzhYULGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataGRN>
                  <SvZalogDerzhYULGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataDataZapisi>
                  <SvZalogDerzhYULGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataIsprGRN>
                  <SvZalogDerzhYULGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataIsprDataZapisi>
                  <OKSM>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
                  </OKSM>
                  <NaimStran>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
                  </NaimStran>
                  <DataReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
                  </DataReg>
                  <RegNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
                  </RegNomer>
                  <NaimRegOrg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <AdrStr>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
                  </AdrStr>
                  <SvZalogDerzhYULSvRegInGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataGRN>
                  <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                  <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                  <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                  <SvZalogDerzhYULSvRegInKodNPStrReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
                  </SvZalogDerzhYULSvRegInKodNPStrReg>
                  <SvZalogDerzhYULSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhYULSvNotUdDogZalNomer>
                  <SvZalogDerzhYULSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhYULSvNotUdDogZalData>
                  <SvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotariusFamiliya>
                  <SvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotariusImya>
                  <SvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotariusOtchestvo>
                  <SvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotariusINNFL>
                  <SvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotariusGRNDataGRN>
                  <SvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataDataZapisi>
                  <SvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotariusGRNDataIsprGRN>
                  <SvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']">
                    <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                    <SvNaimYULPolnIn>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <NaimPoln>
                        <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                      </NaimPoln>
                    </SvNaimYULPolnIn>
                  </xsl:if>
                </smevEncum>
              </xsl:for-each>
            </SvObrem>
            <CHislit>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ДоляРубля']/@Числит"/>
            </CHislit>
            <Znamenat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ДоляРубля']/@Знаменат"/>
            </Znamenat>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <SvDovUprYULRF>
              <xsl:for-each select="*[local-name()= 'СвДовУпрЮЛРФ']">
                <smevSvDovUprYULRF>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <INN>
                    <xsl:value-of select="@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <OGRN>
                    <xsl:value-of select="@ОГРН"/>
                  </OGRN>
                </smevSvDovUprYULRF>
              </xsl:for-each>
            </SvDovUprYULRF>
            <xsl:if test="*[local-name()= 'СвОбъемПрав']">
              <xsl:variable name="SvObyemPrav" select="*[local-name()= 'СвОбъемПрав']"/>
              <SvObyemPrav>
                <GRNDataGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <ObyemPrav>
                  <xsl:value-of select="$SvObyemPrav/@ОбъемПрав"/>
                </ObyemPrav>
              </SvObyemPrav>
            </xsl:if>
            <SvUpravZal>
              <xsl:for-each select="*[local-name()= 'СвУправЗал']">
                <smevSvUpravZal>
                  <GRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </GRNDataPervGRN>
                  <GRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </GRNDataPervDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataGRN>
                  <SvDogUpravZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprGRN>
                  <SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                  <SvDogUpravZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvDogUpravZalSvNotariusINNFL>
                  <SvDogUpravZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvDogUpravZalSvNotariusImya>
                  <SvDogUpravZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvDogUpravZalSvNotariusOtchestvo>
                  <SvDogUpravZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvDogUpravZalSvNotariusFamiliya>
                  <SvDogUpravZalData>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Дата"/>
                  </SvDogUpravZalData>
                  <SvDogUpravZalNomer>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Номер"/>
                  </SvDogUpravZalNomer>
                  <SvNotUdDogZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataGRN>
                  <SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                  <SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                  <SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                  <SvNotUdDogZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotUdDogZalSvNotariusINNFL>
                  <SvNotUdDogZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotUdDogZalSvNotariusImya>
                  <SvNotUdDogZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotUdDogZalSvNotariusOtchestvo>
                  <SvNotUdDogZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotUdDogZalSvNotariusFamiliya>
                  <SvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvNotUdDogZalData>
                  <SvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvNotUdDogZalNomer>
                  <xsl:if test="*[local-name()= 'СвУпрЗалФЛ']">
                    <xsl:variable name="SvUprZalFL" select="*[local-name()= 'СвУпрЗалФЛ']"/>
                    <SvUprZalFL>
                      <SvFLGRNDataGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </SvFLGRNDataGRN>
                      <SvFLGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </SvFLGRNDataDataZapisi>
                      <SvFLGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </SvFLGRNDataIsprGRN>
                      <SvFLGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </SvFLGRNDataIsprDataZapisi>
                      <SvFLINNFL>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@ИННФЛ"/>
                      </SvFLINNFL>
                      <SvFLImya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Имя"/>
                      </SvFLImya>
                      <SvFLOtchestvo>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Отчество"/>
                      </SvFLOtchestvo>
                      <SvFLFamiliya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Фамилия"/>
                      </SvFLFamiliya>
                      <OGRNIP>
                        <xsl:value-of select="$SvUprZalFL/@ОГРНИП"/>
                      </OGRNIP>
                    </SvUprZalFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()= 'СвУпрЗалЮЛ']">
                    <xsl:variable name="SvUprZalYUL" select="*[local-name()= 'СвУпрЗалЮЛ']"/>
                    <SvUprZalYUL>
                      <NaimINNYULGRNDataGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </NaimINNYULGRNDataGRN>
                      <NaimINNYULGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataDataZapisi>
                      <NaimINNYULGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </NaimINNYULGRNDataIsprGRN>
                      <NaimINNYULGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataIsprDataZapisi>
                      <NaimINNYULINN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                      </NaimINNYULINN>
                      <NaimINNYULNaimYULPoln>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                      </NaimINNYULNaimYULPoln>
                      <NaimINNYULOGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                      </NaimINNYULOGRN>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']">
                        <xsl:variable name="SvNaimYULPolnIn" select="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                        <SvNaimYULPolnIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <NaimPoln>
                            <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                          </NaimPoln>
                        </SvNaimYULPolnIn>
                      </xsl:if>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвРегИн']">
                        <xsl:variable name="SvRegIn" select="$SvUprZalYUL/*[local-name()= 'СвРегИн']"/>
                        <SvRegIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <AdrStr>
                            <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                          </AdrStr>
                          <DataReg>
                            <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                          </DataReg>
                          <KodNPStrReg>
                            <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                          </KodNPStrReg>
                          <NaimRegOrg>
                            <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                          </NaimRegOrg>
                          <NaimStran>
                            <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                          </NaimStran>
                          <OKSM>
                            <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                          </OKSM>
                          <RegNomer>
                            <xsl:value-of select="$SvRegIn/@РегНомер"/>
                          </RegNomer>
                        </SvRegIn>
                      </xsl:if>
                    </SvUprZalYUL>
                  </xsl:if>
                </smevSvUpravZal>
              </xsl:for-each>
            </SvUpravZal>
          </smevFounderRegion>
        </xsl:for-each>
      </UchrRFSubMO>
      <UchrPIF>
        <xsl:for-each select="$SvUL/*[local-name()='СвУчредит']/*[local-name()='УчрПИФ']">
          <smevFounderPIF>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <NaimPIF>
              <xsl:value-of select="*[local-name()='СвНаимПИФ']/@НаимПИФ"/>
            </NaimPIF>
            <SvNaimPIFGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвНаимПИФ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvNaimPIFGRNDataGRN>
            <SvNaimPIFGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвНаимПИФ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvNaimPIFGRNDataDataZapisi>
            <SvNaimPIFGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвНаимПИФ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvNaimPIFGRNDataIsprGRN>
            <SvNaimPIFGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвНаимПИФ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvNaimPIFGRNDataIsprDataZapisi>
            <SvObrem>
              <xsl:for-each select="*[local-name()='СвОбрем']">
                <smevEncum>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <VidObremeneniya>
                    <xsl:value-of select="@ВидОбрем"/>
                  </VidObremeneniya>
                  <SrokObremeneniya>
                    <xsl:value-of select="@СрокОбременения"/>
                  </SrokObremeneniya>
                  <NaimSuda>
                    <xsl:value-of select="*[local-name()='РешСуд']/@НаимСуда"/>
                  </NaimSuda>
                  <Nomer>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Номер"/>
                  </Nomer>
                  <Data>
                    <xsl:value-of select="*[local-name()='РешСуд']/@Дата"/>
                  </Data>
                  <GRNDataGRN>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
                  </GRNDataGRN>
                  <GRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </GRNDataDataZapisi>
                  <GRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRNDataIsprGRN>
                  <GRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </GRNDataIsprDataZapisi>
                  <SvZalogDerzhFLGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhFLGRNDataPervGRN>
                  <SvZalogDerzhFLGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLGRNDataPervDataZapisi>
                  <Familiya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
                  </Familiya>
                  <Imya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Имя"/>
                  </Imya>
                  <Otchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Отчество"/>
                  </Otchestvo>
                  <INNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
                  </INNFL>
                  <SvZalogDerzhFLSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhFLSvNotUdDogZalNomer>
                  <SvZalogDerzhFLSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhFLSvNotUdDogZalData>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLImya>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
                  <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']">
                    <xsl:variable name="SvPolFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']"/>
                    <SvZalogDerzhFLSvPolFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <Pol>
                        <xsl:value-of select="$SvPolFL/@Пол"/>
                      </Pol>
                    </SvZalogDerzhFLSvPolFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']">
                    <xsl:variable name="SvGrazhdFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']"/>
                    <SvZalogDerzhFLSvGrazhdFL>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <KodGrazhd>
                        <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                      </KodGrazhd>
                      <NaimStran>
                        <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                      </NaimStran>
                      <OKSM>
                        <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                      </OKSM>
                    </SvZalogDerzhFLSvGrazhdFL>
                  </xsl:if>
                  <SvZalogDerzhYULGRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataPervGRN>
                  <SvZalogDerzhYULGRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataPervDataZapisi>
                  <OGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                  </OGRN>
                  <INN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <SvZalogDerzhYULGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataGRN>
                  <SvZalogDerzhYULGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataDataZapisi>
                  <SvZalogDerzhYULGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULGRNDataIsprGRN>
                  <SvZalogDerzhYULGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULGRNDataIsprDataZapisi>
                  <OKSM>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
                  </OKSM>
                  <NaimStran>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
                  </NaimStran>
                  <DataReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
                  </DataReg>
                  <RegNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
                  </RegNomer>
                  <NaimRegOrg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
                  </NaimRegOrg>
                  <AdrStr>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
                  </AdrStr>
                  <SvZalogDerzhYULSvRegInGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataGRN>
                  <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
                  <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
                  <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
                  <SvZalogDerzhYULSvRegInKodNPStrReg>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
                  </SvZalogDerzhYULSvRegInKodNPStrReg>
                  <SvZalogDerzhYULSvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvZalogDerzhYULSvNotUdDogZalNomer>
                  <SvZalogDerzhYULSvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvZalogDerzhYULSvNotUdDogZalData>
                  <SvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotariusFamiliya>
                  <SvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotariusImya>
                  <SvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotariusOtchestvo>
                  <SvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotariusINNFL>
                  <SvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotariusGRNDataGRN>
                  <SvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataDataZapisi>
                  <SvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotariusGRNDataIsprGRN>
                  <SvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotariusGRNDataIsprDataZapisi>
                  <xsl:if test="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']">
                    <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                    <SvNaimYULPolnIn>
                      <GRNDataGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                      </GRNDataGRN>
                      <GRNDataDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </GRNDataDataZapisi>
                      <GRNDataIsprGRN>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </GRNDataIsprGRN>
                      <GRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </GRNDataIsprDataZapisi>
                      <NaimPoln>
                        <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                      </NaimPoln>
                    </SvNaimYULPolnIn>
                  </xsl:if>
                </smevEncum>
              </xsl:for-each>
            </SvObrem>
            <SvUprKompPIFGRNDataPervGRN>
              <xsl:value-of select="*[local-name()='СвУпрКомпПИФ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </SvUprKompPIFGRNDataPervGRN>
            <SvUprKompPIFGRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='СвУпрКомпПИФ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </SvUprKompPIFGRNDataPervDataZapisi>
            <OGRN>
              <xsl:value-of select="*[local-name()='СвУпрКомпПИФ']/*[local-name()='УпрКомпПиф']/@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="*[local-name()='СвУпрКомпПИФ']/*[local-name()='УпрКомпПиф']/@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="*[local-name()='СвУпрКомпПИФ']/*[local-name()='УпрКомпПиф']/@НаимЮЛПолн"/>
            </NaimYULPoln>
            <NominStoim>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/@НоминСтоим"/>
            </NominStoim>
            <Procent>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='Процент']"/>
            </Procent>
            <DrobDesyat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробДесят']"/>
            </DrobDesyat>
            <DrobProst>
              <xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Числит"/>/<xsl:value-of select="*[local-name()='ДоляУстКап']//*[local-name()='ДробПрост']/@Знаменат"/>
            </DrobProst>
            <DolyaUstKapGRNDataGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ГРН"/>
            </DolyaUstKapGRNDataGRN>
            <DolyaUstKapGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataDataZapisi>
            <DolyaUstKapGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </DolyaUstKapGRNDataIsprGRN>
            <DolyaUstKapGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </DolyaUstKapGRNDataIsprDataZapisi>
            <CHislit>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ДоляРубля']/@Числит"/>
            </CHislit>
            <Znamenat>
              <xsl:value-of select="*[local-name()='ДоляУстКап']/*[local-name()='ДоляРубля']/@Знаменат"/>
            </Znamenat>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвОбъемПрав']">
              <xsl:variable name="SvObyemPrav" select="*[local-name()= 'СвОбъемПрав']"/>
              <SvObyemPrav>
                <GRNDataGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvObyemPrav/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <ObyemPrav>
                  <xsl:value-of select="$SvObyemPrav/@ОбъемПрав"/>
                </ObyemPrav>
              </SvObyemPrav>
            </xsl:if>
            <SvUpravZal>
              <xsl:for-each select="*[local-name()= 'СвУправЗал']">
                <smevSvUpravZal>
                  <GRNDataPervGRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
                  </GRNDataPervGRN>
                  <GRNDataPervDataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
                  </GRNDataPervDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataGRN>
                  <SvDogUpravZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataDataZapisi>
                  <SvDogUpravZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprGRN>
                  <SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
                  <SvDogUpravZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvDogUpravZalSvNotariusINNFL>
                  <SvDogUpravZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvDogUpravZalSvNotariusImya>
                  <SvDogUpravZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvDogUpravZalSvNotariusOtchestvo>
                  <SvDogUpravZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvDogUpravZalSvNotariusFamiliya>
                  <SvDogUpravZalData>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Дата"/>
                  </SvDogUpravZalData>
                  <SvDogUpravZalNomer>
                    <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Номер"/>
                  </SvDogUpravZalNomer>
                  <SvNotUdDogZalSvNotariusGRNDataGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataGRN>
                  <SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataDataZapisi>
                  <SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprGRN>
                  <SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
                  <SvNotUdDogZalSvNotariusINNFL>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
                  </SvNotUdDogZalSvNotariusINNFL>
                  <SvNotUdDogZalSvNotariusImya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
                  </SvNotUdDogZalSvNotariusImya>
                  <SvNotUdDogZalSvNotariusOtchestvo>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
                  </SvNotUdDogZalSvNotariusOtchestvo>
                  <SvNotUdDogZalSvNotariusFamiliya>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
                  </SvNotUdDogZalSvNotariusFamiliya>
                  <SvNotUdDogZalData>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Дата"/>
                  </SvNotUdDogZalData>
                  <SvNotUdDogZalNomer>
                    <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Номер"/>
                  </SvNotUdDogZalNomer>
                  <xsl:if test="*[local-name()= 'СвУпрЗалФЛ']">
                    <xsl:variable name="SvUprZalFL" select="*[local-name()= 'СвУпрЗалФЛ']"/>
                    <SvUprZalFL>
                      <SvFLGRNDataGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </SvFLGRNDataGRN>
                      <SvFLGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </SvFLGRNDataDataZapisi>
                      <SvFLGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </SvFLGRNDataIsprGRN>
                      <SvFLGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </SvFLGRNDataIsprDataZapisi>
                      <SvFLINNFL>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@ИННФЛ"/>
                      </SvFLINNFL>
                      <SvFLImya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Имя"/>
                      </SvFLImya>
                      <SvFLOtchestvo>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Отчество"/>
                      </SvFLOtchestvo>
                      <SvFLFamiliya>
                        <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Фамилия"/>
                      </SvFLFamiliya>
                      <OGRNIP>
                        <xsl:value-of select="$SvUprZalFL/@ОГРНИП"/>
                      </OGRNIP>
                    </SvUprZalFL>
                  </xsl:if>
                  <xsl:if test="*[local-name()= 'СвУпрЗалЮЛ']">
                    <xsl:variable name="SvUprZalYUL" select="*[local-name()= 'СвУпрЗалЮЛ']"/>
                    <SvUprZalYUL>
                      <NaimINNYULGRNDataGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                      </NaimINNYULGRNDataGRN>
                      <NaimINNYULGRNDataDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataDataZapisi>
                      <NaimINNYULGRNDataIsprGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                      </NaimINNYULGRNDataIsprGRN>
                      <NaimINNYULGRNDataIsprDataZapisi>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                      </NaimINNYULGRNDataIsprDataZapisi>
                      <NaimINNYULINN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                      </NaimINNYULINN>
                      <NaimINNYULNaimYULPoln>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                      </NaimINNYULNaimYULPoln>
                      <NaimINNYULOGRN>
                        <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                      </NaimINNYULOGRN>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']">
                        <xsl:variable name="SvNaimYULPolnIn" select="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                        <SvNaimYULPolnIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <NaimPoln>
                            <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                          </NaimPoln>
                        </SvNaimYULPolnIn>
                      </xsl:if>
                      <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвРегИн']">
                        <xsl:variable name="SvRegIn" select="$SvUprZalYUL/*[local-name()= 'СвРегИн']"/>
                        <SvRegIn>
                          <GRNDataGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                          </GRNDataGRN>
                          <GRNDataDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                          </GRNDataDataZapisi>
                          <GRNDataIsprGRN>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                          </GRNDataIsprGRN>
                          <GRNDataIsprDataZapisi>
                            <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                          </GRNDataIsprDataZapisi>
                          <AdrStr>
                            <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                          </AdrStr>
                          <DataReg>
                            <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                          </DataReg>
                          <KodNPStrReg>
                            <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                          </KodNPStrReg>
                          <NaimRegOrg>
                            <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                          </NaimRegOrg>
                          <NaimStran>
                            <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                          </NaimStran>
                          <OKSM>
                            <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                          </OKSM>
                          <RegNomer>
                            <xsl:value-of select="$SvRegIn/@РегНомер"/>
                          </RegNomer>
                        </SvRegIn>
                      </xsl:if>
                    </SvUprZalYUL>
                  </xsl:if>
                </smevSvUpravZal>
              </xsl:for-each>
            </SvUpravZal>
          </smevFounderPIF>
        </xsl:for-each>
      </UchrPIF>

      <xsl:variable name="SvDerzhReestrAO" select="$SvUL/*[local-name()='СвДержРеестрАО']"/>
      <xsl:if test="$SvDerzhReestrAO/*[local-name()= 'ОгрДосСв']">
        <xsl:variable name="OgrDosSv" select="$SvDerzhReestrAO/*[local-name()= 'ОгрДосСв']"/>
        <OgrDosSv>
          <GRNDataGRN>
            <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
          </GRNDataGRN>
          <GRNDataDataZapisi>
            <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
          </GRNDataDataZapisi>
          <GRNDataIsprGRN>
            <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
          </GRNDataIsprGRN>
          <GRNDataIsprDataZapisi>
            <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
          </GRNDataIsprDataZapisi>
          <OgrDosSv>
            <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
          </OgrDosSv>
        </OgrDosSv>
      </xsl:if>
      <xsl:variable name="SvDolyaOOO" select="$SvUL/*[local-name()='СвДоляООО']"/>
      <NominStoim>
        <xsl:value-of select="$SvDolyaOOO/@НоминСтоим"/>
      </NominStoim>
      <Procent>
        <xsl:value-of select="$SvDolyaOOO//*[local-name()='Процент']"/>
      </Procent>
      <DrobDesyat>
        <xsl:value-of select="$SvDolyaOOO//*[local-name()='ДробДесят']"/>
      </DrobDesyat>
      <DrobProst>
        <xsl:value-of select="$SvDolyaOOO//*[local-name()='ДробПрост']/@Числит"/>/<xsl:value-of select="$SvDolyaOOO//*[local-name()='ДробПрост']/@Знаменат"/>
      </DrobProst>
      <CHislit>
        <xsl:value-of select="$SvDolyaOOO/*[local-name()='ДоляРубля']/@Числит"/>
      </CHislit>
      <Znamenat>
        <xsl:value-of select="$SvDolyaOOO/*[local-name()='ДоляРубля']/@Знаменат"/>
      </Znamenat>
      <SvDolyaOOOGRNDataGRN>
        <xsl:value-of select="$SvDolyaOOO/*[local-name()='ГРНДата']/@ГРН"/>
      </SvDolyaOOOGRNDataGRN>
      <SvDolyaOOOGRNDataDataZapisi>
        <xsl:value-of select="$SvDolyaOOO/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvDolyaOOOGRNDataDataZapisi>
      <SvDolyaOOOGRNDataIsprGRN>
        <xsl:value-of select="$SvDolyaOOO/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvDolyaOOOGRNDataIsprGRN>
      <SvDolyaOOOGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvDolyaOOO/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvDolyaOOOGRNDataIsprDataZapisi>
      <SvUpravZal>
        <xsl:for-each select="$SvDolyaOOO/*[local-name()= 'СвУправЗал']">
          <smevSvUpravZal>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <SvDogUpravZalSvNotariusGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvDogUpravZalSvNotariusGRNDataGRN>
            <SvDogUpravZalSvNotariusGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvDogUpravZalSvNotariusGRNDataDataZapisi>
            <SvDogUpravZalSvNotariusGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvDogUpravZalSvNotariusGRNDataIsprGRN>
            <SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvDogUpravZalSvNotariusGRNDataIsprDataZapisi>
            <SvDogUpravZalSvNotariusINNFL>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
            </SvDogUpravZalSvNotariusINNFL>
            <SvDogUpravZalSvNotariusImya>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Имя"/>
            </SvDogUpravZalSvNotariusImya>
            <SvDogUpravZalSvNotariusOtchestvo>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Отчество"/>
            </SvDogUpravZalSvNotariusOtchestvo>
            <SvDogUpravZalSvNotariusFamiliya>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
            </SvDogUpravZalSvNotariusFamiliya>
            <SvDogUpravZalData>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Дата"/>
            </SvDogUpravZalData>
            <SvDogUpravZalNomer>
              <xsl:value-of select="*[local-name()='СвДогУправЗал']/@Номер"/>
            </SvDogUpravZalNomer>
            <SvNotUdDogZalSvNotariusGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvNotUdDogZalSvNotariusGRNDataGRN>
            <SvNotUdDogZalSvNotariusGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvNotUdDogZalSvNotariusGRNDataDataZapisi>
            <SvNotUdDogZalSvNotariusGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvNotUdDogZalSvNotariusGRNDataIsprGRN>
            <SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvNotUdDogZalSvNotariusGRNDataIsprDataZapisi>
            <SvNotUdDogZalSvNotariusINNFL>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
            </SvNotUdDogZalSvNotariusINNFL>
            <SvNotUdDogZalSvNotariusImya>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
            </SvNotUdDogZalSvNotariusImya>
            <SvNotUdDogZalSvNotariusOtchestvo>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
            </SvNotUdDogZalSvNotariusOtchestvo>
            <SvNotUdDogZalSvNotariusFamiliya>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
            </SvNotUdDogZalSvNotariusFamiliya>
            <SvNotUdDogZalData>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Дата"/>
            </SvNotUdDogZalData>
            <SvNotUdDogZalNomer>
              <xsl:value-of select="*[local-name()='СвНотУдДогЗал']/@Номер"/>
            </SvNotUdDogZalNomer>
            <xsl:if test="*[local-name()= 'СвУпрЗалФЛ']">
              <xsl:variable name="SvUprZalFL" select="*[local-name()= 'СвУпрЗалФЛ']"/>
              <SvUprZalFL>
                <SvFLGRNDataGRN>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                </SvFLGRNDataGRN>
                <SvFLGRNDataDataZapisi>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </SvFLGRNDataDataZapisi>
                <SvFLGRNDataIsprGRN>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </SvFLGRNDataIsprGRN>
                <SvFLGRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </SvFLGRNDataIsprDataZapisi>
                <SvFLINNFL>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@ИННФЛ"/>
                </SvFLINNFL>
                <SvFLImya>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Имя"/>
                </SvFLImya>
                <SvFLOtchestvo>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Отчество"/>
                </SvFLOtchestvo>
                <SvFLFamiliya>
                  <xsl:value-of select="$SvUprZalFL/*[local-name()='СвФЛ']/@Фамилия"/>
                </SvFLFamiliya>
                <OGRNIP>
                  <xsl:value-of select="$SvUprZalFL/@ОГРНИП"/>
                </OGRNIP>
              </SvUprZalFL>
            </xsl:if>
            <xsl:if test="*[local-name()= 'СвУпрЗалЮЛ']">
              <xsl:variable name="SvUprZalYUL" select="*[local-name()= 'СвУпрЗалЮЛ']"/>
              <SvUprZalYUL>
                <NaimINNYULGRNDataGRN>
                  <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
                </NaimINNYULGRNDataGRN>
                <NaimINNYULGRNDataDataZapisi>
                  <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </NaimINNYULGRNDataDataZapisi>
                <NaimINNYULGRNDataIsprGRN>
                  <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </NaimINNYULGRNDataIsprGRN>
                <NaimINNYULGRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </NaimINNYULGRNDataIsprDataZapisi>
                <NaimINNYULINN>
                  <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ИНН"/>
                </NaimINNYULINN>
                <NaimINNYULNaimYULPoln>
                  <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
                </NaimINNYULNaimYULPoln>
                <NaimINNYULOGRN>
                  <xsl:value-of select="$SvUprZalYUL/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
                </NaimINNYULOGRN>
                <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']">
                  <xsl:variable name="SvNaimYULPolnIn" select="$SvUprZalYUL/*[local-name()= 'СвНаимЮЛПолнИн']"/>
                  <SvNaimYULPolnIn>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <NaimPoln>
                      <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                    </NaimPoln>
                  </SvNaimYULPolnIn>
                </xsl:if>
                <xsl:if test="$SvUprZalYUL/*[local-name()= 'СвРегИн']">
                  <xsl:variable name="SvRegIn" select="$SvUprZalYUL/*[local-name()= 'СвРегИн']"/>
                  <SvRegIn>
                    <GRNDataGRN>
                      <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ГРН"/>
                    </GRNDataGRN>
                    <GRNDataDataZapisi>
                      <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                    </GRNDataDataZapisi>
                    <GRNDataIsprGRN>
                      <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                    </GRNDataIsprGRN>
                    <GRNDataIsprDataZapisi>
                      <xsl:value-of select="$SvRegIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                    </GRNDataIsprDataZapisi>
                    <AdrStr>
                      <xsl:value-of select="$SvRegIn/@АдрСтр"/>
                    </AdrStr>
                    <DataReg>
                      <xsl:value-of select="$SvRegIn/@ДатаРег"/>
                    </DataReg>
                    <KodNPStrReg>
                      <xsl:value-of select="$SvRegIn/@КодНПСтрРег"/>
                    </KodNPStrReg>
                    <NaimRegOrg>
                      <xsl:value-of select="$SvRegIn/@НаимРегОрг"/>
                    </NaimRegOrg>
                    <NaimStran>
                      <xsl:value-of select="$SvRegIn/@НаимСтран"/>
                    </NaimStran>
                    <OKSM>
                      <xsl:value-of select="$SvRegIn/@ОКСМ"/>
                    </OKSM>
                    <RegNomer>
                      <xsl:value-of select="$SvRegIn/@РегНомер"/>
                    </RegNomer>
                  </SvRegIn>
                </xsl:if>
              </SvUprZalYUL>
            </xsl:if>
          </smevSvUpravZal>
        </xsl:for-each>
      </SvUpravZal>
      <SvObrem>
        <xsl:for-each select="$SvDolyaOOO/*[local-name()='СвОбрем']">
          <smevEncum>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <VidObremeneniya>
              <xsl:value-of select="@ВидОбрем"/>
            </VidObremeneniya>
            <SrokObremeneniya>
              <xsl:value-of select="@СрокОбременения"/>
            </SrokObremeneniya>
            <NaimSuda>
              <xsl:value-of select="*[local-name()='РешСуд']/@НаимСуда"/>
            </NaimSuda>
            <Nomer>
              <xsl:value-of select="*[local-name()='РешСуд']/@Номер"/>
            </Nomer>
            <Data>
              <xsl:value-of select="*[local-name()='РешСуд']/@Дата"/>
            </Data>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <SvZalogDerzhFLGRNDataPervGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </SvZalogDerzhFLGRNDataPervGRN>
            <SvZalogDerzhFLGRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </SvZalogDerzhFLGRNDataPervDataZapisi>
            <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']">
              <xsl:variable name="SvPolFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвПолФЛ']"/>
              <SvZalogDerzhFLSvPolFL>
                <GRNDataGRN>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvPolFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <Pol>
                  <xsl:value-of select="$SvPolFL/@Пол"/>
                </Pol>
              </SvZalogDerzhFLSvPolFL>
            </xsl:if>
            <xsl:if test="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']">
              <xsl:variable name="SvGrazhdFL" select="*[local-name()='СвЗалогДержФЛ']/*[local-name()= 'СвГраждФЛ']"/>
              <SvZalogDerzhFLSvGrazhdFL>
                <GRNDataGRN>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvGrazhdFL/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <KodGrazhd>
                  <xsl:value-of select="$SvGrazhdFL/@КодГражд"/>
                </KodGrazhd>
                <NaimStran>
                  <xsl:value-of select="$SvGrazhdFL/@НаимСтран"/>
                </NaimStran>
                <OKSM>
                  <xsl:value-of select="$SvGrazhdFL/@ОКСМ"/>
                </OKSM>
              </SvZalogDerzhFLSvGrazhdFL>
            </xsl:if>
            <Familiya>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Фамилия"/>
            </Familiya>
            <Imya>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Имя"/>
            </Imya>
            <Otchestvo>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@Отчество"/>
            </Otchestvo>
            <INNFL>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/@ИННФЛ"/>
            </INNFL>
            <SvZalogDerzhFLSvFLGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvZalogDerzhFLSvFLGRNDataGRN>
            <SvZalogDerzhFLSvFLGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvZalogDerzhFLSvFLGRNDataDataZapisi>
            <SvZalogDerzhFLSvFLGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvZalogDerzhFLSvFLGRNDataIsprGRN>
            <SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvZalogDerzhFLSvFLGRNDataIsprDataZapisi>
            <SvZalogDerzhFLSvNotUdDogZalNomer>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
            </SvZalogDerzhFLSvNotUdDogZalNomer>
            <SvZalogDerzhFLSvNotUdDogZalData>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
            </SvZalogDerzhFLSvNotUdDogZalData>
            <SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLFamiliya>
            <SvZalogDerzhFLSvNotUdDogZalSvFLImya>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLImya>
            <SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLOtchestvo>
            <SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLINNFL>
            <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataGRN>
            <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataDataZapisi>
            <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprGRN>
            <SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержФЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvZalogDerzhFLSvNotUdDogZalSvFLGRNDataIsprDataZapisi>

            <SvZalogDerzhYULGRNDataPervGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </SvZalogDerzhYULGRNDataPervGRN>
            <SvZalogDerzhYULGRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </SvZalogDerzhYULGRNDataPervDataZapisi>
            <OGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/@НаимЮЛПолн"/>
            </NaimYULPoln>
            <SvZalogDerzhYULGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvZalogDerzhYULGRNDataGRN>
            <SvZalogDerzhYULGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvZalogDerzhYULGRNDataDataZapisi>
            <SvZalogDerzhYULGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvZalogDerzhYULGRNDataIsprGRN>
            <SvZalogDerzhYULGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='НаимИННЮЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvZalogDerzhYULGRNDataIsprDataZapisi>
            <OKSM>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ОКСМ"/>
            </OKSM>
            <NaimStran>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимСтран"/>
            </NaimStran>
            <DataReg>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@ДатаРег"/>
            </DataReg>
            <RegNomer>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@РегНомер"/>
            </RegNomer>
            <NaimRegOrg>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@НаимРегОрг"/>
            </NaimRegOrg>
            <AdrStr>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@АдрСтр"/>
            </AdrStr>
            <SvZalogDerzhYULSvRegInGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvZalogDerzhYULSvRegInGRNDataGRN>
            <SvZalogDerzhYULSvRegInGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvZalogDerzhYULSvRegInGRNDataDataZapisi>
            <SvZalogDerzhYULSvRegInGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvZalogDerzhYULSvRegInGRNDataIsprGRN>
            <SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvZalogDerzhYULSvRegInGRNDataIsprDataZapisi>
            <SvZalogDerzhYULSvRegInKodNPStrReg>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвРегИн']/@КодНПСтрРег"/>
            </SvZalogDerzhYULSvRegInKodNPStrReg>
            <SvZalogDerzhYULSvNotUdDogZalNomer>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Номер"/>
            </SvZalogDerzhYULSvNotUdDogZalNomer>
            <SvZalogDerzhYULSvNotUdDogZalData>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/@Дата"/>
            </SvZalogDerzhYULSvNotUdDogZalData>
            <SvNotariusFamiliya>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Фамилия"/>
            </SvNotariusFamiliya>
            <SvNotariusImya>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Имя"/>
            </SvNotariusImya>
            <SvNotariusOtchestvo>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@Отчество"/>
            </SvNotariusOtchestvo>
            <SvNotariusINNFL>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/@ИННФЛ"/>
            </SvNotariusINNFL>
            <SvNotariusGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvNotariusGRNDataGRN>
            <SvNotariusGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvNotariusGRNDataDataZapisi>
            <SvNotariusGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvNotariusGRNDataIsprGRN>
            <SvNotariusGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()='СвНотУдДогЗал']/*[local-name()='СвНотариус']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvNotariusGRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']">
              <xsl:variable name="SvNaimYULPolnIn" select="*[local-name()='СвЗалогДержЮЛ']/*[local-name()= 'СвНаимЮЛПолнИн']"/>
              <SvZalogDerzhYULSvNaimYULPolnIn>
                <GRNDataGRN>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$SvNaimYULPolnIn/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <NaimPoln>
                  <xsl:value-of select="$SvNaimYULPolnIn/@НаимПолн"/>
                </NaimPoln>
              </SvZalogDerzhYULSvNaimYULPolnIn>
            </xsl:if>
          </smevEncum>
        </xsl:for-each>
      </SvObrem>
      <SvDerzhReestrAOGRNDataGRN>
        <xsl:value-of select="$SvDerzhReestrAO/*[local-name()='ГРНДатаПерв']/@ГРН"/>
      </SvDerzhReestrAOGRNDataGRN>
      <SvDerzhReestrAOGRNDataDataZapisi>
        <xsl:value-of select="$SvDerzhReestrAO/*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
      </SvDerzhReestrAOGRNDataDataZapisi>
      <SvDerzhReestrAOOGRN>
        <xsl:value-of select="$SvDerzhReestrAO/*[local-name()='ДержРеестрАО']/@ОГРН"/>
      </SvDerzhReestrAOOGRN>
      <SvDerzhReestrAOINN>
        <xsl:value-of select="$SvDerzhReestrAO/*[local-name()='ДержРеестрАО']/@ИНН"/>
      </SvDerzhReestrAOINN>
      <SvDerzhReestrAONaimYULPoln>
        <xsl:value-of select="$SvDerzhReestrAO/*[local-name()='ДержРеестрАО']/@НаимЮЛПолн"/>
      </SvDerzhReestrAONaimYULPoln>
      <xsl:variable name="SvOKVED" select="$SvUL/*[local-name()='СвОКВЭД']"/>
      <KodOKVED _json="as_{$SvOKVED/*[local-name()='СвОКВЭДОсн']/@КодОКВЭД}">
        <xsl:value-of select="$SvOKVED/*[local-name()='СвОКВЭДОсн']/@КодОКВЭД"/>
      </KodOKVED>
      <NaimOKVED>
        <xsl:value-of select="$SvOKVED/*[local-name()='СвОКВЭДОсн']/@НаимОКВЭД"/>
      </NaimOKVED>
      <PrVersOKVED>
        <xsl:value-of select="$SvOKVED/*[local-name()='СвОКВЭДОсн']/@ПрВерсОКВЭД"/>
      </PrVersOKVED>
      <SvOKVEDGRNDataGRN>
        <xsl:value-of select="$SvOKVED/*[local-name()='СвОКВЭДОсн']/*[local-name()='ГРНДата']/@ГРН"/>
      </SvOKVEDGRNDataGRN>
      <SvOKVEDGRNDataDataZapisi>
        <xsl:value-of select="$SvOKVED/*[local-name()='СвОКВЭДОсн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvOKVEDGRNDataDataZapisi>
      <SvOKVEDGRNDataIsprGRN>
        <xsl:value-of select="$SvOKVED/*[local-name()='СвОКВЭДОсн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvOKVEDGRNDataIsprGRN>
      <SvOKVEDGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvOKVED/*[local-name()='СвОКВЭДОсн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvOKVEDGRNDataIsprDataZapisi>
      <SvOKVEDOsn>
        <xsl:for-each select="$SvOKVED/*[local-name()='СвОКВЭДОсн']">
          <smevKindActive>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <KodOKVED _json="as_{@КодОКВЭД}">
              <xsl:value-of select="@КодОКВЭД"/>
            </KodOKVED>
            <NaimOKVED>
              <xsl:value-of select="@НаимОКВЭД"/>
            </NaimOKVED>
            <PrVersOKVED>
              <xsl:value-of select="@ПрВерсОКВЭД"/>
            </PrVersOKVED>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <condition>osn</condition>
          </smevKindActive>
        </xsl:for-each>
      </SvOKVEDOsn>
      <SvOKVEDDop>
        <xsl:for-each select="$SvOKVED/*[local-name()='СвОКВЭДДоп']">
          <smevKindActive>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <KodOKVED _json="as_{@КодОКВЭД}">
              <xsl:value-of select="@КодОКВЭД"/>
            </KodOKVED>
            <NaimOKVED>
              <xsl:value-of select="@НаимОКВЭД"/>
            </NaimOKVED>
            <PrVersOKVED>
              <xsl:value-of select="@ПрВерсОКВЭД"/>
            </PrVersOKVED>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <condition>dop</condition>
          </smevKindActive>
        </xsl:for-each>
      </SvOKVEDDop>
      <SvLicenziya>
        <xsl:for-each select="$SvUL/*[local-name()='СвЛицензия']">
          <smevLicenseUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
            <NomLic>
              <xsl:value-of select="@НомЛиц"/>
            </NomLic>
            <DataLic>
              <xsl:value-of select="@ДатаЛиц"/>
            </DataLic>
            <DataOkonchLic>
              <xsl:value-of select="@ДатаНачЛиц"/>
            </DataOkonchLic>
            <NaimLicVidDeyat>
              <xsl:for-each select="*[local-name()='НаимЛицВидДеят']">
                <smevKindLicense>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <NaimLicVidDeyat>
                    <xsl:value-of select="."/>
                  </NaimLicVidDeyat>
                </smevKindLicense>
              </xsl:for-each>
            </NaimLicVidDeyat>
            <MestoDejstLic>
              <xsl:for-each select="*[local-name()='МестоДейстЛиц']">
                <smevAddressUL>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <MestoDejstLic>
                    <xsl:value-of select="."/>
                  </MestoDejstLic>
                </smevAddressUL>
              </xsl:for-each>
            </MestoDejstLic>
            <LicOrgVydLic>
              <xsl:value-of select="*[local-name()='ЛицОргВыдЛиц']"/>
            </LicOrgVydLic>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <DataPriostLic>
              <xsl:value-of select="*[local-name()='СвПриостЛиц']/@ДатаПриостЛиц"/>
            </DataPriostLic>
            <LicOrgPriostLic>
              <xsl:value-of select="*[local-name()='СвПриостЛиц']/@ЛицОргПриостЛиц"/>
            </LicOrgPriostLic>
            <SvPriostLicGRN>
              <xsl:value-of select="*[local-name()='СвПриостЛиц']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvPriostLicGRN>
            <SvPriostLicDataZapisi>
              <xsl:value-of select="*[local-name()='СвПриостЛиц']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvPriostLicDataZapisi>
            <SvPriostLicGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвПриостЛиц']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvPriostLicGRNDataIsprGRN>
            <SvPriostLicGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвПриостЛиц']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvPriostLicGRNDataIsprDataZapisi>
          </smevLicenseUL>
        </xsl:for-each>
      </SvLicenziya>
      <SvFilial>
        <xsl:for-each select="$SvUL/*[local-name()='СвПодразд']/*[local-name()='СвФилиал']">
          <smevFilialUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <NaimPoln>
              <xsl:value-of select="*[local-name()='СвНаим']/@НаимПолн"/>
            </NaimPoln>
            <SvNaimGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvNaimGRNDataGRN>
            <SvNaimGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvNaimGRNDataDataZapisi>
            <SvNaimGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvNaimGRNDataIsprGRN>
            <SvNaimGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvNaimGRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()= 'АдрМНФИАС']">
              <xsl:variable name="AdrMNFIAS" select="*[local-name()= 'АдрМНФИАС']"/>
              <AdrMNFIAS>
                <GRNDataGRN>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <GorodSelPoselenVidKod>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГородСелПоселен']/@ВидКод"/>
                </GorodSelPoselenVidKod>
                <GorodSelPoselenNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГородСелПоселен']/@Наим"/>
                </GorodSelPoselenNaim>
                <ZdaniyeNomer>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='Здание']/@Номер"/>
                </ZdaniyeNomer>
                <ZdaniyeTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='Здание']/@Тип"/>
                </ZdaniyeTip>
                <MunitsipRayonVidKod>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='МуниципРайон']/@ВидКод"/>
                </MunitsipRayonVidKod>
                <MunitsipRayonNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='МуниципРайон']/@Наим"/>
                </MunitsipRayonNaim>
                <NaimRegion>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='НаимРегион']"/>
                </NaimRegion>
                <NaselenPunktVid>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='НаселенПункт']/@Вид"/>
                </NaselenPunktVid>
                <NaselenPunktNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='НаселенПункт']/@Наим"/>
                </NaselenPunktNaim>
                <PomeshchZdaniyaNomer>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещЗдания']/@Номер"/>
                </PomeshchZdaniyaNomer>
                <PomeshchZdaniyaTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещЗдания']/@Тип"/>
                </PomeshchZdaniyaTip>
                <PomeshchKvartiryNomer>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещКвартиры']/@Номер"/>
                </PomeshchKvartiryNomer>
                <PomeshchKvartiryTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещКвартиры']/@Тип"/>
                </PomeshchKvartiryTip>
                <Region>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='Регион']"/>
                </Region>
                <ElPlanStrukturNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлПланСтруктур']/@Наим"/>
                </ElPlanStrukturNaim>
                <ElPlanStrukturTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлПланСтруктур']/@Тип"/>
                </ElPlanStrukturTip>
                <ElUlDorSetiNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлУлДорСети']/@Наим"/>
                </ElUlDorSetiNaim>
                <ElUlDorSetiTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлУлДорСети']/@Тип"/>
                </ElUlDorSetiTip>
                <IdNom>
                  <xsl:value-of select="$AdrMNFIAS/@ИдНом"/>
                </IdNom>
                <Indeks>
                  <xsl:value-of select="$AdrMNFIAS/@Индекс"/>
                </Indeks>
              </AdrMNFIAS>
            </xsl:if>
            <Indeks>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Индекс"/>
            </Indeks>
            <KodRegion _json="as_{*[local-name()='АдрМНРФ']/@КодРегион}">
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@КодРегион"/>
            </KodRegion>
            <KodAdrKladr _json="as_{*[local-name()='АдрМНРФ']/@КодАдрКладр}">
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@КодАдрКладр"/>
            </KodAdrKladr>
            <Dom>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Дом"/>
            </Dom>
            <Korpus>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Корпус"/>
            </Korpus>
            <Kvart>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Кварт"/>
            </Kvart>
            <Region>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Регион']/@НаимРегион"/>
            </Region>
            <Rajon>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Район']/@НаимРайон"/>
            </Rajon>
            <Gorod>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Город']/@НаимГород"/>
            </Gorod>
            <NaselPunkt>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='НаселПункт']/@НаимНаселПункт"/>
            </NaselPunkt>
            <Ulica>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Улица']/@НаимУлица"/>
            </Ulica>
            <AdrMNRFGRNDataGRN>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДата']/@ГРН"/>
            </AdrMNRFGRNDataGRN>
            <AdrMNRFGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </AdrMNRFGRNDataDataZapisi>
            <AdrMNRFGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </AdrMNRFGRNDataIsprGRN>
            <AdrMNRFGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </AdrMNRFGRNDataIsprDataZapisi>
            <OKSM>
              <xsl:value-of select="*[local-name()='АдрМНИн']/@ОКСМ"/>
            </OKSM>
            <NaimStran>
              <xsl:value-of select="*[local-name()='АдрМНИн']/@НаимСтран"/>
            </NaimStran>
            <AdrIn>
              <xsl:value-of select="*[local-name()='АдрМНИн']/@АдрИн"/>
            </AdrIn>
            <AdrMNInGRNDataGRN>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДата']/@ГРН"/>
            </AdrMNInGRNDataGRN>
            <AdrMNInGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </AdrMNInGRNDataDataZapisi>
            <AdrMNInGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </AdrMNInGRNDataIsprGRN>
            <AdrMNInGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </AdrMNInGRNDataIsprDataZapisi>
            <KPP>
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/@КПП"/>
            </KPP>
            <DataPostUch>
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/@ДатаПостУч"/>
            </DataPostUch>
            <KodNO _json="as_{*[local-name()='СвУчетНОФилиал']/*[local-name()='СвНО']/@КодНО}">
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/*[local-name()='СвНО']/@КодНО"/>
            </KodNO>
            <NaimNO>
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/*[local-name()='СвНО']/@НаимНО"/>
            </NaimNO>
            <SvUchetNOFilialGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvUchetNOFilialGRNDataGRN>
            <SvUchetNOFilialGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvUchetNOFilialGRNDataDataZapisi>
            <SvUchetNOFilialGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvUchetNOFilialGRNDataIsprGRN>
            <SvUchetNOFilialGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвУчетНОФилиал']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvUchetNOFilialGRNDataIsprDataZapisi>
          </smevFilialUL>
        </xsl:for-each>
      </SvFilial>
      <SvPredstav>
        <xsl:for-each select="$SvUL/*[local-name()='СвПодразд']/*[local-name()='СвПредстав']">
          <smevRepresUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <GRNDataPervGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ГРН"/>
            </GRNDataPervGRN>
            <GRNDataPervDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаПерв']/@ДатаЗаписи"/>
            </GRNDataPervDataZapisi>
            <NaimPoln>
              <xsl:value-of select="*[local-name()='СвНаим']/@НаимПолн"/>
            </NaimPoln>
            <SvNaimGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvNaimGRNDataGRN>
            <SvNaimGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvNaimGRNDataDataZapisi>
            <SvNaimGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvNaimGRNDataIsprGRN>
            <SvNaimGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвНаим']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvNaimGRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()= 'АдрМНФИАС']">
              <xsl:variable name="AdrMNFIAS" select="*[local-name()= 'АдрМНФИАС']"/>
              <AdrMNFIAS>
                <GRNDataGRN>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <GorodSelPoselenVidKod>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГородСелПоселен']/@ВидКод"/>
                </GorodSelPoselenVidKod>
                <GorodSelPoselenNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ГородСелПоселен']/@Наим"/>
                </GorodSelPoselenNaim>
                <ZdaniyeNomer>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='Здание']/@Номер"/>
                </ZdaniyeNomer>
                <ZdaniyeTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='Здание']/@Тип"/>
                </ZdaniyeTip>
                <MunitsipRayonVidKod>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='МуниципРайон']/@ВидКод"/>
                </MunitsipRayonVidKod>
                <MunitsipRayonNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='МуниципРайон']/@Наим"/>
                </MunitsipRayonNaim>
                <NaimRegion>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='НаимРегион']"/>
                </NaimRegion>
                <NaselenPunktVid>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='НаселенПункт']/@Вид"/>
                </NaselenPunktVid>
                <NaselenPunktNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='НаселенПункт']/@Наим"/>
                </NaselenPunktNaim>
                <PomeshchZdaniyaNomer>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещЗдания']/@Номер"/>
                </PomeshchZdaniyaNomer>
                <PomeshchZdaniyaTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещЗдания']/@Тип"/>
                </PomeshchZdaniyaTip>
                <PomeshchKvartiryNomer>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещКвартиры']/@Номер"/>
                </PomeshchKvartiryNomer>
                <PomeshchKvartiryTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ПомещКвартиры']/@Тип"/>
                </PomeshchKvartiryTip>
                <Region>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='Регион']"/>
                </Region>
                <ElPlanStrukturNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлПланСтруктур']/@Наим"/>
                </ElPlanStrukturNaim>
                <ElPlanStrukturTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлПланСтруктур']/@Тип"/>
                </ElPlanStrukturTip>
                <ElUlDorSetiNaim>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлУлДорСети']/@Наим"/>
                </ElUlDorSetiNaim>
                <ElUlDorSetiTip>
                  <xsl:value-of select="$AdrMNFIAS/*[local-name()='ЭлУлДорСети']/@Тип"/>
                </ElUlDorSetiTip>
                <IdNom>
                  <xsl:value-of select="$AdrMNFIAS/@ИдНом"/>
                </IdNom>
                <Indeks>
                  <xsl:value-of select="$AdrMNFIAS/@Индекс"/>
                </Indeks>
              </AdrMNFIAS>
            </xsl:if>
            <Indeks>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Индекс"/>
            </Indeks>
            <KodRegion _json="as_{*[local-name()='АдрМНРФ']/@КодРегион}">
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@КодРегион"/>
            </KodRegion>
            <KodAdrKladr _json="as_{*[local-name()='АдрМНРФ']/@КодАдрКладр}">
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@КодАдрКладр"/>
            </KodAdrKladr>
            <Dom>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Дом"/>
            </Dom>
            <Korpus>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Корпус"/>
            </Korpus>
            <Kvart>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/@Кварт"/>
            </Kvart>
            <Region>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Регион']/@НаимРегион"/>
            </Region>
            <Rajon>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Район']/@НаимРайон"/>
            </Rajon>
            <Gorod>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Город']/@НаимГород"/>
            </Gorod>
            <NaselPunkt>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='НаселПункт']/@НаимНаселПункт"/>
            </NaselPunkt>
            <Ulica>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='Улица']/@НаимУлица"/>
            </Ulica>
            <AdrMNRFGRNDataGRN>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДата']/@ГРН"/>
            </AdrMNRFGRNDataGRN>
            <AdrMNRFGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </AdrMNRFGRNDataDataZapisi>
            <AdrMNRFGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </AdrMNRFGRNDataIsprGRN>
            <AdrMNRFGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНРФ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </AdrMNRFGRNDataIsprDataZapisi>
            <OKSM>
              <xsl:value-of select="*[local-name()='АдрМНИн']/@ОКСМ"/>
            </OKSM>
            <NaimStran>
              <xsl:value-of select="*[local-name()='АдрМНИн']/@НаимСтран"/>
            </NaimStran>
            <AdrIn>
              <xsl:value-of select="*[local-name()='АдрМНИн']/@АдрИн"/>
            </AdrIn>
            <AdrMNInGRNDataGRN>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДата']/@ГРН"/>
            </AdrMNInGRNDataGRN>
            <AdrMNInGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </AdrMNInGRNDataDataZapisi>
            <AdrMNInGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </AdrMNInGRNDataIsprGRN>
            <AdrMNInGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='АдрМНИн']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </AdrMNInGRNDataIsprDataZapisi>
            <KPP>
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/@КПП"/>
            </KPP>
            <DataPostUch>
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/@ДатаПостУч"/>
            </DataPostUch>
            <KodNO _json="as_{*[local-name()='СвУчетНОПредстав']/*[local-name()='СвНО']/@КодНО}">
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/*[local-name()='СвНО']/@КодНО"/>
            </KodNO>
            <NaimNO>
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/*[local-name()='СвНО']/@НаимНО"/>
            </NaimNO>
            <SvUchetNOPredstavGRNDataGRN>
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/*[local-name()='ГРНДата']/@ГРН"/>
            </SvUchetNOPredstavGRNDataGRN>
            <SvUchetNOPredstavGRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </SvUchetNOPredstavGRNDataDataZapisi>
            <SvUchetNOPredstavGRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </SvUchetNOPredstavGRNDataIsprGRN>
            <SvUchetNOPredstavGRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвУчетНОПредстав']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </SvUchetNOPredstavGRNDataIsprDataZapisi>
          </smevRepresUL>
        </xsl:for-each>
      </SvPredstav>
      <SvReorg>
        <xsl:for-each select="$SvUL/*[local-name()='СвРеорг']">
          <smevReorgUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <KodStatusYUL _json="as_{*[local-name()='СвСтатус']/@КодСтатусЮЛ}">
              <xsl:value-of select="*[local-name()='СвСтатус']/@КодСтатусЮЛ"/>
            </KodStatusYUL>
            <NaimStatusYUL>
              <xsl:value-of select="*[local-name()='СвСтатус']/@НаимСтатусЮЛ"/>
            </NaimStatusYUL>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <SvReorgYUL>
              <xsl:for-each select="*[local-name()='СвРеоргЮЛ']">
                <smevULInReorg>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <OGRN>
                    <xsl:value-of select="@ОГРН"/>
                  </OGRN>
                  <INN>
                    <xsl:value-of select="@ИНН"/>
                  </INN>
                  <NaimYULPoln>
                    <xsl:value-of select="@НаимЮЛПолн"/>
                  </NaimYULPoln>
                  <SostYULposle>
                    <xsl:value-of select="@СостЮЛпосле"/>
                  </SostYULposle>
                  <GRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
                  </GRN>
                  <DataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                  </DataZapisi>
                </smevULInReorg>
              </xsl:for-each>
            </SvReorgYUL>
          </smevReorgUL>
        </xsl:for-each>
      </SvReorg>
      <SvPredsh>
        <xsl:for-each select="$SvUL/*[local-name()='СвПредш']">
          <smevPredecUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <OGRN>
              <xsl:value-of select="@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="@НаимЮЛПолн"/>
            </NaimYULPoln>
            <SvPredshOGRN>
              <xsl:value-of select="*[local-name()='СвЮЛсложнРеорг']/@ОГРН"/>
            </SvPredshOGRN>
            <SvPredshINN>
              <xsl:value-of select="*[local-name()='СвЮЛсложнРеорг']/@ИНН"/>
            </SvPredshINN>
            <SvPredshNaimYULPoln>
              <xsl:value-of select="*[local-name()='СвЮЛсложнРеорг']/@НаимЮЛПолн"/>
            </SvPredshNaimYULPoln>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
          </smevPredecUL>
        </xsl:for-each>
      </SvPredsh>
      <SvKFHPredsh>
        <xsl:for-each select="$SvUL/*[local-name()='СвКФХПредш']">
          <smevFarmerUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <OGRNIP>
              <xsl:value-of select="@ОГРНИП"/>
            </OGRNIP>
            <Familiya>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Фамилия"/>
            </Familiya>
            <Imya>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Имя"/>
            </Imya>
            <Otchestvo>
              <xsl:value-of select="*[local-name()='СвФЛ']/@Отчество"/>
            </Otchestvo>
            <INNFL>
              <xsl:value-of select="*[local-name()='СвФЛ']/@ИННФЛ"/>
            </INNFL>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
          </smevFarmerUL>
        </xsl:for-each>
      </SvKFHPredsh>
      <SvPreem>
        <xsl:for-each select="$SvUL/*[local-name()='СвПреем']">
          <smevLawUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <OGRN>
              <xsl:value-of select="@ОГРН"/>
            </OGRN>
            <INN>
              <xsl:value-of select="@ИНН"/>
            </INN>
            <NaimYULPoln>
              <xsl:value-of select="@НаимЮЛПолн"/>
            </NaimYULPoln>
            <SvYULslozhnReorgOGRN>
              <xsl:value-of select="*[local-name()='СвЮЛсложнРеорг']/@ОГРН"/>
            </SvYULslozhnReorgOGRN>
            <SvYULslozhnReorgINN>
              <xsl:value-of select="*[local-name()='СвЮЛсложнРеорг']/@ИНН"/>
            </SvYULslozhnReorgINN>
            <SvYULslozhnReorgNaimYULPoln>
              <xsl:value-of select="*[local-name()='СвЮЛсложнРеорг']/@НаимЮЛПолн"/>
            </SvYULslozhnReorgNaimYULPoln>
            <GRNDataGRN>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ГРН"/>
            </GRNDataGRN>
            <GRNDataDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДата']/@ДатаЗаписи"/>
            </GRNDataDataZapisi>
            <GRNDataIsprGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ГРН"/>
            </GRNDataIsprGRN>
            <GRNDataIsprDataZapisi>
              <xsl:value-of select="*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
            </GRNDataIsprDataZapisi>
            <xsl:if test="*[local-name()= 'ОгрДосСв']">
              <xsl:variable name="OgrDosSv" select="*[local-name()= 'ОгрДосСв']"/>
              <OgrDosSv>
                <GRNDataGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ГРН"/>
                </GRNDataGRN>
                <GRNDataDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
                </GRNDataDataZapisi>
                <GRNDataIsprGRN>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ГРН"/>
                </GRNDataIsprGRN>
                <GRNDataIsprDataZapisi>
                  <xsl:value-of select="$OgrDosSv/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
                </GRNDataIsprDataZapisi>
                <OgrDosSv>
                  <xsl:value-of select="$OgrDosSv/@ОгрДосСв"/>
                </OgrDosSv>
              </OgrDosSv>
            </xsl:if>
          </smevLawUL>
        </xsl:for-each>
      </SvPreem>
      <SvKFHPreemOGRNIP>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/@ОГРНИП"/>
      </SvKFHPreemOGRNIP>
      <SvKFHPreemFamiliya>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/@Фамилия"/>
      </SvKFHPreemFamiliya>
      <SvKFHPreemImya>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/@Имя"/>
      </SvKFHPreemImya>
      <SvKFHPreemOtchestvo>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/@Отчество"/>
      </SvKFHPreemOtchestvo>
      <SvKFHPreemINNFL>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/@ИННФЛ"/>
      </SvKFHPreemINNFL>
      <SvKFHPreemGRNDataGRN>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ГРН"/>
      </SvKFHPreemGRNDataGRN>
      <SvKFHPreemGRNDataDataZapisi>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/*[local-name()='ГРНДата']/@ДатаЗаписи"/>
      </SvKFHPreemGRNDataDataZapisi>
      <SvKFHPreemGRNDataIsprGRN>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ГРН"/>
      </SvKFHPreemGRNDataIsprGRN>
      <SvKFHPreemGRNDataIsprDataZapisi>
        <xsl:value-of select="$SvUL/*[local-name()='СвКФХПреем']/*[local-name()='СвФЛ']/*[local-name()='ГРНДатаИспр']/@ДатаЗаписи"/>
      </SvKFHPreemGRNDataIsprDataZapisi>
      <SvZapEGRYUL>
        <xsl:for-each select="$SvUL/*[local-name()='СвЗапЕГРЮЛ']">
          <smevNotesEGRUL>
            <xsl:attribute name="_json">asList</xsl:attribute>
            <IdZap>
              <xsl:value-of select="@ИдЗап"/>
            </IdZap>
            <IdZapGRN>
              <xsl:value-of select="@ГРН"/>
            </IdZapGRN>
            <DataZap>
              <xsl:value-of select="@ДатаЗап"/>
            </DataZap>
            <KodSPVZ _json="as_{*[local-name()='ВидЗап']/@КодСПВЗ}">
              <xsl:value-of select="*[local-name()='ВидЗап']/@КодСПВЗ"/>
            </KodSPVZ>
            <NaimVidZap>
              <xsl:value-of select="*[local-name()='ВидЗап']/@НаимВидЗап"/>
            </NaimVidZap>
            <KodNO _json="as_{*[local-name()='СвРегОрг']/@КодНО}">
              <xsl:value-of select="*[local-name()='СвРегОрг']/@КодНО"/>
            </KodNO>
            <NaimNO>
              <xsl:value-of select="*[local-name()='СвРегОрг']/@НаимНО"/>
            </NaimNO>
            <SvedPredDok>
              <xsl:for-each select="*[local-name()='СведПредДок']">
                <smevDocsEGRUL>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <NaimDok>
                    <xsl:value-of select="*[local-name()='НаимДок']"/>
                  </NaimDok>
                  <NomDok>
                    <xsl:value-of select="*[local-name()='НомДок']"/>
                  </NomDok>
                  <DataDok>
                    <xsl:value-of select="*[local-name()='ДатаДок']"/>
                  </DataDok>
                </smevDocsEGRUL>
              </xsl:for-each>
            </SvedPredDok>
            <SvSvid>
              <xsl:for-each select="*[local-name()='СвСвид']">
                <smevCertEGRUL>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <NaimDok>
                    <xsl:value-of select="@Серия"/>
                  </NaimDok>
                  <NomDok>
                    <xsl:value-of select="@Номер"/>
                  </NomDok>
                  <DataDok>
                    <xsl:value-of select="@ДатаВыдСвид"/>
                  </DataDok>
                  <GRN>
                    <xsl:value-of select="*[local-name()='ГРНДатаСвидНед']/@ГРН"/>
                  </GRN>
                  <DataZapisi>
                    <xsl:value-of select="*[local-name()='ГРНДатаСвидНед']/@ДатаЗаписи"/>
                  </DataZapisi>
                </smevCertEGRUL>
              </xsl:for-each>
            </SvSvid>
            <GRNDataIsprPredIdZap>
              <xsl:value-of select="*[local-name()='ГРНДатаИспрПред']/@ИдЗап"/>
            </GRNDataIsprPredIdZap>
            <GRNDataIsprPredGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаИспрПред']/@ГРН"/>
            </GRNDataIsprPredGRN>
            <GRNDataIsprPredDataZap>
              <xsl:value-of select="*[local-name()='ГРНДатаИспрПред']/@ДатаЗаписи"/>
            </GRNDataIsprPredDataZap>
            <GRNDataNedPredIdZap>
              <xsl:value-of select="*[local-name()='ГРНДатаНедПред']/@ИдЗап"/>
            </GRNDataNedPredIdZap>
            <GRNDataNedPredGRN>
              <xsl:value-of select="*[local-name()='ГРНДатаНедПред']/@ГРН"/>
            </GRNDataNedPredGRN>
            <GRNDataNedPredDataZap>
              <xsl:value-of select="*[local-name()='ГРНДатаНедПред']/@ДатаЗаписи"/>
            </GRNDataNedPredDataZap>
            <GRNDataNedIdZap>
              <xsl:value-of select="*[local-name()='СвСтатусЗап']/*[local-name()='ГРНДатаНед']/@ИдЗап"/>
            </GRNDataNedIdZap>
            <GRNDataNedGRN>
              <xsl:value-of select="*[local-name()='СвСтатусЗап']/*[local-name()='ГРНДатаНед']/@ГРН"/>
            </GRNDataNedGRN>
            <GRNDataNedDataZap>
              <xsl:value-of select="*[local-name()='СвСтатусЗап']/*[local-name()='ГРНДатаНед']/@ДатаЗаписи"/>
            </GRNDataNedDataZap>
            <GRNDataIspr>
              <xsl:for-each select="*[local-name()='СвСтатусЗап']/*[local-name()='ГРНДатаИспр']">
                <smevGRNDateUL>
                  <xsl:attribute name="_json">asList</xsl:attribute>
                  <IdZap>
                    <xsl:value-of select="@ИдЗап"/>
                  </IdZap>
                  <IdZapGRN>
                    <xsl:value-of select="@ГРН"/>
                  </IdZapGRN>
                  <DataZap>
                    <xsl:value-of select="@ДатаЗаписи"/>
                  </DataZap>
                </smevGRNDateUL>
              </xsl:for-each>
            </GRNDataIspr>
          </smevNotesEGRUL>
        </xsl:for-each>
      </SvZapEGRYUL>
    </params>
  </xsl:template>
</xsl:stylesheet>
