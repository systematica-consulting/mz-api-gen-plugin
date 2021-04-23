package sx.microservices;

import org.json.JSONObject;
import org.w3c.dom.Document;
import sx.microservices.xsd2inst.XmlInstance;
import sx.microservices.xsd2inst.XmlInstanceGenerator;

public class Main {

    public static void main(String[] args) throws Exception {
        Converter converter = new Converter();
        XslTransformer transformer = new XslTransformer();
        XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);


        XmlInstance xmlInstance = xmlInstanceGenerator.createInstance();

        Document transformed = transformer.transform(xmlInstance.getDocument());

        JSONObject jsonObject = converter.toJson(transformed);

        System.out.println(jsonObject);
    }

}


