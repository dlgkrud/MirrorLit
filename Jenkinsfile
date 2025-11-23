pipeline {
    agent any
    
    environment {
        // Docker Hub 이미지 이름
        DOCKERHUB = "hagyeoung/mirrorlit"
        // GitHub 저장소 URL
        GITHUB_REPO = "https://github.com/0-ch-sl-0/MirrorLit.git"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: "${env.GITHUB_REPO}"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${env.DOCKERHUB}:${env.BUILD_NUMBER}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-cred') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-cred', variable: 'KUBECONFIG')]) {
                    sh '''
                      export KUBECONFIG=$KUBECONFIG
                      kubectl set image deployment/mirrorlit-app mirrorlit=${DOCKERHUB}:latest
                      kubectl rollout status deployment/mirrorlit-app
                    '''
                }
            }
        }
    }
}

