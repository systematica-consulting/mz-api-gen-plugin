package ru.systematica_consulting.mz.api.xsd2inst;

import lombok.Data;
import ru.systematica_consulting.mz.api.schema.XmlType;

import java.util.Map;

@Data
public class XmlInstance {
  private String xml;
  private Map<String, XmlType> types;
}
