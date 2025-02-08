pipeline {
    agent any
     tools {
      maven 'Apache Maven 3.8.8'
    }
           
     environment {
        DOCKER_IMAGE = 'maheshprathipati/gamutkart1'
        DOCKER_TAG = 'latest'
       
    }
    stages {
        stage("Git Checkout") {
            steps {
                
                git branch: 'main', credentialsId: 'gitcredentials', url: 'https://github.com/maheshprathipati/REPO.git'
            }
        }
        stage("Maven Build") {
            steps {
                bat "mvn clean install"
            }
        }
        stage("Maven code deploy in tomcat") {
            steps {
                 bat '''
                 scp -P 3333 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ^
                 C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\test2\\target\\gamutkart.war ^
                 tomcat@192.168.232.243:/home/tomcat/apache-tomcat-11.0.2/webapps/
                 '''
            }
        }
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