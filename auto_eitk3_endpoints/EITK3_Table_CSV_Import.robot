*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Resource    EITK3_General_Endpoints_Keywords.robot
Resource    EITK3_POST_Keywords.robot
Resource    EITK3_GET_Keywords.robot
Resource    EITK3_PUT_Keywords.robot
Resource    EITK3_DELETE_Keywords.robot
Resource    EITK3_PATCH_Keywords.robot
Resource    Report_to_Jama.robot
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Test Setup    Create Session    Swagger    ${Base_URL}
Test Teardown    Delete All Sessions

*** Variables ***
### TABLES_IDS ###
${testsystem}=    SM5-DAC1    ##By default, can be changed during execution
${testcycle}

*** Test Cases ***
Table CSV Import
### Small Table Operations ###
### The "results" variable will be used to report to Jama. We set to 0 so if the test fails, it will report 'FAILED' to jama ###
    Set Suite Variable    ${results}    ${0}
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    ${table_id}=    Set Variable    Table1_A
    Make Sure Table Does Not Exist    ${table_id}
### Request to import a small table in CSV format ###
    ${table}=    Create Request Body From CSV File    ${table_id}
    ${PATCH_response}=    PATCH-Import Table    ${table}
    Status Should Be    200    ${PATCH_response}
### Request to obtain the newly created table ###
    ${GET_response}=    GET-Table with ID    ${table_id}
    Status Should Be    200    ${GET_response}
### Verify column names ###
    ${names}=    Create List    Column 0    Column 1    Column 2
    FOR    ${counter}    IN RANGE    0    3
        Check Table Columns Attribute    ${GET_response}    ${names}[${counter}]    ${counter}    name    
    END
### Request to obtain the newly created table rows ###
    ${GET_response_rows}=    GET-Tables Rows    ${table_id}
    Status Should Be    200    ${GET_response_rows}
### Count the number of rows and verify it is consistent with the table ###
    ${number_of_rows}=    Count Rows    ${GET_response_rows}
    Should Be Equal As Strings    10    ${number_of_rows}
###Verify each row hast data in each column, using the columnd id ###
    @{ids}=    Create List    c0    c1    c2
    FOR    ${counter}    IN RANGE    0    10
        FOR    ${id}    IN    @{ids}
            Check Rows Have Values    ${GET_response_rows}    ${counter}    ${id}    
        END    
    END
### Repeat the same verification but using another table ###
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    ${table_id}=    Set Variable    Table1_B
    Make Sure Table Does Not Exist    ${table_id}
### Request to import a small table in CSV format ###
    ${table}=    Create Request Body From CSV File    ${table_id}
    ${PATCH_response}=    PATCH-Import Table    ${table}
    Status Should Be    200    ${PATCH_response}
### Request to obtain the newly created table ###
    ${GET_response}=    GET-Table with ID    ${table_id}
    Status Should Be    200    ${GET_response}
### Verify column names ###
    ${names}=    Create List    Column 0    Column 1    Column 3
    FOR    ${counter}    IN RANGE    0    3
        Check Table Columns Attribute    ${GET_response}    ${names}[${counter}]    ${counter}    name    
    END
### Request to obtain the newly created table rows ###
    ${GET_response_rows}=    GET-Tables Rows    ${table_id}
    Status Should Be    200    ${GET_response_rows}
### Count the number of rows and verify it is consistent with the table ###
    ${number_of_rows}=    Count Rows    ${GET_response_rows}
    Should Be Equal As Strings    5    ${number_of_rows}
###Verify each row hast data in each column, using the columnd id ###
    @{ids}=    Create List    c0    c1    c3
    FOR    ${counter}    IN RANGE    0    5
        FOR    ${id}    IN    @{ids}
            Check Rows Have Values    ${GET_response_rows}    ${counter}    ${id}    
        END    
    END


### Large Table Operations ###
### We set the name of the tables to upload using curl ###
    ${table2a}=    Set Variable    Table2_A
    ${table2b}=    Set Variable    Table2_B
### First, we make sure the table names aren't used. If they are, we delete those tables ###
### The keyword "Make Sure Table Does Not Exist" depends on a DELETE request, and if the tables are large, it could timeout so we choose to ignore the timeout error ###
    Run Keyword And Ignore Error    Make Sure Table Does Not Exist    ${table2a}
    Run Keyword And Ignore Error    Make Sure Table Does Not Exist    ${table2b}
    Sleep    3min    ### Time to make sure the tables are deleted. Otherwise, the patch request doesn't upload all rows
    ${upload_table2a}=    Run    curl -X PATCH "${Base_URL}/eitk/api/v1/tables-import" -H "Content-Type: text/csv" -H "osiApiToken: ${Token}" --data-binary "@./Files/Table2_A.csv" --insecure -v --connect-timeout 900
    ${upload_table2b}=    Run    curl -X PATCH "${Base_URL}/eitk/api/v1/tables-import" -H "Content-Type: text/csv" -H "osiApiToken: ${Token}" --data-binary "@./Files/Table2_B.csv" --insecure -v --connect-timeout 900
