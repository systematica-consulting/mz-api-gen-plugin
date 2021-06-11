package sx.microservices.mz.api.xsd2inst;

import lombok.Data;

import javax.xml.namespace.QName;
import java.util.List;

@Data
public class TypeInfo {
    private String uuid;
    private String type;
    private QName qName;
    private List<String> enumeration;
    private String description;
    private boolean required;
}
