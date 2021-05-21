package sx.microservices;

import lombok.Data;

@Data
public class Config {
    RequestConfig request;
    ResponseConfig response;
}
