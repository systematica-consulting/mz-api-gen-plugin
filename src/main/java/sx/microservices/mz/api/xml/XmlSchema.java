package sx.microservices.mz.api.xml;

import lombok.Data;
import sx.microservices.mz.api.xsd2inst.XmlType;

import java.util.HashMap;
import java.util.Map;


@Data
public class XmlSchema {
  private XmlType type;
  private String elementValue;
  private String elementAddress;
  private String elementName;
  private Map<String, XmlSchema> children;
  private XmlSchema parent;

  public void putChild(String name, XmlSchema schema){
    if (children == null){
      children = new HashMap<>();
    }
    children.putIfAbsent(name, schema);
  }


}
