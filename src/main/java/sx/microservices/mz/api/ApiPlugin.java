package sx.microservices.mz.api;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.gradle.api.Plugin;
import org.gradle.api.Project;
import org.gradle.api.plugins.ExtensionAware;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.mz.api.schema.JsonSchemaGenerator;
import sx.microservices.mz.api.schema.SchemaBean;
import sx.microservices.mz.api.xml.XmlSchema;
import sx.microservices.mz.api.xml.XmlSchemaGenerator;
import sx.microservices.mz.api.xsd2inst.XmlType;
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
import java.util.stream.Collectors;

@Slf4j
public class ApiPlugin implements Plugin<Project> {

  @Override
  public void apply(Project project) {
    Config config = project.getExtensions().create("apiGenerator", Config.class);
    RequestConfig requestConfig = ((ExtensionAware) config).getExtensions().create("request", RequestConfig.class);
    ResponseConfig responseConfig = ((ExtensionAware) config).getExtensions().create("response", ResponseConfig.class);
    project.task("generateApi").doLast(task -> {
      if (responseConfig.isFull()) {
        log.warn("\nGenerating response API..");
        SchemaBean schemaBean = generateResponse(responseConfig);
        print(schemaBean, responseConfig.getOut());
      }
      if (requestConfig.isFull()) {
        log.warn("\nGenerating request API..");
        SchemaBean schemaBean = generateRequest(requestConfig);
        print(schemaBean, requestConfig.getOut());
      }
    });
  }


  @SneakyThrows
  public static SchemaBean generateResponse(ResponseConfig config) {

    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator();
    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());

    XslTransformer transformer = new XslTransformer(config.getTemplate());

    XmlSchemaGenerator xmlSchemaGenerator = new XmlSchemaGenerator(xmlInstance, transformer);
    XmlSchema xmlSchema = xmlSchemaGenerator.generateResponse();

    JsonSchemaGenerator generator = new JsonSchemaGenerator();
    return generator.generate(xmlSchema);

    /*

    Map<String, String> smevMap = transformer.transformToMap(xmlInstance.getDocument());

    Map<String, String> guidMap = new HashMap<>();
    smevMap.forEach((k,v) -> guidMap.put(v,k));

    Map<String, String> paramsMap = transformer.transformToMap(transformed);

    Map<String, String> mapping = paramsMap.entrySet().stream().collect(Collectors.toMap(Map.Entry::getKey, e -> guidMap.get(e.getValue())));

    HashSet<String> paramsKeys = new HashSet<>(mapping.keySet());
    paramsKeys.forEach(k -> {
      while (!k.isEmpty()){
        k = k.substring(0, k.lastIndexOf("/"));
        mapping.putIfAbsent(k, "");
      }
    });

    int max = mapping.keySet().stream().map(String::length).mapToInt(e -> e).max().orElseThrow();

    Function<String, String> getDelim = s ->{
      int l = max - s.length();
      return " ".repeat(l);
    };

    String collect = mapping.entrySet().stream().sorted(Map.Entry.comparingByKey())
      .map(e -> e.getKey() +getDelim.apply(e.getKey()) + e.getValue()).collect(Collectors.joining("\n"));

     */
  }

  @SneakyThrows
  public static SchemaBean generateRequest(RequestConfig config) {

    byte[] request = Util.getFileContent(config.getRequest());

    Converter converter = new Converter();
    Document document = converter.toDocument(new String(request));
    setGuids(document);

    XslTransformer transformer = new XslTransformer(config.getTemplate());
    Document transformed = transformer.transform(document);

    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator();
    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());

    Map<String, String> requestMap = transformer.transformToMap(transformed);
    Map<String, String> instanceMap = transformer.transformToMap(converter.toDocument(xmlInstance.getXml()));
    Map<String, XmlType> types = defineTypes(requestMap, instanceMap, xmlInstance.getTypes());

    Map<String, XmlType> addressTypeMap = xmlInstance.getTypes().values().stream().collect(Collectors.toMap(XmlType::getElementAddress, t -> t));

    //XmlSchemaGenerator xmlSchemaGenerator = new XmlSchemaGenerator(types, addressTypeMap);
    //XmlSchema xmlSchema = xmlSchemaGenerator.generate(document.getDocumentElement());


    //JsonSchemaGenerator generator = new JsonSchemaGenerator();
    return new SchemaBean();//generator.generate(xmlSchema);

  }


  @SneakyThrows
  private static void print(SchemaBean schema, String path) {
    Files.createDirectories(Paths.get(path).getParent());
    PrintStream requestStream = new PrintStream(path, StandardCharsets.UTF_8);
    requestStream.print(schema);
    requestStream.close();
  }

  private static Map<String, XmlType> defineTypes(Map<String, String> requestMap, Map<String, String> instanceMap, Map<String, XmlType> types) {
    Map<String, XmlType> result = new HashMap<>();
    requestMap.forEach((key, value) -> {
      String instanceGuid = instanceMap.get(key);
      XmlType type = types.get(instanceGuid);
      if (type != null) {
        result.put(value, type);
      }
    });
    return result;
  }





  private static void setGuids(Document document) throws XPathExpressionException {
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[count(./*) = 0]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    for (int i = 0; i < nodeList.getLength(); i++) {
      Node node = nodeList.item(i);

      node.setTextContent(UUID.randomUUID().toString());
    }
  }


}


