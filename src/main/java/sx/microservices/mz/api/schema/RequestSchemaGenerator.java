package sx.microservices.mz.api.schema;

import lombok.SneakyThrows;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.mz.api.XslTransformer;
import sx.microservices.mz.api.xsd2inst.XmlInstance;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class RequestSchemaGenerator extends XmlSchemaGenerator{

  public RequestSchemaGenerator(XmlInstance xmlInstance, XslTransformer transformer) {
    super(transformer, xmlInstance);
  }

  public XmlSchema generate(byte[] request) {
    Document document = converter.toDocument(new String(request));
    setGuids(document);
    Document transformed = transformer.transform(document);

    Map<String, String> requestMap = transformer.transformToMap(transformed);
    Map<String, String> instanceMap = transformer.transformToMap(converter.toDocument(xml));
    Map<String, XmlType> types = defineTypes(requestMap, instanceMap, guidTypeMap);
    guidTypeMap.putAll(types);


    XmlSchema schema = _generate(document.getDocumentElement());
    fillObjectsTypes(schema);

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
