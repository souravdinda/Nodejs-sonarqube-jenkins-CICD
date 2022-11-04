pipeline {
  agent any
  tools {
      nodejs "nodejs"
    }
   environment {
        PROJECT_ID = 'qwiklabs-gcp-01-82bbc493ae94'
        CLUSTER_NAME = 'jenkins-cd'
        LOCATION = 'us-central1-a'
        CREDENTIALS_ID = 'qwiklabs-gcp-01-82bbc493ae94'
        dockerImage = "nodeapp"
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
                -Dsonar.projectKey=sample \
                -Dsonar.sources=. \
                -Dsonar.host.url=https://9000-145248df-48c1-4f67-98cc-08303b019d3e.cs-asia-southeast1-ajrg.cloudshell.dev \
                -Dsonar.login=sqp_7449d33aa41a36293820203cf902d34054cf6773"
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
                    not { branch 'main' }
                    not { branch 'master' }
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
