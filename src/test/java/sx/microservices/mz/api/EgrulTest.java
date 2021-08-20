package sx.microservices.mz.api;

import com.ibm.icu.text.Transliterator;
import org.junit.Ignore;
import org.junit.Test;
import org.w3c.dom.Document;
import sx.microservices.mz.api.xsd2inst.XmlInstance;
import sx.microservices.mz.api.xsd2inst.XmlInstanceGenerator;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.stream.Collectors;


/**
 * К сервису тест не относится. Сдесь сравниваются xsd схемы старого и нового egrul. Пусть полежит здесь пока
 */
@Ignore
public class EgrulTest {

  @Test
  public void old() throws Exception {
    Converter converter = new Converter();
    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);
    XslTransformer transformer = new XslTransformer();

    ResponseConfig config = new ResponseConfig();
    config.setSchema("egrul/old-schema/schema.xsd");
    config.setElement("FNSVipULResponse");
    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());
    Map<String, String> instanceMap = transformer.transformToMap(xmlInstance.getDocument());

    String collect = instanceMap.keySet().stream()
      .map(s -> s.replace("/FNSVipULResponse/", ""))
      .sorted(String::compareTo)
      .collect(Collectors.joining("\n"));
    Files.writeString(Path.of("old"), collect);
  }

  @Test
  public void newO() throws Exception {
    Converter converter = new Converter();
    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);
    XslTransformer transformer = new XslTransformer();

    ResponseConfig config = new ResponseConfig();
    config.setSchema("egrul/new-schema/schema.xsd");
    config.setElement("Файл");
    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());
    Map<String, String> instanceMap = transformer.transformToMap(xmlInstance.getDocument());
    String collect = instanceMap.keySet().stream()
      .map(s -> s.replace("/Файл/Документ/", ""))
      .sorted(String::compareTo)
      .collect(Collectors.joining("\n"));
    Files.writeString(Path.of("new"), collect);
  }

  @Test
  public void fullMapTest() throws Exception{
    Converter converter = new Converter();
    XmlInstanceGenerator xmlInstanceGenerator = new XmlInstanceGenerator(converter);
    XslTransformer transformer = new XslTransformer();

    ResponseConfig config = new ResponseConfig();
    config.setSchema("egrul/new-schema/schema.xsd");
    config.setElement("Файл");
    XmlInstance xmlInstance = xmlInstanceGenerator.createInstance(config.getSchema(), config.getElement());
    Map<String, String> instanceMap = transformer.transformToMap(xmlInstance.getDocument());
    Map<String, List<String>> swapped = instanceMap.entrySet()
      .stream()
      .collect(Collectors.groupingBy(Map.Entry::getValue, Collectors.mapping(Map.Entry::getKey, Collectors.toList())));

    Document transform = transformer.transform(xmlInstance.getDocument(), "egrul/template/response.xsl");
    Map<String, String> transformedMap = transformer.transformToMap(transform);
    Map<String, List<String>> swappedTransformedMap = transformedMap.entrySet()
      .stream()
      .collect(Collectors.groupingBy(Map.Entry::getValue, Collectors.mapping(Map.Entry::getKey, Collectors.toList())));

    swapped.keySet().removeAll(swappedTransformedMap.keySet());

    String collect = swapped.values().stream().map(strings -> strings.get(0))
      .sorted(String::compareTo)
      .collect(Collectors.joining("\n"));
    Files.writeString(Path.of("lack"), collect);

  }

  @Test
  public void added() throws Exception {
    String old_string = Files.readString(Path.of("old"));
    Set<String> old = Arrays.stream(old_string.split("\n")).collect(Collectors.toSet());

    String new_string = Files.readString(Path.of("new"));
    Set<String> new0 = Arrays.stream(new_string.split("\n")).collect(Collectors.toSet());

    Set<String> added = new0.stream().filter(e -> !old.contains(e)).collect(Collectors.toSet());
    String added_string = added.stream().sorted(String::compareTo).collect(Collectors.joining("\n"));
    Files.writeString(Path.of("added"), added_string);

    Set<String> to_arr = added.stream().filter(e -> e.contains("[2]"))
      .map(e -> e.replace("[2]", ""))
      .filter(e -> !added.contains(e))
      .collect(Collectors.toSet());
    String to_arr_string = to_arr.stream().sorted(String::compareTo).collect(Collectors.joining("\n"));
    Files.writeString(Path.of("to_arr"), to_arr_string);

    Set<String> without_duplicates = added.stream().filter(a -> !a.contains("[2]")).collect(Collectors.toSet());
    String w_d_st = without_duplicates.stream()
      .sorted(String::compareTo)
      .collect(Collectors.joining("\n"));
    Files.writeString(Path.of("without_duplicates"), w_d_st);

    String lack_string = Files.readString(Path.of("lack"));
    Set<String> lack = Arrays.stream(lack_string.split("\n")).collect(Collectors.toSet());
    Set<String> my_lack_set = new0.stream().filter(lack::contains).collect(Collectors.toSet());
    String my_lack = my_lack_set.stream()
      .sorted(String::compareTo)
      .collect(Collectors.joining("\n"));
    Files.writeString(Path.of("my_lack"), my_lack);


  }

  private static final String CYRILLIC_TO_LATIN = "Russian-Latin/BGN";

  @Test
  public void xslGen() throws Exception {
    String src = Files.readString(Path.of("srcs"));
    Transliterator toLatinTrans = Transliterator.getInstance(CYRILLIC_TO_LATIN);

    String root = "СвРешИзмМН";
    boolean asList = false;
    String trRoot = toLatinTrans.transliterate(root);

    String res = "";

    if (asList) {
      res += "<" + trRoot + ">";
      res += "<xsl:for-each select=\"kokoko/*[local-name()= '" + root + "']\">";
      res += "<smev" + trRoot + ">";
    } else {
      res = "<xsl:if test=\"kokoko/*[local-name()= '" + root + "']\">";
      res += "<xsl:variable name=\"" + trRoot + "\" select=\"kokoko/*[local-name()= '" + root + "']\"/>";
      res += "<" + trRoot + ">";
    }


    String[] fields = src.split("\n");
    for (String field : fields) {
      field = field.trim();
      field = field.substring(field.indexOf(root) + root.length());
      String attrName = toLatinTrans.transliterate(field).replaceAll("[@/\\[\\]]", "");
      res += "<" + attrName + ">";
      res += "<xsl:value-of select=\"$" + trRoot;

      int st = 0;
      char stCh = field.charAt(0);
      for (int i = 1; i < field.length(); i++) {
        if (field.charAt(i) == '[' || field.charAt(i) == '/' || field.charAt(i) == ']') {
          if (stCh == '/') {
            res += "/*[local-name()='" + field.substring(st + 1, i) + "']";
          } else if (stCh == '[') {
            res += "/" + field.substring(st + 1, i);
          }
          st = i;
          stCh = field.charAt(i);
        }
      }
      if (st != field.length() - 1) {
        res += "/*[local-name()='" + field.substring(st + 1) + "']";
      }

      res += "\"/>";

      res += "</" + attrName + ">";
    }



    if (asList) {
      res += "</smev" + trRoot + ">";
      res += "</xsl:for-each>";
      res += "</" + trRoot + ">";
      res = res.replace("$" + trRoot + "/", "");
    } else {
      res += "</" + trRoot + ">";
      res += "</xsl:if>";
    }


    Files.writeString(Path.of("result.xsl"), res);

  }

}
