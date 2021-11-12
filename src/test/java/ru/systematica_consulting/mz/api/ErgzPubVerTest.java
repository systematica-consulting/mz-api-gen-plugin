package ru.systematica_consulting.mz.api;

import org.junit.Test;
import ru.systematica_consulting.mz.api.config.RequestConfig;
import ru.systematica_consulting.mz.api.config.ResponseConfig;
import ru.systematica_consulting.mz.api.json.SchemaBean;

public class ErgzPubVerTest {


  @Test
  public void generationTest() throws Exception {
    ResponseConfig responseConfig = new ResponseConfig();
    responseConfig.setTemplate("ergz-pub-ver/templates/response.xsl");
    responseConfig.setElement("PublicPrintOutResponse");
    responseConfig.setSchema("ergz-pub-ver/schema/publicprintout.xsd");
    responseConfig.setOut("ergz-pub-ver/api/response.json");

    RequestConfig requestConfig = new RequestConfig();
    requestConfig.setRequest("ergz-pub-ver/request-our.xml");
    requestConfig.setTemplate("ergz-pub-ver/templates/request.xsl");
    requestConfig.setElement("PublicPrintOutRequest");
    requestConfig.setSchema("ergz-pub-ver/schema/publicprintout.xsd");
    requestConfig.setOut("ergz-pub-ver/api/request.json");

    SchemaBean request = ApiPlugin.generateRequest(requestConfig);
    SchemaBean response = ApiPlugin.generateResponse(responseConfig);

    TestUtil.assertEquals(requestConfig.getOut(), request, true);
    TestUtil.assertEquals(responseConfig.getOut(), response, true);
  }

}
