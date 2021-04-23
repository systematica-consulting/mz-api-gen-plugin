package sx.microservices;

import org.json.JSONObject;
import org.w3c.dom.Document;
import sx.microservices.schema.JsonSchemaGenerator;
import sx.microservices.schema.SchemaBean;
import sx.microservices.xsd2inst.XmlInstance;
import sx.microservices.xsd2inst.XmlInstanceGenerator;

import java.io.PrintStream;

public class Main {

    public static void main(String[] args) throws Exception {
        ResponseConfig responseConfig = new ResponseConfig();
        responseConfig.templatePath = "templates/response.xsl";
        responseConfig.elementName = "PensionsOnDateResponse";
        responseConfig.schemaPath = "schema/schema.xsd";
        responseConfig.out = "response.json";

        RequestConfig requestConfig = new RequestConfig();
        requestConfig.out = "request.json";

        generateResponse(responseConfig);
        generateRequest(requestConfig);
    }


    private static void generateResponse(ResponseConfig config) throws Exception{
        Converter converter = new Converter();
        XslTransformer transformer = new XslTransformer();
        XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);
        JsonSchemaGenerator jsonSchemaGenerator = new JsonSchemaGenerator();

        XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.schemaPath, config.elementName);

        Document transformed = transformer.transform(xmlInstance.getDocument(), config.templatePath);

        JSONObject jsonObject = converter.toJson(transformed);

        SchemaBean response = jsonSchemaGenerator.generate(jsonObject, "Ответ", xmlInstance.getTypes());

        PrintStream responseStream = new PrintStream(config.out);
        responseStream.print(response.toString());
        responseStream.close();

    }

    private static void generateRequest(RequestConfig config) throws Exception{


        SchemaBean request = new SchemaBean();

        PrintStream requestStream = new PrintStream(config.out);
        requestStream.print(request.toString());
        requestStream.close();
    }


    static class ResponseConfig{
        private String templatePath;
        private String elementName;
        private String schemaPath;
        private String out;
    }

    static class RequestConfig{
        private String out;
    }

}


