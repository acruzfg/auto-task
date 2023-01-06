*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Library    SeleniumLibrary
Resource    ../Resources/API/POST.robot
Resource    ../Resources/API/PUT.robot
Resource    ../Resources/API/GET.robot
Resource    ../Resources/API/DELETE.robot
Resource    ../Resources/Validation/Validation.robot
Resource    ../Resources/API/PATCH.robot
*** Variables ***
${TestTable}=    CTest1.JSON

*** Keywords ***
PRE-CONDITIONS_Export_CSV_Table
    Make Sure Table Does Not Exist    ${TestTable}
    ${POST_response}=    POST Table with ID    ${TestTable}
    Verify Successful Creation    ${POST_response}