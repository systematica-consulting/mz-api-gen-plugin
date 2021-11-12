package ru.systematica_consulting.mz.api.json;

import com.fasterxml.jackson.annotation.JsonProperty;

public enum Format {
  date, @JsonProperty("date-time") dateTime, int32, int64, @JsonProperty("float") _float,
  @JsonProperty("double") _double;

  public static Format fromXmlType(String type) {
    switch (type) {
      case "XmlDateTime":
        return dateTime;
      case "XmlDate":
        return date;
      case "XmlFloat":
        return _float;
      case "XmlDouble":
      case "XmlDecimal":
        return _double;
      case "XmlInt":
        return int32;
      case "XmlLong":
        return int64;
      default:
        return null;
    }
  }

}
