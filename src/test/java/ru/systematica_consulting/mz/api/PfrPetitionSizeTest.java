package ru.systematica_consulting.mz.api;

import org.junit.Test;
import ru.systematica_consulting.mz.api.config.RequestConfig;
import ru.systematica_consulting.mz.api.config.ResponseConfig;
import ru.systematica_consulting.mz.api.json.SchemaBean;

import static org.junit.Assert.assertEquals;

public class PfrPetitionSizeTest {

  @Test
  public void generationTest() throws Exception {
    ResponseConfig responseConfig = new ResponseConfig();
    responseConfig.setTemplate("pfr-petition-size/templates/response.xsl");
    responseConfig.setElement("PensionsOnDateResponse");
    responseConfig.setSchema("pfr-petition-size/schema/schema.xsd");
    responseConfig.setOut("pfr-petition-size/api/response.json");

    RequestConfig requestConfig = new RequestConfig();
    requestConfig.setRequest("pfr-petition-size/request-our.xml");
    requestConfig.setTemplate("pfr-petition-size/templates/request.xsl");
    requestConfig.setElement("PensionsOnDateRequest");
    requestConfig.setSchema("pfr-petition-size/schema/schema.xsd");
    requestConfig.setOut("pfr-petition-size/api/request.json");

    SchemaBean request = ApiPlugin.generateRequest(requestConfig);
    SchemaBean response = ApiPlugin.generateResponse(responseConfig);

    TestUtil.assertEquals(requestConfig.getOut(), request, true);
    TestUtil.assertEquals(responseConfig.getOut(), response, true);

  }

}
