*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Resource    EITK3_General_Endpoints_Keywords.robot
Resource    EITK3_POST_Keywords.robot
Resource    EITK3_PATCH_Keywords.robot
Resource    Report_to_Jama.robot
Test Setup       Create Session    Swagger    ${Base_URL}
Test Teardown    Delete All Sessions

*** Variables ***
${testsystem}=    SM5-DAC1    #By default, can be changed during execution
${Table_Name}=    CTest1
${testcycle}

*** Test Cases ***
Export CSV Table
### Pre-conditions ###
### The "results" variable will be used to report to Jama. We set to 0 so if the test fails, it will report 'FAILED' to jama ###
    Set Suite Variable                ${results}                          0
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    Make Sure Table Does Not Exist    ${Table_Name}
### Create table ###
    ${c0}=                            Set Variable                        {"name": "Key","id":"c0","type":"Key"}
    ${c1}=                            Set Variable                        {"name": "Unique","id":"c1","type":"Unique"}
    ${c2}=                            Set Variable                        {"name": "None","id":"c2","type":"None"}
    ${columns}=                       Set Variable                        [${c0},${c1},${c2}]
    ${table}=                         Set Variable                        {"columns": ${columns}, "id":"${Table_Name}"}
    ${table}=                         Convert To String                   ${table}
### Make Request to Create the Table ###
    ${POST_response}=                 POST-Create Table                   ${table}
    Status Should Be                  201                                 ${POST_response}

### Export CSV Table ###
### Request to obtain the table posted in pre-conditions but in CSV format ###
    ${GET_response}=                  GET-Table with ID in CSV Format    ${Table_Name}
    Status Should Be                  200                                ${GET_response}
### Request to delete the existing table ###
    ${DELETE_response}=               DELETE-Table with ID               ${Table_Name}
    Status Should Be                  200                                ${DELETE_response}
### Verify the table was indeed deleted ###
    Make Sure Table Does Not Exist    ${Table_Name}   
### Request using the GET response to import the table. This will fail if the table is not in CSV format ###
    ${PATCH_response}=                PATCH-Import Table                 ${GET_response.content}
    Status Should Be                  200                                ${PATCH_response}
    Set Suite Variable                ${results}                         1
Report to JAMA
### Report to JAMA test results ###   
    ${jama_id}=                       Run                                python .\\auto_eitk3_endpoints\\TestCaseResults.py "Automated - Export CSV Table" "${testcycle}" 
    Run Keyword If                    ${results} == 1                    Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...  Jama-Report Failed Test      run_id=${jama_id}