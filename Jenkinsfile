node {
   sshagent (credentials: ['jenkins-ssh']) {
       withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-ssh', keyFileVariable: 'GH_REPO_SSH_KEY')]) {
           sh 'echo $GH_REPO_SSH_KEY > a.txt'
           sh 'cat a.txt'
           nodejs(nodeJSInstallationName: 'nodejs-8.1.2', configId: 'ce521769-a223-47c7-bbe9-d54cb3f782b8') {
                sh 'rm -rf django-audience'
                sh 'npm install @natgeosociety/ngs-react'
                sh 'git clone git@github.com:natgeosociety/django-audience.git'
           }
       }
  }
}
