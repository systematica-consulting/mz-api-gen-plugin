package sx.microservices.mz.api.config;

import lombok.Data;

@Data
public class Config {
  RequestConfig request;
  ResponseConfig response;
}
