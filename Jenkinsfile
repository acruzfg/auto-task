pipeline {
    agent {label 'master'}
    parameters {
        booleanParam(name: 'Basic_Task_Operations', defaultValue: true, description: 'Create task, edit task, add step and remove a step via enpoints')
    }
    stages {

        stage ("Basic_Task_Operations") {
                when {
            expression {
                params.Basic_Task_Operations == true
            }
        }
           steps {
                script {
                    cd C:\Program Files (x86)\Jenkins\workspace\estCase_Jobs_EITK_Auto_Task_main
                    robot -d results -l Basic_Task_Operations_log -r Basic_Task_Operations_report ./TestCases/Tasks/Basic_Task_Operations.robot
                    echo 'Running test: Basic_Task_Operations'
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