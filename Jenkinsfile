pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sshagent (credentials: ['jenkins-ssh']) {
          withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-ssh', keyFileVariable: 'GH_REPO_SSH_KEY')]) {
            sh 'echo "Building initial code image"'
            sh "cp $GH_REPO_SSH_KEY ${env.BUILD_NUMBER}-key"
            sh "docker build -t test123 --build-arg ID_RSA_FILE=${env.BUILD_NUMBER}-key ."
            sh "rm ${env.BUILD_NUMBER}-key"
          }
        }
      }
    }
  }
}
