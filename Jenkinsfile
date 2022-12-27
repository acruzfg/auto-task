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
                    echo "Testing on ${params.TEST_SYSTEM}"
                    bat "robot -d results -l Basic_Task_Operations_log -r Basic_Task_Operations_report --variable testsystem:${params.TEST_SYSTEM} ./Basic_Task_Operations.robot"
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