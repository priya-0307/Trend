pipeline {
  agent any
  environment {
    DOCKERHUB = 'priyadharshini030722'
    IMAGE = "${DOCKERHUB}/trend-app"
    TAG  = "latest"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm 
      }
    }
    stage('Build') {
      steps {
        sh 'npm install'
        
      }
    }
    stage('Docker Build') {
      steps {
        sh "docker build -t ${IMAGE}:${TAG} ."
      }
    }
    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh 'echo $PASS | docker login -u $USER --password-stdin'
          sh "docker push ${IMAGE}:${TAG}"
        }
      }
    }
    
    stage('Deploy to K8s') {
      steps {
        // write kubeconfig to a temp file using the secret-file credential
        withCredentials([file(credentialsId: 'kubeconfig-cred', variable: 'kkkkk.txt')]) {
          sh '''
            export KUBECONFIG=${kkkkk.txt}
            kubectl set image deployment/trend-app trend=${IMAGE}:${SHORT_COMMIT} --record --namespace default
            kubectl rollout status deployment/trend-app --namespace default
          '''
        }
      }
    }
 
  }
}
