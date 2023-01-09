*** Settings ***
Library    RequestsLibrary
Resource    EITK3_General_Endpoints_Keywords.robot
Resource    EITK3_POST_Keywords.robot
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Resource    Report_to_Jama.robot
Test Setup    Create Session    Swagger    ${Base_URL}
Test Teardown    Delete All Sessions

*** Variables ***
${testsystem}=    SM5-DAC1    #By default, can be changed during execution
${name}=          pytest
${testcycle}

*** Test Cases ***
Python API is added to support for EITK tables
### This test case runs a python script via a task that creates tables ###
### The "results" variable will be used to report to Jama. We set to 0 so if the test fails, it will report 'FAILED' to jama ###
    Set Suite Variable    ${results}    0
### Ensure the task name isn't occupied already, if the name is used, the task will be deleted ###
    Make Sure Task Does Not Exist    ${name}
### Create task ###
    ${createAuditCopies}=    Set Variable    Never
    ${steps}=    Set Variable    [ {"type" : "TRANSLATION","script" : "/opt/osi/osi_cust/table_test.py","pyScriptParam" : [ ],"type" : "TRANSLATION","protocol" : "PYTHON"} ]
    ${task}=    Set Variable    {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Request to create the task ###
    ${post_response}=    POST-Create Task    ${task}
    Status Should Be    201    ${post_response}
### Request to run the created task. We evaluate the run request. It must be successful###
    ${run_request}=    POST-Run a Task    ${name}
    Status Should Be    200    ${run_request}
    Check Task is Successful    ${run_request}
    Set Suite Variable    ${results}    1

Report to JAMA
### Report to JAMA test results ###   
    ${jama_id}=    Run    python .\\auto_eitk3_endpoints\\TestCaseResults.py "Automated - Python API is added to support for EITK tables" "${testcycle}" 
    Run Keyword If    ${results} == 1    Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...    Jama-Report Failed Test    run_id=${jama_id}