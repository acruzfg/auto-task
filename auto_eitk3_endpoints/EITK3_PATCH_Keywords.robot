*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
PATCH-Import Table    [Arguments]    ${table}    
    ${headers}=     Create Dictionary    osiApiToken=${Token}    Content-Type=text/csv
    ${response}=    PATCH On Session    Swagger    url=/eitk/api/v1/tables-import    data=${table}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}
PATCH-Update Table    [Arguments]    ${table}        ${table_id}
    ${headers}=     Create Dictionary    osiApiToken=${Token}    Content-Type=text/csv
    ${response}=    PATCH On Session    Swagger    url=/eitk/api/v1/tables/${table_id}/updates    data=${table}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}
PATCH-Update IDMap or Table    [Arguments]    ${table}        ${name}
    ${headers}=     Create Dictionary    osiApiToken=${Token}    Content-Type=text/csv
    ${response}=    PATCH On Session    Swagger    url=/eitk/api/v1/idmaps/${name}/transactions    data=${table}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}    