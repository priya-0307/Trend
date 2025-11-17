pipeline {
  agent any
  environment {
    DOCKERHUB = 'priyadharshini030722'
    IMAGE = "${DOCKERHUB}/trend-app"
    TAG  = "latest"
    KUBECONFIG = credentials('kubeconfig-id')  
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
    
    stage('Deploy to Kubernetes') {
            steps {
                withEnv(["KUBECONFIG=${KUBECONFIG}"]) {
                    sh """
                    sed -i 's#IMAGE_TAG#${IMAGE_TAG}#g' deployment.yaml
                    sed -i 's#DOCKER_REPO#${DOCKERHUB_REPO}#g' deployment.yaml
                    
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml

                    kubectl rollout status deployment/trend-app-deployment
                    """
        }
      }
    }
 
  }
}
