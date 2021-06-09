package sx.microservices.mz.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import sx.microservices.mz.api.schema.SchemaBean;

import static org.junit.Assert.assertEquals;

public class FnsDohflnaTest {

    @Test
    public void generationTest() throws Exception{
        ResponseConfig responseConfig = new ResponseConfig();
        responseConfig.setTemplate("fns-dohflna/templates/response.xsl");
        responseConfig.setElement("DOHFLNAResponse");
        responseConfig.setSchema("fns-dohflna/schema/fns-dohflna-ru-root.xsd");
        responseConfig.setOut("fns-dohflna/api/response.json");

        RequestConfig requestConfig = new RequestConfig();
        requestConfig.setRequest("fns-dohflna/request-our.xml");
        requestConfig.setTemplate("fns-dohflna/templates/request.xsl");
        requestConfig.setElement("DOHFLNARequest");
        requestConfig.setSchema("fns-dohflna/schema/fns-dohflna-ru-root.xsd");
        requestConfig.setOut("fns-dohflna/api/request.json");

        SchemaBean request = ApiPlugin.generateRequest(requestConfig);
        SchemaBean response = ApiPlugin.generateResponse(responseConfig);

        ObjectMapper objectMapper = new ObjectMapper();

        JsonNode requestNode = objectMapper.readTree(request.toString());
        byte[] reqExpected = Util.getFileContent(requestConfig.getOut());
        JsonNode expectedRequest = objectMapper.readTree(reqExpected);

        assertEquals( expectedRequest, requestNode);

        JsonNode responseNode = objectMapper.readTree(response.toString());
        byte[] respExpected = Util.getFileContent(responseConfig.getOut());
        JsonNode expectedResponse = objectMapper.readTree(respExpected);

        assertEquals(expectedResponse, responseNode);
    }
}
