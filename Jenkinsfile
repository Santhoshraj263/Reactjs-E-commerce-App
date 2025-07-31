pipeline {
    agent any
    tools {
        git 'Default'
    }
    
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
        DOCKERHUB_DEV_REPO = 'san263/deploy_enr'
        DOCKERHUB_PROD_REPO = 'san263/production_env'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                    sh "docker build -t ${imageTag} ."
                }
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                script {
                    def imageTag = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                    def targetRepo = env.BRANCH_NAME == 'master' ? env.DOCKERHUB_PROD_REPO : env.DOCKERHUB_DEV_REPO

                    docker.withRegistry('', env.DOCKER_CREDENTIALS_ID) {
                        sh "docker tag ${imageTag} ${targetRepo}:${imageTag}"
                        sh "docker push ${targetRepo}:${imageTag}"
                    }
                }
            }
        }
    }
}
