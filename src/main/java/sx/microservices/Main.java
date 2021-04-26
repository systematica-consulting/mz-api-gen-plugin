package sx.microservices;

import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.schema.JsonSchemaGenerator;
import sx.microservices.schema.SchemaBean;
import sx.microservices.xsd2inst.TypeInfo;
import sx.microservices.xsd2inst.XmlInstance;
import sx.microservices.xsd2inst.XmlInstanceGenerator;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class Main {

    public static void main(String[] args) throws Exception {
        ResponseConfig responseConfig = new ResponseConfig();
        responseConfig.template = "templates/response.xsl";
        responseConfig.element = "PensionsOnDateResponse";
        responseConfig.schema= "schema/schema.xsd";
        responseConfig.out = "response.json";

        RequestConfig requestConfig = new RequestConfig();
        requestConfig.request = "request-our.xml";
        requestConfig.template = "templates/request.xsl";
        requestConfig.element = "PensionsOnDateRequest";
        requestConfig.schema = "schema/schema.xsd";
        requestConfig.out = "request.json";

        generateResponse(responseConfig);
        generateRequest(requestConfig);
    }


    private static void generateResponse(ResponseConfig config) throws Exception{
        Converter converter = new Converter();
        XslTransformer transformer = new XslTransformer();
        XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);
        JsonSchemaGenerator jsonSchemaGenerator = new JsonSchemaGenerator();

        XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.schema, config.element);

        Document transformed = transformer.transform(xmlInstance.getDocument(), config.template);

        JSONObject jsonObject = converter.toJson(transformed);

        SchemaBean response = jsonSchemaGenerator.generate(jsonObject, "Ответ", xmlInstance.getTypes());

        PrintStream responseStream = new PrintStream(config.out);
        responseStream.print(response.toString());
        responseStream.close();

    }

    private static void generateRequest(RequestConfig config) throws Exception{

        Converter converter = new Converter();
        JsonSchemaGenerator jsonSchemaGenerator = new JsonSchemaGenerator();
        XslTransformer transformer = new XslTransformer();
        XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);


        InputStream inputStream = ClassLoader.getSystemResource(config.request).openStream();
        byte[] request;
        try(inputStream){
            request = inputStream.readAllBytes();
        }

        Document document = converter.toDocument(new String(request));
        setGuids(document);

        Document transformed = transformer.transform(document, config.template);


        XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.schema, config.element);


        Map<String, String> requestMap = transformer.transformToMap(transformed);


        Map<String, String> instanceMap = transformer.transformToMap(xmlInstance.getDocument());


        Map<String, TypeInfo> types = defineTypes(requestMap, instanceMap, xmlInstance.getTypes());


        JSONObject jsonObject = converter.toJson(document);
        SchemaBean schema = jsonSchemaGenerator.generate(jsonObject, "Запрос", types);


        PrintStream requestStream = new PrintStream(config.out);
        requestStream.print(schema);
        requestStream.close();
    }

    private static Map<String, TypeInfo> defineTypes(Map<String, String> requestMap, Map<String, String> instanceMap, Map<String, TypeInfo> types){
        Map<String, TypeInfo> result = new HashMap<>();
        requestMap.forEach((key, value) -> {
            String instanceGuid = instanceMap.get(key);
            TypeInfo type = types.get(instanceGuid);
            if (type != null) {
                result.put(value, type);
            }
        });
        return result;
    }



    private  static void setGuids(Document document) throws XPathExpressionException {
        XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[count(./*) = 0]");
        NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
        for (int i = 0; i< nodeList.getLength(); i++){
            Node node = nodeList.item(i);

            node.setTextContent(UUID.randomUUID().toString());
        }
    }


    static class ResponseConfig{
        private String template;
        private String element;
        private String schema;
        private String out;
    }

    static class RequestConfig{
        private String template;
        private String element;
        private String schema;
        private String request;
        private String out;
    }

}


