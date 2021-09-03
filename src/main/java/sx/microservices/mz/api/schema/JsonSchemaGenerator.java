package sx.microservices.mz.api.schema;

import org.json.JSONArray;
import org.json.JSONObject;
import sx.microservices.mz.api.xsd2inst.TypeInfo;

import java.util.*;
import java.util.function.UnaryOperator;

public class JsonSchemaGenerator {

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


  public SchemaBean generate(JSONObject jsonObject, String title, Map<String, TypeInfo> types) {
    SchemaBean schemaBean = new SchemaBean();
    schemaBean.setTitle(title);
    schemaBean.setType(Type.object);

    Set<String> required = new HashSet<>();

    Map<String, SchemaBean> properties = new HashMap<>();
    jsonObject.keySet().forEach(k -> {

      SchemaBean bean;
      Object object = jsonObject.get(k);
      if (object instanceof JSONObject) {
        bean = generate((JSONObject) object, "", types);
      } else if (object instanceof JSONArray) {
        JSONArray array = (JSONArray) object;
        bean = new SchemaBean();
        bean.setType(Type.array);
        Object obj = array.get(0);
        if (obj instanceof JSONObject) {
          bean.setItems(generate((JSONObject) obj, "", types));
        } else if (obj instanceof String) {
          bean.setItems(processString(k, (String) obj, types, required));
        } else if (obj instanceof JSONArray) {
          throw new UnsupportedOperationException("Not implemented, yet");
        } else {
          SchemaBean b = new SchemaBean();
          bean.setType(Type.fromValue(obj));
          bean.setItems(b);
        }
      } else {// simple type
        Object obj = jsonObject.get(k);
        if (obj instanceof String) {
          bean = processString(k, (String) obj, types, required);
        } else {
          bean = new SchemaBean();
          bean.setType(Type.fromValue(obj));
          bean.setTitle("");
        }
      }
      properties.put(k, bean);
    });
    schemaBean.setProperties(properties);
    schemaBean.setRequired(required);

    return schemaBean;
  }

  private SchemaBean processString(String key,
                                   String uuid,
                                   Map<String, TypeInfo> types,
                                   Set<String> required) {
    SchemaBean bean = new SchemaBean();
    TypeInfo typeInfo = types.get(uuid);
    if (typeInfo == null) {
      typeInfo = functions
        .stream()
        .map(f -> f.apply(uuid))
        .filter(types::containsKey)
        .map(types::get)
        .findFirst()
        .orElse(null);
    }

    if (typeInfo == null) {
      //todo log warn: couldn't find type
      bean.setType(Type.string);
      bean.setTitle("");
    } else {
      bean.setType(Type.fromXmlType(typeInfo.getType()));
      bean.setFormat(Format.fromXmlType(typeInfo.getType()));
      bean.setTitle(typeInfo.getDescription());
      bean.setEnumeration(typeInfo.getEnumeration());
    }

    if (typeInfo != null && typeInfo.isRequired()) {
      required.add(key);
    }
    return bean;
  }


}
