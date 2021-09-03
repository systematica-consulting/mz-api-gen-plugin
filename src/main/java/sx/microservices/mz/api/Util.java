package sx.microservices.mz.api;

import lombok.SneakyThrows;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.net.URL;

public class Util {

  @SneakyThrows
  public static InputStream getFileInputStream(String path) {
    try {
      return new FileInputStream(path);
    } catch (FileNotFoundException e) {
      URL systemResource = ClassLoader.getSystemResource(path);
      if (systemResource == null) {
        throw e;
      }
      return systemResource.openStream();
    }
  }

  @SneakyThrows
  public static byte[] getFileContent(String path) {
    InputStream inputStream = getFileInputStream(path);
    try (inputStream) {
      return inputStream.readAllBytes();
    }
  }
}
