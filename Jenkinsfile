pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-DockerHub')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:hesam5218/cw2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hesam5218/cw2-server:${BUILD_NUMBER} .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker login -u $DOCKER_HUB_CREDENTIALS_USR -p $DOCKER_HUB_CREDENTIALS_PSW'
                sh 'docker push hesam5218/cw2-server:${BUILD_NUMBER}'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl set image deployment/cw2-server cw2-server=hesam5218/cw2-server:${BUILD_NUMBER}'
            }
        }
    }
}
