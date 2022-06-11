package ru.systematica_consulting.mz.api;

import lombok.SneakyThrows;

import java.io.*;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileUtils {

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
  public static OutputStream getFileOutputStream(String path) {
    try {
      return new FileOutputStream(path);
    } catch (FileNotFoundException e) {
      String path1 = ClassLoader.getSystemResource(path).getPath();
      path1 = path1.replace("build", "src");
      path1 = path1.replace("test", "resources");
      path1 = path1.replaceFirst("resources", "test");
      return new FileOutputStream(path1);
    }
  }

  @SneakyThrows
  public static void writeFile(String path, byte[] content){
    try (OutputStream outputStream = getFileOutputStream(path);){
      outputStream.write(content);
    }
  }

  @SneakyThrows
  public static byte[] getFileContent(String path) {
    InputStream inputStream = getFileInputStream(path);
    try (inputStream) {
      return inputStream.readAllBytes();
    }
  }

  public static String[] getSchemas(String schemaPath, String elementName) throws IOException {
    Path path = Paths.get(schemaPath);
    if (!Files.exists(path)) {
      URL systemResource = ClassLoader.getSystemResource(schemaPath);
      if (systemResource == null) {
        throw new FileNotFoundException(schemaPath + " not found");
      }
      path = new File(systemResource.getFile()).toPath();
    }
    return Files.find(path.getParent(), Integer.MAX_VALUE, (p, a) -> p.toString().endsWith(".xsd"))
      .map(p -> {
        try {
          return Files.readString(p);
        } catch (IOException e) {
          throw new RuntimeException(e);
        }
      })
      .toArray(String[]::new);
  }
}
