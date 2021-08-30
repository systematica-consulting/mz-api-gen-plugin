@Library('shared-library') _

pipeline {
  agent {
    label "jenkins-gradle6-j11"
  }

  stages {
    stage('Default Build') {
      steps {
        container('gradle') {
          withCredentials([usernamePassword(credentialsId: 'nexus.devsun.ru', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
            sh "gradle test"
            sh "gradle uploadArchives"
          }
        }
      }
    }
  }
}
