package sx.microservices.schema;

import org.json.JSONArray;
import org.json.JSONObject;
import sx.microservices.xsd2inst.TypeInfo;

import java.util.HashMap;
import java.util.Map;

public class JsonSchemaGenerator {

    public SchemaBean generate(JSONObject jsonObject, String title, Map<String, TypeInfo> types){
        SchemaBean schemaBean = new SchemaBean();
        schemaBean.setTitle(title);
        schemaBean.setType(Type.object);

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
                    bean.setType(Type.string);
                }else {
                    bean.setType(Type.fromXmlType(typeInfo.getType()));
                    bean.setTitle(typeInfo.getDescription());
                }
                if (bean.getTitle() == null){
                    bean.setTitle("");
                }
                properties.put(k, bean);
            }
        });
        schemaBean.setProperties(properties);

        return schemaBean;
    }
}
