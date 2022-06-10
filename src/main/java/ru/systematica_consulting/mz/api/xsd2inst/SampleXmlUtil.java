package ru.systematica_consulting.mz.api.xsd2inst;


import org.apache.xmlbeans.*;
import org.apache.xmlbeans.impl.schema.SchemaParticleImpl;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import ru.systematica_consulting.mz.api.schema.XmlType;

import java.util.*;
import java.util.stream.Collectors;

class SampleXmlUtil {
  private static final int MAX_ELEMENTS = 1000;
  private int _nElements;
  private final Map<String, XmlType> types = new HashMap<>();

  private SampleXmlUtil() {
  }

  public static XmlInstance createSampleForType(SchemaType sType) {
    XmlObject object = XmlObject.Factory.newInstance();
    XmlCursor cursor = object.newCursor();
    // Skip the document node
    cursor.toNextToken();
    // Using the type and the cursor, call the utility method to get a
    // sample XML payload for that Schema element
    Map<String, XmlType> types = new SampleXmlUtil().createSampleForType(sType, cursor);
    // Cursor now contains the sample payload
    // Pretty print the result.  Note that the cursor is positioned at the
    // end of the doc so we use the original xml object that the cursor was
    // created upon to do the xmlText() against.
    XmlOptions options = new XmlOptions();
    options.setSavePrettyPrint();
    options.setSavePrettyPrintIndent(2);
    options.setSaveAggressiveNamespaces();

    XmlInstance instance = new XmlInstance();
    instance.setXml(object.xmlText(options));
    instance.setTypes(types);
    return instance;
  }

  Random _picker = new Random(1);

  /**
   * Cursor position
   * Before:
   * <theElement>^</theElement>
   * After:
   * <theElement><lots of stuff/>^</theElement>
   */
  private Map<String, XmlType> createSampleForType(SchemaType stype, XmlCursor xmlc) {
    if (_typeStack.contains(stype)) {
      return this.types;
    }

    _typeStack.add(stype);

    try {
      if (stype.isSimpleType() || stype.isURType()) {
        processSimpleType(stype, xmlc);
        return this.types;
      }

      // complex Type
      // <theElement>^</theElement>
      processAttributes(stype, xmlc);

      // <theElement attri1="string">^</theElement>
      switch (stype.getContentType()) {
        case SchemaType.NOT_COMPLEX_TYPE:
        case SchemaType.EMPTY_CONTENT:
          // noop
          break;
        case SchemaType.SIMPLE_CONTENT: {
          processSimpleType(stype, xmlc);
        }
        break;
        case SchemaType.MIXED_CONTENT:
          xmlc.insertChars(pick(WORDS) + " ");
          if (stype.getContentModel() != null) {
            processParticle(stype.getContentModel(), xmlc, true);
          }
          xmlc.insertChars(pick(WORDS));
          break;
        case SchemaType.ELEMENT_CONTENT:
          if (stype.getContentModel() != null) {
            processParticle(stype.getContentModel(), xmlc, false);
          }
          break;
      }
    } finally {
      _typeStack.remove(_typeStack.size() - 1);
    }
    return this.types;
  }

  private void processSimpleType(SchemaType stype, XmlCursor xmlc) {
    String sample = sampleDataForSimpleType(stype);
    xmlc.insertChars(sample);
  }

  private String sampleDataForSimpleType(SchemaType sType) {
    return UUID.randomUUID().toString();
  }

  // a bit from the Aenid
  private static final String[] WORDS = {
    "ipsa", "iovis", "rapidum", "iaculata", "e", "nubibus", "ignem",
    "disiecitque", "rates", "evertitque", "aequora", "ventis",
    "illum", "exspirantem", "transfixo", "pectore", "flammas",
    "turbine", "corripuit", "scopuloque", "infixit", "acuto",
    "ast", "ego", "quae", "divum", "incedo", "regina", "iovisque",
    "et", "soror", "et", "coniunx", "una", "cum", "gente", "tot", "annos",
    "bella", "gero", "et", "quisquam", "numen", "iunonis", "adorat",
    "praeterea", "aut", "supplex", "aris", "imponet", "honorem",
    "talia", "flammato", "secum", "dea", "corde", "volutans",
    "nimborum", "in", "patriam", "loca", "feta", "furentibus", "austris",
    "aeoliam", "venit", "hic", "vasto", "rex", "aeolus", "antro",
    "luctantis", "ventos", "tempestatesque", "sonoras",
    "imperio", "premit", "ac", "vinclis", "et", "carcere", "frenat",
    "illi", "indignantes", "magno", "cum", "murmure", "montis",
    "circum", "claustra", "fremunt", "celsa", "sedet", "aeolus", "arce",
    "sceptra", "tenens", "mollitque", "animos", "et", "temperat", "iras",
    "ni", "faciat", "maria", "ac", "terras", "caelumque", "profundum",
    "quippe", "ferant", "rapidi", "secum", "verrantque", "per", "auras",
    "sed", "pater", "omnipotens", "speluncis", "abdidit", "atris",
    "hoc", "metuens", "molemque", "et", "montis", "insuper", "altos",
    "imposuit", "regemque", "dedit", "qui", "foedere", "certo",
    "et", "premere", "et", "laxas", "sciret", "dare", "iussus", "habenas",
  };


