*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
GET-Table with ID         [Arguments]              ${table_id}
    ${headers}=      Create Dictionary             osiApiToken=${Token}        accept=application/json
    ${response}=     GET On Session    Swagger    url=/eitk/api/v1/tables/${table_id}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

GET-Tables
    ${headers}=      Create Dictionary             osiApiToken=${Token}        accept=application/json
    ${response}=     GET On Session    Swagger    url=/eitk/api/v1/tables   headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Tables With Filter    [Arguments]             ${filter}
    ${headers}=           Create Dictionary       osiApiToken=${Token}         accept=application/json
    ${params}=            Create Dictionary       filter=${filter}
    ${response}=          GET On Session    Swagger    url=/eitk/api/v1/tables   headers=${headers}        params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword   ${response}

GET-Tasks With Name       [Arguments]             ${task_name}
    ${headers}=           Create Dictionary       osiApiToken=${Token}    accept=application/json
    ${response}=          GET On Session    Swagger    url=/eitk/api/v1/taskconfig/${task_name}   headers=${headers}        expected_status=Anything    verify=${False}
    Return From Keyword   ${response}

GET-Tasks With Filter     [Arguments]             ${task_name}            ${filter}
    ${headers}=           Create Dictionary       osiApiToken=${Token}    accept=application/json
    ${params}=            Create Dictionary       filter=${filter}
    ${response}=          GET On Session    Swagger    url=/eitk/api/v1/taskconfig   headers=${headers}        params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword   ${response}

GET-IDMap With Name Filter    [Arguments]          ${name}
    ${headers}=               Create Dictionary    osiApiToken=${Token}
    ${params}=                Create Dictionary    filter=["name","=","${name}"]
    ${response}=              GET On Session    Swagger    url=/api/v1/idmaps   headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword       ${response}

GET-Row with Key            [Arguments]            ${table_id}             ${row_key}
    ${headers}=             Create Dictionary      osiApiToken=${Token}    accept=application/json
    ${response}=            GET On Session    Swagger    url=/eitk/api/v1/tables/${table_id}/rows/${row_key}    headers=${headers}    verify=${False}
    Return From Keyword     ${response}

GET-Tables Events with Filter    [Arguments]        ${filter}
    ${headers}=             Create Dictionary       osiApiToken=${Token}    accept=application/json
    ${params}=              Create Dictionary       filter=${filter}
    ${response}=            GET On Session    Swagger    url=/eitk/api/v1/tables-events    headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword     ${response}

GET-Tables Events
    ${headers}=            Create Dictionary    osiApiToken=${Token}    accept=application/json
    ${response}=           GET On Session    Swagger    url=/eitk/api/v1/tables-events    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Table with ID in CSV Format       [Arguments]         ${table_id}
    ${headers}=              Create Dictionary            osiApiToken=${Token}    accept=text/csv
    ${response}=             GET On Session    Swagger    url=/eitk/api/v1/tables-export/${table_id}    headers=${headers}    verify=${False}
    Return From Keyword      ${response}

GET-Tables Rows    [Arguments]        ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${Token}    accept=application/json
    ${response}=   GET On Session       Swagger    url=/eitk/api/v1/tables/${table_id}/rows    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

GET-Filter IDMap with Name    [Arguments]    ${idmap_name}
    ${headers}=       Create Dictionary    osiApiToken=${Token}    accept=application/json
    ${params}=        Create Dictionary    filter=["name","=","${idmap_name}"]
    ${response}=      GET On Session    Swagger    url=/eitk/v1/idmaps   headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-IDMaps
    ${headers}=     Create Dictionary    osiApiToken=${Token}
    ${response}=    GET On Session    Swagger    url=/eitk/api/v1/idmaps   headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-IDMap With Name    [Arguments]       ${name}
    ${headers}=     Create Dictionary    osiApiToken=${Token}
    ${response}=    GET On Session    Swagger    url=/eitk/api/v1/idmaps/${name}   headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Links That Map One Source to Another    [Arguments]    ${idmap_name}    ${fromSource}    ${toSource}
    ${headers}=     Create Dictionary    osiApiToken=${Token}
    ${response}=    GET On Session    Swagger    url=/eitk/api/v1/idmaps/${idmap_name}/from/${fromSource}/to/${toSource}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Links That Contain ItemID    [Arguments]    ${idmap_name}    ${sourceID}    ${itemID}
    ${headers}=     Create Dictionary    osiApiToken=${Token}
    ${response}=    GET On Session    Swagger    url=/eitk/api/v1/idmaps/${idmap_name}/sources/${sourceID}/items/${itemID}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Task Run History            [Arguments]     ${params}=${None}
    ${headers}=     Create Dictionary    osiApiToken=${Token}
    ${response}=      GET On Session    Swagger    url=/eitk/api/v1/taskrunhistory   headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET-Task Run Requests            [Arguments]     ${params}=${None}
    ${headers}=     Create Dictionary    osiApiToken=${Token}
    ${response}=      GET On Session    Swagger    url=/eitk/api/v1/taskrunrequests   headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}