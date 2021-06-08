package sx.microservices.mz.api;

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
