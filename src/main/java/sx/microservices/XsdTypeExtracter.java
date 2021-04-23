package sx.microservices;

import org.apache.xmlbeans.*;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class XsdTypeExtracter {

    public void extract(String[] schemas, String rootElem) throws XmlException{
        XmlObject[] xmlObjects = Arrays.stream(schemas).map(s -> {
            try {
                return XmlObject.Factory.parse(s);
            } catch (XmlException e) {
                throw new RuntimeException(e);
            }
        }).toArray(XmlObject[]::new);

        //todo смотрим как работает генерация инстанса и вместо генераци достаем типы
        System.out.println("ds");
    }

    private void setGuids(Document document) throws XPathExpressionException {
        XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[count(./*) = 0]");
        NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
        for (int i = 0; i< nodeList.getLength(); i++){
            Node node = nodeList.item(i);

            node.setTextContent(UUID.randomUUID().toString());
        }
    }
}
