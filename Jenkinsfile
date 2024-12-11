pipeline {
    agent any

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

        stage('Test Docker Image') {
            steps {
                echo 'Testing Docker Image...'
                sh '''
                    docker image inspect hesam5218/cw2-server:${BUILD_NUMBER}
                    docker run --name test-container -p 8081:3000 -d hesam5218/cw2-server:${BUILD_NUMBER}
                    docker ps
                    docker stop test-container
                    docker rm test-container
                '''
            }
        }

       

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker Image to DockerHub...'
                sh 'docker push hesam5218/cw2-server:${BUILD_NUMBER}'
            }
        }

        stage('Deploy') {
            steps {
                 sshagent(['jenkins-k8s-ssh-key']) {
        echo 'Deploying to Kubernetes via SSH....'
        sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@ec2-3-88-236-172.compute-1.amazonaws.com << EOF
            kubectl set image deployment/cw2-server cw2-server=hesam5218/cw2-server:${BUILD_NUMBER}
            EOF
        '''
                }
            }
        }
    }
}
