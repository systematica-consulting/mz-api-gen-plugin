package ru.systematica_consulting.mz.api;

import lombok.SneakyThrows;
import org.json.JSONObject;
import org.json.XML;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;

public class Converter {

  @SneakyThrows
  public Document toDocument(String xml) {
    DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
    documentBuilderFactory.setNamespaceAware(true);
    documentBuilderFactory.setCoalescing(true);
    documentBuilderFactory.setIgnoringElementContentWhitespace(true);
    DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
    return documentBuilder.parse(new ByteArrayInputStream(xml.getBytes()));
  }

  @SneakyThrows
  public String toString(Document document) {
    Transformer transformer = TransformerFactory.newInstance().newTransformer();
    transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
    StringWriter sw = new StringWriter();
    transformer.transform(new DOMSource(document), new StreamResult(sw));
    return sw.toString();
  }

  public JSONObject toJson(Document document) {
    JSONObject jsonObject = XML.toJSONObject(toString(document));
    return jsonObject.has("params") ? jsonObject.getJSONObject("params") : jsonObject;
  }
}
