package sx.microservices.xsd2inst;

import org.w3c.dom.Document;

import java.util.Map;

public class XmlInstance {
    private Document document;
    private String xml;
    private Map<String, TypeInfo> types;

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    public Map<String, TypeInfo> getTypes() {
        return types;
    }

    public void setTypes(Map<String, TypeInfo> types) {
        this.types = types;
    }

    public String getXml() {
        return xml;
    }

    public void setXml(String xml) {
        this.xml = xml;
    }
}