  private static final String[] DNS1 = new String[]{"corp", "your", "my", "sample", "company", "test", "any"};
  private static final String[] DNS2 = new String[]{"com", "org", "com", "gov", "org", "com", "org", "com", "edu"};

  private int pick(int n) {
    return _picker.nextInt(n);
  }

  private String pick(String[] a) {
    return a[pick(a.length)];
  }

  /**
   * Cursor position:
   * Before this call:
   * <outer><foo/>^</outer>  (cursor at the ^)
   * After this call:
   * <<outer><foo/><bar/>som text<etc/>^</outer>
   */
  private void processParticle(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
    int loop = determineMinMaxForSample(sp, xmlc);

    while (loop-- > 0) {
      switch (sp.getParticleType()) {
        case (SchemaParticle.ELEMENT):
          processElement(sp, xmlc, mixed);
          break;
        case (SchemaParticle.SEQUENCE):
          processSequence(sp, xmlc, mixed);
          break;
        case (SchemaParticle.CHOICE):
          processChoice(sp, xmlc, mixed);
          break;
        case (SchemaParticle.ALL):
          processAll(sp, xmlc, mixed);
          break;
        case (SchemaParticle.WILDCARD):
          processWildCard(sp, xmlc, mixed);
          break;
        default:
          // throw new Exception("No Match on Schema Particle Type: " + String.valueOf(sp.getParticleType()));
      }
    }
  }

  private int determineMinMaxForSample(SchemaParticle sp, XmlCursor xmlc) {
    int minOccurs = sp.getIntMinOccurs();
    int maxOccurs = sp.getIntMaxOccurs();

    if (minOccurs == maxOccurs) {
      return minOccurs;
    }

    int result = minOccurs;
    if (result == 0 && _nElements < MAX_ELEMENTS) {
      result = 1;
    }

    if (sp.getParticleType() != SchemaParticle.ELEMENT) {
      return result;
    }

    // it probably only makes sense to put comments in front of individual elements that repeat

    if (sp.getMaxOccurs() == null) {
      // xmlc.insertComment("The next " + getItemNameOrType(sp, xmlc) + " may be repeated " + minOccurs + " or more times");
      if (minOccurs == 0) {
        xmlc.insertComment("Zero or more repetitions:");
      } else {
        xmlc.insertComment(minOccurs + " or more repetitions:");
      }
    } else if (sp.getIntMaxOccurs() > 1) {
      xmlc.insertComment(minOccurs + " to " + sp.getMaxOccurs() + " repetitions:");
    } else {
      xmlc.insertComment("Optional:");
    }
    return result;
  }

  private void processElement(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
    // cast as schema local element
    SchemaLocalElement element = (SchemaLocalElement) sp;
    /// ^  -> <elemenname></elem>^
    xmlc.insertElement(element.getName().getLocalPart(), element.getName().getNamespaceURI());

    _nElements++;
    /// -> <elem>^</elem>
    xmlc.toPrevToken();
    // -> <elem>stuff^</elem>

    SchemaType elementType = element.getType();
    createSampleForType(elementType, xmlc);

    if (elementType.isSimpleType() || elementType.isURType() ||
      elementType.getContentType() == SchemaType.SIMPLE_CONTENT) {
      String uuid = xmlc.getDomNode().getFirstChild().getNodeValue();
      putType(uuid, elementType, element, xmlc);
    }else {
      putElementInfo(elementType, element, xmlc);
    }

    xmlc.toNextToken();

  }

  private void putElementInfo(SchemaType elementType, SchemaLocalElement element, XmlCursor cursor){
    String uuid = UUID.randomUUID().toString();
    boolean required = element.getMinOccurs().intValue() > 0;
    boolean list = element.getMaxOccurs() == null || element.getMaxOccurs().intValue() > 1;

    String description = retrieveDescription(element);
    if (description == null) {
      description = retrieveDescription(elementType);
    }

    XmlType xmlType = new XmlType();
    xmlType.setUuid(uuid);
    xmlType.setRequired(required);
    xmlType.setList(list);
    xmlType.setType("XmlObject");
    xmlType.setDescription(description);
    xmlType.setElementAddress(getElementAddress(cursor, element));

    types.put(uuid, xmlType);
  }

  private String getElementAddress(XmlCursor cursor, SchemaField element){
    StringBuilder result = new StringBuilder();
    Node node = cursor.getDomNode();
    do {
      result
        .insert(0, node.getNodeName())
        .insert(0, "/");
      node = node.getParentNode();
    }while (node.getLocalName() != null);
    if (element.isAttribute()){
      result.append("/@").append(element.getName());
    }
    return result.toString();
  }


