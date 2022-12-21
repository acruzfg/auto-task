*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Test Setup    Create Session    Swagger    ${base_url}
Test Teardown    Delete All Sessions

*** Variables ***
${JSON_format}=    application/json
${CSV_format}=    text/csv
${base_url}=    https://sm5-dac1:8443/eitk
${token}=    60ddc80ae2381a658bf5d87e:e031c694fe4d499bab7730485b83ce2f02e310a5b5cd9acb13850615ec7b2657
### BASIC TASK SET UP ###
${name}=    Auto-Task

### STEP SET UP ###
${type}=    EXE
${hostname}=    sm5-dac1
${processName}=    osii_file_adaptor
${args}=    -i 33 --domain ASSASSIN
${envArgs}=    33
${expectedExitCode}=   0
${timeout}=    5000


*** Test Cases ***
Basic Tasks Operations
    Set Suite Variable    ${results}    0    ### Report to Jama
### Ensure task doesn not exist so to obtain accurate results ###
    Make Sure Task Does Not Exist    ${name}
### Create task details ###
    ${createAuditCopies}=    Set Variable    Always
    ${task}=    Set Variable    {"name": "${name}","createAuditCopies": "${createAuditCopies}"}
### Create task ###
    ${Create_task}=    POST-Create Task with Name    ${task}
    Verify Successful Creation    ${Create_task}
### Obtain task details ###
    ${Obtain_task_details}=    GET-Tasks With Name    ${name}
    Verify Successful Response    ${Obtain_task_details}
### Check task details are as configured for creation ###
    Check Task Details    ${Obtain_task_details}    ${name}    $.name
    Check Task Details    ${Obtain_task_details}    ${createAuditCopies}    $.createAuditCopies
### Edit task details ###
    ${createAuditCopies}=    Set Variable    OnError
    ${task}=    Set Variable    {"name": "${name}","createAuditCopies": "${createAuditCopies}"}
### Edit task#
    ${Edit_task}=    PUT-Update Task with Name    ${name}    ${task}
    Verify Successful Response    ${Edit_task}
### Obtain task details ###
    ${Obtain_task_details}=    GET-Tasks With Name    ${name}
    Verify Successful Response    ${Obtain_task_details}
### Check task details are as edited ###
    Check Task Details    ${Obtain_task_details}    ${name}    $.name
    Check Task Details    ${Obtain_task_details}    ${createAuditCopies}    $.createAuditCopies
