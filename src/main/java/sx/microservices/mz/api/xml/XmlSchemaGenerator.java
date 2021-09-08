package sx.microservices.mz.api.xml;

import lombok.extern.slf4j.Slf4j;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import sx.microservices.mz.api.xsd2inst.TypeInfo;

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


  private final Map<String, TypeInfo> guidTypeMap;
  private final Map<String, TypeInfo> addressTypeMap;

  public XmlSchemaGenerator(Map<String, TypeInfo> types) {
    this.guidTypeMap = types;
    this.addressTypeMap = types.values().stream().collect(Collectors.toMap(TypeInfo::getElementAddress, t -> t));
  }

  public XmlSchemaGenerator(Map<String, TypeInfo> guidTypeMap, Map<String, TypeInfo> addressTypeMap) {
    this.guidTypeMap = guidTypeMap;
    this.addressTypeMap = addressTypeMap;
  }

  public XmlSchema generate(Element element){
    XmlSchema schema = _generate(element);
    fillObjectsTypes(schema);
    return schema;
  }

  private XmlSchema _generate(Element element){
    XmlSchema xmlSchema = new XmlSchema();
    xmlSchema.setElementName(element.getLocalName());
    xmlSchema.setElementAddress(getElementAddress(element));

    NodeList childNodes = element.getChildNodes();
    int count = 0;
    for (int i = 0; i< childNodes.getLength(); i++){
      Node item = childNodes.item(i);
      if (item instanceof Element) {
        count++;
        xmlSchema.putChild(item.getLocalName(), _generate((Element) item));
      }
    }
    if (count == 0){
      String guid = element.getTextContent();
      xmlSchema.setTypeGuid(guid);
      xmlSchema.setType(guidTypeMap.get(guid));
    }

    return xmlSchema;
  }

  private String getElementAddress(Element element) {
    StringBuilder sb = new StringBuilder();
    Node curr = element;
    while (curr.getLocalName() != null){
      sb.insert(0, curr.getLocalName()).insert(0, "/");
      curr = curr.getParentNode();
    }
    return sb.toString();
  }

  private TypeInfo fillObjectsTypes(XmlSchema schema){
    if (schema.getType() == null && schema.getChildren() != null){
      Set<TypeInfo> childrenTypes = new HashSet<>();
      schema.getChildren().forEach((k, v) -> childrenTypes.add(fillObjectsTypes(v)));

      List<String> addresses = childrenTypes.stream()
        .filter(t -> t.getElementAddress() != null)
        .map(TypeInfo::getElementAddress)
        .collect(Collectors.toList());

      String address = findCommonAddress(addresses);

      TypeInfo typeInfo = addressTypeMap.get(address);
      //может быть такое, что не нашли тип, тогда тип - Object
      schema.setType(typeInfo);
    }else if (schema.getType() == null && schema.getChildren() == null){
      TypeInfo typeInfo = functions
        .stream()
        .map(f -> f.apply(schema.getTypeGuid()))
        .filter(guidTypeMap::containsKey)
        .map(guidTypeMap::get)
        .findFirst()
        .orElse(null);
      if (typeInfo == null){
        log.warn("Not founded type for {}", schema.getElementAddress());
        typeInfo = new TypeInfo();
        typeInfo.setType("XmlString");
        typeInfo.setDescription("");
      }

      schema.setType(typeInfo);
    }
    return schema.getType();
  }



  /**
   * @param addresses адреса
   * @return общий префикс
   */
  private String findCommonAddress(List<String> addresses){
    if (addresses.isEmpty()) return "";
    if (addresses.size() == 1){
      return addresses.get(0).substring(0, addresses.get(0).lastIndexOf("/"));
    }
    String result = addresses.get(0);
    boolean founded = false;
    w: while (!founded) {
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
