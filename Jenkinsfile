pipeline {
    agent 172.17.81.2
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
                    cd D:\GitHub\seit-sysman\auto_eitk3_robot
                    echo 'Running test: Basic_Task_Operations'
                    sh 'robot -d results -l Basic_Task_Operations_log -r Basic_Task_Operations_report ./TestCases/Tasks/Basic_Task_Operations.robot'  
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