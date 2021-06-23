package sx.microservices.mz.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import sx.microservices.mz.api.schema.SchemaBean;

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
