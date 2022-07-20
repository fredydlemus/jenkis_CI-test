pipeline {
    agent any
    options {
        timeout(time: 2, unit: 'MINUTES')
    }
    environment {
        ARTIFACT_ID = "fredydlemus/webapp:${env.BUILD_NUMBER}"
        dockerhub=credentials('DockerHubCredentials')
    }

    stages {
        
        stage('Build') {
            steps {
                script {
                    dir('.'){
                        dockerImage = docker.build "${env.ARTIFACT_ID}"
                    }
                }
            }
        }
        stage('Run tests') {
            steps {
                sh "docker run ${dockerImage.id} npm test"
            }
        }
        stage('Publish'){
            when {
                branch 'main'
            }
            steps {
                sh "echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin"
                sh "docker push ${dockerImage.id}"
            }
        }
    }
}