package sx.microservices.mz.api.xsd2inst;

import sx.microservices.mz.api.schema.XmlType;

import java.util.Map;

public class XmlInstance {
  private String xml;
  private Map<String, XmlType> types;

  public Map<String, XmlType> getTypes() {
    return types;
  }

  public void setTypes(Map<String, XmlType> types) {
    this.types = types;
  }

  public String getXml() {
    return xml;
  }

  public void setXml(String xml) {
    this.xml = xml;
  }
}
