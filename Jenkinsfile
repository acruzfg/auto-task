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
                    bat 'robot -d results -l Basic_Task_Operations_log -r Basic_Task_Operations_report ./Basic_Task_Operations.robot'
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