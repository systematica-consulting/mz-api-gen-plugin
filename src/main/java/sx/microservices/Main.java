package sx.microservices;

import org.json.JSONObject;
import org.w3c.dom.Document;

public class Main {

    public static void main(String[] args) throws Exception {
        Converter converter = new Converter();
        XslTransformer transformer = new XslTransformer();
        XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);


        Document document = xmlInstanceGenerator.createInstance();

        Document transformed = transformer.transform(document);

        JSONObject jsonObject = converter.toJson(transformed);


        System.out.println(jsonObject);
    }

}


