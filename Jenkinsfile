pipeline {
    
    agent any 
    
    environment {
  
        DOCKERHUB_REPO='sanketlawande1/react-app-frontend'
	    DOCKERHUB_CREDENTIALS=credentials('DOCKERHUB_CREDENTIALS')
	    SECRET=credentials('SECRET')
    }


stages {
    
    stage("Git Checkout") {

        steps { git branch: 'main', url: 'https://github.com/delta-bravo277/react-app-frontend' }
        
    }
    
    stage('Code Scanning') {
        
        steps { echo 'sonar-scanner' }
    }
    
    stage('Installing Dependencies') {
        
         steps { sh 'npm install'
                 sh 'npm run build'
                 } // steps install-dependencies closed
    } // stage install-dependencies closed
    
   /* stage('Dependencies Scanning and Fixing') {
        
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
    } // stage scanning closed */
    
    stage('Build , Sign and Publish an image') {
        
        steps {
            
            sh '''
                docker build -t $DOCKERHUB_REPO:latest .
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker push $DOCKERHUB_REPO:latest
                '''
                        
        } // steps build and sign closed
         
    
    } //  stage build and sign closed

    stage('Deploying to K8s') {
        
        steps {
            
            sh  'kubectl apply -f manifests/* '
                        
        } // steps deploy closed
         
    
    } //  stage deploy closed
    
} // stages closed

} // pipeline closed
