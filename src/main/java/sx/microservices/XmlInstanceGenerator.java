package sx.microservices;

import org.apache.xmlbeans.XmlException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import sx.microservices.xsd2inst.SchemaInstanceGenerator;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.IOException;
import java.io.InputStream;
import java.util.Set;

public class XmlInstanceGenerator {

    private final Converter converter;
    private final XsdTypeExtracter xsdTypeExtracter;

    public XmlInstanceGenerator(Converter converter) {
        this.converter = converter;
        this.xsdTypeExtracter = new XsdTypeExtracter();
    }

    public Document createInstance() throws IOException, XmlException, SAXException, ParserConfigurationException, XPathExpressionException {
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
        Document document = converter.toDocument(result);
        replaceComments(document);


        xsdTypeExtracter.extract(schemas, elementName);

        return document;
    }

    private String getSchema(String path) throws IOException {
        InputStream inputStream = ClassLoader.getSystemResource(path).openStream();
        try(inputStream){
            return new String(inputStream.readAllBytes());
        }
    }





    private void replaceComments(Document document) throws XPathExpressionException {
        Set<String> plentyNodes = Set.of("1 or more repetitions:", "Zero or more repetitions:");
        XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//comment()");
        NodeList nodeList;
        do {
            nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (plentyNodes.contains(node.getTextContent())) {
                    Node cloneNode = node.getNextSibling().getNextSibling().cloneNode(true);
                    Node parentNode = node.getParentNode();
                    parentNode.appendChild(cloneNode);
                    parentNode.removeChild(node);
                } else {
                    Node parentNode = node.getParentNode();
                    parentNode.removeChild(node);
                }
            }
        }while (nodeList.getLength() != 0);
    }
}
