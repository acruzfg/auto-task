pipeline {
    agent {label 'master'}
    stages {
        stage('Installingt jama-rest-client'){
            steps{
                script{
                    bat'pip install py-jama-rest-client'
                }
            }
        }
        stage ("Testing") {
           steps {
                script {
                    echo 'Running test: Basic_Task_Operations'
                    bat 'run.bat'
                }
            }
        }
    }
    post {
        always {
            script {
                echo 'Finished test'
            }
        }
    }
}