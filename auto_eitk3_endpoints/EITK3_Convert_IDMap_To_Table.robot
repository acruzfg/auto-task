*** Settings ***
Library     RequestsLibrary
Library     CSVLibrary
Library     String
Resource    EITK3_General_Endpoints_Keywords.robot
Resource    EITK3_POST_Keywords.robot
Resource    EITK3_GET_Keywords.robot
Resource    EITK3_PUT_Keywords.robot
Resource    EITK3_DELETE_Keywords.robot
Resource    EITK3_PATCH_Keywords.robot
Resource    Report_to_Jama.robot
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Resource    ../auto_eitk3_tasks/EITK_Task_Endpoints_Keywords.robot
Test Setup    Create Session    Swagger    ${Base_URL}
Test Teardown    Delete All Sessions

*** Variables ***
${testsystem}=    SM5-DAC1
${testcycle}

*** Test Cases ***
Convert IDMap to Table
### The "results" variable will be used to report to Jama. We set to 0 so if the test fails, it will report 'FAILED' to jama ###
    Set Suite Variable    ${results}    0
### Pre-conditions###
### Ensure the table names aren't occupied already, if the names are used, the tables will be deleted ###
    @{names}=    Create List    Map1    Table1    MapTable    Invalid
    FOR    ${name}    IN    @{names}
        Make Sure Table Does Not Exist    ${name}   
    END
### We upload Map1, deleting sources and idmaps with the same name ###
    ${name}=    Set Variable    Map1
    ${idmap}=    Create Request Body From CSV File    ${name} 
    ${POST_response}=    POST-Create IDMap    ${idmap}    deleteExistingMap=true    deleteExistingMapAndSources=true
    Status Should Be    200    ${POST_response}
### We upload MapTable as idmap ###
    ${name}=    Set Variable    MapTable
    ${idmap}=    Create Request Body From CSV File    ${name}.idmap
    ${POST_response}=    POST-Create IDMap    ${idmap}
    Status Should Be    200    ${POST_response}
### We upload MapTable as table using the PATCH endpoint ###
    ${table}=    Create Request Body From CSV File    ${name}.table
    ${PATCH_response}=    PATCH-Import Table    ${table}
    Status Should Be    200    ${PATCH_response}
### We upload Invalid as idmap ###
    ${name}=    Set Variable    Invalid
    ${idmap}=    Create Request Body From CSV File    ${name}
    ${POST_response}=    POST-Create IDMap    ${idmap}
    Status Should Be    200    ${POST_response}
### We upload Table1 using the PATCH endpoint ###
    ${table_id}=    Set Variable    Table1
    ${table}=    Create Request Body From CSV File    ${table_id}.table
    ${PATCH_response}=    PATCH-Import Table    ${table}
    Status Should Be    200    ${PATCH_response}
### We activate 'Enforce Unique Items' in Map1 ###
    Unique Items    Map1

### Convert IDMap to Table ###
### Create request body to convert idmap Map1 to Table ###
    ${idmap_name}=    Set Variable    Map1
    ${1a}=    Set Variable    {"sourceId":"1","type":"Key"}
    ${1b}=    Set Variable    {"sourceId":"1","itemIndex":"1","type":"None"}
    ${2a}=    Set Variable    {"sourceId":"2","type":"None"}
    ${2b}=    Set Variable    {"sourceId":"2","itemIndex":"1","type":"None"}
    ${columns}=    Set Variable    {"1a":${1a},"1b":${1b},"2a":${2a},"2b":${2b}}
    ${request}=    Set Variable    {"idMapName":"${idmap_name}","columns":${columns}}
    ${request}=    Convert To String    ${request}
### We send request ###
    ${response}=    POST-Conversion Request    ${request}
    Status Should Be    200    ${response}
### Request to verify the IDMap can be obtain using the table's endpoints ###
    ${table_id}=    Set Variable    Map1
    ${GET_response}=    GET-Table with ID    ${table_id}
    Status Should Be    200    ${GET_response}
### We verify the table elements are consistent with the IDMap ###
    Check Table Attribute    ${GET_response}    ${table_id}    $.id    ## Verify table id
    Check Table Columns Attribute    ${GET_response}    1a    0    id  ## Verify each column id and name
    Check Table Columns Attribute    ${GET_response}    1a    0    name
    Check Table Columns Attribute    ${GET_response}    1b    1    id
    Check Table Columns Attribute    ${GET_response}    1b    1    name
    Check Table Columns Attribute    ${GET_response}    2a    2    id
    Check Table Columns Attribute    ${GET_response}    2a    2    name
    Check Table Columns Attribute    ${GET_response}    2b    3    id
    Check Table Columns Attribute    ${GET_response}    2b    3    name
    Check Table Columns Attribute    ${GET_response}    Key    0    type  ## Verify each column type
    FOR    ${counter}    IN RANGE    1    4
        Check Table Columns Attribute    ${GET_response}    None    ${counter}    type    
    END

### We deactivate 'Enforce Unique Items' in Map1 ###
    Unique Items    Map1    enforce=false
### Create an invalid request to convert IDMap to Table ###
    ${idmap_name}=    Set Variable    Invalid
    ${c1}=    Set Variable    {"sourceId": "1","type": "Key"}
    ${c2}=    Set Variable    {"sourceId": "2","type": "None"}
    ${columns}=    Set Variable    {"1":${c1},"2":${c2}}
    ${request}=    Set Variable    {"idMapName": "${idmap_name}","columns": ${columns}}
