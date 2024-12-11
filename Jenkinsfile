
pipeline {
     agent {
        docker {
            image 'bitnami/kubectl:latest'
        }
    }
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker')
        GIT_CREDENTIALS = credentials('GitHub')
    }

    stages {

         stage('DockerHub Login') {
            steps {
                echo 'Logging in to DockerHub...'
                sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Test Docker Access') {
    steps {
        sh 'docker --version'
        sh 'docker ps'
    }
}

        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'GitHub', url: 'git@github.com:hesam5218/cw2.git'
            }
        }
        

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh 'docker build -t hesam5218/cw2-server:${BUILD_NUMBER} .'
                echo 'Docker Image built successfully!'
            }
        }

        
       

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker Image to DockerHub...'
                sh 'docker push hesam5218/cw2-server:${BUILD_NUMBER}'
            }
        }
        stage('Setup Kubernetes CLI') {
            steps {
                sh '''
                apt-get update
                apt-get install -y apt-transport-https ca-certificates curl
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                chmod +x kubectl
                mv kubectl /usr/local/bin/
                kubectl version --client
                '''
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['jenkins-k8s-ssh-key']) {
                    echo 'Deploying to Kubernetes...'
                    sh '''
                        kubectl set image deployment/cw2-server cw2-server=hesam5218/cw2-server:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }
}
