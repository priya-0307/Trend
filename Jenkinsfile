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
       withCredentials([file(credentialsId: 'kubeconfig-cred', variable: 'KUBECONF')]) {
         sh '''
           mkdir -p tmp-kube
           cp $KUBECONF tmp-kube/config
           export KUBECONFIG=$(pwd)/tmp-kube/config
         '''
         sh 'kubectl apply -f deployment.yaml'
         sh "kubectl set image deployment/trend-app trend=${IMAGE}:${TAG} --record"
      }
    }
  }

  }
}
