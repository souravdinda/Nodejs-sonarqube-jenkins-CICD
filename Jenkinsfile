pipeline {
  agent any

   environment {


        PROJECTKEY= 'sample'
        SONARURL = 'http://13.235.103.54:9000/'
        LOGIN= 'cfda070e8374bab165a024e3f8f2f912a6364f36'


    } 
stages {
      

        stage('Code Quality Check via SonarQube') {
        steps {
            // script {
            // def scannerHome = tool 'sonarscanner';
            //    withSonarQubeEnv(credentialsId: 'sonarkey'){
            //     sh "${tool("sonarscanner")}/bin/sonar-scanner \
            //     -Dsonar.projectKey=${env.PROJECTKEY} \
            //     -Dsonar.sources=. \
            //     -Dsonar.host.url=${env.SONARURL} \
            //     -Dsonar.login=${env.LOGIN}"
            //         }
            //     }
            
//             sh "sudo yum install nodejs npm"
//             sh "sudo yum install nodejs --enablerepo=epel-testing"
            sh "sudo yum install nodejs nodejs-devel nodejs-docs --enablerepo=nodesource"
            sh "npm install -g sonarqube-scanner"
            sh """sonar-scanner -D"sonar.projectKey=sample"  \
                 -D"sonar.host.url=http://13.235.103.54:9000/" \
                 -D"sonar.login=cfda070e8374bab165a024e3f8f2f912a6364f36" \
                  -D"sonar.exclusions=**/node_modules/**"
                """
            }
        }
        
         

           
              
        

      


        
}
}




















