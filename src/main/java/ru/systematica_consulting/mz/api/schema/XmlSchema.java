package ru.systematica_consulting.mz.api.schema;

import lombok.Data;

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
    children.compute(name, (n, s) -> {
      if (s == null){
        return schema;
      }else {
        if (schema.children != null) {
          schema.children.forEach(s::putChild);
        }
        return s;
      }
    });
  }


}
