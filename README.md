# mz-api-gen-plugin

Plugin to generate JSON schema from xsd schema and xsl template

Usage
====================

````
  plugins {
    id "ru.systematica_consulting.mz.api-gen-plugin" version "1.0"
  }
  
  apiGenerator{
    request{
      request = "$projectDir/src/test/resources/sample_request.xml"
      template = "$projectDir/src/main/resources/templates/request.xsl"
      element = "SomeRequest" //element of xsd schema 
      schema = "$projectDir/src/main/resources/schema/schema.xsd" 
      out = "$projectDir/src/main/resources/api/request.json"
    }
    response{
      template = "$projectDir/src/main/resources/templates/response.xsl"
      element = "SomeResponse" //element of xsd schema
      schema= "$projectDir/src/main/resources/schema/schema.xsd"
      out = "$projectDir/src/main/resources/api/response.json"
    }
}
  
  ````