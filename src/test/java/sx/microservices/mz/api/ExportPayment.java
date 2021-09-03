package sx.microservices.mz.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import sx.microservices.mz.api.schema.SchemaBean;

import static org.junit.Assert.assertEquals;

public class ExportPayment {
  @Test
  public void generationTest() throws Exception {
    ResponseConfig responseConfig = new ResponseConfig();
    responseConfig.setTemplate("export-payment/templates/response.xsl");
    responseConfig.setElement("ExportPaymentsResponse");
    responseConfig.setSchema("export-payment/schema/ExportPayments.xsd");
    responseConfig.setOut("export-payment/api/response.json");

    RequestConfig requestConfig = new RequestConfig();
    requestConfig.setRequest("export-payment/request-our.xml");
    requestConfig.setTemplate("export-payment/templates/request.xsl");
    requestConfig.setElement("ExportPaymentsRequest");
    requestConfig.setSchema("export-payment/schema/ExportPayments.xsd");
    requestConfig.setOut("export-payment/api/request.json");

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

