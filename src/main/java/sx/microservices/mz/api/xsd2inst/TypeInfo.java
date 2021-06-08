package sx.microservices.mz.api.xsd2inst;

import javax.xml.namespace.QName;

public class TypeInfo {
    private String uuid;
    private String type;
    private QName qName;
    private String description;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public QName getqName() {
        return qName;
    }

    public void setqName(QName qName) {
        this.qName = qName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
