pipeline {
    agent{label 'master'}
    parameters {
        string(name: 'TEST_SYSTEM', defaultValue: 'SM5-DAC1', description: 'System hosting the EITK3 instance.')
        string(name: 'TEST_CYCLE', description: 'JAMA test cycle API ID')
    }
    stages {
        stage('Download resources from git'){
            steps{
                script{
                    bat '''
                    git clean  -d  -f .
                    git init
                    git remote add -f origin https://github.com/acruzfg/auto-task.git
                    git config core.sparseCheckout true
                    echo "/auto_common_robot" >> .git/info/sparse-checkout
                    echo "/auto_eitk3_endpoints" >> .git/info/sparse-checkout
                    echo "/auto_eitk3_endpoints/Files" >> .git/info/sparse-checkout
                    git sparse-checkout add /auto_common_robot/SM5-DAC1_Variables.robot
                    git sparse-checkout add /auto_common_robot/SM5-PDS1_Variables.robot
                    git sparse-checkout add /auto_eitk3_endpoints/EITK3_Basic_Tables_Operations.robot
                    git sparse-checkout add /auto_eitk3_endpoints/EITK3_General_Endpoints_Keywords.robot
                    git sparse-checkout add /auto_eitk3_endpoints/EITK3_POST_Keywords.robot
                    git sparse-checkout add /auto_eitk3_endpoints/EITK3_GET_Keywords.robot
                    git sparse-checkout add /auto_eitk3_endpoints/EITK3_PUT_Keywords.robot
                    git sparse-checkout add /auto_eitk3_endpoints/EITK3_DELETE_Keywords.robot
                    git sparse-checkout add /auto_eitk3_endpoints/EITK3_PATCH_Keywords.robot
                    git sparse-checkout add /auto_eitk3_endpoints/Report_to_Jama.robot
                    git sparse-checkout add /auto_eitk3_endpoints/TestCaseResults.py
                    git sparse-checkout add /auto_eitk3_endpoints/Files/ATable1.csv
                    git sparse-checkout add /auto_eitk3_endpoints/Files/ATable1_updated.csv
                    git pull origin main
                    '''
                }

            }
        }
        stage('Testing'){
            steps{
                script{
                    echo "Testing node ${params.TEST_SYSTEM}"
                    bat "robot --variable testcycle:${params.TEST_CYCLE} --variable testsystem:${params.TEST_SYSTEM} -l EITK3_Basic_Tables_Operations__log -r EITK3_Basic_Tables_Operations_report .\\auto_eitk3_endpoints\\EITK3_Basic_Tables_Operations.robot"
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