pipeline {
    agent any
     
      environment {
        DOCKER_IMAGE = 'maheshprathipati/gamutkart1'
        DOCKER_TAG = 'latest'
       
    }
    stages {
        stage('Check File Existence') {
            steps {
               bat 'dir C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\test2\\target'
            }
        }
        
        stage('DOCKER build'){
            steps{
                bat "docker build -t  ${DOCKER_IMAGE}:${DOCKER_TAG} ."
               
            }
        }

        
        stage('DOCKER login'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){

                
                 bat "echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin"
                } 
                 
            }
        }
        stage('DOCKER PUSH IMAGE'){
            steps{
                 bat "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }
}

 post {
        success {
            echo "Docker image successfully built and pushed: ${DOCKER_IMAGE}:${DOCKER_TAG}"
        
        failure {
            echo "Pipeline failed! Check logs for errors."
        }
    }
}