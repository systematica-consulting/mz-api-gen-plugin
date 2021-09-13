package sx.microservices.mz.api.schema;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sx.microservices.mz.api.FileUtils;
import sx.microservices.mz.api.XslTransformer;
import sx.microservices.mz.api.xsd2inst.XmlInstance;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.util.*;

@Slf4j
public class ResponseSchemaGenerator extends XmlSchemaGenerator {

  public ResponseSchemaGenerator(XmlInstance xmlInstance, String templatePath) {
    super(xmlInstance, templatePath);
  }


  public XmlSchema generate() {
    byte[] fullTemplate = createFullTemplate(templatePath);

    XslTransformer transformer = new XslTransformer(templatePath);
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

  private byte[] createFullTemplate(String templatePath) {
    byte[] templateContent = FileUtils.getFileContent(templatePath);
    Document document = converter.toDocument(new String(templateContent));
    removeUnkosherNodes(document);
    return new byte[0];
  }

  /**
   * Удалить все if, when node из шаблона, смерджить их контент, если он задублируется.
   * Чтобы преобразование было полным
   * @param document doc
   */
  @SneakyThrows
  private void removeUnkosherNodes(Document document) {
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[name()='xsl:choose' or name()='xsl:when' or name()='xsl:otherwise'] ");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    for (int i = 0; i< nodeList.getLength(); i++){
      Element element = (Element)nodeList.item(i);
      if (element.getLocalName().equals("when")){
        document.renameNode(element, element.getNamespaceURI(), "xsl:if");
      }
      if (element.getLocalName().equals("choose") || element.getLocalName().equals("otherwise")){
        document.renameNode(element, element.getNamespaceURI(), "xsl:if");
        element.setAttribute("test", "true");
      }

    }
    document.normalizeDocument();
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
