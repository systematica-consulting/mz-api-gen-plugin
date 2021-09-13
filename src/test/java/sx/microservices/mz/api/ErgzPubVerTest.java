package sx.microservices.mz.api;

import org.junit.Test;
import sx.microservices.mz.api.config.RequestConfig;
import sx.microservices.mz.api.config.ResponseConfig;
import sx.microservices.mz.api.json.SchemaBean;

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
