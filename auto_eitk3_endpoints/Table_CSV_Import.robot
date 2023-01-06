*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Resource    ../Resources/API/POST.robot
Resource    ../Resources/API/PUT.robot
Resource    ../Resources/API/GET.robot
Resource    ../Resources/API/DELETE.robot
Resource    ../Resources/Validation/Validation.robot
Resource    ../Resources/API/PATCH.robot
Test Setup    Create Swagger Session
Test Teardown    Delete All Sessions

*** Variables ***
### TABLES_IDS ###
${table1a}=    Table1_A
${table1b}=    Table1_B
${table2a}=    Table2_A
${table2b}=    Table2_B
${table3}=    Table3
${table4}=    Table4
${table5}=    Table5

### JSON PATH ###

${column_json_path}=    $.columns


#@{ta_ids}=    c0    c1    c2
@{tb_ids}=    c0    c1    c3
@{t3_ids}=    c0    c1    c2
@{t4_ids}=    c0    c1    c2
@{t5_ids}=    c0    c1    c2
@{ta_names}=    Column 0    Column 1    Column 2
@{tb_names}=    Column 0    Column 1    Column 3
@{t3_names}=    Column 0    Column 1    Column 2
@{t4_names}=    Column 0    Column 1    Column 2
@{t5_names}=    Column 0    Column 1    Column 2


*** Test Cases ***
Table CSV Import
    Set Suite Variable    ${results}    0
    Make Sure Table Does Not Exist    ${table1a}
    ${PATCH_response_a}=    PATCH Table from Import    ${table1a}
    Verify Successful Response    ${PATCH_response_a}

    ${GET_response_a}=    GET Table with ID    ${table1a}
    Verify Successful Response    ${GET_response_a}
    Check Table1_A Columns ID    ${GET_response_a}
    Check Table1_A Columns Names    ${GET_response_a}

    ${rows_response_a}=    GET Rows    ${table1a}
    Verify Successful Response    ${rows_response_a}
    Check Number of Rows    ${rows_response_a}    10
    Check Table1_A Columns    ${rows_response_a}

    Make Sure Table Does Not Exist    ${table1b}
    ${PATCH_response_b}=    PATCH Table from Import    ${table1b}
    Verify Successful Response    ${PATCH_response_b}

    ${GET_response_b}=    GET Table with ID    ${table1b}
    Verify Successful Response    ${GET_response_b}
    Check Table1_B Columns ID    ${GET_response_b}
    Check Table1_B Columns Names    ${GET_response_b}

    ${rows_response_b}=    GET Rows    ${table1b}
    Verify Successful Response    ${rows_response_b}
    Check Number of Rows    ${rows_response_b}    5
    Check Table1_B Columns    ${rows_response_b}

    Run Keyword And Ignore Error    Make Sure Table Does Not Exist    ${table2a}
    Run Keyword And Ignore Error    Make Sure Table Does Not Exist    ${table2b}
    Sleep    3min    ### Time to make sure the tables are deleted. Otherwise, the patch request does not complete
    ${upload_table2a}=    Run    curl -X PATCH "https://sm5-dac1:8443/eitk/api/v1/tables-import" -H "Content-Type: text/csv" -H "osiApiToken: ${token}" --data-binary "@./Files/Table2_A.csv" --insecure -v --connect-timeout 900
    ${download_table2a}=    Run    curl -X GET "https://sm5-dac1:8443/eitk/api/v1/tables/Table2_A/rows" -H "accept: application/json" -H "osiApiToken: ${token}" --connect-timeout 900 
    ${upload_table2b}=    Run    curl -X PATCH "https://sm5-dac1:8443/eitk/api/v1/tables-import" -H "Content-Type: text/csv" -H "osiApiToken: ${token}" --data-binary "@./Files/Table2_B.csv" --insecure -v --connect-timeout 900
    ${download_table2b}=    Run    curl -X GET "https://sm5-dac1:8443/eitk/api/v1/tables/Table2_B/rows" -H "accept: application/json" -H "osiApiToken: ${token}" --connect-timeout 900 


    Make Sure Table Does Not Exist    ${table3}
    ${PATCH_response}=    PATCH Table from Import    ${table3}
    Verify Successful Response    ${PATCH_response}


    ${GET_response}=    GET Table with ID    ${table3}
    Verify Successful Response    ${GET_response}
    Check Table3 Columns ID    ${GET_response}
    Check Table3 Columns Names    ${GET_response}

    ${rows_response}=    GET Rows    ${table3}
    Verify Successful Response    ${rows_response}
    Check Number of Rows    ${rows_response}    2
    Check Table3 Columns    ${rows_response}


    Make Sure Table Does Not Exist    ${table4}
    ${PATCH_response}=    PATCH Table from Import    ${table4}
    Verify Successful Response    ${PATCH_response}

    ${GET_response}=    GET Table with ID    ${table4}
    Verify Successful Response    ${GET_response}
    Check Table4 Columns ID    ${GET_response}
    Check Table4 Columns Names    ${GET_response}

    ${rows_response}=    GET Rows    ${table4}
    Verify Successful Response    ${rows_response}
    Check Number of Rows    ${rows_response}    2
    Check Table4 Columns    ${rows_response}

    Make Sure Table Does Not Exist    ${table5}
    ${PATCH_response}=    PATCH Table from Import    ${table5}
    Verify Successful Response    ${PATCH_response}

    ${GET_response}=    GET Table with ID    ${table5}
    Check Table5 Columns ID    ${GET_response}
    Check Table5 Columns Names    ${GET_response}

    ${rows_response}=    GET Rows    ${table5}
    Verify Successful Response    ${rows_response}
    Check Number of Rows    ${rows_response}    1

    Set Suite Variable    ${results}    1
