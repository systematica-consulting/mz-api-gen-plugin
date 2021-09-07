package sx.microservices.mz.api.xml;

import lombok.extern.slf4j.Slf4j;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import sx.microservices.mz.api.xsd2inst.TypeInfo;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
public class XmlSchemaGenerator {
  private final Map<String, TypeInfo> guidTypeMap;
  private final Map<String, TypeInfo> addressTypeMap;

  public XmlSchemaGenerator(Map<String, TypeInfo> types) {
    this.guidTypeMap = types;
    this.addressTypeMap = types.values().stream().collect(Collectors.toMap(TypeInfo::getElementAddress, t -> t));
  }

  public XmlSchema generate(Element element){
    XmlSchema schema = _generate(element);
    fillObjectsTypes(schema);
    return schema;
  }

  private XmlSchema _generate(Element element){
    XmlSchema xmlSchema = new XmlSchema();
    xmlSchema.setElementName(element.getLocalName());

    if (element.getFirstChild() instanceof Text){
      String guid = element.getTextContent();
      xmlSchema.setTypeGuid(guid);
      xmlSchema.setType(guidTypeMap.get(guid));
    }else {
      NodeList childNodes = element.getChildNodes();
      for (int i = 0; i< childNodes.getLength(); i++){
        Node item = childNodes.item(i);
        if (item instanceof Element) {
          xmlSchema.putChild(item.getLocalName(), _generate((Element) item));
        }
      }
    }
    return xmlSchema;
  }

  private TypeInfo fillObjectsTypes(XmlSchema schema){
    if (schema.getType() == null && schema.getChildren() != null){
      Set<TypeInfo> childrenTypes = new HashSet<>();
      schema.getChildren().forEach((k, v) -> childrenTypes.add(fillObjectsTypes(v)));
      String address = childrenTypes.stream()//todo наибольший общий родитель
        .filter(t -> t.getElementAddress() != null)
        .map(t -> t.getElementAddress().substring(0, t.getElementAddress().lastIndexOf("/"))).findFirst().orElseThrow();
      TypeInfo typeInfo = addressTypeMap.get(address);
      //может быть такое, что не нашли тип, тогда тип - Object
      schema.setType(typeInfo);
    }else if (schema.getType() == null && schema.getChildren() == null){
      log.warn("Не найден тип!!!!!!!!!!");
      TypeInfo typeInfo = new TypeInfo();
      typeInfo.setType("XmlString");//пока так //todo
      schema.setType(typeInfo);
    }
    return schema.getType();
  }

}
