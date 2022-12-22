pipeline {
    agent any
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
                    cd C:/Program Files (x86)/Jenkins/caches/git-fa0bdcae8ffc5c3294caabb20cb1f1f2
                    echo 'Running test: Basic_Task_Operations'
                    robot -d results -l Basic_Task_Operations_log -r Basic_Task_Operations_report ./TestCases/Tasks/Basic_Task_Operations.robot
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