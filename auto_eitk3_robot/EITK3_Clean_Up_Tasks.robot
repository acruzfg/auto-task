*** Settings ***
Library     SeleniumLibrary    run_on_failure=Nothing
Library     DateTime
Library     OperatingSystem
Library     String
Resource    ../auto_common_robot/General_Variables.robot
Resource    ../auto_common_robot/General_Keywords.robot
Resource    ../auto_common_robot/${TESTSYSTEM}_Variables.robot
Resource    ../auto_eitk3_endpoints/EITK3_POST_Keywords.robot
Resource    ../auto_eitk3_endpoints/EITK3_PUT_Keywords.robot
Resource    ../auto_eitk3_endpoints/EITK3_DELETE_Keywords.robot
Resource    ../auto_eitk3_endpoints/EITK3_GET_Keywords.robot
Resource    ../auto_eitk3_endpoints/EITK3_General_Endpoints_Keywords.robot
Resource    Report_to_Jama.robot
Resource    EITK3_Task_Variables.robot
Resource    EITK3_General_Variables.robot
Resource    EITK3_General_Keywords.robot

*** Variables ***
${TESTSYSTEM}=               SM5-DAC1    #Default values, can be changed during execution
${testcycle}
### Task variables
${TaskName}
${Hostname}
### Settings variables
${TaskCleanupTime}           1
${FileAge}                   1
${PayloadsStoredperTask}     100
${TaskHistoryAge}            1
${TaskRunRequestAge}         1

*** Test Cases ***
Change System Settings
    [Tags]    settings
## In the first part, we make sure there's at least one task that has run today ##
## Verify the task name is not occupied, if it is, then the task is deleted ##
    Create Session    Swagger                         ${Base_URL}
    Make Sure Task Does Not Exist                     ${TaskName}
### Create task details ###
    ${createAuditCopies}=    Set Variable             Always
    ${task}=                 Set Variable             {"name": "${TaskName}","createAuditCopies": "${createAuditCopies}"}
### Create file step set up ###
    ${createAuditCopies}=    Set Variable             Never
    ${Hostname}=             Convert To Lower Case    ${TESTSYSTEM}  
    ${steps}=                Set Variable             [{"type": "FILE","description": "","hostname": "${Hostname}","filePath": "*","disablePreserveTimestamp": false,"deletePostTransfer": "NEVER","readFile": true,"treatMissingFilesAsSuccess": true,"protocol": "MONARCH"}]
    ${task}=                 Set Variable             {"name": "${TaskName}", "createAuditCopies": "${createAuditCopies}","steps": ${steps}}
### Create task ###
    ${Create_task}=     POST-Create Task   ${task}
    Status Should Be    201                ${Create_task}
### Run the created task, it should be successful by default ##
    ${Run_request}=     POST-Run a Task    ${TaskName}
    Status Should Be    200                ${Run_request}
    Delete All Sessions
## Navigate to EITK Setting Page Task Tab ##
    Open_Browser_And_Login_As_Admin    Chrome
    Select_EITK_Tool
    Navigate_To_System_Settings_Page
    EnterpriseITK_Settings_Task_Tab
    Verify_EITK_Settings_Page_Task_Tab
## Entering values ##
    ${Time}=               Get Current Date                  increment=00:05:00    result_format=%H:%M:%S    ## to set up the clean up time
    ${Current_Daytime}=    Get Current Date                  increment=00:05:00    exclude_millis=True       ## to check if clean up was ran the next day
    ${Daytime}=            Add Time To Date                  ${Current_Daytime}    1 day
    ${TaskCleanupTime}=    Set Variable                      ${Time}
    Set_Value              ${TaskCleanupTime}                ${EITK_Cleanup_Time_Textbox}
    Set_Value              ${FileAge}                        ${EITK_Max_File_Age_Textbox}   
    Set_Value              ${PayloadsStoredperTask}          ${EITK_Max_Payloads_Stored_Per_Task_Textbox}
    Set_Value              ${TaskHistoryAge}                 ${EITK_Task_History_Age_Textbox} 
    Set_Value              ${TaskRunRequestAge}              ${EITK_Max_Task_Run_Request_Age_Textbox}
## Save changes and verify correct pop up message ##
    Click Button                           xpath=${EITK_Settings_Save_Button}
    Wait until element is visible          ${Message_Snackbar}
    ${Pop_Up_Message}=                     Get text                 ${Message_Snackbar_Text}
    Run Keyword If                         "${Pop_Up_Message}" == "No changes made"
    ...    Log                             The values entered are the same as before. No changes made.
    ...  ELSE
    ...    Should be equal                 ${Pop_Up_Message}        Save successful
    Restart_Proccess_Using_Site_Monitor    ${TESTSYSTEM}            osii_eitkd
    Logout_User_And_Close_Browser
    ${Expected_Clean_Up_Time}=             Convert Date      ${Daytime}     result_format=epoch
    Run    echo ${Expected_Clean_Up_Time} >> time_setup.txt            ### save to verify the cleaner run the next day

Check the Clean Up ran as expected
    [Tags]   verify
    Set Suite Variable    ${results}        0
    ${Clean_Up_Time}=    Get File    time_setup.txt
    Remove File          time_setup.txt
    Log    Clean up time was expected at ${Clean_Up_Time}
    Navigate_To_Audits_Page
## Wait for the page to load and te download button appears
    Wait Until Page Contains         Audits
    Wait Until Element Is Visible    xpath=${Download_Button}
    Wait Until Element Is Enabled    xpath=${Download_Button}
    Click Element                    xpath=${Download_Button}
# Wait for option in the download button and select one
    Wait Until Element Is Visible    xpath=${Download_All_Option}
    Wait Until Element Is Enabled    xpath=${Download_All_Option}
    Click Element                    xpath=${Download_All_Option}
    Wait Until Keyword Succeeds    1min    5s    File Should Exist    ${OUTPUT DIR}/audits.csv
    # create unique folder
    Logout_User_And_Close_Browser
    ${Return_Code}                   ${Output}=        Run And Return Rc And Output   python .\\auto_eitk3_robot\\check_audits_file.py "audits.csv" "${Clean_Up_Time}"
    Should Be Equal As Integers      ${Return_Code}    0
    Should Be Equal As Strings       ${Output}         OK
    Set Suite Variable               ${results}        1

Report to JAMA
    [Tags]    jama
###   Report to JAMA test results ###  
    ${jama_id}=            Run                        python .\\auto_eitk3_endpoints\\TestCaseResults.py "Automated - Clean Up Tasks" "${testcycle}" 
    Run Keyword If         ${results} == 1            Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...  Jama-Report Failed Test            run_id=${jama_id}


*** Keywords ***
Set_Value    [Arguments]             ${value}          ${xpath}
    Set Selenium Timeout             60s
    Click Element                    xpath=${xpath}
    Wait Until Element Is Enabled    xpath=${xpath}
    Input Text                       xpath=${xpath}    ${value}