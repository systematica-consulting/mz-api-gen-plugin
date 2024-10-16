package ru.systematica_consulting.mz.api.schema;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.xmlbeans.XmlException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import ru.systematica_consulting.mz.api.FileUtils;
import ru.systematica_consulting.mz.api.XslTransformer;
import ru.systematica_consulting.mz.api.xsd2inst.XmlInstanceGenerator;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
public class ResponseSchemaGenerator extends XmlSchemaGenerator {

  public ResponseSchemaGenerator(String schemaPath, String element, String templatePath) throws IOException, XmlException {
    super(new XmlInstanceGenerator().createInstance(schemaPath, element), templatePath);
  }


  public XmlElement generate() {
    byte[] whenTemplate = createWhenTemplate(templatePath);

    XslTransformer transformer = new XslTransformer(whenTemplate);
    Document document = converter.toDocument(xml);
    Document transformed = transformer.transform(document);
    removeJsonAttrs(transformed);
    noArrayElements = findArrayNodes(transformed);

    XmlElement schema = generate(transformed.getDocumentElement());

    document = converter.toDocument(xml);
    duplicateArrayNodes(document);
    transformed = transformer.transform(document);
    removeJsonAttrs(transformed);
    Set<String> arrayNodes = findArrayNodes(transformed);
    setArrayType(schema, arrayNodes);


    if (!notFoundedTypes.isEmpty()) {
      System.out.println("\nNot founded type for:");
      notFoundedTypes.stream().sorted(Comparator.comparing(s -> s)).forEach(System.out::println);
    }

    List<String> noMatch = guidTypeMap.entrySet().stream().filter(e -> !e.getValue().getType().equals("XmlObject") && !foundedGuids.contains(e.getKey()))
      .map(e -> e.getValue().getElementAddress())
      .sorted(Comparator.comparing(s -> s)).collect(Collectors.toList());
    if (!noMatch.isEmpty()){
      System.out.println("\nNo match for:");
      noMatch.forEach(System.out::println);
    }

    return schema;
  }

  private byte[] createWhenTemplate(String templatePath) {
    byte[] templateContent = FileUtils.getFileContent(templatePath);
    Document document = converter.toDocument(new String(templateContent));
    replaceChooseNodes(document);
    return converter.toString(document).getBytes(StandardCharsets.UTF_8);
  }


  @SneakyThrows
  private void replaceChooseNodes(Document document) {
    XPathExpression xpath = XPathFactory.newInstance().newXPath().compile("//*[name()='xsl:choose' or name()='xsl:when' or name()='xsl:otherwise'] ");
    NodeList nodeList = (NodeList) xpath.evaluate(document, XPathConstants.NODESET);
    for (int i = 0; i< nodeList.getLength(); i++){
      Element element = (Element)nodeList.item(i);
      if (element.getLocalName().equals("when")){
        document.renameNode(element, element.getNamespaceURI(), "xsl:if");
      }
      if (element.getLocalName().equals("choose") ){
        document.renameNode(element, element.getNamespaceURI(), "xsl:if");
        element.setAttribute("test", "boolean(1)");
      }
      if (element.getLocalName().equals("otherwise")){
        document.renameNode(element, element.getNamespaceURI(), "xsl:if");
        boolean containElements = false;
        NodeList childNodes = element.getChildNodes();
        for (int j = 0; j< childNodes.getLength(); j ++){//ппц
          if (childNodes.item(j) instanceof Element && !"xsl:value-of".equals(childNodes.item(j).getNodeName())){
            containElements = true;
          }
        }
        if (containElements){
          element.setAttribute("test", "boolean(1)");
        }else {
          element.setAttribute("test", "boolean(0)");
        }
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