### Create step set up ###
    ${createAuditCopies}=    Set Variable    Never
    ${steps}=    Set Variable    [{"type": "${type}","hostname": "${hostname}","processName": "${processName}","args": "${args}","envArgs": "${envArgs}","expectedExitCode": [${expectedExitCode}],"timeout": 5000}]
    ${task}=    Set Variable    {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Add step ###
    ${Add_Step}=    PUT-Update Task with Name    ${name}    ${task}
    Verify Successful Response    ${Add_Step}
### Obtain task details ###
    ${Obtain_task_details}=    GET-Tasks With Name    ${name}
    Verify Successful Response    ${Obtain_task_details}
### Verify steps exist and its details are as configured ###
    Check Task Details    ${Obtain_task_details}    ${name}    $.name
    Check Task Details    ${Obtain_task_details}    ${createAuditCopies}    $.createAuditCopies
    Check Task Details    ${Obtain_task_details}    ${type}    $.steps[0].type
    Check Task Details    ${Obtain_task_details}    ${hostname}    $.steps[0].hostname
    Check Task Details    ${Obtain_task_details}    ${processName}    $.steps[0].processName
    Check Task Details    ${Obtain_task_details}    ${args}    $.steps[0].args
    Check Task Details    ${Obtain_task_details}    ${envArgs}    $.steps[0].envArgs
    Check Task Details    ${Obtain_task_details}    ${expectedExitCode}    $.steps[0].expectedExitCode[0]
    Check Task Details    ${Obtain_task_details}    ${timeout}    $.steps[0].timeout
### Edit step details ###
    ${steps}=    Set Variable    [${EMPTY}]
### Remove step ###
    ${task}=    Set Variable    {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
    ${Remove_Step}=    PUT-Update Task with Name    ${name}    ${task}
    Verify Successful Response    ${Remove_Step}
### Obtain task details ###
    ${Obtain_task_details}=    GET-Tasks With Name    ${name}
    Verify Successful Response    ${Obtain_task_details}
### Check steps doesn't exist ###
    Check Task Details    ${Obtain_task_details}    ${name}    $.name
    Check Task Details    ${Obtain_task_details}    ${createAuditCopies}    $.createAuditCopies
    Check Task Details    ${Obtain_task_details}    ${steps}    $.steps
### Set Results to Successful ###
    Set Suite Variable    ${results}    1

Jama Report
    ${jama}=    Run    pip install py-jama-rest-client    #installs the jama rest client to e used
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Basic Task Operations"    #Gets the ID from the actual test run based in the testname 

    IF    ${results} == 1
        Jama Passed Test    run_id=${jama_id}    #if result=1, then places the result as "passed"
    ELSE
        Jama Failed Test    run_id=${jama_id}    #if result=0, then places the result as "failed"  
    END



*** Keywords ***
POST-Create Task with Name    [Arguments]    ${POST_body}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    POST On Session    Swagger    url=/api/v1/taskconfig    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

PUT-Update Task with Name    [Arguments]    ${task_name}    ${PUT_body}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    PUT On Session    Swagger    url=/api/v1/taskconfig/${task_name}   data=${PUT_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Tasks With Name    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/taskconfig/${task_name}   headers=${headers}        expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Tasks With Name Filter    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${params}=    Create Dictionary    filter=["name","=","${task_name}"]
    ${response}=    GET On Session    Swagger    url=/api/v1/taskconfig   headers=${headers}        params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

DELETE-Task with Name    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    DELETE On Session    Swagger    url=/api/v1/taskconfig/${task_name}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

Verify Reason    [Arguments]    ${response}    ${reason}
    ${body}=    Convert To String    ${response.reason}
    Should Contain    ${body}    ${reason}

Verify Successful Creation    [Arguments]    ${response}
    Status Should Be    201    ${response}
    Verify Reason    ${response}    Created

Verify Successful Response    [Arguments]    ${response}
    Status Should Be    200    ${response}

Verify Bad Request Response    [Arguments]    ${response}
    Status Should Be    400    ${response}

Make Sure Task Does Not Exist    [Arguments]    ${task_name}
    ${response}=    GET-Tasks With Name Filter    ${task_name}
    ${body}=    Convert To String    ${response.content}
    ${status}=    Evaluate    '${task_name}' in '''${body}'''
    IF    ${status}
        ${Delete_response}=    DELETE-Task with Name    ${task_name}
        Verify Successful Response    ${DELETE_response}
    END

Check Task Details    [Arguments]    ${response}    ${task_detail}    ${json_path}    ${list}=False
    ${string}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${string}
    ${task_attribute}=    Get Value From Json    ${json_body}    ${json_path}
    Should Be Equal As Strings    ${task_detail}    ${task_attribute[0]}

Jama Passed Test    [Arguments]    ${run_id}    #gets the if from the test run
    ${curl}=    Set Variable    curl -u auto_sysman:OSISysman -X PUT "https://osi.jamacloud.com/rest/v1/testruns/${run_id}" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \\"fields\\": { \\"testRunStatus\\": \\"PASSED\\", \\"automated$37\\": false }}"
    ${jama_id}=    Run    ${curl}
    Should Contain    ${jama_id}    "OK"    #validation for the endpoint response, if it contains "ok" then, the test run was updated



Jama Failed Test    [Arguments]    ${run_id}
    ${curl}=    Set Variable    curl -u auto_sysman:OSISysman -X PUT "https://osi.jamacloud.com/rest/v1/testruns/${run_id}" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \\"fields\\": { \\"testRunStatus\\": \\"PASSED\\", \\"automated$37\\": false }}"
    ${jama_id}=    Run    ${curl}
    Should Contain    ${jama_id}    "OK"

    
    