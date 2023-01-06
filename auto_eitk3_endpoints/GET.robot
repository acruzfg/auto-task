*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Resource    ../../Resources/Validation/Validation.robot

*** Variables ***


*** Keywords ***
GET Table with ID    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}    accept=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/tables/${table_id}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

GET Tables
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/tables    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

GET Tables With ID Filter    [Arguments]    ${id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${params}=    Create Dictionary    filter=["id","=","${id}"]
    ${response}=    GET On Session    Swagger    url=/api/v1/tables   headers=${headers}        params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}


GET Tasks With Name Filter    [Arguments]    ${name}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${params}=    Create Dictionary    filter=["name","=","${name}"]
    ${response}=    GET On Session    Swagger    url=/api/v1/taskconfig   headers=${headers}        params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET IDMap With Name Filter    [Arguments]    ${name}
    ${headers}=    Create Dictionary    osiApiToken=${token}
    ${params}=    Create Dictionary    filter=["name","=","${name}"]
    ${response}=    GET On Session    Swagger    url=/api/v1/idmaps   headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET Row with Key    [Arguments]    ${table_id}    ${row_key}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/tables/${table_id}/rows/${row_key}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

GET Tables Events with Filter    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    accept=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/tables-events    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET Tables Events
    ${headers}=    Create Dictionary    osiApiToken=${token}    accept=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/tables-events    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET Table with ID in CSV Format   [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}    accept=${CSV_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/tables-export/${table_id}    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

GET Rows    [Arguments]    ${table_id}
    ${headers}=    Create Dictionary    osiApiToken=${token}    Content-Type=${JSON_format}    accept=${JSON_format}
    ${response}=    GET On Session    Swagger    url=/api/v1/tables/${table_id}/rows    headers=${headers}    verify=${False}
    Return From Keyword    ${response}

GET IDMap Details    [Arguments]    ${name}
    ${headers}=    Create Dictionary    osiApiToken=${token}
    ${params}=    Create Dictionary    filter=["name","=","${name}"]
    ${response}=    GET On Session    Swagger    url=/v1/idmaps   headers=${headers}    params=${params}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET IDMaps
    ${headers}=    Create Dictionary    osiApiToken=${token}
    ${response}=    GET On Session    Swagger    url=/api/v1/idmaps   headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET IDMap With Name    [Arguments]    ${name}
    ${headers}=    Create Dictionary    osiApiToken=${token}
    ${response}=    GET On Session    Swagger    url=/api/v1/idmaps/${name}   headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET Mapping from one source to another in IDMap    [Arguments]    ${idmap_name}    ${fromSource}    ${toSource}
    ${headers}=    Create Dictionary    osiApiToken=${token}
    ${response}=    GET On Session    Swagger    url=/api/v1/idmaps/${idmap_name}/from/${fromSource}/to/${toSource}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}

GET Links IDMap    [Arguments]    ${idmap_name}    ${sourceID}    ${itemID}
    ${headers}=    Create Dictionary    osiApiToken=${token}
    ${response}=    GET On Session    Swagger    url=/api/v1/idmaps/${idmap_name}/sources/${sourceID}/items/${itemID}    headers=${headers}    expected_status=Anything    verify=${False}
    Return From Keyword    ${response}





    