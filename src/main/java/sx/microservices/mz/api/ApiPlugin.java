package sx.microservices.mz.api;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.gradle.api.Plugin;
import org.gradle.api.Project;
import org.gradle.api.plugins.ExtensionAware;
import sx.microservices.mz.api.json.JsonSchemaGenerator;
import sx.microservices.mz.api.json.SchemaBean;
import sx.microservices.mz.api.schema.RequestSchemaGenerator;
import sx.microservices.mz.api.schema.XmlSchema;
import sx.microservices.mz.api.schema.ResponseSchemaGenerator;
import sx.microservices.mz.api.xsd2inst.XmlInstance;
import sx.microservices.mz.api.xsd2inst.XmlInstanceGenerator;
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

    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator();
    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());

    XslTransformer transformer = new XslTransformer(config.getTemplate());

    ResponseSchemaGenerator responseSchemaGenerator = new ResponseSchemaGenerator(xmlInstance, transformer);
    XmlSchema xmlSchema = responseSchemaGenerator.generate();

    JsonSchemaGenerator generator = new JsonSchemaGenerator();
    return generator.generate(xmlSchema);

  }

  @SneakyThrows
  public static SchemaBean generateRequest(RequestConfig config) {

    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator();
    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());

    byte[] request = Util.getFileContent(config.getRequest());

    XslTransformer transformer = new XslTransformer(config.getTemplate());

    RequestSchemaGenerator xmlSchemaGenerator = new RequestSchemaGenerator(xmlInstance, transformer);
    XmlSchema xmlSchema = xmlSchemaGenerator.generate(request);

    JsonSchemaGenerator generator = new JsonSchemaGenerator();
    return generator.generate(xmlSchema);

  }


  @SneakyThrows
  private static void print(SchemaBean schema, String path) {
    Files.createDirectories(Paths.get(path).getParent());
    PrintStream requestStream = new PrintStream(path, StandardCharsets.UTF_8);
    requestStream.print(schema);
    requestStream.close();
  }




}


