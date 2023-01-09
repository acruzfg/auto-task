*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
PATCH-Import Table    [Arguments]    ${table}    
    ${headers}=    Create Dictionary    osiApiToken=${Token}    Content-Type=text/csv
    ${response}=    PATCH On Session    Swagger    url=/eitk/api/v1/tables-import    data=${table}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}