package sx.microservices.mz.api;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.gradle.api.Plugin;
import org.gradle.api.Project;
import org.gradle.api.plugins.ExtensionAware;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.mz.api.schema.JsonSchemaGenerator;
import sx.microservices.mz.api.schema.SchemaBean;
import sx.microservices.mz.api.xml.XmlSchema;
import sx.microservices.mz.api.xml.XmlSchemaGenerator;
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
  public static SchemaBean generateResponse(ResponseConfig config) {
    Converter converter = new Converter();
    XslTransformer transformer = new XslTransformer();
    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);

    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());

    Document transformed = transformer.transform(xmlInstance.getDocument(), config.getTemplate());

    removeJsonAttrs(transformed);

    XmlSchemaGenerator xmlSchemaGenerator = new XmlSchemaGenerator(xmlInstance.getTypes());
    XmlSchema xmlSchema = xmlSchemaGenerator.generate(transformed.getDocumentElement());

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

    Map<String, TypeInfo> addressTypeMap = xmlInstance.getTypes().values().stream().collect(Collectors.toMap(TypeInfo::getElementAddress, t -> t));

    XmlSchemaGenerator xmlSchemaGenerator = new XmlSchemaGenerator(types, addressTypeMap);
    XmlSchema xmlSchema = xmlSchemaGenerator.generate(document.getDocumentElement());


    JsonSchemaGenerator generator = new JsonSchemaGenerator();
    return generator.generate(xmlSchema);

  }


  @SneakyThrows
  private static void print(SchemaBean schema, String path) {
    Files.createDirectories(Paths.get(path).getParent());
    PrintStream requestStream = new PrintStream(path, StandardCharsets.UTF_8);
    requestStream.print(schema);
    requestStream.close();
  }

  private static Map<String, TypeInfo> defineTypes(Map<String, String> requestMap, Map<String, String> instanceMap, Map<String, TypeInfo> types) {
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


  private static void removeJsonAttrs(Document document) throws XPathExpressionException {
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[@_json]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    for (int i = 0; i < nodeList.getLength(); i++) {
      Element element = (Element) nodeList.item(i);
      element.removeAttribute("_json");
    }

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


