pipeline {
  agent any
  tools {
      nodejs "nodejs"
    }
stages {
        stage("Code Checkout from GitLab") {
          steps {
            git branch: 'main', url: 'https://github.com/shivam779823/Nodejs-sonarqube-jenkins-CICD.git'
          }
      }

        stage('Code Quality Check via SonarQube') {
        steps {
            script {
            def scannerHome = tool 'sonarqube';
                withSonarQubeEnv("sonarqube-container") {
                sh "${tool("sonarqube")}/bin/sonar-scanner \
                -Dsonar.projectKey=test-node-js \
                -Dsonar.sources=. \
                -Dsonar.css.node=. \
                -Dsonar.host.url=http://your-ip-here:9000 \
                -Dsonar.login=your-generated-token-from-sonarqube-container"
                    }
                }
            }
        }
        stage("Install Project Dependencies") {
          steps {
              nodejs(nodeJSInstallationName: 'nodejs'){
                  sh "npm install"
                  }
              }
        }
        stage("docker image build")  {
                  steps {
                      script {
                          dockerImage = docker.build("tom")
                          sh "docker run -p 3000:3000 tom:latest"
                      }
                  
                  }
              } 
}
}






















// pipeline {
//   tools {
//     nodejs 'nodejs'
//   }
//   stages {
//     stage('code checkout') {
//       steps {
//        git branch: 'main', url: 'https://github.com/shivam779823/Nodejs-sonarqube-jenkins-CICD.git'
//       }
//     }

//     stage('Code Quality Check via SonarQube'){
//       steps{
//         script {
//           def scannerHome = tool 'sonarqube';
//                 withSonarQubeEnv("sonarqube-container") {
//                 sh "${tool("sonarqube")}/bin/sonar-scanner \
//                 -Dsonar.projectKey=test-node-js \
//                 -Dsonar.sources=. \
//                 -Dsonar.css.node=. \
//                 -Dsonar.host.url=http://your-ip-here:9000 \
//                 -Dsonar.login=your-generated-token-from-sonarqube-container"
//                     }
//         }
//       }
//     }
//     stage('Test') {
//       steps {
//         script {
//           sh 'npm run test'
//         }
//       }
      
//     }
//     stage('Install Project Dependencies') {
//       steps {
//         script {
//           sh 'npm start'
//           sh 'npm pack'
//         }
//       }
//     }
    
    
//   }
// }
