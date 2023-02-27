*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
DELETE-Table with ID        [Arguments]          ${table_id}
    ${headers}=             Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=            DELETE On Session    Swagger    url=/eitk/api/v1/tables/${table_id}                    headers=${headers}    verify=${False}
    Return From Keyword     ${response}

DELETE-Task with Name       [Arguments]          ${task_name}
    ${headers}=             Create Dictionary    osiApiToken=${Token}
    ${response}=            DELETE On Session    Swagger    url=/eitk/api/v1/taskconfig/${task_name}             headers=${headers}    verify=${False}
    Return From Keyword     ${response}

DELETE-IDMAp with ID        [Arguments]          ${idmap_id}
    ${headers}=             Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=            DELETE On Session    Swagger    url=/eitk/api/v1/idmaps/${idmap_id}                    headers=${headers}    verify=${False}
    Return From Keyword     ${response}

DELETE-Row with Key         [Arguments]        ${table_id}            ${row_key}
    ${headers}=             Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=            DELETE On Session    Swagger    url=/eitk/api/v1/tables/${table_id}/rows/${row_key}    headers=${headers}    verify=${False}
    Return From Keyword     ${response}