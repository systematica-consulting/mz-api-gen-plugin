package ru.systematica_consulting.mz.api.schema;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;


@Data
public class XmlElement {
  private XmlType type;
  private String elementValue;
  private String elementAddress;
  private String elementName;
  private Map<String, XmlElement> children;
  private XmlElement parent;

  public void putChild(String name, XmlElement schema) {
    if (children == null) {
      children = new HashMap<>();
    }
    children.compute(name, (n, s) -> {
      if (s == null) {
        return schema;
      } else {
        if (schema.children != null) {
          schema.children.forEach(s::putChild);
        }
        return s;
      }
    });
  }


}
