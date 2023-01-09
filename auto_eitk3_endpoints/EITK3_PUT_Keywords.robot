*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
PUT-Update Table    [Arguments]    ${table_id}    ${table}
    ${headers}=    Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=    PUT On Session    Swagger    url=/eitk/api/v1/tables/${table_id}    data=${table}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

PUT-Update Row    [Arguments]    ${table_id}    ${row_key}    ${row}
    ${headers}=    Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=    PUT On Session    Swagger    url=/eitk/api/v1/tables/${table_id}/rows/${row_key}    data=${row}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

PUT-Update Task with Name    [Arguments]    ${task_name}    ${PUT_body}
    ${headers}=    Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=    PUT On Session    Swagger    url=/eitk/api/v1/taskconfig/${task_name}   data=${PUT_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

PUT-Update IDMap    [Arguments]    ${request_body}
    ${headers}=    Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=    PUT On Session    Swagger    url=/eitk/v1/idmaps    data=${request_body}    headers=${headers}    expected_status=Anything    verify=${False}