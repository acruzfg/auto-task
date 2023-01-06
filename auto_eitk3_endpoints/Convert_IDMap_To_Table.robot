*** Settings ***
Resource    ../Resources/API/POST.robot
Resource    ../Resources/API/PUT.robot
Resource    ../Resources/API/GET.robot
Resource    ../Resources/API/DELETE.robot
Resource    ../Resources/Validation/Validation.robot
Resource    ../Resources/API/PATCH.robot
Resource    ../Resources/API/Resources.robot
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Test Setup    Create Swagger Session
Test Teardown    Delete All Sessions

*** Variables ***
${map1}=    map1
${map2}=    invalid
${map3}=    MapTable
${table}=    Table1


*** Test Cases ***
Convert IDMap to Table
    Set Suite Variable    ${results}    0

    Make Sure Table Does Not Exist    ${map1}
    Make Sure Table Does Not Exist    ${table}
    Make Sure Table Does Not Exist    ${map3}
    ${new_map}=    POST New IDMap From File    ${map1}    true    true
    Verify Successful Response    ${new_map}
    ${new_map}=    POST New IDMap From File    ${map3}.idmap    true    false
    Verify Successful Response    ${new_map}
    ${new_table}=    PATCH Table from Import    ${map3}.table
    Verify Successful Response    ${new_table}
    ${new_table}=    PATCH Table from Import    ${table}.table
    Verify Successful Response    ${new_table}

    Enforce Unique Items    ${map1}
    ${response}=    POST Conversion Request    ${map1}    
    Verify Successful Response    ${response}

    ${GET_response}=    GET Table with ID    ${map1}
    Verify Successful Response    ${GET_response}
    ${rows_response}=    GET Rows    ${map1}
    Verify Successful Response    ${rows_response}

    No Longer Enforce Unique Items    ${map1}
    ${invalid_map}=    POST New IDMap From File    ${map2}
    ${invalid_response}=    POST Conversion Request    ${map2}
    Verify Bad Request Response    ${invalid_response}

    ${response}=    GET IDMaps
    Verify Successful Response    ${response}
    ${body}=    Convert To String    ${response.content}
    Should Contain    ${body}    ${table}
    Should Contain    ${body}    ${map3}

    ${response}=    GET IDMap With Name    ${map3}
    Verify Successful Response    ${response}

    ${response}=    GET IDMap With Name    ${table}
    Verify Successful Response    ${response}

    ${response}=    GET Mapping from one source to another in IDMap    ${map1}    1    2
    Verify Successful Response    ${response}

    ${response}=    GET Mapping from one source to another in IDMap    ${table}    1    2
    Verify Successful Response    ${response}

    ${response}=    GET Links IDMap    ${map1}    1    4a
    Verify Successful Response    ${response}

    ${response}=    GET Links IDMap    ${table}    1    4a
    Verify Successful Response    ${response}

    Set Suite Variable    ${results}    1


Jama Report
    ${jama}=    Run    pip install py-jama-rest-client    #installs the jama rest client to e used
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Chrome - Delete ID Map"    #Gets the ID from the actual test run based in the testname 
    #the next evualtes if the test cases finished just fine, right now when trying to use the endpoint to post the resutls, i got a 500 error code, so im working in that, almost there....  
    IF    ${results} == 1
        Jama Passed Test    run_id=${jama_id}    #if result=1, then places the result as "passed"
    ELSE
        Jama Failed Test    run_id=${jama_id}    #if result=0, then places the result as "failed"  
    END





