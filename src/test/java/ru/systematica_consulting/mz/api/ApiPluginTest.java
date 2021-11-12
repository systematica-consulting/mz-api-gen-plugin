package ru.systematica_consulting.mz.api;

import org.gradle.api.Project;
import org.gradle.testfixtures.ProjectBuilder;
import org.junit.Test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

public class ApiPluginTest {


  @Test
  public void greetingTest() {
    Project project = ProjectBuilder.builder().build();
    project.getPluginManager().apply("ru.systematica_consulting.mz.api-gen-plugin");

    assertTrue(project.getPluginManager()
      .hasPlugin("ru.systematica_consulting.mz.api-gen-plugin"));

    assertNotNull(project.getTasks().getByName("generateApi"));
  }


}