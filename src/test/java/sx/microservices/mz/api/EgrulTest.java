package sx.microservices.mz.api;

import org.junit.Ignore;
import org.junit.Test;
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
    public void old() throws Exception{
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
    public void newO() throws Exception{
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
    public void added() throws Exception{
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



    }
}
