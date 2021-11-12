package ru.systematica_consulting.mz.api.schema;

import lombok.Data;

import javax.xml.namespace.QName;
import java.util.List;

@Data
public class XmlType {
  private String uuid;
  private String type;
  private String elementAddress;
  private List<String> enumeration;
  private String description;
  private boolean required;
  private boolean list;
}
