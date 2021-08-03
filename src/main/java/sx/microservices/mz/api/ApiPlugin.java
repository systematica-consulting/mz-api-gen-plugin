package sx.microservices.mz.api;

import lombok.SneakyThrows;
import org.gradle.api.Plugin;
import org.gradle.api.Project;
import org.gradle.api.plugins.ExtensionAware;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.mz.api.schema.JsonSchemaGenerator;
import sx.microservices.mz.api.schema.SchemaBean;
import sx.microservices.mz.api.xsd2inst.TypeInfo;
import sx.microservices.mz.api.xsd2inst.XmlInstance;
import sx.microservices.mz.api.xsd2inst.XmlInstanceGenerator;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class ApiPlugin implements Plugin<Project> {

    @Override
    public void apply(Project project) {
        Config config = project.getExtensions().create("apiGenerator", Config.class);
        RequestConfig requestConfig = ((ExtensionAware) config).getExtensions().create("request", RequestConfig.class);
        ResponseConfig responseConfig = ((ExtensionAware) config).getExtensions().create("response", ResponseConfig.class);
        project.task("generateApi").doLast(task -> {
            if (responseConfig.isFull()) {
                SchemaBean schemaBean = generateResponse(responseConfig);
                print(schemaBean, responseConfig.getOut());
            }
            if (requestConfig.isFull()) {
                SchemaBean schemaBean = generateRequest(requestConfig);
                print(schemaBean, requestConfig.getOut());
            }
        });
    }


    @SneakyThrows
    public static SchemaBean generateResponse(ResponseConfig config){
        Converter converter = new Converter();
        XslTransformer transformer = new XslTransformer();
        XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);
        JsonSchemaGenerator jsonSchemaGenerator = new JsonSchemaGenerator();

        XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());

        Document transformed = transformer.transform(xmlInstance.getDocument(), config.getTemplate());

        JSONObject jsonObject = converter.toJson(transformed);

        return jsonSchemaGenerator.generate(jsonObject, "Ответ", xmlInstance.getTypes());
    }

    @SneakyThrows
    public static SchemaBean generateRequest(RequestConfig config){

        Converter converter = new Converter();
        JsonSchemaGenerator jsonSchemaGenerator = new JsonSchemaGenerator();
        XslTransformer transformer = new XslTransformer();
        XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);

        byte[] request = Util.getFileContent(config.getRequest());

        Document document = converter.toDocument(new String(request));
        setGuids(document);

        Document transformed = transformer.transform(document, config.getTemplate());


        XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());


        Map<String, String> requestMap = transformer.transformToMap(transformed);


        Map<String, String> instanceMap = transformer.transformToMap(xmlInstance.getDocument());


        Map<String, TypeInfo> types = defineTypes(requestMap, instanceMap, xmlInstance.getTypes());


        JSONObject jsonObject = converter.toJson(document);

        return jsonSchemaGenerator.generate(jsonObject, "Запрос", types);

    }

    @SneakyThrows
    private static void print(SchemaBean schema, String path){
        Files.createDirectories(Paths.get(path).getParent());
        PrintStream requestStream = new PrintStream(path, StandardCharsets.UTF_8);
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


}


