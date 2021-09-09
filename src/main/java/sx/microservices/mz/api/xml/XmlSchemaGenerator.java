package sx.microservices.mz.api.xml;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.mz.api.Converter;
import sx.microservices.mz.api.XslTransformer;
import sx.microservices.mz.api.xsd2inst.XmlType;
import sx.microservices.mz.api.xsd2inst.XmlInstance;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.util.*;
import java.util.function.UnaryOperator;
import java.util.stream.Collectors;

@Slf4j
public class XmlSchemaGenerator {

  private static final List<UnaryOperator<String>> functions = new ArrayList<>();

  static {
    UnaryOperator<String> formatDate = s -> {
      if (s.length() >= 10) {
        return s.substring(0, 4) + "-" + s.substring(5, 7) + "-" + s.substring(8, 10);
      } else {
        return s;
      }
    };
    functions.add(formatDate);
  }


  private final Map<String, XmlType> guidTypeMap;
  private final Map<String, XmlType> addressTypeMap;
  private final XslTransformer transformer;
  private final String xml;
  private final Converter converter= new Converter();

  public XmlSchemaGenerator(XmlInstance xmlInstance, XslTransformer transformer) {
    this.xml = xmlInstance.getXml();
    this.transformer = transformer;
    this.guidTypeMap = xmlInstance.getTypes();
    this.addressTypeMap = guidTypeMap.values().stream().collect(Collectors.toMap(XmlType::getElementAddress, t -> t));
  }

  public XmlSchemaGenerator(Map<String, XmlType> guidTypeMap, Map<String, XmlType> addressTypeMap, XslTransformer transformer) {
    this.xml = "";
    this.transformer = transformer;
    this.guidTypeMap = guidTypeMap;
    this.addressTypeMap = addressTypeMap;
  }

  public XmlSchema generateResponse() {
    Document document = converter.toDocument(xml);
    Document transformed = transformer.transform(document);
    removeJsonAttrs(transformed);

    XmlSchema schema = _generate(transformed.getDocumentElement());
    fillObjectsTypes(schema);

    document = converter.toDocument(xml);
    replaceComments(document);
    transformed = transformer.transform(document);
    removeJsonAttrs(transformed);
    Set<String> arrayNodes = findArrayNodes(transformed);
    setArrayType(schema, arrayNodes);


    return schema;
  }

  private XmlSchema _generate(Element element) {
    XmlSchema xmlSchema = new XmlSchema();
    xmlSchema.setElementName(element.getLocalName());
    xmlSchema.setElementAddress(getElementAddress(element));

    NodeList childNodes = element.getChildNodes();
    int count = 0;
    for (int i = 0; i < childNodes.getLength(); i++) {
      Node item = childNodes.item(i);
      if (item instanceof Element) {
        count++;
        xmlSchema.putChild(item.getLocalName(), _generate((Element) item));
      }
    }
    if (count == 0) {//simple type
      String guid = element.getTextContent();
      xmlSchema.setElementValue(guid);

      XmlType oldType = findSimpleType(xmlSchema);

      XmlType type = new XmlType();
      if (oldType == null){
        log.warn("Not founded type for {}", xmlSchema.getElementAddress());
        type.setType(getTypeFromValue(xmlSchema.getElementValue()));
        type.setDescription("");
      }else {
        type.setType(oldType.getType());
        type.setDescription(oldType.getDescription());
        type.setElementAddress(oldType.getElementAddress());
        type.setEnumeration(oldType.getEnumeration());
      }
      xmlSchema.setType(type);
    }

    return xmlSchema;
  }

  private String getElementAddress(Element element) {
    StringBuilder sb = new StringBuilder();
    Node curr = element;
    while (curr.getLocalName() != null) {
      sb.insert(0, curr.getLocalName()).insert(0, "/");
      curr = curr.getParentNode();
    }
    return sb.toString();
  }

