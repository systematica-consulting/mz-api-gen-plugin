package sx.microservices.mz.api.schema;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.mz.api.XslTransformer;
import sx.microservices.mz.api.xsd2inst.XmlInstance;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.util.*;

@Slf4j
public class ResponseSchemaGenerator extends XmlSchemaGenerator {

  public ResponseSchemaGenerator(XmlInstance xmlInstance, XslTransformer transformer) {
    super(transformer, xmlInstance);
  }


  public XmlSchema generate() {
    Document document = converter.toDocument(xml);
    Document transformed = transformer.transform(document);
    removeJsonAttrs(transformed);

    XmlSchema schema = _generate(transformed.getDocumentElement());
    fillObjectsTypes(schema);

    document = converter.toDocument(xml);
    duplicateArrayNodes(document);
    transformed = transformer.transform(document);
    removeJsonAttrs(transformed);
    Set<String> arrayNodes = findArrayNodes(transformed);
    setArrayType(schema, arrayNodes);

    return schema;
  }


  @SneakyThrows
  private void removeJsonAttrs(Document document) {
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[@_json]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    for (int i = 0; i < nodeList.getLength(); i++) {
      Element element = (Element) nodeList.item(i);
      element.removeAttribute("_json");
    }
  }

  @SneakyThrows
  private Set<String> findArrayNodes(Document document){
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[1]");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    Set<String> result = new HashSet<>();
    for (int i = 0; i< nodeList.getLength(); i++){
      Node sib = nodeList.item(i);
      Set<String> elementNames = new HashSet<>();
      do {
        if (sib instanceof Element){
          if (elementNames.contains(sib.getLocalName())){
            result.add(getElementAddress((Element) sib));
          }
          elementNames.add(sib.getLocalName());
        }
      } while ((sib = sib.getNextSibling()) != null);
    }
    return result;
  }

  private void setArrayType(XmlSchema xmlSchema, Set<String> arrayNodes){
    if (arrayNodes.contains(xmlSchema.getElementAddress())){
      xmlSchema.getType().setList(true);
    }
    if (xmlSchema.getChildren() != null){
      xmlSchema.getChildren().values().forEach(s -> setArrayType(s, arrayNodes));
    }
  }

  @SneakyThrows
  private void duplicateArrayNodes(Document document){
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//comment()");
    NodeList nodeList;
    do {
      nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
      for (int i = 0; i < nodeList.getLength(); i++) {
        Node node = nodeList.item(i);
        if (node.getTextContent() != null && node.getTextContent().contains("repetitions:")) {
          Node cloneNode = node.getNextSibling().getNextSibling().cloneNode(true);
          Node parentNode = node.getParentNode();
          parentNode.appendChild(cloneNode);
          parentNode.removeChild(node);
        } else {
          Node parentNode = node.getParentNode();
          parentNode.removeChild(node);
        }
      }
    } while (nodeList.getLength() != 0);
  }

}
