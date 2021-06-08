package sx.microservices;

import lombok.Data;

@Data
class ResponseConfig {
    private String template;
    private String element;
    private String schema;
    private String out;

    public boolean isFull(){
        return template != null && element != null && schema != null && out != null;
    }
}
