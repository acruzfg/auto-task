*** Settings ***
Resource    ../Resources/Pre-Conditions/pre-conditions.robot
Resource    ../Resources/API/POST.robot
Resource    ../Resources/API/PUT.robot
Resource    ../Resources/API/GET.robot
Resource    ../Resources/API/DELETE.robot
Resource    ../Resources/Validation/Validation.robot
Test Setup    Create Swagger Session
Test Teardown    Delete All Sessions


*** Variables ***
${python_task}=    pytest
${testcycle}

*** Test Cases ***
Python API is added to support for EITK tables
    Set Suite Variable    ${results}    0
    Make Sure Task Does Not Exist    ${python_task}
    ${post_response}=    POST Task with Name    ${python_task}
    ${run_request}=    Run a Task with Name    ${python_task}
    Evaluate Task Status    ${run_request}
    Set Suite Variable    ${results}    1

Report to JAMA
### Report to JAMA test results ###   
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Basic Task Operations" "${testcycle}" 
    Run Keyword If    ${results} == 1    Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...    Jama-Report Failed Test    run_id=${jama_id}