### The row number must be verified directly in the test system so we continue with the test and report to JAMA the 'Passed' or 'Failed' states of this part of the test ###


### Empty values ###
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    ${table_id}=    Set Variable    Table3
    Make Sure Table Does Not Exist    ${table_id}
### Request to import a table in CSV format ###
    ${table}=    Create Request Body From CSV File    ${table_id}
    ${PATCH_response}=    PATCH-Import Table    ${table}
    Status Should Be    200    ${PATCH_response}
### Request to obtain the newly created table ###
    ${GET_response}=    GET-Table with ID    ${table_id}
    Status Should Be    200    ${GET_response}
### Verify column names ###
    ${names}=    Create List    Column 0    Column 1    Column 2
    FOR    ${counter}    IN RANGE    0    3
        Check Table Columns Attribute    ${GET_response}    ${names}[${counter}]    ${counter}    name    
    END
### Request to obtain the newly created table rows ###
    ${GET_response_rows}=    GET-Tables Rows    ${table_id}
    Status Should Be    200    ${GET_response_rows}
### Count the number of rows and verify it is consistent with the table ###
    ${number_of_rows}=    Count Rows    ${GET_response_rows}
    Should Be Equal As Strings    2    ${number_of_rows}
### Verify row with key = k0 has values for the columns 'c0', and 'c2' ###
    @{ids}=    Create List    c0    c2
    Check Data in a Row    ${GET_response_rows}    k0    $.[0].key    ##First check row 0 has key = k0
    FOR    ${id}    IN    @{ids}
        Check Rows Have Values    ${GET_response_rows}    0    ${id}    
    END
### Verify row with key = k1 has values for the columns 'c0', and 'c1' ###
    @{ids}=    Create List    c0    c1
    Check Data in a Row    ${GET_response_rows}    k1    $.[1].key    ##First check row 1 has key = k1
    FOR    ${id}    IN    @{ids}
        Check Rows Have Values    ${GET_response_rows}    1    ${id}    
    END


### Not values ###
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    ${table_id}=    Set Variable    Table4
    Make Sure Table Does Not Exist    ${table_id}
### Request to import a table in CSV format ###
    ${table}=    Create Request Body From CSV File    ${table_id}
    ${PATCH_response}=    PATCH-Import Table    ${table}
    Status Should Be    200    ${PATCH_response}
### Request to obtain the newly created table ###
    ${GET_response}=    GET-Table with ID    ${table_id}
    Status Should Be    200    ${GET_response}
### Verify column names ###
    ${names}=    Create List    Column 0    Column 1    Column 2
    FOR    ${counter}    IN RANGE    0    3
        Check Table Columns Attribute    ${GET_response}    ${names}[${counter}]    ${counter}    name    
    END
### Request to obtain the newly created table rows ###
    ${GET_response_rows}=    GET-Tables Rows    ${table_id}
    Status Should Be    200    ${GET_response_rows}
### Count the number of rows and verify it is consistent with the table, which in this case means that each row must have a key defined ###
    ${number_of_rows}=    Count Rows    ${GET_response_rows}
    Should Be Equal As Strings    1    ${number_of_rows}


### Invalid missing keys ###
### Ensure the table name isn't occupied already, if the name is used, the table will be deleted ###
    ${table_id}=    Set Variable    Table5
    Make Sure Table Does Not Exist    ${table_id}
### Request to import a table in CSV format ###
    ${table}=    Create Request Body From CSV File    ${table_id}
    ${PATCH_response}=    PATCH-Import Table    ${table}
    Status Should Be    200    ${PATCH_response}
### Request to obtain the newly created table ###
    ${GET_response}=    GET-Table with ID    ${table_id}
    Status Should Be    200    ${GET_response}
### Verify column names ###
    ${names}=    Create List    Column 0    Column 1    Column 2
    FOR    ${counter}    IN RANGE    0    3
        Check Table Columns Attribute    ${GET_response}    ${names}[${counter}]    ${counter}    name    
    END
### Request to obtain the newly created table rows ###
    ${GET_response_rows}=    GET-Tables Rows    ${table_id}
    Status Should Be    200    ${GET_response_rows}
### Count the number of rows and verify it is consistent with the table, which in this case means the key value for a row must be unique ###
    ${number_of_rows}=    Count Rows    ${GET_response_rows}
    Should Be Equal As Strings    1    ${number_of_rows}
    Set Suite Variable    ${results}    1


Report to JAMA
### Report to JAMA test results ###   
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Table CSV Import" "${testcycle}" 
    Run Keyword If    ${results} == 1    Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...    Jama-Report Failed Test    run_id=${jama_id}