Jama Test Report
    ${jama}=    Run    pip install py-jama-rest-client    #installs the jama rest client to e used
    ${jama_id}=    Run    python TestCaseResults.py "Automated - IE - Create ID Map"    #Gets the ID from the actual test run based in the testname 
    
    IF    ${results} == 1
        Jama Passed Test    run_id=${jama_id}    #if result=1, then places the result as "passed"
    ELSE
        Jama Failed Test    run_id=${jama_id}    #if result=0, then places the result as "failed"  
    END

*** Keywords ***
Check Table1_A Columns ID    [Arguments]    ${response}
    ${ta_ids}=    Create List    c0    c1    c2
    ${string_body}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${string_body}
    FOR    ${counter}    IN RANGE    0    3  
        ${id}=    Get Value From Json    ${json_body}    $.columns[${counter}].id
        ${var}=    Get From List    ${ta_ids}    ${counter}
        Should Be Equal As Strings    ${id}[0]    ${var}
    END
    

Check Table1_B Columns ID    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    FOR    ${element}    IN    @{tb_ids}
       Should Contain    ${body}    ${element}
    END

Check Table1_A Columns Names    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    FOR    ${element}    IN    @{ta_names}
       Should Contain    ${body}    ${element}
    END

Check Table1_B Columns Names    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    FOR    ${element}    IN    @{tb_names}
       Should Contain    ${body}    ${element}
    END

Check Number of Rows    [Arguments]    ${response}    ${number_of_rows}
    ${body}=    Convert To String    ${response.content}
    Should Contain X Times    ${body}    key    ${number_of_rows}

Check Table1_A Columns    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    Should Contain X Times    ${body}    "c0"    10
    Should Contain X Times    ${body}    "c1"    10
    Should Contain X Times    ${body}    "c2"    10

Check Table1_B Columns    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    Should Contain X Times    ${body}    "c0"    5
    Should Contain X Times    ${body}    "c1"    5
    Should Contain X Times    ${body}    "c3"    5

Check Table3 Columns ID    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    FOR    ${element}    IN    @{t3_ids}
       Should Contain    ${body}    ${element}
    END

Check Table3 Columns Names    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    FOR    ${element}    IN    @{t3_names}
       Should Contain    ${body}    ${element}
    END

Check Table3 Columns    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    Should Contain X Times    ${body}    "c0"    2
    Should Contain X Times    ${body}    "c1"    1
    Should Contain X Times    ${body}    "c2"    1

Check Table4 Columns ID    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    FOR    ${element}    IN    @{t4_ids}
       Should Contain    ${body}    ${element}
    END

Check Table4 Columns Names    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    FOR    ${element}    IN    @{t4_names}
       Should Contain    ${body}    ${element}
    END

Check Table4 Columns    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    Should Contain X Times    ${body}    "c0"    2
    Should Contain X Times    ${body}    "c1"    2
    Should Contain X Times    ${body}    "c2"    2

Check Table5 Columns Names    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    FOR    ${element}    IN    @{t5_names}
       Should Contain    ${body}    ${element}
    END

Check Table5 Columns    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    Should Contain X Times    ${body}    "c0"    2
    Should Contain X Times    ${body}    "c1"    2
    Should Contain X Times    ${body}    "c2"    2

Check Table5 Columns ID    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}
    FOR    ${element}    IN    @{t5_ids}
       Should Contain    ${body}    ${element}
    END

    
