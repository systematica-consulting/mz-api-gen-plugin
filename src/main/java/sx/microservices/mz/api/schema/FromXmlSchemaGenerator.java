package sx.microservices.mz.api.schema;

import sx.microservices.mz.api.xml.XmlSchema;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class FromXmlSchemaGenerator {

  public SchemaBean generate(XmlSchema xmlSchema){
    SchemaBean schemaBean = new SchemaBean();

    if (xmlSchema.getType().isList()){
      schemaBean.setType(Type.array);
      xmlSchema.getType().setList(false);
      schemaBean.setItems(generate(xmlSchema));
      return schemaBean;
    }

    schemaBean.setTitle(xmlSchema.getType().getDescription());
    schemaBean.setType(Type.fromXmlType(xmlSchema.getType().getType()));

    if (schemaBean.getType().isSimple()){
      schemaBean.setFormat(Format.fromXmlType(xmlSchema.getType().getType()));
      schemaBean.setEnumeration(xmlSchema.getType().getEnumeration());
      return schemaBean;
    }

    Set<String> required = new HashSet<>();

    Map<String, SchemaBean> properties = new HashMap<>();

    if (xmlSchema.getChildren() != null) {
      xmlSchema.getChildren().forEach((name, schema) -> {
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
