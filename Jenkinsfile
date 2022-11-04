pipeline {
  agent any
  tools {
      nodejs "nodejs"
    }
   environment {
        PROJECT_ID = 'qwiklabs-gcp-04-ecebad306a3c'
        CLUSTER_NAME = 'jenkins-cd'
        LOCATION = 'us-central1-a'
        CREDENTIALS_ID = 'qwiklabs-gcp-04-ecebad306a3c'
        dockerImage = "nodeapp"

        // sonarscanner

        PROJECTKEY= 'sample'
        SONARURL = 'http://34.134.17.81:9000'
        LOGIN= 'sqp_012a82ccb48a91e5277a0d8e981195d9775b452a'


    } 
stages {
        stage("Code Checkout from Github") {
          steps {
            git branch: 'main', url: 'https://github.com/shivam779823/Nodejs-sonarqube-jenkins-CICD.git'
          }
      }

        stage('Code Quality Check via SonarQube') {
        steps {
            script {
            def scannerHome = tool 'sonarscanner';
               withSonarQubeEnv(credentialsId: 'sonarkey'){
                sh "${tool("sonarscanner")}/bin/sonar-scanner \
                -Dsonar.projectKey=${env.PROJECTKEY} \
                -Dsonar.sources=. \
                -Dsonar.host.url=${env.SONARURL} \
                -Dsonar.login=${env.LOGIN}"
                    }
                }
            }
        }
        stage("Install Project Dependencies & Test") {
          steps {
              nodejs(nodeJSInstallationName: 'nodejs'){
                  sh "npm install"
                  //add test
                  }
              }
        }
         stage("docker image build")  {
            steps {
                script {
                    dockerImage = docker.build("shiva9921/${env.dockerImage}:${env.BUILD_ID}")
                }
            
            }
         }

         stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhublogin') {
                            dockerImage.push("latest")
                            dockerImage.push("${env.BUILD_ID}")


                            // Remove Image
                            sh "docker rmi -f shiva9921/${env.dockerImage}:${env.BUILD_ID}"
                            echo "image removed"
                            
                    }
                }
                  
            }
        }
        //Step 6  
              
        stage('Deploy Production') {

            when { branch 'main' }

            steps{
    
                sh "sed -i 's/mywebsite:latest/mywebsite:${env.BUILD_ID}/g' k8s/deployment.yaml"

                step([$class: 'KubernetesEngineBuilder', namespace:'production', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8s/deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
 
	            step([$class: 'KubernetesEngineBuilder', namespace:'production', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8s/service.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])

              

                echo "Deployment Finished ..."


                  
            }
        }

        stage('Deploy Dev') {
             when {
                    { branch 'main' }
                    
             }
            steps{
    
                sh "sed -i 's/mywebsite:latest/mywebsite:${env.BUILD_ID}/g' k8s/deployment.yaml"

                step([$class: 'KubernetesEngineBuilder', namespace:'dev', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8s/deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
 
	            step([$class: 'KubernetesEngineBuilder', namespace:'dev', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8s/service.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])

               

                echo "Deployment Finished ..."


                  
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
