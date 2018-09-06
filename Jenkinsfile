pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sshagent (credentials: ['jenkins-ssh']) {
          withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-ssh', keyFileVariable: 'GH_REPO_SSH_KEY')]) {
            sh 'echo "Building initial code image"'
            sh 'docker build -t test123 --build-arg ID_RSA_FILE=$GH_REPO_SSH_KEY .'
          }
        }
      }
    }
  }
}
