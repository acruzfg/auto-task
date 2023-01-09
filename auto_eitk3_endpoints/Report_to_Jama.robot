*** Settings ***
Library    OperatingSystem

*** Keywords ***
Jama-Report Passed Test    [Arguments]    ${run_id}    
    ${curl}=    Set Variable    curl -u auto_sysman:OSISysman -X PUT "https://osi.jamacloud.com/rest/v1/testruns/${run_id}" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \\"fields\\": { \\"testRunStatus\\": \\"PASSED\\", \\"automated$37\\": false }}"
    ${jama_id}=    Run    ${curl}
    Should Contain    ${jama_id}    "OK"    
Jama-Report Failed Test    [Arguments]    ${run_id}
    ${curl}=    Set Variable    curl -u auto_sysman:OSISysman -X PUT "https://osi.jamacloud.com/rest/v1/testruns/${run_id}" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \\"fields\\": { \\"testRunStatus\\": \\"FAILED\\", \\"automated$37\\": false }}"
    ${jama_id}=    Run    ${curl}
    Should Contain    ${jama_id}    "OK"