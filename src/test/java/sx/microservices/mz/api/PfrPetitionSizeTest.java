package sx.microservices.mz.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import sx.microservices.mz.api.schema.SchemaBean;

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