  private void putType(String uuid, SchemaType elementType, SchemaAnnotated element, XmlCursor cursor) {
    String type;
    SchemaType primitiveType = elementType.getPrimitiveType();
    if (primitiveType == null) { // всякие unions
      if (elementType.isNumeric()) {
        type = "XmlDecimal";
      } else {
        type = "XmlString";
      }
    } else {
      type = elementType.getPrimitiveType().getShortJavaName();
    }
    if ("XmlDecimal".equals(type)) {
      int size = elementType.getDecimalSize();
      if (size == SchemaType.SIZE_LONG || size == SchemaType.SIZE_BIG_INTEGER) {
        type = "XmlLong";
      } else if (size == SchemaType.SIZE_INT || size == SchemaType.SIZE_SHORT || size == SchemaType.SIZE_BYTE) {
        type = "XmlInt";
      }
    }

    String description = retrieveDescription(element);
    if (description == null) {
      description = retrieveDescription(elementType);
    }

    XmlType xmlType = new XmlType();

    if (elementType.getEnumerationValues() != null && elementType.getEnumerationValues().length != 0) {
      XmlAnySimpleType[] values = elementType.getEnumerationValues();
      List<String> vals = new ArrayList<>();
      Arrays.stream(values).forEach(v -> vals.add(v.getStringValue()));
      xmlType.setEnumeration(vals);
    }

    SchemaField field = (SchemaField) element;

    boolean required = field.getMinOccurs().intValue() > 0;
    boolean list = field.getMaxOccurs() == null || field.getMaxOccurs().intValue() > 1;

    xmlType.setUuid(uuid);
    xmlType.setDescription(description);
    xmlType.setType(type);
    xmlType.setRequired(required);
    xmlType.setList(list);
    xmlType.setElementAddress(getElementAddress(cursor, field));
    types.put(uuid, xmlType);
  }

  private String retrieveDescription(SchemaAnnotated element) {
    SchemaAnnotation annotation = element.getAnnotation();
    if (annotation == null) return null;
    StringBuilder sb = new StringBuilder();
    Arrays.stream(annotation.getUserInformation()).forEach(xmlObject -> {
      Node docInfo = xmlObject.getDomNode();
      NodeList list = docInfo.getChildNodes();
      for (int i = 0; i < list.getLength(); i++) {
        Node c = list.item(i);
        if (c.getNodeType() == Node.TEXT_NODE) {
          String str = c.getNodeValue();
          if (sb.length() != 0){
            sb.append(". ");
          }
          sb.append(str.trim());
          break;
        }
      }
    });
    String result = sb.toString();
    if (result.isBlank()){
      return null;
    }
    result = Arrays.stream(result.split("\n")).map(String::strip).collect(Collectors.joining(" "));
    return result;
  }


  private void processAttributes(SchemaType stype, XmlCursor xmlc) {
    SchemaLocalAttribute[] attributes = stype.getAttributeModel().getAttributes();
    for (SchemaLocalAttribute attr : attributes) {
      String uuid = sampleDataForSimpleType(attr.getType());
      xmlc.insertAttributeWithValue(attr.getName(), uuid);
      putType(uuid, attr.getType(), attr, xmlc);
    }
  }

  private void processSequence(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
    SchemaParticle[] spc = sp.getParticleChildren();
    for (int i = 0; i < spc.length; i++) {
      /// <parent>maybestuff^</parent>
      processParticle(spc[i], xmlc, mixed);
      //<parent>maybestuff...morestuff^</parent>
      if (mixed && i < spc.length - 1) {
        xmlc.insertChars(pick(WORDS));
      }
    }
  }

  private void processChoice(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
    SchemaParticle[] spc = sp.getParticleChildren();
    xmlc.insertComment("You have a CHOICE of the next " + spc.length + " items at this level");
    for (SchemaParticle schemaParticle : spc) {
      if (sp.getMaxOccurs() == null) {
        ((SchemaParticleImpl) schemaParticle).setMaxOccurs(null);
      }
      processParticle(schemaParticle, xmlc, mixed);
    }
  }

  private void processAll(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
    SchemaParticle[] spc = sp.getParticleChildren();
    // xmlc.insertComment("You may enter the following " + String.valueOf(spc.length) + " items in any order");
    for (int i = 0; i < spc.length; i++) {
      processParticle(spc[i], xmlc, mixed);
      if (mixed && i < spc.length - 1) {
        xmlc.insertChars(pick(WORDS));
      }
    }
  }

  private void processWildCard(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
    xmlc.insertComment("You may enter ANY elements at this point");
    xmlc.insertElement("AnyElement");
  }

  private final ArrayList<SchemaType> _typeStack = new ArrayList<>();
}
