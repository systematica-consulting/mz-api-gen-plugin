package sx.microservices;

import org.w3c.dom.Document;

import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

public class XslTransformer {

    public Document transform(Document document, String templatePath) throws IOException, TransformerException {
        TransformerFactory factory = TransformerFactory.newInstance();
        InputStream inputStream = ClassLoader.getSystemResource(templatePath).openStream();
        try(inputStream){
            Source xslt = new StreamSource(inputStream);
            Source data = new DOMSource(document);
            DOMResult result = new DOMResult();
            Transformer transformer = factory.newTransformer(xslt);
            transformer.setParameter("headers", new HashMap<>());
            transformer.transform(data, result);
            return (Document) result.getNode();
        }

    }
}
