package sx.microservices.mz.api;

import lombok.Data;

@Data
public class Config {
  RequestConfig request;
  ResponseConfig response;
}
