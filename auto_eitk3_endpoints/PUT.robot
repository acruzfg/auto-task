*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Resource    ../../Resources/Validation/Validation.robot

*** Variables ***


*** Keywords ***
Create PUT Request Body    [Arguments]    ${filename}
    ${request_body}=    Get File    ${table_path}/${filename}.JSON
    Return From Keyword    ${request_body}

PUT Table with ID    [Arguments]    ${table_id}    ${updated_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${request_body}=    Create PUT Request Body    ${updated_id}
    ${response}=    PUT On Session    Swagger    url=/api/v1/tables/${table_id}    data=${request_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

PUT Row    [Arguments]    ${table_id}    ${row_key}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${PUT_body}=    Create Request Body From File    changed_row
    ${response}=    PUT On Session    Swagger    url=/api/v1/tables/${table_id}/rows/${row_key}    data=${PUT_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

PUT IDMap    [Arguments]    ${request_body}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    PUT On Session    Swagger    url=/v1/idmaps    data=${request_body}    headers=${headers}    expected_status=Anything    verify=${False}

Jama-Report Passed Test    [Arguments]    ${run_id}    
    ${curl}=    Set Variable    curl -u auto_sysman:OSISysman -X PUT "https://osi.jamacloud.com/rest/v1/testruns/${run_id}" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \\"fields\\": { \\"testRunStatus\\": \\"PASSED\\", \\"automated$37\\": false }}"
    ${jama_id}=    Run    ${curl}
    Should Contain    ${jama_id}    "OK"    

Jama-Report Failed Test    [Arguments]    ${run_id}
    ${curl}=    Set Variable    curl -u auto_sysman:OSISysman -X PUT "https://osi.jamacloud.com/rest/v1/testruns/${run_id}" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \\"fields\\": { \\"testRunStatus\\": \\"FAILED\\", \\"automated$37\\": false }}"
    ${jama_id}=    Run    ${curl}
    Should Contain    ${jama_id}    "OK"
