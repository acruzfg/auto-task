*** Settings ***
Library     RequestsLibrary
Library     CSVLibrary
Resource    EITK3_General_Endpoints_Keywords.robot
Resource    EITK3_POST_Keywords.robot
Resource    EITK3_GET_Keywords.robot
Resource    EITK3_PUT_Keywords.robot
Resource    EITK3_DELETE_Keywords.robot
Resource    EITK3_PATCH_Keywords.robot
Resource    ../auto_common_robot/${TESTSERVER}_Variables.robot
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
### TEST CASE VARIABLES ###
${TESTSERVER}=         SM5-DAC1        ### By default but values can be changed during execution
${tableId}=            ATest1
${table_name_csv}=     ATable1

*** Test Cases ***
Basic Table Operations
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    Make Sure Table Does Not Exist    ${Table_ID}
### Create table ###
    ${c0_type}=                       Set Variable                  Key
    ${c0_id}=                         Set Variable                  c0
    ${c0_name}=                       Set Variable                  Key
    ${c1_type}=                       Set Variable                  Unique
    ${c1_id}=                         Set Variable                  c1
    ${c1_name}=                       Set Variable                  Unique
    ${c2_type}=                       Set Variable                  None
    ${c2_id}=                         Set Variable                  c2
    ${c2_name}=                       Set Variable                  None
    ${c0}=                            Set Variable                  {"name": "${c0_name}","id":"${c0_id}","type":"${c0_type}"}
    ${c1}=                            Set Variable                  {"name": "${c1_name}","id":"${c1_id}","type":"${c1_type}"}
    ${c2}=                            Set Variable                  {"name": "${c2_name}","id":"${c2_id}","type":"${c2_type}"}
    ${columns}=                       Set Variable                  [${c0},${c1},${c2}]
    ${table}=                         Set Variable                  {"columns": ${columns}, "id":"${Table_ID}"}
    ${table}=                         Convert To String             ${table}
### Request to create the table ###
    ${POST_response}=                 POST-Create Table             ${table}
    Status Should Be                  201                           ${POST_response}
### Request to get the newly created table ### 
    ${GET_response}=                  GET-Table with ID             ${Table_ID}
    Status Should Be                  200                           ${GET_response}
### We verify it is the same table we sent ###
    Check Table Attribute             ${GET_response}               ${Table_ID}        $.id
    Check Table Columns Attribute     ${GET_response}               ${c0_id}           0            id
    Check Table Columns Attribute     ${GET_response}               ${c0_type}         0            type
    Check Table Columns Attribute     ${GET_response}               ${c0_name}         0            name
    Check Table Columns Attribute     ${GET_response}               ${c1_id}           1            id
    Check Table Columns Attribute     ${GET_response}               ${c1_type}         1            type
    Check Table Columns Attribute     ${GET_response}               ${c1_name}         1            name
    Check Table Columns Attribute     ${GET_response}               ${c2_id}           2            id
    Check Table Columns Attribute     ${GET_response}               ${c2_type}         2            type
    Check Table Columns Attribute     ${GET_response}               ${c2_name}         2            name
### Update table, keeping the ID ###
    ${c1_type}=                       Set Variable                  None
    ${c2_type}=                       Set Variable                  Unique
    ${c1}=                            Set Variable                  {"name": "${c1_name}","id":"${c1_id}","type":"${c1_type}"}
    ${c2}=                            Set Variable                  {"name": "${c2_name}","id":"${c2_id}","type":"${c2_type}"}
    ${columns}=                       Set Variable                  [${c0},${c1},${c2}]
    ${table}=                         Set Variable                  {"columns": ${columns}, "id":"${Table_ID}"}
    ${updated_table}=                 Convert To String             ${table}
### Request to update the table, keeping the same ID ###
    ${PUT_response}=                  PUT-Update Table              ${Table_ID}                                                        ${updated_table}
    Status Should Be                  200                           ${PUT_response}
### We verify it is the same table we updated ###
    Check Table Attribute             ${PUT_response}               ${Table_ID}            $.id
    Check Table Columns Attribute     ${PUT_response}               ${c0_id}               0            id
    Check Table Columns Attribute     ${PUT_response}               ${c0_type}             0            type
    Check Table Columns Attribute     ${PUT_response}               ${c0_name}             0            name
    Check Table Columns Attribute     ${PUT_response}               ${c1_id}               1            id
    Check Table Columns Attribute     ${PUT_response}               ${c1_type}             1            type
    Check Table Columns Attribute     ${PUT_response}               ${c1_name}             1            name
    Check Table Columns Attribute     ${PUT_response}               ${c2_id}               2            id
    Check Table Columns Attribute     ${PUT_response}               ${c2_type}             2            type
    Check Table Columns Attribute     ${PUT_response}               ${c2_name}             2            name
