*** Settings ***
Library    JSONLibrary
Resource   EITK3_DELETE_Keywords.robot
Resource   EITK3_GET_Keywords.robot

*** Keywords ***
Make Sure Task Does Not Exist    [Arguments]    ${task_name}
    ${name_filter}=    Set Variable    ["name","=", "${task_name}"]
    ${response}=    GET-Tasks With Filter    ${task_name}    ${name_filter}
    ${body}=    Convert To String    ${response.content}
    ${status}=    Evaluate    '${task_name}' in '''${body}'''
    ${Delete_response}=    Run Keyword If    ${status} == ${True}    DELETE-Task with Name    ${task_name}
    Run Keyword If    ${status} == ${True}    Status Should Be    200    ${Delete_response}
Make Sure Table Does Not Exist    [Arguments]    ${table_id}
    ${filter}=    Set Variable    ["id","=","${table_id}"]
    ${response}=    GET-Tables With Filter    ${filter}
    Status Should Be    200    ${response}
    ${body}=    Convert To String    ${response.content}
    ${status}=    Evaluate    '${table_id}' in '''${body}'''
    ${Delete_response}=    Run Keyword If    ${status} == ${True}    DELETE-Table with ID    ${table_id}
    Run Keyword If    ${status} == ${True}    Status Should Be    200    ${Delete_response}
Check Task is Successful    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    ${body_json}=    Convert String To Json    ${body}
    ${status}=    Get Value From Json    ${body_json}    $[0].status
    Should Be Equal As Strings    ${status}[0]    Success
Create Request Body From CSV File    [Arguments]    ${filename}
    ${request_body}=    Get File    Files/${filename}.csv
    Return From Keyword    ${request_body}
Check Table Attribute    [Arguments]    ${response}    ${attribute}    ${json_path}
    ${string}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${string}
    ${value}=    Get Value From Json    ${json_body}    ${json_path}
    Should Be Equal As Strings    ${value[0]}    ${attribute}
Check Table Columns Attribute    [Arguments]    ${response}    ${attribute}    ${column_number}    ${json_path}
    ${string}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${string}
    ${value}=    Get Value From Json    ${json_body}    $.columns[${column_number}].${json_path}
    Should Be Equal As Strings    ${value[0]}    ${attribute}
Note Down Event ID    [Arguments]    ${request_response}
    ${body}=    Convert To String    ${request_response.content}
    ${body_JSON}=    Convert String To Json    ${body}
    ${JSON_value}=    Get Value From Json    ${body_JSON}    $..id
    ${action_id}=    Convert To String    ${JSON_value}
    Return From Keyword    ${action_id}
Note Down IDMap ID    [Arguments]    ${request_response}
    ${body}=    Convert To String    ${request_response.content}
    ${body_JSON}=    Convert String To Json    ${body}
    ${JSON_value}=    Get Value From Json    ${body_JSON}    $[0].id
    ${id}=    Convert To String    ${JSON_value[0]}
    Return From Keyword    ${id}
Check Data in a Row    [Arguments]    ${response}    ${data}    ${json_path}
    ${body}=    Convert To String    ${response.content}
    ${json}=    Convert String To Json    ${body}
    ${value}=    Get Value From Json    ${json}    ${json_path}
    Should Be Equal As Strings    ${value[0]}    ${data}
Verify Event Exists in Tables-Events    [Arguments]    ${event_id}    ${response_tables_events}
    ${body}=    Convert To String    ${response_tables_events.content}
    Should Contain    ${body}    ${event_id[0]}
Count Rows    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    ${count}=    Get Count   ${body}    key
    Return From Keyword    ${count}
Check Rows Have Values    [Arguments]    ${response}    ${row_number}    ${column_id}
    ${body}=    Convert To String    ${response.content}
    ${body}=    Convert String To Json    ${body}
    ${data}=    Get Value From Json    ${body}    $.[${row_number}].data
    ${data}=    Convert To String    ${data}
    Should Contain    ${data}    ${column_id}
Check IDMap Source Attribute    [Arguments]    ${response}    ${attribute}    ${source_number}    ${json_path}
    ${string}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${string}
    ${value}=    Get Value From Json    ${json_body}    $.sources[${source_number}].${json_path}
    Should Be Equal As Strings    ${value[0]}    ${attribute}
Count Links    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    ${count}=    Get Count   ${body}    from
    Return From Keyword    ${count}
Count Links that Contain ItemID    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    ${body}=    Convert String To Json    ${body}
    ${items}=    Get Value From Json    ${body}    $[0].items
    ${items}=    Convert To String    ${items}
    ${count}=    Get Count   ${items}    name
    Return From Keyword    ${count}