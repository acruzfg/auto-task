*** Settings ***
Library    JSONLibrary
Resource   EITK3_General_Endpoints_Keywords.robot
Resource   EITK3_POST_Keywords.robot
Resource   EITK3_GET_Keywords.robot
Resource   EITK3_PUT_Keywords.robot
Resource   ../auto_common_robot/${TESTSERVER}_Variables.robot
Test Setup       Create Session    Swagger    ${Base_URL}
Test Teardown    Delete All Sessions 
Suite Teardown   Run Keywords
...              Run Keyword If All Tests Passed    Run    jama_report_results.EXE --testplanid ${testplanid} --testcaseid ${testcaseid} --passed True --user ${jamauser} --password ${jamapwd} --notes "Test passed"
...    AND       Run Keyword If Any Tests Failed    Run    jama_report_results.EXE --testplanid ${testplanid} --testcaseid ${testcaseid} --passed False --user ${jamauser} --password ${jamapwd} --notes "Test failed. Check logs for more information"

*** Variables ***
### VARIABLES TO REPORT IN JAMA ###
${testplanid}
${testcaseid}
${jamauser}
${jamapwd}
### BASIC TASK SET UP ###
${name}=          Auto-Task-Basic-Verification      ##Variables by default but can be changed during execution
${TESTSERVER}=    SM5-DAC1      

### STEP SET UP ###                                 ## Default step type is EXE, that can't be changed but all the set up can be changed if needed.
${type}=               EXE                          ## Step type
${hostname}=           sm5-dac1                     ## Hostname
${processName}=        osii_file_adaptor            ## whitelisted process to run
${domain}              CC                           ## hostname's domain
${envArgs}=            33                           ## enviroment arguments for process
${expectedExitCode}=   0                            ## meaning the process was successful
${timeout}=            5000                         ## in miliseconds

*** Test Cases ***
Basic Tasks Operations
### Ensure task does not exist to obtain accurate results ###
    Make Sure Task Does Not Exist    ${name}
### Create task details ###
    ${createAuditCopies}=            Set Variable           Always
    ${task}=                         Set Variable           {"name": "${name}","createAuditCopies": "${createAuditCopies}"}
### Create task ###
    ${Create_task}=                  POST-Create Task       ${task}
    Status Should Be                 201                    ${Create_task}
### Obtain task details ###
    ${Task_details}=                 GET-Tasks With Name    ${name}
    Status Should Be                 200                    ${Task_details}
### Verifying task details are returned as expected
    Check Task Details    ${Task_details}    ${name}                 $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies

### Edit task details ###
    ${createAuditCopies}=            Set Variable        OnError
    ${task}=                         Set Variable        {"name": "${name}","createAuditCopies": "${createAuditCopies}"}
### Edit task#
    ${Edit_task}=            PUT-Update Task with Name   ${name}        ${task}
    Status Should Be         200                         ${Edit_task}
### Obtain task details ###
    ${Task_details}=         GET-Tasks With Name         ${name}
    Status Should Be         200                         ${Task_details}
### Verifying task details are returned as expected
    Check Task Details    ${Task_details}    ${name}                 $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies

### Create step set up ###
    ${createAuditCopies}=        Set Variable        Never
    ${args}=                     Set Variable        -i 33 --domain ${domain}
    ${steps}=                    Set Variable        [{"type": "${type}","hostname": "${hostname}","processName": "${processName}","args": "${args}","envArgs": "${envArgs}","expectedExitCode": [${expectedExitCode}],"timeout": ${timeout} }]
    ${task}=                     Set Variable        {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Add step ###
    ${Add_Step}=        PUT-Update Task with Name    ${name}        ${task}
    Status Should Be    200                          ${Add_Step}
### Obtain task details ###
    ${Task_details}=    GET-Tasks With Name          ${name}
    Status Should Be    200                          ${Task_details}
### Verify steps exist and its details are as expected ###
    Check Task Details    ${Task_details}    ${name}                 $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies
    Check Task Details    ${Task_details}    ${type}                 $.steps[0].type
    Check Task Details    ${Task_details}    ${hostname}             $.steps[0].hostname
    Check Task Details    ${Task_details}    ${processName}          $.steps[0].processName
    Check Task Details    ${Task_details}    ${args}                 $.steps[0].args
    Check Task Details    ${Task_details}    ${envArgs}              $.steps[0].envArgs
    Check Task Details    ${Task_details}    ${expectedExitCode}     $.steps[0].expectedExitCode[0]
    Check Task Details    ${Task_details}    ${timeout}              $.steps[0].timeout

### Edit step details ###
    ${steps}=        Set Variable    [${EMPTY}]
    ${task}=         Set Variable    {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Remove step ###
    ${Remove_Step}=     PUT-Update Task with Name    ${name}        ${task}
    Status Should Be    200                          ${Remove_Step}
### Obtain task details ###
    ${Task_details}=    GET-Tasks With Name          ${name}
    Status Should Be    200                          ${Task_details}
### Check steps doesn't exist ###
    Check Task Details    ${Task_details}    ${name}                 $.name
    Check Task Details    ${Task_details}    ${createAuditCopies}    $.createAuditCopies
    Check Task Details    ${Task_details}    ${steps}                $.steps

*** Keywords ***
Check Task Details        [Arguments]               ${response}             ${task_detail}    ${json_path}    
    ${string}=            Convert To String         ${response.content}
    ${json_body}=         Convert String To Json    ${string}
    ${task_attribute}=    Get Value From Json       ${json_body}            ${json_path}
    Should Be Equal As Strings                      ${task_detail}          ${task_attribute[0]}