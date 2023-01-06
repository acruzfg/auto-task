*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Resource    ../../Resources/Validation/Validation.robot

*** Variables ***

*** Keywords ***
POST Table with ID    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Create Request Body From File    ${table_id}
    ${response}=    POST On Session    Swagger    url=/api/v1/tables    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

POST Task with Name    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Create Request Body From File    ${task_name}
    ${response}=    POST On Session    Swagger    url=/api/v1/taskconfig    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

Run a Task with Name    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Set Variable    {"waitForResponse": true,"name": "${task_name}"}
    ${response}=    POST On Session    Swagger    url=/api/v1/taskrunrequests    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

POST Multiple Tables
    FOR    ${id}    IN     @{tables}
    Make Sure Table Does Not Exist    ${id}
    ${POST_response}=    POST Table with ID    ${id}
    Verify Successful Creation    ${POST_response}
    END

POST New Row    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Create Request Body From File    row
    ${response}=    POST On Session    Swagger    url=/api/v1/tables/${table_id}/rows    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

POST Row without Key    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Create Request Body From File    no_key
    ${response}=    POST On Session    Swagger    url=/api/v1/tables/${table_id}/rows    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

POST New Row From File    [Arguments]    ${table_id}    ${row}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Create Request Body From File    ${row}
    ${response}=    POST On Session    Swagger    url=/api/v1/tables/${table_id}/rows    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

POST New IDMap From File    [Arguments]    ${idmap_name}    ${deleteExistingMap}=false    ${deleteExistingMapAndSources}=false
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${CSV_format}    accept=${JSON_format}
    ${params}=    Create Dictionary    deleteExistingMap=${deleteExistingMap}    deleteExistingMapAndSources=${deleteExistingMapAndSources}
    ${POST_body}=    Create Request Body From CSV File    ${idmap_name}
    ${response}=    POST On Session    Swagger    url=/api/naming-csv/v1/idmaps    data=${POST_body}    headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

POST Conversion Request    [Arguments]    ${idmap_name}    
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Create Request Body From File    ${idmap_name}_table
    ${response}=    POST On Session    Swagger    url=/api/v1/idmaps-conversion-request/table    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}
