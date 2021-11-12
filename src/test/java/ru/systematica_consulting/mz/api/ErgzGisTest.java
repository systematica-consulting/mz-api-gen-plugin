package ru.systematica_consulting.mz.api;

import org.junit.Test;
import ru.systematica_consulting.mz.api.config.RequestConfig;
import ru.systematica_consulting.mz.api.config.ResponseConfig;
import ru.systematica_consulting.mz.api.json.SchemaBean;

import static org.junit.Assert.assertEquals;

public class ErgzGisTest {

  @Test
  public void generationTest() throws Exception {
    ResponseConfig responseConfig = new ResponseConfig();
    responseConfig.setTemplate("ergz-gis/templates/response.xsl");
    responseConfig.setElement("FullPrintOutResponse");
    responseConfig.setSchema("ergz-gis/schema/fullprintout.xsd");
    responseConfig.setOut("ergz-gis/api/response.json");

    RequestConfig requestConfig = new RequestConfig();
    requestConfig.setRequest("ergz-gis/request-our.xml");
    requestConfig.setTemplate("ergz-gis/templates/request.xsl");
    requestConfig.setElement("FullPrintOutRequest");
    requestConfig.setSchema("ergz-gis/schema/fullprintout.xsd");
    requestConfig.setOut("ergz-gis/api/request.json");

    SchemaBean request = ApiPlugin.generateRequest(requestConfig);
    SchemaBean response = ApiPlugin.generateResponse(responseConfig);

    TestUtil.assertEquals(requestConfig.getOut(), request, true);
    TestUtil.assertEquals(responseConfig.getOut(), response, true);
  }


}
