package sx.microservices.mz.api.schema;

import com.fasterxml.jackson.annotation.JsonProperty;

enum Type {
    string, array, object, number, integer, date,
    @JsonProperty("boolean")
    _boolean;

    public static Type fromXmlType(String type){
        switch (type){
            case "XmlString":
                return string;
            case "XmlDecimal":
                return number;
            case "XmlDate":
                return date;
            case "XmlInt":
                return integer;
            case "XmlBoolean":
                return _boolean;
            default:
                throw new RuntimeException("Failed to define type: " + type);
        }
    }
}
