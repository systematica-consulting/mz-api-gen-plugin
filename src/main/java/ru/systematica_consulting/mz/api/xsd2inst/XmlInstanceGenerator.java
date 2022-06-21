package ru.systematica_consulting.mz.api.xsd2inst;

import lombok.extern.slf4j.Slf4j;
import org.apache.xmlbeans.*;
import ru.systematica_consulting.mz.api.FileUtils;

import java.io.IOException;

@Slf4j
public class XmlInstanceGenerator {

  public XmlInstance createInstance(String schemaPath, String elementName) throws IOException {
    XmlObject[] schemas = FileUtils.getSchemas(schemaPath);
    return createInstance(schemas, elementName);
  }

  public XmlInstance createInstance(XmlObject[] schemas, String rootName) {
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
    for (SchemaType globalElem : globalElems) {
      if (rootName.equals(globalElem.getDocumentElementName().getLocalPart())) {
        elem = globalElem;
        break;
      }
    }

    if (elem == null) {
      throw new RuntimeException("Could not find a global element with name \"" + rootName + "\"");
    }

    return new SampleXmlUtil().createSampleForType(elem);
  }

}
