pipeline {
  stages {
    stage('Build') {
        sshagent (credentials: ['jenkins-ssh']) {
           withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-ssh', keyFileVariable: 'GH_REPO_SSH_KEY')]) {
               sh 'echo "Building initial code image"'
               sh 'ls -la .'
               sh 'docker build -t test123 --build-arg ID_RSA_FILE=$GH_REPO_SSH_KEY -f ./Dockerfile .'
               nodejs(nodeJSInstallationName: 'nodejs-8.1.2', configId: 'ce521769-a223-47c7-bbe9-d54cb3f782b8') {
                    sh 'rm -rf django-audience'
                    sh 'npm install @natgeosociety/ngs-react'
                    sh 'git clone git@github.com:natgeosociety/django-audience.git'
               }
           }
        }
        }
    }
}
