pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = '/apicadastro:0.0.1'
        DOCKER_HUB_CREDENTIALS_ID = 'rodrigodebiasiborghi'
        GIT_REPO = 'https://github.com/Hodriz/cadastro.git'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-credentials-id', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.build("${DOCKER_HUB_REPO}:latest")
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_HUB_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_HUB_REPO}:latest").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh '''
                    docker-compose down
                    docker-compose pull
                    docker-compose up -d
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deploy realizado com sucesso!'
        }
        failure {
            echo 'O deploy falhou!'
        }
    }
}
