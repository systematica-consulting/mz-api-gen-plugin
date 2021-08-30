package sx.microservices.mz.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import sx.microservices.mz.api.schema.SchemaBean;

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

    ObjectMapper objectMapper = new ObjectMapper();

    JsonNode requestNode = objectMapper.readTree(request.toString());
    byte[] reqExpected = Util.getFileContent(requestConfig.getOut());
    JsonNode expectedRequest = objectMapper.readTree(reqExpected);

    assertEquals(expectedRequest, requestNode);

    JsonNode responseNode = objectMapper.readTree(response.toString());
    byte[] respExpected = Util.getFileContent(responseConfig.getOut());
    JsonNode expectedResponse = objectMapper.readTree(respExpected);

    assertEquals(expectedResponse, responseNode);
  }
}
