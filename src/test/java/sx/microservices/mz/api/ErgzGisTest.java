package sx.microservices.mz.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import org.junit.Test;
import sx.microservices.mz.api.schema.SchemaBean;

import java.io.IOException;

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


    assertEquals(requestConfig.getOut(), requestNode, true);

    JsonNode responseNode = objectMapper.readTree(response.toString());

    assertEquals(responseConfig.getOut(), responseNode, true);
  }

  public void assertEquals(String expectedPath, JsonNode actual, boolean overwrite) throws IOException {
    ObjectMapper objectMapper = new ObjectMapper();
    byte[] expected_bytes = Util.getFileContent(expectedPath);
    JsonNode expected = objectMapper.readTree(expected_bytes);
    try{
      Assert.assertEquals(expected, actual);
    }catch (AssertionError e){
      if (overwrite){
        Util.writeFile(expectedPath, actual.toPrettyString().getBytes());
      }else {
        throw e;
      }
    }

  }
}
