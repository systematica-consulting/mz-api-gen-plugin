package sx.microservices.mz.api.schema;

import com.fasterxml.jackson.annotation.JsonProperty;

enum Type {
    string, array, object, number, integer, @JsonProperty("boolean") _boolean;

    public static Type fromXmlType(String type){
        switch (type){
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
}
