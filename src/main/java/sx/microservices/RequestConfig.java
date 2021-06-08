package sx.microservices;

import lombok.Data;

@Data
class RequestConfig {
    private String template;
    private String element;
    private String schema;
    private String request;
    private String out;

    public boolean isFull(){
        return template != null && element != null && schema != null && request != null && out != null;
    }
}
