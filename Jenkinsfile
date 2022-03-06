pipeline {
  environment {
    repo = "shtarkel/yavor"
    credential = 'shtarkel-dockerhub'
    dockerImage = ''
  }
  agent docker
  stages {
    stage('Clone git') {
      steps {
        git([url: 'https://bitbucket.local/shtarkel/yavor.git', branch: 'develop', credentialsId: 'shtarkel-bitbucket'])
      }
    }
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build repo
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', credential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')
          }
        }
      }
    }
    stage('Remove local docker image cache') {
      steps{
        sh "docker rmi $repo:$BUILD_NUMBER"
         sh "docker rmi $repo:latest"
      }
    }
    stage('Apply new image') {
      steps{
        sh "helm upgrade yavor ./yavor"
      }
    }
  }
}