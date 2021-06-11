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
            if (s.length() >= 10){
                return s.substring(0,4) + "-" + s.substring(5,7) + "-" + s.substring(8,10);
            } else {
                return s;
            }
        };
        functions.add(formatDate);
    }



    public SchemaBean generate(JSONObject jsonObject, String title, Map<String, TypeInfo> types){
        SchemaBean schemaBean = new SchemaBean();
        schemaBean.setTitle(title);
        schemaBean.setType(Type.object);

        Set<String> required = new HashSet<>();

        Map<String, SchemaBean> properties = new HashMap<>();
        jsonObject.keySet().forEach(k -> {
            if (k.equals("_json")) return;

            if (jsonObject.get(k) instanceof JSONObject){
                properties.put(k, generate(jsonObject.getJSONObject(k), "", types));
            }else if (jsonObject.get(k) instanceof JSONArray){
                SchemaBean bean = new SchemaBean();
                bean.setType(Type.array);
                JSONObject obj = jsonObject.getJSONArray(k).getJSONObject(0);
                bean.setItems(generate(obj, "", types));
                properties.put(k, bean);
            }else {// simple type
                String uuid = jsonObject.getString(k);
                TypeInfo typeInfo = types.get(uuid);
                SchemaBean bean = new SchemaBean();

                if (typeInfo == null){
                    typeInfo = functions
                            .stream()
                            .map(f -> f.apply(uuid))
                            .filter(types::containsKey)
                            .map(types::get)
                            .findFirst()
                            .orElse(null);
                }

                if (typeInfo == null){
                    //todo log warn: couldn't find type
                    bean.setType(Type.string);
                }else {
                    bean.setType(Type.fromXmlType(typeInfo.getType()));
                    bean.setFormat(Format.fromXmlType(typeInfo.getType()));
                    bean.setTitle(typeInfo.getDescription());
                    bean.setEnumeration(typeInfo.getEnumeration());

                    if (typeInfo.isRequired()){
                        required.add(k);
                    }
                }
                properties.put(k, bean);
            }
        });
        schemaBean.setProperties(properties);
        schemaBean.setRequired(required);

        return schemaBean;
    }


}
