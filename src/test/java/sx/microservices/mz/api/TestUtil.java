package sx.microservices.mz.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import sx.microservices.mz.api.json.SchemaBean;

import java.io.IOException;

public class TestUtil {

  public static void assertEquals(String expectedPath, SchemaBean actualBean, boolean overwrite) throws IOException {
    ObjectMapper objectMapper = new ObjectMapper();
    byte[] expected_bytes = FileUtils.getFileContent(expectedPath);
    JsonNode expected = objectMapper.readTree(expected_bytes);
    JsonNode actual = objectMapper.readTree(actualBean.toString());
    try{
      Assert.assertEquals(expected, actual);
    }catch (AssertionError e){
      if (overwrite){
        FileUtils.writeFile(expectedPath, actual.toPrettyString().getBytes());
      }else {
        throw e;
      }
    }

  }
}
