pipeline {
    agent {label 'master'}
    parameters {
        booleanParam(name: 'Basic_Task_Operations', defaultValue: true, description: 'Create task, edit task, add step and remove a step via enpoints')
    }
    stages {
        stage('Installingt jama-rest-client'){
            steps{
                script{
                    bat'pip install py-jama-rest-client'
                }
            }
        }
        stage ("Testing") {
                when {
            expression {
                params.Basic_Task_Operations == true
            }
        }
           steps {
                script {
                    echo 'Running test: Basic_Task_Operations'
                    bat 'cd C:\Program Files (x86)\Jenkins\workspace\estCase_Jobs_EITK_Auto_Task_main'
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