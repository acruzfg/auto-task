*** Settings ***
Resource    ../Resources/API/POST.robot
Resource    ../Resources/API/PUT.robot
Resource    ../Resources/API/GET.robot
Resource    ../Resources/API/DELETE.robot
Resource    ../Resources/Validation/Validation.robot
Resource    ../Resources/API/PATCH.robot
Test Setup    Create Swagger Session
Test Teardown    Delete All Sessions



*** Variables ***
#### TABLES_IDs ####
${table1}=    ATest1
${table2}=    ATest1_v2
${table}=    4CTest
${updated_table}=    4CTest_v2
${import_table}=    ATable1
${updated_import_table}=    ATable1_updated

#### ROWS_KEYs ####
${key}=    key123
${new_key}=    123key

*** Test Cases ***
Create Modify Delete EITK Table and Verify Table Elements via Endpoints
    Set Suite Variable    ${results}    0
    Make Sure Table Does Not Exist    ${table1}
    ${POST_response}=    POST Table with ID    ${table1}
    Verify Successful Creation    ${POST_response}
    
    ${GET_response}=    GET Table with ID    ${table1}
    Verify Successful Response    ${GET_response}
    Verify Table is Returned    ${GET_response}    ${table1}

    ${PUT_response}=    PUT Table with ID    ${table1}    ${table2}
    Verify Successful Response    ${PUT_response}

    ${DELETE_response}=    DELETE Table with ID    ${table1}
    Verify Successful Response    ${DELETE_response}
    Make Sure Table Does Not Exist    ${table1}

    POST Multiple Tables
    ${response}=    GET Tables
    Verify Successful Response    ${response}
    Verify a List of Tables Is Returned    ${response}

    ${FILTER_response}=    GET Tables With ID Filter    BTable2
    Verify Successful Response    ${FILTER_response}
    Verify Table is Returned    ${FILTER_response}    BTable2
    DELETE Multiple Tables

    Make Sure Table Does Not Exist    ${table1}
    ${body}=    POST Table with ID    ${table1}
    Verify Successful Creation    ${body}

    ${POST_response}=    POST New Row    ${table1}
    Verify Successful Creation    ${POST_response}
    ${post_id}=    Note Down Event ID    ${POST_response}

    ${GET_response}=    GET Row with Key    ${table1}    ${key}
    Verify Successful Response    ${GET_response}
    Verify Row is Returned    ${GET_response}    ${key}
    ${get_id}=    Note Down Event ID    ${GET_response}

    ${PUT_response}=    PUT Row    ${table1}    ${key}
    Verify Successful Creation    ${PUT_response}
    Verify Row is Returned    ${PUT_response}    ${new_key}
    ${put_id}=    Note Down Event ID    ${PUT_response}

    ${DELETE_response}=    DELETE Row with Key    ${table1}    ${new_key}
    Verify Successful Response    ${DELETE_response}
    Verify Row is Returned    ${DELETE_response}    ${new_key}
    ${delete_id}=    Note Down Event ID    ${DELETE_response}

    Verify Row Should Have A Key    ${table1}
 
    ${events_response}=    GET Tables Events with Filter    ${table1}

    Verify Event Exists in Tables-Events    ${post_id}    ${events_response}
    Verify Event Exists in Tables-Events    ${get_id}    ${events_response}
    Verify Event Exists in Tables-Events    ${put_id}    ${events_response}
    Verify Event Exists in Tables-Events    ${delete_id}    ${events_response}

    ${D_response}=    DELETE Table with ID    ${table1}

    Make Sure Table Does Not Exist    ${table}
    ${response}=    POST Table with ID    ${table}
    Verify Successful Creation    ${response}

    ${Update_response}=    PUT Table with ID    ${table}    ${updated_table}
    Verify Successful Response    ${Update_response}

    ${DELETE_response}=    DELETE Table with ID    ${table}
    Verify Successful Response    ${DELETE_response}
    Make Sure Table Does Not Exist    ${table}

    ${response}=    PATCH Table from Import    ${import_table}
    Verify Successful Response    ${response}
    
    ${Update_response}=    Update Table from Import    ${updated_import_table}
    Verify Successful Response    ${Update_response}

    ${DELETE_response}=    DELETE Table with ID    ${import_table}
    Verify Successful Response    ${DELETE_response}
    Make Sure Table Does Not Exist    ${import_table}

    Set Suite Variable    ${results}    1
Jama Report
    ${jama}=    Run    pip install py-jama-rest-client    #installs the jama rest client to e used
    ${jama_id}=    Run    python TestCaseResults.py "Automated - IE - Add a Source to an ID Map"    #Gets the ID from the actual test run based in the testname 

    IF    ${results} == 1
        Jama Passed Test    run_id=${jama_id}    #if result=1, then places the result as "passed"
    ELSE
        Jama Failed Test    run_id=${jama_id}    #if result=0, then places the result as "failed"  
    END




