pipeline {
    agent sm5-dac1 
    parameters {
    }
    environment {
        NEW_VERSION = '1.3.1'
    }

    stages {

        stage ("Permissions test cases") {
                when {
            expression {
                params.PERMISSIONS == 'y'
            }
        }+
/+--            steps {
                script {
                    echo 'hey permissions'
                }

            }

        }
        stage("Data Provider import without IDMap") {
                when {
            expression {
                params.DPIwoMap == 'y'
            }
        }
            steps {
                script{
                    echo 'hey data provider woMap'
                }
            }
        }
        stage ("Data Provider import with IDMap") {
            when {
            expression {
                params.DPIwMap == 'y'
            }
        }
            steps {
                script{

                    echo 'hey data provider woMap'
                }
            }
        }
        stage ("Deleting Data Provider import request") {
            when {
            expression {
                params.DEL == 'y'
            }
        }
            steps {
                script{

                    echo 'hey delete'

                }



            }

        }
    }
    post {
        always {
            script {
                echo ':)'
            }
        }
    }
}