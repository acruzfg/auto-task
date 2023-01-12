*** Settings ***
Library     RequestsLibrary
Library     CSVLibrary
Resource    EITK3_General_Endpoints_Keywords.robot
Resource    EITK3_POST_Keywords.robot
Resource    EITK3_GET_Keywords.robot
Resource    EITK3_PUT_Keywords.robot
Resource    EITK3_DELETE_Keywords.robot
Resource    EITK3_PATCH_Keywords.robot
Resource    Report_to_Jama.robot
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Test Setup       Create Session    Swagger    ${Base_URL}
Test Teardown    Delete All Sessions

*** Variables ***
${testsystem}=    SM5-DAC1
${testcycle}

*** Test Cases ***
Column Types
### The "results" variable will be used to report to Jama. We set to 0 so if the test fails, it will report 'FAILED' to jama ###
    Set Suite Variable                ${results}                0
### Key Column Must Exist ###
    ${table_id}=                      Set Variable              CTest1
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    Make Sure Table Does Not Exist    ${table_id}
### Create table ### 
    ${c0_type}=                       Set Variable              Key
    ${c0_id}=                         Set Variable              c0
    ${c0_name}=                       Set Variable              Key
    ${c1_type}=                       Set Variable              Unique
    ${c1_id}=                         Set Variable              c1
    ${c1_name}=                       Set Variable              Unique
    ${c2_type}=                       Set Variable              None
    ${c2_id}=                         Set Variable              c2
    ${c2_name}=                       Set Variable              None
    ${c0}=                            Set Variable              {"name": "${c0_name}","id":"${c0_id}","type":"${c0_type}"}
    ${c1}=                            Set Variable              {"name": "${c1_name}","id":"${c1_id}","type":"${c1_type}"}
    ${c2}=                            Set Variable              {"name": "${c2_name}","id":"${c2_id}","type":"${c2_type}"}
    ${columns}=                       Set Variable              [${c0},${c1},${c2}]
    ${table}=                         Set Variable              {"columns": ${columns}, "id":"${table_id}"}
    ${table}=                         Convert To String         ${table}
### Request to create the table ###
    ${POST_response}=                 POST-Create Table         ${table}
    Status Should Be                  201                       ${POST_response}
### Update table, changing the 'Key' column type to something else ###
    ${c0_type}=                       Set Variable              None
    ${c0}=                            Set Variable              {"name": "${c0_name}","id":"${c0_id}","type":"${c0_type}"}
    ${columns}=                       Set Variable              [${c0},${c1},${c2}]
    ${table}=                         Set Variable              {"columns": ${columns}, "id":"${Table_ID}"}
    ${updated_table}=                 Convert To String         ${table}
### Request to update the table, changing the 'Key' column type to something else. We expect this request to fail as a table must have a key column defined. ###
    ${PUT_response}=                  PUT-Update Table          ${Table_ID}                                                    ${updated_table}
    Status Should Be                  400                       ${PUT_response}


## Unique&Key Column Type Only Allows Unique Values ###
    ${table_id}=                      Set Variable              UniqueTest1
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    Make Sure Table Does Not Exist    ${table_id}
### Create table ###
    ${c0_type}=                        Set Variable             Key
    ${c0_id}=                          Set Variable             key
    ${c0_name}=                        Set Variable             Key
    ${c1_type}=                        Set Variable             Unique
    ${c1_id}=                          Set Variable             unique
    ${c1_name}=                        Set Variable             Unique
    ${c0}=                             Set Variable             {"name": "${c0_name}","id":"${c0_id}","type":"${c0_type}"}
    ${c1}=                             Set Variable             {"name": "${c1_name}","id":"${c1_id}","type":"${c1_type}"}
    ${columns}=                        Set Variable             [${c0},${c1}]
    ${table}=                          Set Variable             {"columns": ${columns}, "id":"${table_id}"}
    ${table}=                          Convert To String        ${table}
### Request to create the table ###
    ${POST_response}=                  POST-Create Table        ${table}
    Status Should Be                   201                      ${POST_response}
### Create the row for column ###
    ${c0_data}=                        Set Variable             1
    ${c1_data}=                        Set Variable             1
    ${row}=                            Set Variable             {"data": {"${c0_id}": "${c0_data}","${c1_id}": "${c1_data}"},"tableId": "${table_id}"}
### Request to create the new row ###    
    ${POST_response}=                  POST-Create Row          ${table_id}    ${row}
    Status Should Be                   201                      ${POST_response}
### We repeat the request and expect it to fail, rejecting a duplicate key value and a duplicate value in the unique type column ###
    ${POST_response}=                  POST-Create Row          ${table_id}    ${row}
    Status Should Be                   400                      ${POST_response}
### Update the row for column ###
    ${c0_data}=                        Set Variable             1
    ${c1_data}=                        Set Variable             2
    ${row}=                            Set Variable             {"data": {"${c0_id}": "${c0_data}","${c1_id}": "${c1_data}"},"tableId": "${table_id}"}
