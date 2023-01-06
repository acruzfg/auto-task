*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Resource    ../../Resources/API/Resources.robot
Resource    ../../Resources/API/POST.robot
Resource    ../../Resources/API/DELETE.robot
Resource    ../../Resources/API/GET.robot
Resource    ../../Resources/API/PUT.robot
Resource    ../API/GET.robot

*** Variables ***

*** Keywords ***

Verify Successful Creation    [Arguments]    ${response}
    Status Should Be    201    ${response}
    Verify Reason    ${response}    Created

Verify Successful Response    [Arguments]    ${response}
    Status Should Be    200    ${response}

Verify Bad Request Response    [Arguments]    ${response}
    Status Should Be    400    ${response}

Verify Internal Error Response    [Arguments]    ${response}
    Status Should Be    500    ${response}

Verify Table is Returned    [Arguments]    ${response}    ${table_id}
    ${body}=    Convert to String    ${response.content}
    Should Contain    ${body}    ${table_id}

Verify a List of Tables Is Returned    [Arguments]    ${response}
    ${body}=    Convert to String    ${response.content}
    FOR    ${table}    IN    @{tables}
      Should Contain    ${body}    ${table}   
    END

Verify Row is Returned    [Arguments]    ${response}    ${row_key}
    ${body}=    Convert to String    ${response.content}
    Should Contain    ${body}    ${row_key}

Verify Row Should Have A Key    [Arguments]    ${table_id}
    ${response}=    POST Row without Key    ${table_id}
    Verify Bad Request Response    ${response}

Verify Event Exists in Tables-Events    [Arguments]    ${event_id}    ${response_tables_events}
    ${body}=    Convert To String    ${response_tables_events.content}
    Should Contain    ${body}    ${event_id[0]}

Make Sure Table Does Not Exist    [Arguments]    ${table_id}
    ${response}=    GET Tables With ID Filter    ${table_id}
    ${body}=    Convert To String    ${response.content}
    ${status}=    Evaluate    '${table_id}' in '''${body}'''
    IF    ${status}
        ${Delete_response}=    DELETE Table with ID    ${table_id}
        Verify Successful Response    ${DELETE_response}
    END

Verify Reason    [Arguments]    ${response}    ${reason}
    ${body}=    Convert To String    ${response.reason}
    Should Contain    ${body}    ${reason}

Verify Body    [Arguments]    ${response}    ${reason}
    ${body}=    Convert To String    ${response.content}
    Should Contain    ${body}    ${reason}


Verify Unique Column Should Not Have Duplicate Values    [Arguments]    ${table_id}    ${duplicate_value_row}    ${log}=False
    ${response}=    POST New Row From File    ${table_id}    ${duplicate_value_row}
    Status Should Be    400    ${response}
    IF    ${log}
    Log    ${response.reason}
    Log    ${response.content}
    END

Add New Row to Unique Column    [Arguments]    ${table_id}    ${new_row}    ${log}=False
    ${response}=    POST New Row From File    ${table_id}    ${new_row}
    Status Should Be    201    ${response}
    Verify Reason    ${response}    Created
    IF    ${log}
        Log    ${response.reason}
        Log    ${response.content}
    END

Make Sure Task Does Not Exist    [Arguments]    ${task_name}
    ${response}=    GET Tasks With Name Filter    ${task_name}
    ${body}=    Convert To String    ${response.content}
    ${status}=    Evaluate    '${task_name}' in '''${body}'''
    IF    ${status}
        ${Delete_response}=    DELETE Task with Name    ${task_name}
        Verify Successful Response    ${DELETE_response}
    END

Evaluate Task Status    [Arguments]    ${response}
    ${body}=    Convert To String    ${response.content}
    ${body_json}=    Convert String To Json    ${body}
    ${status}=    Get Value From Json    ${body_json}    $[0].status
    Should Be Equal As Strings    ${status}[0]    Success



Enforce Unique Items    [Arguments]    ${idmap_name}
    ${response}=    GET IDMap Details   ${idmap_name}
    ${body}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${body}
    ${idmap_id}=    Get Value From Json    ${json_body}    $[0].id
    ${id_source_2}=    Get Value From Json    ${json_body}    $.[0].sources[0].id
    ${id_source_1}=    Get Value From Json    ${json_body}    $.[0].sources[1].id
    ${jsonfile}=    Load Json From File    Files/enforce.json
    ${PUT_body}=    Convert Json To String    ${jsonfile}
    ${PUT_body}=    Replace String    ${PUT_body}    map_id    ${idmap_id[0]}
    ${PUT_body}=    Replace String    ${PUT_body}    source2_id    ${id_source_2[0]}
    ${PUT_body}=    Replace String    ${PUT_body}    source1_id    ${id_source_1[0]}
    Log    ${PUT_body}
    ${request_body}=    Convert To String    ${PUT_body}
    ${response}=    PUT IDMAP    ${request_body}
    Verify Successful Response    ${response}

No Longer Enforce Unique Items    [Arguments]    ${idmap_name}
    ${response}=    GET IDMap Details   ${idmap_name}
    ${body}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${body}
    ${idmap_id}=    Get Value From Json    ${json_body}    $[0].id
    ${id_source_2}=    Get Value From Json    ${json_body}    $.[0].sources[0].id
    ${id_source_1}=    Get Value From Json    ${json_body}    $.[0].sources[1].id
    ${jsonfile}=    Load Json From File    Files/enforce.json
    ${PUT_body}=    Convert Json To String    ${jsonfile}
    ${PUT_body}=    Replace String    ${PUT_body}    map_id    ${idmap_id[0]}
    ${PUT_body}=    Replace String    ${PUT_body}    source2_id    ${id_source_2[0]}
    ${PUT_body}=    Replace String    ${PUT_body}    source1_id    ${id_source_1[0]}
    ${response}=    PUT IDMAP    ${PUT_body}
    Log    ${PUT_body}
    Verify Successful Response    ${response}