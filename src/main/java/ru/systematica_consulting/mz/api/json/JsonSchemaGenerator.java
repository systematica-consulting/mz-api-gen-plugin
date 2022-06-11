package ru.systematica_consulting.mz.api.json;

import ru.systematica_consulting.mz.api.schema.XmlElement;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class JsonSchemaGenerator {

  public SchemaBean generate(XmlElement xmlElement) {
    SchemaBean schemaBean = new SchemaBean();

    if (xmlElement.getType().isList()) {
      schemaBean.setType(Type.array);
      xmlElement.getType().setList(false);
      schemaBean.setItems(generate(xmlElement));
      return schemaBean;
    }

    schemaBean.setTitle(xmlElement.getType().getDescription());
    schemaBean.setType(Type.fromXmlType(xmlElement.getType().getType()));

    if (schemaBean.getType().isSimple()) {
      schemaBean.setFormat(Format.fromXmlType(xmlElement.getType().getType()));
      schemaBean.setEnumeration(xmlElement.getType().getEnumeration());
      return schemaBean;
    }

    Set<String> required = new HashSet<>();

    Map<String, SchemaBean> properties = new HashMap<>();

    if (xmlElement.getChildren() != null) {
      xmlElement.getChildren().forEach((name, schema) -> {
        properties.put(name, generate(schema));
        if (schema.getType().isRequired()) {
          required.add(name);
        }
      });
    }

    schemaBean.setProperties(properties);
    schemaBean.setRequired(required);

    return schemaBean;
  }

}
