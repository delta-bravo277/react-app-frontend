pipeline {
    
    agent any 
    
    environment {
  
        DOCKERHUB_REPO='sanketlawande1/react-app'
	    DOCKERHUB_CREDENTIALS=credentials('DOCKERHUB_CREDENTIALS')
	    SECRET=credentials('SECRET')
    }


stages {
    
    stage("Git Checkout") {

        steps { git branch: 'main', url: 'https://github.com/delta-bravo277/react-app' }
        
    }
    
    stage('Code Scanning') {
        
        steps { echo 'sonar-scanner' }
    }
    
    stage('Installing Dependencies') {
        
         steps { sh 'npm install'
                 sh 'npm run build'
                 } // steps install-dependencies closed
    } // stage install-dependencies closed
    
    stage('Dependencies Scanning and Fixing') {
        
       steps { 
        sh 'npm audit fix || true '
        sh 'npm audit --audit-level=none || true'
        sh 'npm audit --json | npm-audit-html'
        
        publishHTML target: [
            allowMissing: false,
            alwaysLinkToLastBuild: false,
            keepAll: true,
            reportDir: '.',
            reportFiles: 'npm-audit.html',
            reportName: 'NPM Audit Report'
            ]
       } // steps scanning closed
    } // stage scanning closed
    
    stage('Build , Sign and Publish an image') {
        
        steps {
            
            sh '''
                docker build -t $DOCKERHUB_REPO:$BUILD_NUMBER .
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                export DOCKER_CONTENT_TRUST_REPOSITORY_PASSPHRASE=$SECRET
                docker -D trust sign $DOCKERHUB_REPO:$BUILD_NUMBER
                
                '''
                        
        } // steps build and sign closed
         
    
    } //  stage build and sign closed
    
} // stages closed

} // pipeline closed
