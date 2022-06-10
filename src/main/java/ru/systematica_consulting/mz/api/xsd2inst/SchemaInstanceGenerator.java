package ru.systematica_consulting.mz.api.xsd2inst;

import org.apache.xmlbeans.*;

import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

class SchemaInstanceGenerator {

  public static XmlInstance xsd2inst(String[] xsds, String rootName) {
    Reader[] instReaders = new Reader[xsds.length];
    for (int i = 0; i < xsds.length; i++) {
      instReaders[i] = new StringReader(xsds[i]);
    }

    return xsd2inst(instReaders, rootName);
  }


  private static XmlInstance xsd2inst(Reader[] schemaReaders, String rootName) {
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

    return xsd2inst(schemas, rootName);
  }


  private static XmlInstance xsd2inst(XmlObject[] schemas, String rootName) {
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
