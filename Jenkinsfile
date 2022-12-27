pipeline {
    agent {label 'master'}
    parameters {
        string(name: 'TEST_SYSTEM', defaultValue: 'SM5-DAC1', description: 'System to which endpoints will make the API requests. Default is SM5-DAC1.')
        string(name: 'TEST_CYCLE', description: 'JAMA test cycle API ID')
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
                    echo "Testing on ${params.TEST_SYSTEM}"
                    echo 'Running test: Basic_Task_Operations'
                    bat "robot -d results -l Basic_Task_Operations_log -r Basic_Task_Operations_report --variable testsystem:${params.TEST_SYSTEM} --variable testcycle:${params.TEST_CYCLE} ./Basic_Task_Operations.robot"
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