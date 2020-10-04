pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage("Compile") {
            steps {
                sh "./gradlew compileJava"
            }
        }
        stage("Unit test") {
            steps {
                sh "./gradlew test"
            }
        }
        stage ("Package") {
            steps {
        	    sh "./gradlew build"
        	}
        }
        stage ("Probar si funciona Docker") {
            steps {
                sh "docker version"
            }
        }
        stage ("Docker build") {
            steps {
                sh "docker build -t juanmamacgyvercode/calculator ."
            }
        }
        stage ("Docker login") {
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub',
                                   usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                    sh "docker login --username $USERNAME --password $PASSWORD"
                }
            }
        }
        stage ("Docker push") {
            steps {
                sh "docker push juanmamacgyvercode/calculator"
            }
        }
        stage ("Deploy to staging") {
            steps {
                sh "docker run -d --rm -p 8765:8080 --name calculatorStaging juanmamacgyvercode/calculator"
            }
        }
        // Si quieres que Jenkins haga un rest de aceptación de una repo docker, no uses localhost, usa tu IP.
        /*stage ("Prueba") {
                    steps {
                        sleep 20
                        sh "curl -i \"192.168.2.89:8765/sum?a=1&b=2\""
                    }
                }*/
        stage ("Acceptance test") {
            steps {
                sleep 60
                sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"

            }
            post {
                always {
                    sh "docker stop calculatorStaging"
                }
            }
        }
    }
}
