@Library('library') _

node("cicd") {
  container('ansible') {
    cicd.run(
      projectName: 'pgs'
    )
  }
}