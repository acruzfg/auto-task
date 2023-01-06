*** Settings ***
Resource    ../Resources/Pre-Conditions/pre-conditions.robot
Resource    ../Resources/API/POST.robot
Resource    ../Resources/API/PUT.robot
Resource    ../Resources/API/GET.robot
Resource    ../Resources/API/DELETE.robot
Resource    ../Resources/Validation/Validation.robot
Resource    ../Resources/API/PATCH.robot
Resource    ../Resources/Pre-Conditions/pre-conditions.robot
Test Setup    Create Swagger Session
Test Teardown    Delete All Sessions


*** Variables ***
${TestTable}=    CTest1

*** Test Cases ***
Export CSV Table
    Set Suite Variable    ${results}    0    #if testcase is not completed, the JAMA result will be "failed" 
    PRE-CONDITIONS_Export_CSV_Table
    ${GET_response}=    GET Table with ID in CSV Format    ${TestTable}
    Verify Successful Response    ${GET_response}
    Verify Table is Returned    ${GET_response}    ${TestTable}

    ${DELETE_response}=    DELETE Table with ID    ${TestTable}
    Verify Successful Response    ${DELETE_response}
    Make Sure Table Does Not Exist    ${TestTable}   

    ${PATCH_response}=    PATCH Table from previous step in CSV Format    ${GET_response}
    Verify Successful Response    ${PATCH_response}

    Set Suite Variable    ${results}    1
Jama Report
    ${jama}=    Run    pip install py-jama-rest-client    #installs the jama rest client to e used
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Chrome - Add a Source to an ID Map"    #Gets the ID from the actual test run based in the testname 

    IF    ${results} == 1
        Jama Passed Test    run_id=${jama_id}    #if result=1, then places the result as "passed"
    ELSE
        Jama Failed Test    run_id=${jama_id}    #if result=0, then places the result as "failed"  
    END