### Request to delete the table, verifying it really gets deleted ###
    ${DELETE_response}=               DELETE-Table with ID          ${Table_ID}
    Status Should Be                  200                           ${DELETE_response}
    Make Sure Table Does Not Exist    ${Table_ID}

### Multiple Tables ####
### Create general table columns and ids ###
    @{tables}=                        Create List            BTable1   BTable2   BTable3   BTable4   BTable5
    ${c0}=                            Set Variable           {"name": "Key","id":"c0","type":"Key"}
    ${c1}=                            Set Variable           {"name": "Unique","id":"c1","type":"Unique"}
    ${c2}=                            Set Variable           {"name": "None","id":"c2","type":"None"}
    ${columns}=                       Set Variable           [${c0},${c1},${c2}]
### Iterate to make sure table id aren't used before sending the request to create the table and verify successful response ###
    FOR    ${table_id}    IN    @{tables}
    Make Sure Table Does Not Exist    ${table_id}
    ${table}=                         Set Variable               {"columns": ${columns}, "id":"${table_id}"}
    ${table}=                         Convert To String          ${table}
    ${POST_response}=                 POST-Create Table          ${table}
    Status Should Be                  201                        ${POST_response}
    END
### We make a GET request to obtain all tables in the database, then we iterate over the table ids to make sure our tables are returned ###
    ${GET_response}=                  GET-Tables
    Status Should Be                  200                        ${GET_response}
    ${body}=                          Convert To String          ${GET_response.content}
    FOR    ${table_id}    IN    @{tables}
    Should Contain                    ${body}                    ${table_id}
    END
### We repeat the GET request but this time we make a query filter for each table id ###
    FOR    ${table_id}    IN    @{tables}  
    ${GET_response}=          GET-Tables With Filter    ["id","=","${table_id}"]
    Status Should Be          200                       ${GET_response}
    ${body}=                  Convert To String         ${GET_response.content}
    Should Contain            ${body}                   ${table_id}
### We finally delete each table ###
    ${DELETE_response}=       DELETE-Table with ID      ${table_id}
    Status Should Be          200                       ${DELETE_response}
    END    


### Basic Operations with Rows###
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    Make Sure Table Does Not Exist    ${Table_ID}
### Create a table with general columns ###
    ${c0}=                            Set Variable            {"name": "Key","id":"c0","type":"Key"}
    ${c1}=                            Set Variable            {"name": "Unique","id":"c1","type":"Unique"}
    ${c2}=                            Set Variable            {"name": "None","id":"c2","type":"None"}
    ${columns}=                       Set Variable            [${c0},${c1},${c2}]
    ${table}=                         Set Variable            {"columns": ${columns}, "id":"${Table_ID}"}
### Request to create the table ###
    ${Create_table}=                  POST-Create Table       ${table}
    Status Should Be                  201                     ${Create_table}
### Create the row for column
    ${c0_data}=                       Set Variable            key123
    ${c1_data}=                       Set Variable            0
    ${c2_data}=                       Set Variable            1
    ${row}=                           Set Variable            {"data": {"c0": "${c0_data}","c1": "${c1_data}","c2": "${c2_data}"},"tableId": "${Table_ID}"}
### Request to create the new row ###    
    ${New_Row}=            POST-Create Row            ${Table_ID}            ${row}
    Status Should Be       201                        ${New_Row}
### We save the event id for later use ###
    ${post_id}=            Note Down Event ID         ${New_Row}
### Request to obtain the newly created row ###
    ${GET_row}=            GET-Row with Key           ${Table_ID}            ${c0_data}
    Status Should Be       200                        ${GET_row}
### We check we are returned the right row ###
    Check Data in a Row            ${GET_row}            ${Table_ID}            $.tableId
    Check Data in a Row            ${GET_row}            ${c0_data}             $.key
    Check Data in a Row            ${GET_row}            ${c0_data}             $.data.c0
    Check Data in a Row            ${GET_row}            ${c1_data}             $.data.c1
    Check Data in a Row            ${GET_row}            ${c2_data}             $.data.c2
### We save the event id for later use ###
    ${get_id}=    Note Down Event ID    ${GET_row}
### Update row data ###
    ${key}=                Set Variable            key123
    ${c0_data}=            Set Variable            123key
    ${c1_data}=            Set Variable            A
    ${c2_data}=            Set Variable            B
    ${row}=                Set Variable            {"data": {"c0": "${c0_data}","c1": "${c1_data}","c2": "${c2_data}"},"tableId": "${Table_ID}"}
### Request to update the row data ###
    ${Update_row}=         PUT-Update Row          ${Table_ID}            ${key}            ${row}
    Status Should Be       201                     ${Update_row}
### We check we are returned the updated row ###
    Check Data in a Row    ${Update_row}           ${Table_ID}            $.tableId
    Check Data in a Row    ${Update_row}           ${c0_data}             $.key
    Check Data in a Row    ${Update_row}           ${c0_data}             $.data.c0
    Check Data in a Row    ${Update_row}           ${c1_data}             $.data.c1
    Check Data in a Row    ${Update_row}           ${c2_data}             $.data.c2
