*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Resource    POST.robot
Resource    PUT.robot
Resource    GET.robot
Resource    DELETE.robot
Resource    ../Validation/Validation.robot
Resource    Resources.robot
Resource    PATCH.robot

*** Keywords ***
Key Should be Unique    [Arguments]    ${table_id}    ${row}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${POST_body}=    Create Request Body From File    ${row}
    ${response}=    POST On Session    Swagger    url=/api/v1/tables/${table_id}/rows    data=${POST_body}    headers=${headers}    verify=${False}