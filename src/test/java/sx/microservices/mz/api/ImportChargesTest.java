package sx.microservices.mz.api;

import org.junit.Test;
import sx.microservices.mz.api.config.RequestConfig;
import sx.microservices.mz.api.config.ResponseConfig;
import sx.microservices.mz.api.json.SchemaBean;

import static org.junit.Assert.assertEquals;

public class ImportChargesTest {

  @Test
  public void generationTest() throws Exception {
    ResponseConfig responseConfig = new ResponseConfig();
    responseConfig.setTemplate("import-charge/templates/response.xsl");
    responseConfig.setElement("ImportChargesResponse");
    responseConfig.setSchema("import-charge/schema/ImportCharges.xsd");
    responseConfig.setOut("import-charge/api/response.json");

    RequestConfig requestConfig = new RequestConfig();
    requestConfig.setRequest("import-charge/request-our.xml");
    requestConfig.setTemplate("import-charge/templates/request.xsl");
    requestConfig.setElement("ImportChargesRequest");
    requestConfig.setSchema("import-charge/schema/ImportCharges.xsd");
    requestConfig.setOut("import-charge/api/request.json");

    SchemaBean request = ApiPlugin.generateRequest(requestConfig);
    SchemaBean response = ApiPlugin.generateResponse(responseConfig);

    TestUtil.assertEquals(requestConfig.getOut(), request, true);
    TestUtil.assertEquals(responseConfig.getOut(), response, true);
  }
}