### We save the event id for later use ###
    ${put_id}=             Note Down Event ID      ${Update_row}
### Request to delete the row ###
    ${DELETE_row}=         DELETE-Row with Key     ${Table_ID}            ${c0_data}
    Status Should Be       200                     ${DELETE_row}
    ${delete_id}=          Note Down Event ID      ${DELETE_row}
### We check we are returned the deleted row ###
    Check Data in a Row    ${DELETE_row}           ${Table_ID}            $.tableId
    Check Data in a Row    ${DELETE_row}           ${c0_data}             $.key
    Check Data in a Row    ${DELETE_row}           ${c0_data}             $.data.c0
    Check Data in a Row    ${DELETE_row}           ${c1_data}             $.data.c1
    Check Data in a Row    ${DELETE_row}           ${c2_data}             $.data.c2
### We set data to each column, except the key column to verify a key must always be definied ###
    ${c0_data}=            Set Variable           ${EMPTY}
    ${c1_data}=            Set Variable           A
    ${c2_data}=            Set Variable           B
    ${row}=                Set Variable           {"data": {"c0": "${c0_data}","c1": "${c1_data}","c2": "${c2_data}"},"tableId": "${Table_ID}"}
### Request to create a row without key, we expect this request to fail ###
    ${second_row}=         POST-Create Row        ${Table_ID}            ${row}
    Status Should Be       400                    ${second_row}
### Request to obtain all the history events for the past operation and verify they are registered ###               
    ${events_response}=                     GET-Tables Events with Filter           ["tableId","=",${Table_ID}] 
    Verify Event Exists in Tables-Events    ${post_id}                              ${events_response}
    Verify Event Exists in Tables-Events    ${get_id}                               ${events_response}
    Verify Event Exists in Tables-Events    ${put_id}                               ${events_response}
    Verify Event Exists in Tables-Events    ${delete_id}                            ${events_response}


### Import Tables ###
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    ${Table_ID}=                            Set Variable                            ATable1
    Make Sure Table Does Not Exist          ${Table_ID}
### Obtain table from file ###
    ${table}=                               Create Request Body From CSV File      ${Table_ID}
### Request to import the table ###
    ${import_table}=                        PATCH-Import Table                     ${table}
    Status Should Be                        200                                    ${import_table}
### Request to obtain the newly imported table ###
    ${GET_response}=                        GET-Table with ID                      ${Table_ID}
    Status Should Be                        200                                    ${GET_response}
### Verify its elements ###
    Check Table Attribute                    ${GET_response}        ${Table_ID}    $.id
    Check Table Columns Attribute            ${GET_response}        c1             0        id
    Check Table Columns Attribute            ${GET_response}        Key            0        type
    Check Table Columns Attribute            ${GET_response}        C 1            0        name
    Check Table Columns Attribute            ${GET_response}        c2             1        id
    Check Table Columns Attribute            ${GET_response}        Unique         1        type
    Check Table Columns Attribute            ${GET_response}        C 2            1        name
    Check Table Columns Attribute            ${GET_response}        c3             2        id
    Check Table Columns Attribute            ${GET_response}        None           2        type
    Check Table Columns Attribute            ${GET_response}        C 3            2        name
    Check Table Columns Attribute            ${GET_response}        c4             3        id
    Check Table Columns Attribute            ${GET_response}        None           3        type
    Check Table Columns Attribute            ${GET_response}        C 4            3        name
### Update table from file ###
    ${table}=            Create Request Body From CSV File          ATable1_updated
### Request to update the table ###
    ${update_table}=     PATCH-Import Table                         ${table}
    Status Should Be     200                                        ${update_table}
### Request to obtain the newly updated table ###
    ${GET_response}=     GET-Table with ID                          ${Table_ID}
    Status Should Be     200                                        ${GET_response}
### Verify its elements ###
    Check Table Attribute                    ${GET_response}    ${Table_ID}    $.id
    Check Table Columns Attribute            ${GET_response}    c1             0            id
    Check Table Columns Attribute            ${GET_response}    Key            0            type
    Check Table Columns Attribute            ${GET_response}    CHANGED        0            name
    Check Table Columns Attribute            ${GET_response}    c2             1            id
    Check Table Columns Attribute            ${GET_response}    None           1            type
    Check Table Columns Attribute            ${GET_response}    C 2            1            name
    Check Table Columns Attribute            ${GET_response}    c3             2            id
    Check Table Columns Attribute            ${GET_response}    None           2            type
    Check Table Columns Attribute            ${GET_response}    C 3            2            name
    Check Table Columns Attribute            ${GET_response}    c5             3            id
    Check Table Columns Attribute            ${GET_response}    None           3            type
    Check Table Columns Attribute            ${GET_response}    C 5            3            name
