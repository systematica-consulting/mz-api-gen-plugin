package sx.microservices.mz.api;

import lombok.SneakyThrows;
import org.w3c.dom.Document;

import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class XslTransformer {

  private final String templatePath;

  public XslTransformer(String templatePath) {
    this.templatePath = templatePath;
  }

  @SneakyThrows
  public Document transform(Document document)  {
    TransformerFactory factory = TransformerFactory.newInstance();

    InputStream inputStream = FileUtils.getFileInputStream(templatePath);
    try (inputStream) {
      Source xslt = new StreamSource(inputStream);
      Source data = new DOMSource(document);
      DOMResult result = new DOMResult();
      Transformer transformer = factory.newTransformer(xslt);
      transformer.setParameter("headers", new HashMap<>());
      transformer.transform(data, result);
      return (Document) result.getNode();
    }
  }

  @SneakyThrows
  public Map<String, String> transformToMap(Document document)  {
    TransformerFactory factory = TransformerFactory.newInstance();
    InputStream inputStream = Objects.requireNonNull(getClass().getClassLoader().getResource("toMapTemplate.xsl"))
      .openStream();
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    try (inputStream) {
      Source xslt = new StreamSource(inputStream);
      Source data = new DOMSource(document);
      StreamResult result = new StreamResult(baos);
      Transformer transformer = factory.newTransformer(xslt);
      transformer.transform(data, result);
    }
    String res = new String(baos.toByteArray());
    Map<String, String> result = new HashMap<>();
    Arrays.stream(res.split("\\r?\\n")).forEach(s -> {
      String[] parts = s.split("=");
      if (parts.length == 2) {
        result.put(parts[0], parts[1]);
      }
    });

    return result;
  }
}
