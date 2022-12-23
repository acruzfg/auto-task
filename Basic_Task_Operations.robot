*** Settings ***
Resource   EITK_Task_Endpoints_Keywords.robot
Resource   Report_to_Jama.robot
Resource   ${testsystem}_API_Variables.robot   
Test Setup    Create Session    Swagger    ${base_url}
Test Teardown    Delete All Sessions

*** Variables ***
### BASIC TASK SET UP ###
${name}=    Auto-Task
${testsystem}=    SM5_DAC1

### STEP SET UP ###
${type}=    EXE
${hostname}=    sm5-dac1
${processName}=    osii_file_adaptor
${args}=    -i 33 --domain CC
${envArgs}=    33
${expectedExitCode}=   0
${timeout}=    5000

*** Test Cases ***
Basic Tasks Operations
    Set Suite Variable    ${results}    0    ### Report to Jama
### Ensure task does not exist to obtain accurate results ###
    Make Sure Task Does Not Exist    ${name}
### Create task details ###
    ${createAuditCopies}=    Set Variable    Always
    ${task}=    Set Variable    {"name": "${name}","createAuditCopies": "${createAuditCopies}"}
### Create task ###
    ${Create_task}=    POST-Create Task with Name    ${task}
    Status Should Be    201    ${Create_task}
### Obtain task details ###
    ${Task_details}=    GET-Tasks With Name    ${name}
    Status Should Be    200    ${Task_details}
### Check task details are as configured for creation ###
    Check Task Details    ${Task_details}    ${name}    $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies
### Edit task details ###
    ${createAuditCopies}=    Set Variable    OnError
    ${task}=    Set Variable    {"name": "${name}","createAuditCopies": "${createAuditCopies}"}
### Edit task#
    ${Edit_task}=    PUT-Update Task with Name    ${name}    ${task}
    Status Should Be    200    ${Edit_task}
### Obtain task details ###
    ${Task_details}=    GET-Tasks With Name    ${name}
    Status Should Be    200    ${Task_details}
### Check task details are as edited ###
    Check Task Details    ${Task_details}    ${name}    $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies
### Create step set up ###
    ${createAuditCopies}=    Set Variable    Never
    ${steps}=    Set Variable    [{"type": "${type}","hostname": "${hostname}","processName": "${processName}","args": "${args}","envArgs": "${envArgs}","expectedExitCode": [${expectedExitCode}],"timeout": ${timeout} }]
    ${task}=    Set Variable    {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Add step ###
    ${Add_Step}=    PUT-Update Task with Name    ${name}    ${task}
    Status Should Be    200    ${Add_Step}
### Obtain task details ###
    ${Task_details}=    GET-Tasks With Name    ${name}
    Status Should Be    200    ${Task_details}
### Verify steps exist and its details are as configured ###
    Check Task Details    ${Task_details}    ${name}    $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies
    Check Task Details    ${Task_details}    ${type}    $.steps[0].type
    Check Task Details    ${Task_details}    ${hostname}    $.steps[0].hostname
    Check Task Details    ${Task_details}    ${processName}    $.steps[0].processName
    Check Task Details    ${Task_details}    ${args}    $.steps[0].args
    Check Task Details    ${Task_details}    ${envArgs}    $.steps[0].envArgs
    Check Task Details    ${Task_details}    ${expectedExitCode}    $.steps[0].expectedExitCode[0]
    Check Task Details    ${Task_details}    ${timeout}    $.steps[0].timeout
### Edit step details ###
    ${steps}=    Set Variable    [${EMPTY}]
    ${task}=    Set Variable    {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Remove step ###
    ${Remove_Step}=    PUT-Update Task with Name    ${name}    ${task}
    Status Should Be    200    ${Remove_Step}
### Obtain task details ###
    ${Task_details}=    GET-Tasks With Name    ${name}
    Status Should Be    200    ${Task_details}
### Check steps doesn't exist ###
    Check Task Details    ${Task_details}    ${name}    $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies
    Check Task Details    ${Task_details}    ${steps}    $.steps
### Set Results to Successful ###
    Set Suite Variable    ${results}    1

Jama Report   
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Basic Task Operations"     
    Run Keyword If    ${results} == 1    Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...    Jama-Report Failed Test    run_id=${jama_id}