  private XmlType fillObjectsTypes(XmlSchema schema) {
    if (schema.getType() == null && schema.getChildren() != null) {
      Set<XmlType> childrenTypes = new HashSet<>();
      schema.getChildren().forEach((k, v) -> childrenTypes.add(fillObjectsTypes(v)));

      List<String> addresses = childrenTypes.stream()
        .filter(t -> t.getElementAddress() != null)
        .map(XmlType::getElementAddress)
        .collect(Collectors.toList());

      String address = findCommonAddress(addresses);

      XmlType oldType = addressTypeMap.get(address);
      XmlType type = new XmlType();
      type.setType("XmlObject");
      type.setDescription(oldType.getDescription());
      type.setElementAddress(oldType.getElementAddress());
      schema.setType(type);

    }
    assert schema.getType() != null;

    return schema.getType();
  }

  private XmlType findSimpleType(XmlSchema schema){
    XmlType type = guidTypeMap.get(schema.getElementValue());
    return type != null ? type : functions
      .stream()
      .map(f -> f.apply(schema.getElementValue()))
      .filter(guidTypeMap::containsKey)
      .map(guidTypeMap::get)
      .findFirst()
      .orElse(null);
  }


  @SneakyThrows
  private void removeJsonAttrs(Document document) {
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[@_json]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    for (int i = 0; i < nodeList.getLength(); i++) {
      Element element = (Element) nodeList.item(i);
      element.removeAttribute("_json");
    }
  }

  @SneakyThrows
  private Set<String> findArrayNodes(Document document){
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[1]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    Set<String> result = new HashSet<>();
    for (int i = 0; i< nodeList.getLength(); i++){
      Element element = (Element) nodeList.item(i);

      Node sib = element;
      Set<String> elementNames = new HashSet<>();
      do {
        if (sib instanceof Element){
          if (elementNames.contains(sib.getLocalName())){
            result.add(getElementAddress((Element) sib));
          }
          elementNames.add(sib.getLocalName());
        }
      } while ((sib = sib.getNextSibling()) != null);
    }
    return result;
  }

  private void setArrayType(XmlSchema xmlSchema, Set<String> arrayNodes){
    if (arrayNodes.contains(xmlSchema.getElementAddress())){
      xmlSchema.getType().setList(true);
    }
    if (xmlSchema.getChildren() != null){
      xmlSchema.getChildren().values().forEach(s -> setArrayType(s, arrayNodes));
    }
  }

  @SneakyThrows
  private void replaceComments(Document document){
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//comment()");
    NodeList nodeList;
    do {
      nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
      for (int i = 0; i < nodeList.getLength(); i++) {
        Node node = nodeList.item(i);
        if (node.getTextContent() != null && node.getTextContent().contains("repetitions:")) {
          Node cloneNode = node.getNextSibling().getNextSibling().cloneNode(true);
          Node parentNode = node.getParentNode();
          parentNode.appendChild(cloneNode);
          parentNode.removeChild(node);
        } else {
          Node parentNode = node.getParentNode();
          parentNode.removeChild(node);
        }
      }
    } while (nodeList.getLength() != 0);
  }


  /**
   * experimental feature
   *
   * @param name имя элемента
   * @return тип
   */
  private XmlType getTypeFromElementName(String name) {
    if (name.equals("messageId")) {
      XmlType xmlType = new XmlType();
      xmlType.setType("XmlString");
      xmlType.setDescription("Идентификатор запроса в системе СМЭВ");
      return xmlType;
    }
    return null;
  }


  /**
   * @param value text xml элемента
   * @return тип xml элемента
   */
  private String getTypeFromValue(String value) {
    if (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("false")) {
      return "XmlBoolean";
    } else if (value.matches("\\d+")) {
      return "XmlLong";
    } else {
      try {
        Double.parseDouble(value);
        return "XmlDouble";
      } catch (NumberFormatException e) {
        return "XmlString";
      }
    }
  }


  /**
   * @param addresses адреса
   * @return общий префикс
   */
  private String findCommonAddress(List<String> addresses) {
    if (addresses.isEmpty()) return "";
    if (addresses.size() == 1) {
      return addresses.get(0);
    }
    String result = addresses.get(0);
    boolean founded = false;
    w:
    while (!founded) {
      for (int i = 1; i < addresses.size(); i++) {
        if (!addresses.get(i).contains(result)) {
          result = result.substring(0, result.lastIndexOf("/"));
          continue w;
        }
      }
      founded = true;
    }
    return result;
  }

}
