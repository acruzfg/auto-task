pipeline {
    agent none
    parameters {
        string(name: 'TEST_SYSTEM', defaultValue: 'SM5-DAC1', description: 'System hosting the EITK3 instance.')
        string(name: 'TEST_CYCLE', description: 'JAMA test cycle API ID')
        string(name: 'FileAge', description:'Maximum age (in days) of a file before is cleaned up.')
        string(name: 'PayloadsStoredperTask', description:'Maximum number of task payload files that can be stored at once for each Task.')
        string(name: 'TaskHistoryAge', description:'Maximum age (in days) of a task history before it is cleaned up.')
        string(name: 'TaskRunRequestAge', description:'Maximum age (in days) of a task run request before it is cleaned up.')
    }
    stages {
        stage('Create files in audits folder'){
            when{
                expression { params.TEST_SYSTEM == "SM5-DAC1" }
            }
            agent{label 'sm5-dac1'}
            steps{
                echo"${params.TEST_SYSTEM}"
                sh '''
                cd /opt/osi/monarch/log/eitk
                mkdir folder1 folder2
                touch -d "2 days ago" folder1
                touch -d "2 days ago" folder1/file1.txt
                touch -d "2 days ago" file3.txt
                touch dir2/file2.txt file4.txt
                '''
            }
        }
        stage('Create files in audits folder'){
            when{
                expression { params.TEST_SYSTEM == "SM5-PDS1" }
            }
            agent{label 'sm5-pds1'}
            steps{
                echo"${params.TEST_SYSTEM}"1
                sh '''
                cd /opt/osi/monarch/log/eitk
                mkdir dir1 dir2 dir3 dir4
                touch -d "2 days ago" dir1/file1.txt
                touch -d "2 days ago" file3.txt
                touch dir2/file2.txt file4.txt
                '''
            }
        }
        stage('Download resources from git'){
            agent{label 'master'}
            steps{
                script{
                    bat '''
                    git clean  -d  -f .
                    git init
                    git remote add -f origin https://github.com/acruzfg/auto-task.git
                    git config core.sparseCheckout true
                    echo "/auto_common_robot" >> .git/info/sparse-checkout
                    echo "/auto_eitk3_robot" >> .git/info/sparse-checkout
                    git sparse-checkout add /auto_common_robot/SM5-DAC1_Variables.robot
                    git sparse-checkout add /auto_common_robot/SM5-PDS1_Variables.robot
                    git sparse-checkout add /auto_common_robot/General_Variables.robot
                    git sparse-checkout add /auto_common_robot/General_Keywords.robot
                    git sparse-checkout add /auto_eitk3_robot/EITK3_Clean_Up_Tasks.robot
                    git sparse-checkout add /auto_eitk3_robot/EITK3_General_Keywords.robot
                    git sparse-checkout add /auto_eitk3_robot/EITK3_General_Variables.robot
                    git pull origin main
                    '''
                }

            }
        }
        stage('Settings for EITK instance'){
            agent{label 'master'}
            steps{
                script{
                    echo "Testing node ${params.TEST_SYSTEM}"
                    bat "robot  -l EITK3_Settings__log --variable testsystem:${params.TEST_SYSTEM} --variable FileAge:${params.FileAge} --variable PayloadsStoredperTask:${params.PayloadsStoredperTask} --variable TaskHistoryAge:${params.TaskHistoryAge} --variable TaskRunRequestAge:${params.TaskRunRequestAge} --exclude restart .//auto_eitk3_robot//EITK3_Clean_Up_Tasks.robot"    
                }
            }
        }
        stage('Restart  EITK instance'){
            agent{label 'master'}
            steps{
                script{
                    echo "Testing node ${params.TEST_SYSTEM}"
                    bat "robot  -l EITK3_Restart__log --variable testsystem:${params.TEST_SYSTEM} --exclude settings .//auto_eitk3_robot//EITK3_Clean_Up_Tasks.robot"    
                }
            }
        }
        stage('Check if files were deleted'){
            when{
                expression { params.TEST_SYSTEM == "SM5-DAC1" }
            }
            agent{label 'sm5-dac1'}
            steps{
                echo"${params.TEST_SYSTEM}"
                sh '''
                git init
                git remote add -f origin https://github.com/acruzfg/auto-task.git
                git config core.sparseCheckout true
                git sparse-checkout add check-files.sh
                git pull origin
                '''
            }
        }
        stage('Check if files were deleted'){
            when{
                expression { params.TEST_SYSTEM == "SM5-PDS1" }
            }
            agent{label 'sm5-pds1'}
            steps{
                echo"${params.TEST_SYSTEM}"
                sh '''
                git init
                git remote add -f origin https://github.com/acruzfg/auto-task.git
                git config core.sparseCheckout true
                git sparse-checkout add check-files.sh
                git pull origin
                '''
            }
        }
        stage('Check audits'){
            agent{label 'master'}
            steps{
                sh '''
                git init
                git remote add -f origin https://github.com/acruzfg/auto-task.git
                git config core.sparseCheckout true
                git sparse-checkout add check-files.sh
                git pull origin
                '''
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