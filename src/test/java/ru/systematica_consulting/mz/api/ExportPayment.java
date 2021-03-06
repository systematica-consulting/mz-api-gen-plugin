package ru.systematica_consulting.mz.api;

import org.junit.Test;
import ru.systematica_consulting.mz.api.config.RequestConfig;
import ru.systematica_consulting.mz.api.config.ResponseConfig;
import ru.systematica_consulting.mz.api.json.SchemaBean;

import static org.junit.Assert.assertEquals;

public class ExportPayment {
  @Test
  public void generationTest() throws Exception {
    ResponseConfig responseConfig = new ResponseConfig();
    responseConfig.setTemplate("export-payment/templates/response.xsl");
    responseConfig.setElement("ExportPaymentsResponse");
    responseConfig.setSchema("export-payment/schema/ExportPayments.xsd");
    responseConfig.setOut("export-payment/api/response.json");

    RequestConfig requestConfig = new RequestConfig();
    requestConfig.setRequest("export-payment/request-our.xml");
    requestConfig.setTemplate("export-payment/templates/request.xsl");
    requestConfig.setElement("ExportPaymentsRequest");
    requestConfig.setSchema("export-payment/schema/ExportPayments.xsd");
    requestConfig.setOut("export-payment/api/request.json");

    SchemaBean request = ApiPlugin.generateRequest(requestConfig);
    SchemaBean response = ApiPlugin.generateResponse(responseConfig);

    TestUtil.assertEquals(requestConfig.getOut(), request, true);
    TestUtil.assertEquals(responseConfig.getOut(), response, true);
  }

}

