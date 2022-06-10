package ru.systematica_consulting.mz.api.schema;

import lombok.SneakyThrows;
import org.apache.xmlbeans.XmlException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import ru.systematica_consulting.mz.api.XslTransformer;
import ru.systematica_consulting.mz.api.xsd2inst.XmlInstanceGenerator;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.IOException;
import java.util.*;

public class RequestSchemaGenerator extends XmlSchemaGenerator {

  public RequestSchemaGenerator(String schemaPath, String element, String templatePath) throws IOException, XmlException {
    super(new XmlInstanceGenerator().createInstance(schemaPath, element), templatePath);
  }

  public XmlSchema generate(byte[] request) {
    XslTransformer transformer = new XslTransformer(templatePath);
    Document document = converter.toDocument(new String(request));
    setGuids(document);
    Document transformed = transformer.transform(document);

    Map<String, String> requestMap = transformer.transformToMap(transformed);
    Map<String, String> instanceMap = transformer.transformToMap(converter.toDocument(xml));
    Map<String, XmlType> types = defineTypes(requestMap, instanceMap, guidTypeMap);
    guidTypeMap.clear();
    guidTypeMap.putAll(types);

    XmlSchema schema = generate(document.getDocumentElement());
    Set<String> arrayNodes = findArrayNodes(document);
    setArrayType(schema, arrayNodes);

    if (!notFoundedTypes.isEmpty()) {
      System.out.println("\nNot founded type for:");
      notFoundedTypes.stream().sorted(Comparator.comparing(s -> s)).forEach(System.out::println);
    }

    return schema;
  }

  private Map<String, XmlType> defineTypes(Map<String, String> requestMap,
                                           Map<String, String> instanceMap,
                                           Map<String, XmlType> types) {
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

  @SneakyThrows
  private void setGuids(Document document) {
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[count(./*) = 0]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    for (int i = 0; i < nodeList.getLength(); i++) {
      Node node = nodeList.item(i);

      node.setTextContent(UUID.randomUUID().toString());
    }
  }


}
