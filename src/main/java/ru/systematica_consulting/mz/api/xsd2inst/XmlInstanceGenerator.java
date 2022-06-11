package ru.systematica_consulting.mz.api.xsd2inst;

import org.apache.xmlbeans.*;
import ru.systematica_consulting.mz.api.FileUtils;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

public class XmlInstanceGenerator {

  public XmlInstance createInstance(String schemaPath, String elementName) throws IOException {
    String[] schemas = FileUtils.getSchemas(schemaPath, elementName);
    Reader[] instReaders = new Reader[schemas.length];
    for (int i = 0; i < schemas.length; i++) {
      instReaders[i] = new StringReader(schemas[i]);
    }

    return createInstance(instReaders, elementName);
  }

  private XmlInstance createInstance(Reader[] schemaReaders, String rootName) {
    // Process Schema files
    List sdocs = new ArrayList();
    for (int i = 0; i < schemaReaders.length; i++) {
      try {
        sdocs.add(XmlObject.Factory.parse(schemaReaders[i],
          (new XmlOptions()).setLoadLineNumbers().setLoadMessageDigest()));
      } catch (Exception e) {
        System.err.println("Can not load schema reader: " + i + "  " + schemaReaders[i] + ": ");
        e.printStackTrace();
      }
    }

    XmlObject[] schemas = (XmlObject[]) sdocs.toArray(new XmlObject[sdocs.size()]);

    return createInstance(schemas, rootName);
  }


  private XmlInstance createInstance(XmlObject[] schemas, String rootName) {
    SchemaTypeSystem sts = null;
    if (schemas.length > 0) {
      XmlOptions compileOptions = new XmlOptions();
      compileOptions.setCompileNoUpaRule();

      try {
        sts = XmlBeans.compileXsd(schemas, XmlBeans.getBuiltinTypeSystem(), compileOptions);
      } catch (Exception e) {
        throw new RuntimeException(e);
      }
    }

    if (sts == null) {
      throw new RuntimeException("No Schemas to process.");
    }
    SchemaType[] globalElems = sts.documentTypes();
    SchemaType elem = null;
    for (int i = 0; i < globalElems.length; i++) {
      if (rootName.equals(globalElems[i].getDocumentElementName().getLocalPart())) {
        elem = globalElems[i];
        break;
      }
    }

    if (elem == null) {
      throw new RuntimeException("Could not find a global element with name \"" + rootName + "\"");
    }

    // Now generate it
    return SampleXmlUtil.createSampleForType(elem);
  }

}
