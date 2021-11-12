package ru.systematica_consulting.mz.api.schema;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import ru.systematica_consulting.mz.api.Converter;
import ru.systematica_consulting.mz.api.xsd2inst.XmlInstance;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.util.*;
import java.util.function.UnaryOperator;
import java.util.stream.Collectors;

@Slf4j
abstract class XmlSchemaGenerator {
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


  protected final Map<String, XmlType> addressTypeMap;
  protected final Map<String, XmlType> guidTypeMap;

  /**
   * Так как при генерации xml instance генерируются все варианты choose, что невозможно в реальном сценарии,
   * некоторые элементы могут представиться массивами, хотя на самом деле ими не являются.
   * Это поле содержит такие элементы
   */
  protected Set<String> noArrayElements = new HashSet<>();
  protected final Set<String> foundedGuids = new HashSet<>();
  protected final Set<String> notFoundedTypes = new HashSet<>();
  protected final Converter converter = new Converter();
  protected final String xml;
  protected final String templatePath;

  public XmlSchemaGenerator(XmlInstance xmlInstance, String templatePath) {
    this.templatePath = templatePath;
    this.guidTypeMap = xmlInstance.getTypes();
    this.xml = xmlInstance.getXml();
    this.addressTypeMap = guidTypeMap.values().stream().collect(Collectors.toMap(XmlType::getElementAddress, t -> t));
  }

  protected XmlSchema _generate(Element element) {
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

      XmlType type;
      if (oldType == null){
        type = createTypeFromElementName(element.getLocalName());
        if (type == null) {
          notFoundedTypes.add(xmlSchema.getElementAddress());
          type = new XmlType();
          type.setType(getTypeFromValue(xmlSchema.getElementValue()));
          type.setDescription("");
        }
      }else {
        type = new XmlType();
        type.setType(oldType.getType());
        type.setDescription(oldType.getDescription());
        type.setElementAddress(oldType.getElementAddress());
        type.setEnumeration(oldType.getEnumeration());
      }
      xmlSchema.setType(type);
    }

    return xmlSchema;
  }

  protected XmlType fillObjectsTypes(XmlSchema schema) {
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
      if (oldType != null){
        type.setDescription(oldType.getDescription());
        type.setElementAddress(oldType.getElementAddress());
      }
      schema.setType(type);

    }
    assert schema.getType() != null;

    return schema.getType();
  }

  @SneakyThrows
  protected Set<String> findArrayNodes(Document document){
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[1]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    Set<String> result = new HashSet<>();
    for (int i = 0; i< nodeList.getLength(); i++){
      Node sib = nodeList.item(i);
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

  protected void setArrayType(XmlSchema xmlSchema, Set<String> arrayNodes){
    if (arrayNodes.contains(xmlSchema.getElementAddress())){
      if (!noArrayElements.contains(xmlSchema.getElementAddress()) || xmlSchema.getChildren() != null){
        xmlSchema.getType().setList(true);
      }
    }
    if (xmlSchema.getChildren() != null){
      xmlSchema.getChildren().values().forEach(s -> setArrayType(s, arrayNodes));
    }
  }

  /**
   * @param addresses адреса
   * @return общий префикс
   */
  private String findCommonAddress(List<String> addresses) {
    if (addresses.isEmpty()) return null;
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

  protected String getElementAddress(Element element) {
    StringBuilder sb = new StringBuilder();
    Node curr = element;
    while (curr.getLocalName() != null) {
      sb.insert(0, curr.getLocalName()).insert(0, "/");
      curr = curr.getParentNode();
    }
    return sb.toString();
  }

  /**
   * experimental feature
   *
   * @param name имя элемента
   * @return тип
   */
  private XmlType createTypeFromElementName(String name) {
    if (name.equals("messageId")) {
      XmlType xmlType = new XmlType();
      xmlType.setType("XmlString");
      xmlType.setDescription("Идентификатор запроса в системе СМЭВ");
      return xmlType;
    }
    return null;
  }

  private XmlType findSimpleType(XmlSchema schema){
    XmlType type = guidTypeMap.get(schema.getElementValue());
    type =  type != null ? type : functions
      .stream()
      .map(f -> f.apply(schema.getElementValue()))
      .filter(guidTypeMap::containsKey)
      .map(guidTypeMap::get)
      .findFirst()
      .orElse(null);

    if (type != null){
      foundedGuids.add(schema.getElementValue());
    }
    return type;
  }

  /**
   * @param value text xml элемента
   * @return тип xml элемента
   */
  private String getTypeFromValue(String value) {
    //лучше не рисковать и не придумывать другие типы
    if (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("false")) {
      return "XmlBoolean";
    } else  {
      return "XmlString";
    }
  }

}
