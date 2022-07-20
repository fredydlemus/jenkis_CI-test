pipeline {
    agent any
    options {
        timeout(time: 2, unit: 'MINUTES')
    }
    environment {
        ARTIFACT_ID = "webapp:${env.BUILD_NUMBER}"
    }

    stages {
        stage('initialize'){
            def dockerHome = tool 'myDocker'
            env.PATH = "${dockerHome}/bin:${env.PATH}"
        }
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
    }
}