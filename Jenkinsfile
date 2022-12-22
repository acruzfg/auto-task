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
                    bat 'run.bat'
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