*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Resource    ../../Resources/Validation/Validation.robot
Resource    ../../Resources/API/Resources.robot

*** Variables ***

*** Keywords ***
DELETE Table with ID    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    DELETE On Session    Swagger    url=/api/v1/tables/${table_id}    headers=${headers}    verify=${False}    timeout=3600
    Return From Keyword    ${response}

DELETE Task with Name    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    DELETE On Session    Swagger    url=/api/v1/taskconfig/${task_name}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

DELETE IDMAp with ID    [Arguments]    ${idmap_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    DELETE On Session    Swagger    url=/api/v1/idmaps/${idmap_id}     headers=${headers}    verify=${False}
    Return From Keyword    ${response}

DELETE Multiple Tables
    FOR    ${id}    IN    @{tables}
    ${response}=    Delete Table with ID    ${id}
    Verify Successful Response    ${response}
    END

DELETE Row with Key    [Arguments]    ${table_id}    ${row_key}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    DELETE On Session    Swagger    url=/api/v1/tables/${table_id}/rows/${row_key}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}
