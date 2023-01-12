*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
POST-Create Table        [Arguments]          ${table}
    ${headers}=          Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=         POST On Session    Swagger    url=/eitk/api/v1/tables    data=${table}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}
POST-Create Task         [Arguments]          ${task}
    ${headers}=     Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=    POST On Session    Swagger    url=/eitk/api/v1/taskconfig    data=${task}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}
POST-Run a Task          [Arguments]          ${task_name}
    ${headers}=      Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${POST_body}=    Set Variable    {"waitForResponse": true,"name": "${task_name}"}
    ${response}=     POST On Session    Swagger    url=/eitk/api/v1/taskrunrequests    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}
POST-Create Row          [Arguments]          ${table_id}        ${row}
    ${headers}=     Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=    POST On Session    Swagger    url=/eitk/api/v1/tables/${table_id}/rows    data=${row}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}
POST-Create IDMap        [Arguments]          ${idmap}           ${deleteExistingMap}=false    ${deleteExistingMapAndSources}=false
    ${headers}=          Create Dictionary    osiApiToken=${Token}    Content-Type=text/csv    accept=application/json
    ${params}=           Create Dictionary    deleteExistingMap=${deleteExistingMap}    deleteExistingMapAndSources=${deleteExistingMapAndSources}
    ${response}=         POST On Session    Swagger    url=/eitk/api/naming-csv/v1/idmaps    data=${idmap}    headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

POST-Conversion Request    [Arguments]    ${request}    
    ${headers}=     Create Dictionary    osiApiToken=${Token}    Content-Type=application/json
    ${response}=    POST On Session    Swagger    url=/eitk/api/v1/idmaps-conversion-request/table    data=${request}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}