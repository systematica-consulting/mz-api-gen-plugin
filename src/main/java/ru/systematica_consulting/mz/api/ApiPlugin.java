package ru.systematica_consulting.mz.api;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.gradle.api.Plugin;
import org.gradle.api.Project;
import org.gradle.api.plugins.ExtensionAware;
import ru.systematica_consulting.mz.api.config.Config;
import ru.systematica_consulting.mz.api.config.RequestConfig;
import ru.systematica_consulting.mz.api.config.ResponseConfig;
import ru.systematica_consulting.mz.api.json.JsonSchemaGenerator;
import ru.systematica_consulting.mz.api.json.SchemaBean;
import ru.systematica_consulting.mz.api.schema.RequestSchemaGenerator;
import ru.systematica_consulting.mz.api.schema.ResponseSchemaGenerator;
import ru.systematica_consulting.mz.api.schema.XmlSchema;

import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

@Slf4j
public class ApiPlugin implements Plugin<Project> {

  @Override
  public void apply(Project project) {
    Config config = project.getExtensions().create("apiGenerator", Config.class);
    RequestConfig requestConfig = ((ExtensionAware) config).getExtensions().create("request", RequestConfig.class);
    ResponseConfig responseConfig = ((ExtensionAware) config).getExtensions().create("response", ResponseConfig.class);
    project.task("generateApi").doLast(task -> {
      if (responseConfig.isFull()) {
        log.warn("\nGenerating response API..");
        SchemaBean schemaBean = generateResponse(responseConfig);
        print(schemaBean, responseConfig.getOut());
      }
      if (requestConfig.isFull()) {
        log.warn("\nGenerating request API..");
        SchemaBean schemaBean = generateRequest(requestConfig);
        print(schemaBean, requestConfig.getOut());
      }
    });
  }


  @SneakyThrows
  public static SchemaBean generateResponse(ResponseConfig config) {
    XmlSchema xmlSchema = new ResponseSchemaGenerator(config.getSchema(), config.getElement(), config.getTemplate())
      .generate();
    return new JsonSchemaGenerator().generate(xmlSchema);
  }

  @SneakyThrows
  public static SchemaBean generateRequest(RequestConfig config) {
    byte[] request = FileUtils.getFileContent(config.getRequest());
    XmlSchema xmlSchema = new RequestSchemaGenerator(config.getSchema(), config.getElement(), config.getTemplate())
      .generate(request);
    return new JsonSchemaGenerator().generate(xmlSchema);
  }


  @SneakyThrows
  private static void print(SchemaBean schema, String path) {
    Files.createDirectories(Paths.get(path).getParent());
    PrintStream printStream = new PrintStream(path, StandardCharsets.UTF_8);
    printStream.print(schema);
    printStream.close();
  }




}


