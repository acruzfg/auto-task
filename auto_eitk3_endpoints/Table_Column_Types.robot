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
${ctest1}=  ATest1
${ctest1_update}=  ATest1_v3
${ctest1_v3}=    ATest1_v4
${unique_test}=    UniqueTest
${changetest1}=  ChangeTest1
${changetest2}=  ChangeTest1_v2

${row11}=    Row1
${row21}=    Row2
${row12}=    Row3
${row22}=    Row4

${key}=    2

*** Test Cases ***
Column Types
    Set Suite Variable    ${results}    0
    Make Sure Table Does Not Exist    ${ctest1}
    ${new_table_response}=    POST Table with ID    ${ctest1}
    Verify Successful Creation    ${new_table_response}

    ${change_column_type_response}=    PUT Table with ID    ${ctest1}    ${ctest1_update}
    Verify Successful Response    ${change_column_type_response}

    ${change_key_column_type_response}=    PUT Table with ID    ${ctest1}    ${ctest1_v3}
    Verify Bad Request Response    ${change_key_column_type_response}

    ${delete_response}=    DELETE Table with ID    ${ctest1}

    Make Sure Table Does Not Exist    ${unique_test}
    ${response}=    POST Table with ID    ${unique_test}
    Verify Successful Creation    ${response}

    ${row11_response}=    POST New Row From File    ${unique_test}    ${row11}
    Verify Successful Creation    ${row11_response}

    ${row11_response_repeat}=    POST New Row From File    ${unique_test}    ${row11}
    Verify Bad Request Response  ${row11_response_repeat}

#    ${row21_response_repeat}=    POST New Row From File    ${unique_test}    ${row21}
#    Verify Internal Error Response    ${row21_response_repeat}

    ${row12_response_repeat}=    POST New Row From File    ${unique_test}    ${row12}
    Verify Bad Request Response    ${row12_response_repeat}

    ${row12_response_repeat}=    POST New Row From File    ${unique_test}    ${row22}
    Verify Successful Creation    ${row12_response_repeat}

    ${delete_response}=    DELETE Table with ID    ${unique_test}

    Make Sure Table Does Not Exist    ${changetest1}
    ${response}=    POST Table with ID    ${changetest1}
    Verify Successful Creation    ${response}

    ${row11_response}=    POST New Row From File    ${changetest1}    ${row11}
    Verify Successful Creation    ${row11_response}

    ${row11_response}=    POST New Row From File    ${changetest1}    ${row21}
    Verify Successful Creation    ${row11_response}

    ${change_column_type_response}=    PUT Table with ID    ${changetest1}    ${changetest2}
    Verify Bad Request Response    ${change_column_type_response}

    ${delete_row_response}=    DELETE Row with Key    ${changetest1}    ${key}
    Verify Successful Response    ${delete_row_response}

    ${change_column_type_response}=    PUT Table with ID    ${changetest1}    ${changetest2}
    Verify Successful Response    ${change_column_type_response}
    
    Set Suite Variable    ${results}    1
Jama Report
    ${jama}=    Run    pip install py-jama-rest-client    #installs the jama rest client to e used
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Chrome - Create ID Map"    #Gets the ID from the actual test run based in the testname 
    #the next evualtes if the test cases finished just fine, right now when trying to use the endpoint to post the resutls, i got a 500 error code, so im working in that, almost there....  
    IF    ${results} == 1
        Jama Passed Test    run_id=${jama_id}    #if result=1, then places the result as "passed"
    ELSE
        Jama Failed Test    run_id=${jama_id}    #if result=0, then places the result as "failed"  
    END




    

