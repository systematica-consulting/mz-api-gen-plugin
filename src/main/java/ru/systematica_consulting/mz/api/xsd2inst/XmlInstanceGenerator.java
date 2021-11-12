package ru.systematica_consulting.mz.api.xsd2inst;

import org.apache.xmlbeans.XmlException;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

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