### We repeat the request and expect it to fail, rejecting a duplicate key value ###
    ${POST_response}=                  POST-Create Row          ${table_id}    ${row}
    Status Should Be                   400                      ${POST_response}
### Update the row for column ###
    ${c0_data}=                        Set Variable             2
    ${c1_data}=                        Set Variable             1
    ${row}=                            Set Variable             {"data": {"${c0_id}": "${c0_data}","${c1_id}": "${c1_data}"},"tableId": "${table_id}"}
### We repeat the request and expect it to fail, rejecting a dduplicate value in the unique type column ###
    ${POST_response}=                  POST-Create Row          ${table_id}    ${row}
    Status Should Be                   400                      ${POST_response}
### Update the row for column ###
    ${c0_data}=                        Set Variable             2
    ${c1_data}=                        Set Variable             2
    ${row}=                            Set Variable             {"data": {"${c0_id}": "${c0_data}","${c1_id}": "${c1_data}"},"tableId": "${table_id}"}
### We repeat the request and expect it to success as there are no conflicts ###
    ${POST_response}=                  POST-Create Row          ${table_id}                                                                                   ${row}
    Status Should Be                   201                      ${POST_response}


### Change Column Type Requires No Conflicts ###
    ${table_id}=                       Set Variable             ChangeTest1
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    Make Sure Table Does Not Exist     ${table_id}
### Create table ###
    ${c0_type}=                        Set Variable             Key
    ${c0_id}=                          Set Variable             key
    ${c0_name}=                        Set Variable             Key
    ${c1_type}=                        Set Variable             None
    ${c1_id}=                          Set Variable             unique
    ${c1_name}=                        Set Variable             Unique
    ${c0}=                             Set Variable             {"name": "${c0_name}","id":"${c0_id}","type":"${c0_type}"}
    ${c1}=                             Set Variable             {"name": "${c1_name}","id":"${c1_id}","type":"${c1_type}"}
    ${columns}=                        Set Variable             [${c0},${c1}]
    ${table}=                          Set Variable             {"columns": ${columns}, "id":"${table_id}"}
    ${table}=                          Convert To String        ${table}
### Request to create the table ###
    ${POST_response}=                  POST-Create Table        ${table}
    Status Should Be                   201                      ${POST_response}
### Create the row for column ###
    ${c0_data}=                        Set Variable             1
    ${c1_data}=                        Set Variable             1
    ${row}=                            Set Variable             {"data": {"${c0_id}": "${c0_data}","${c1_id}": "${c1_data}"},"tableId": "${table_id}"}
### Request to create the new row ###    
    ${POST_response}=                  POST-Create Row          ${table_id}                                                                                   ${row}
    Status Should Be                   201                      ${POST_response}
### Create a second row ###
    ${c0_data}=                        Set Variable             2
    ${c1_data}=                        Set Variable             1
    ${row}=                            Set Variable             {"data": {"${c0_id}": "${c0_data}","${c1_id}": "${c1_data}"},"tableId": "${table_id}"}
### Request to add the second row ###    
    ${POST_response}=                  POST-Create Row          ${table_id}                                                                                   ${row}
    Status Should Be                   201                      ${POST_response}
### Update table ###
    ${c1_type}=                        Set Variable             Unique
    ${c1}=                             Set Variable             {"name": "${c1_name}","id":"${c1_id}","type":"${c1_type}"}
    ${columns}=                        Set Variable             [${c0},${c1}]
    ${table}=                          Set Variable             {"columns": ${columns}, "id":"${table_id}"}
    ${updated_table}=                  Convert To String        ${table}
### Request to update the table, changing the 'None' column type to 'Unique' type. We expect this request to fail as a there's a duplicated value in a Unique type column ###
    ${PUT_response}=                   PUT-Update Table         ${Table_ID}                                                                                   ${updated_table}
    Status Should Be                   400                      ${PUT_response}
### Request to delete the second row, deleting the conflict as well ###
    ${DELETE_row}=                     DELETE-Row with Key      ${Table_ID}                                                                                   ${c0_data}
    Status Should Be                   200                      ${DELETE_row}
### Repeat the request to update the table, changing the 'None' column type to 'Unique' type. We expect this request to be successful as we deleted the duplicate value ###
    ${PUT_response}=                   PUT-Update Table         ${Table_ID}                                                                                   ${updated_table}
    Status Should Be                   200                      ${PUT_response}
    Set Suite Variable                 ${results}               1
Jama Report
### Report to JAMA test results ###   
    ${jama_id}=                        Run                      python .\\auto_eitk3_endpoints\\TestCaseResults.py "Automated - Table Column Types" "${testcycle}" 
    Run Keyword If                     ${results} == 1          Jama-Report Passed Test                                                                       run_id=${jama_id}
    ...  ELSE
    ...  Jama-Report Failed Test       run_id=${jama_id}