package sx.microservices;

import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.impl.xsd2inst.SchemaInstanceGenerator;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.UUID;

public class Main {

    public static void main(String[] args) throws Exception {
        String elementName = "PensionsOnDateResponse";

        String schema = getSchema("schema/schema.xsd");
        String schema1 = getSchema("schema/commons/benefits-common-1.0.0.xsd");
        String schema2 = getSchema("schema/commons/smev-supplementary-commons-1.0.1.xsd");


        SchemaInstanceGenerator.Xsd2InstOptions options = new SchemaInstanceGenerator.Xsd2InstOptions();
        options.setNetworkDownloads(false);
        options.setNopvr(false);
        options.setNoupa(true);

        String[] schemas = {schema, schema1, schema2};
        String result = SchemaInstanceGenerator.xsd2inst(schemas, elementName, options);
        Document document = toDocument(result);
        setGuids(document);

        Document transformed = xslTransform(document);

        result = toString(transformed);



        System.out.println(result);
    }

    private static String getSchema(String path) throws IOException{
        InputStream inputStream = ClassLoader.getSystemResource(path).openStream();
        try(inputStream){
            return new String(inputStream.readAllBytes());
        }
    }

    private static void setGuids(Document document) throws XPathExpressionException {
        XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[count(./*) = 0]");
        NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
        for (int i = 0; i< nodeList.getLength(); i++){
            Node node = nodeList.item(i);
            node.setTextContent(UUID.randomUUID().toString());
        }
    }


    private static Document xslTransform(Document document) throws IOException, TransformerException{
        TransformerFactory factory = TransformerFactory.newInstance();
        InputStream inputStream = ClassLoader.getSystemResource("templates/response.xsl").openStream();
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


    private static Document toDocument(String xml) throws ParserConfigurationException, SAXException, IOException {
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
        documentBuilderFactory.setNamespaceAware(true);
        documentBuilderFactory.setCoalescing(true);
        documentBuilderFactory.setIgnoringElementContentWhitespace(true);
        DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
        return documentBuilder.parse(new ByteArrayInputStream(xml.getBytes()));
    }

    private static String toString(Document document) throws TransformerException {
        Transformer transformer = TransformerFactory.newInstance().newTransformer();
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
        StringWriter sw = new StringWriter();
        transformer.transform(new DOMSource(document), new StreamResult(sw));
        return sw.toString();
    }

}


