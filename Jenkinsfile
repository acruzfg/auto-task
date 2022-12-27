pipeline {
    agent {label 'master'}
    parameters {
        string(name: 'TEST_SYSTEM', defaultValue: '', description: 'System to which endpoints will make the API requests. Use only capital letters.')
    }
    stages {
        stage('Installingt jama-rest-client'){
            steps{
                script{
                    bat 'pip install py-jama-rest-client'
                }
            }
        }
        stage ("Testing") {
           steps {
                script {

                    echo 'Running test: Basic_Task_Operations'
                    echo "${params.TEST_SYSTEM}"
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