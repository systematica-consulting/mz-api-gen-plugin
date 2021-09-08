package sx.microservices.mz.api.schema;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.ByteArrayOutputStream;

enum Type {
  string, array, object, number, integer, @JsonProperty("boolean") _boolean;

  public static Type fromXmlType(String type) {
    switch (type) {
      case "XmlObject":
        return object;
      case "XmlFloat":
      case "XmlDouble":
      case "XmlDecimal":
        return number;
      case "XmlLong":
      case "XmlInt":
        return integer;
      case "XmlBoolean":
        return _boolean;
      default:
        return string;
    }
  }


  public boolean isSimple(){
    return this == string || this == number || this == integer || this == _boolean;
  }
}
