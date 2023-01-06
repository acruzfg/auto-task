*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Resource    ../../Resources/Validation/Validation.robot

*** Keywords ***
PATCH Table from Import    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${CSV_format}
    ${PATCH_body}=    Create Request Body From CSV File    ${table_id}
    ${response}=    PATCH On Session    Swagger    url=/api/v1/tables-import    data=${PATCH_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

Update Table from Import    [Arguments]    ${updated_table}
    ${response}=    PATCH Table from Import    ${updated_table}
    Return From Keyword    ${response}

PATCH Table from previous step in CSV Format   [Arguments]    ${input}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${CSV_format}
    ${response}=    PATCH On Session    Swagger    url=/api/v1/tables-import    data=${input.content}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}