*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Resource    ../../Resources/Validation/Validation.robot

*** Variables ***
#### URLS DAC1 ####
${base_url}=    https://sm5-dac1:8443/eitk
#### URLS PDS1 ####
##${base_url}=    https://sm5-pds1:8443/eitk/
#### HEADERS ####
${token}=    60ddc80ae2381a658bf5d87e:e031c694fe4d499bab7730485b83ce2f02e310a5b5cd9acb13850615ec7b2657
##${token}=    635013fd363f8026d4ab486d:381e1474b6298a09583807b55b520e6dc67f44e84fcd3ff72c9d883c9f4dbb60
${JSON_format}=    application/json
${CSV_format}=    text/csv
#### PATHS ####
${table_path}=    ./Files/
#### LISTS ####
@{tables}=    BTable1   BTable2   BTable3   BTable4   BTable5
#### JSON PATHS ####
${action_id_path}=    $..id


*** Keywords ***
Log Response    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    Log    ${body}

Create Request Body From File    [Arguments]    ${filename}
    ${request_body}=    Get File    ${table_path}/${filename}.JSON
    Return From Keyword    ${request_body}

Create Request Body From CSV File    [Arguments]    ${filename}
    ${request_body}=    Get File    ${table_path}/${filename}.csv
    Return From Keyword    ${request_body}
Create Swagger Session
    Create Session    Swagger    url=${base_url}    timeout=3000

    

Note Down Event ID    [Arguments]    ${request_response}
    ${body}=    Convert To String    ${request_response.content}
    ${body_JSON}=    Convert String To Json    ${body}
    ${JSON_value}=    Get Value From Json    ${body_JSON}    ${action_id_path}
    ${action_id}=    Convert To String    ${JSON_value}
    Return From Keyword    ${action_id}

Note Down IDMap ID    [Arguments]    ${request_response}
    ${body}=    Convert To String    ${request_response.content}
    ${body_JSON}=    Convert String To Json    ${body}
    ${JSON_value}=    Get Value From Json    ${body_JSON}    $[0].id
    ${id}=    Convert To String    ${JSON_value[0]}
    Return From Keyword    ${id}

















    





