*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Resource    SM5_DAC1_API_Variables.robot

*** Keywords ***

POST-Create Task with Name    [Arguments]    ${POST_body}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    POST On Session    Swagger    url=/eitk/api/v1/taskconfig    data=${POST_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

PUT-Update Task with Name    [Arguments]    ${task_name}    ${PUT_body}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    PUT On Session    Swagger    url=/eitk/api/v1/taskconfig/${task_name}   data=${PUT_body}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Tasks With Name    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/eitk/api/v1/taskconfig/${task_name}   headers=${headers}        expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Tasks With Name Filter    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${params}=    Create Dictionary    filter=["name","=","${task_name}"]
    ${response}=    GET On Session    Swagger    url=/eitk/api/v1/taskconfig   headers=${headers}        params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

DELETE-Task with Name    [Arguments]    ${task_name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    DELETE On Session    Swagger    url=/eitk/api/v1/taskconfig/${task_name}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

Make Sure Task Does Not Exist    [Arguments]    ${task_name}
    ${response}=    GET-Tasks With Name Filter    ${task_name}
    ${body}=    Convert To String    ${response.content}
    ${status}=    Evaluate    '${task_name}' in '''${body}'''
    ${Delete_response}=    Run Keyword If    ${status} == ${True}    DELETE-Task with Name    ${task_name}

Check Task Details    [Arguments]    ${response}    ${task_detail}    ${json_path}    
    ${string}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${string}
    ${task_attribute}=    Get Value From Json    ${json_body}    ${json_path}
    Should Be Equal As Strings    ${task_detail}    ${task_attribute[0]}