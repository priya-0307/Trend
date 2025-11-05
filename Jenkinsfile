pipeline {
  agent any
  environment {
    DOCKERHUB = 'priyadharshini030722'
    IMAGE = "${DOCKERHUB}/trend:${env.GIT_COMMIT.substring(0,7)}"
  }
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Build') {
      steps {
        sh 'npm ci'
        sh 'npm run build'
      }
    }
    stage('Docker Build') {
      steps {
        sh "docker build -t ${IMAGE} ."
      }
    }
    stage('Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh 'echo $PASS | docker login -u $USER --password-stdin'
          sh "docker push ${IMAGE}"
        }
      }
    }
    stage('Deploy to K8s') {
      steps {
        withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONF')]) {
          sh 'mkdir -p ~/.kube'
          sh 'cp $KUBECONF ~/.kube/config'
          // Use kubectl set image or apply yaml
          sh "kubectl set image deployment/trend-app trend=${IMAGE} --record || kubectl apply -f k8s/deployment.yaml"
        }
      }
    }
  }
}
