package sx.microservices.mz.api.xsd2inst;

import org.apache.xmlbeans.XmlException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import sx.microservices.mz.api.Converter;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;

public class XmlInstanceGenerator {

  public XmlInstance createInstance(String schemaPath, String elementName) throws IOException, XmlException {

    Path path = Paths.get(schemaPath);
    if (!Files.exists(path)) {
      URL systemResource = ClassLoader.getSystemResource(schemaPath);
      if (systemResource == null) {
        throw new FileNotFoundException(schemaPath + " not found");
      }
      path = new File(systemResource.getFile()).toPath();
    }
    String[] schemas = Files.find(path.getParent(), Integer.MAX_VALUE, (p, a) -> p.toString().endsWith(".xsd"))
      .map(p -> {
        try {
          return Files.readString(p);
        } catch (IOException e) {
          throw new RuntimeException(e);
        }
      })
      .toArray(String[]::new);

    SchemaInstanceGenerator.Xsd2InstOptions options = new SchemaInstanceGenerator.Xsd2InstOptions();
    options.setNetworkDownloads(false);
    options.setNopvr(false);
    options.setNoupa(true);

    return SchemaInstanceGenerator.xsd2inst(schemas, elementName, options);
  }

}
