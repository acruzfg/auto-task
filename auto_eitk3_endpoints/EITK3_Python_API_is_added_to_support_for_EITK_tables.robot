*** Settings ***
Library          RequestsLibrary
Resource         EITK3_General_Endpoints_Keywords.robot
Resource         EITK3_POST_Keywords.robot
Resource         ../auto_common_robot/${TESTSERVER}_Variables.robot
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
### VARIABLES FOR TESTCASE ###
${TESTSERVER}=    SM5-DAC1    #By default, can be changed during execution
${name}=          pytest

*** Test Cases ***
Python API is added to support for EITK tables
### This test case runs a python script via a task that creates tables, thus veryfing the python Api support ###
### Ensure the task name isn't occupied already, if the name is used, the task will be deleted ###
    Make Sure Task Does Not Exist    ${name}
### Create task ###
    ${createAuditCopies}=            Set Variable              Never
    ${steps}=                        Set Variable              [ {"type" : "TRANSLATION","script" : "/opt/osi/osi_cust/table_test.py","pyScriptParam" : [ ],"type" : "TRANSLATION","protocol" : "PYTHON"} ]
    ${task}=                         Set Variable              {"name": "${name}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Request to create the task ###
    ${post_response}=                POST-Create Task          ${task}
    Status Should Be                 201                       ${post_response}
### Request to run the created task. We evaluate the run request. It must be successful###
    ${run_request}=                  POST-Run a Task           ${name}
    Status Should Be                 200                       ${run_request}
    Check Task is Successful         ${run_request}