### We send the request. We expect this to fail because we are no longer enforcing unique items ###
    ${response}=    POST-Conversion Request    ${request}
    Status Should Be    400    ${response}

## We make a GET request to verify the IDMaps can be found in the IDMap database ###
    ${GET_response}=    GET-IDMaps
    Status Should Be    200    ${GET_response}
### We verify each IDMap uploaded in pre-conditions appears and we also verify Table1 appears as an IDMap ###
    ${body}=    Convert To String    ${GET_response.content}
    FOR    ${name}    IN    @{names}
        Should Contain    ${body}    ${name}
    END
## We make a GET request to obtain MapTable and verify its elements ###
    ${idmap_name}=    Set Variable    MapTable
    ${GET_response}=    GET-IDMap With Name    ${idmap_name}
    Status Should Be    200    ${GET_response}
## Verify its elements ##
    Check IDMap Source Attribute    ${GET_response}    2    0    sourceID
    Check IDMap Source Attribute    ${GET_response}    2    0    sourceName
    Check IDMap Source Attribute    ${GET_response}    False    0    uniqueItems
    Check IDMap Source Attribute    ${GET_response}    1    1    sourceID
    Check IDMap Source Attribute    ${GET_response}    1    1    sourceName
    Check IDMap Source Attribute    ${GET_response}    False    1    uniqueItems
## We repeat with the Invalid IDMap ###
    ${idmap_name}=    Set Variable    Invalid
    ${GET_response}=    GET-IDMap With Name    ${idmap_name}
    Status Should Be    200    ${GET_response}
## Verify its elements ##
    Check IDMap Source Attribute    ${GET_response}    2    0    sourceID
    Check IDMap Source Attribute    ${GET_response}    2    0    sourceName
    Check IDMap Source Attribute    ${GET_response}    False    0    uniqueItems
    Check IDMap Source Attribute    ${GET_response}    1    1    sourceID
    Check IDMap Source Attribute    ${GET_response}    1    1    sourceName
    Check IDMap Source Attribute    ${GET_response}    False    1    uniqueItems
## We make a GET request to obtain Table1 with the GET IDMap endpoint ###
    ${idmap_name}=    Set Variable    Table1
    ${GET_response}=    GET-IDMap With Name    ${idmap_name}
    Status Should Be    200    ${GET_response}
## Verify its elements ##
    Check IDMap Source Attribute    ${GET_response}    1    0    sourceID
    Check IDMap Source Attribute    ${GET_response}    1    0    sourceName
    Check IDMap Source Attribute    ${GET_response}    True    0    uniqueItems
    Check IDMap Source Attribute    ${GET_response}    2    1    sourceID
    Check IDMap Source Attribute    ${GET_response}    2    1    sourceName
    Check IDMap Source Attribute    ${GET_response}    False    1    uniqueItems
    Check IDMap Source Attribute    ${GET_response}    3    2    sourceID
    Check IDMap Source Attribute    ${GET_response}    3    2    sourceName
    Check IDMap Source Attribute    ${GET_response}    False    2    uniqueItems
    Check IDMap Source Attribute    ${GET_response}    4    3    sourceID
    Check IDMap Source Attribute    ${GET_response}    4    3    sourceName
    Check IDMap Source Attribute    ${GET_response}    False    3    uniqueItems

## We make a request to obtain all links that map one source to another. We use a Table name to verify it searches in the IDMap database ###
    ${idmap_name}=    Set Variable    Table1
    ${GET_response}=    GET-Links That Map One Source to Another    ${idmap_name}    1    2
    Status Should Be    200    ${GET_response}
## Verify its elements ##
    ${counter}=    Count Links    ${GET_response}
    Should Be Equal As Strings    ${counter}    8
## We make a request to obtain all links that contain one specified item to another. We use a Table name to verify it searches in the IDMap database ###
    ${GET_response}=    GET-Links That Contain ItemID    ${idmap_name}    1    a1
    Status Should Be    200    ${GET_response}
## Verify its elements ##
    ${counter}=    Count Links that Contain ItemID    ${GET_response}
    Should Be Equal As Strings    ${counter}    4
    Set Suite Variable    ${results}    1

Report to JAMA
### Report to JAMA test results ###   
    ${jama_id}=    Run    python TestCaseResults.py "Automated - Convert IDMap to Table" "${testcycle}" 
    Run Keyword If    ${results} == 1    Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...    Jama-Report Failed Test    run_id=${jama_id}

*** Keywords ***
Unique Items    [Arguments]    ${idmap_name}    ${enforce}=true
    ${response}=    GET-Filter IDMap with Name    ${idmap_name}
    ${body}=    Convert To String    ${response.content}
    ${json_body}=    Convert String To Json    ${body}
    ${idmap_id}=    Get Value From Json    ${json_body}    $[0].id
    ${id_source_2}=    Get Value From Json    ${json_body}    $.[0].sources[0].id
    ${id_source_1}=    Get Value From Json    ${json_body}    $.[0].sources[1].id
    ${source1}=    Set Variable    {"id":"${id_source_1[0]}","sourceID": "1","sourceName":"1","uniqueItems":${enforce}}
    ${source2}=    Set Variable    {"id":"${id_source_2[0]}","sourceID": "2","sourceName":"2","uniqueItems":${enforce}}
    ${sources}=    Set Variable    [${source1},${source2}]
    ${jsonfile}=    Set Variable    [{"sources": ${sources},"name": "${idmap_name}","id": "${idmap_id[0]}"}]
    ${request_body}=    Convert To String    ${jsonfile}
    ${response}=    PUT-Update IDMap    ${request_body}
    Status Should Be    200    ${response}