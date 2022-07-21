pipeline {
    agent any
    options {
        timeout(time: 30, unit: 'MINUTES')
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
        stage('Schedule Stagin'){
            when {
                branch 'main'
            }
            steps {
                build job: 'deploy-webapp-staging', parameters: [string(name: 'ARTIFACT_ID', value: ${env.ARTIFACT_ID})], wait: false
            }
        }
    }
}