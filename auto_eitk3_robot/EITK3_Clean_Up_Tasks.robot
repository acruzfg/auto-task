*** Settings ***
Library     SeleniumLibrary    run_on_failure=Nothing
Library     DateTime
Library     OperatingSystem
Library     String
Resource    ../auto_common_robot/General_Variables.robot
Resource    ../auto_common_robot/General_Keywords.robot
Resource    ../auto_common_robot/${TESTSERVER}_Variables.robot
Resource    ../auto_eitk3_endpoints/EITK3_POST_Keywords.robot
Resource    ../auto_eitk3_endpoints/EITK3_DELETE_Keywords.robot
Resource    ../auto_eitk3_endpoints/EITK3_GET_Keywords.robot
Resource    ../auto_eitk3_endpoints/EITK3_General_Endpoints_Keywords.robot
Resource    EITK3_Task_Variables.robot
Resource    EITK3_General_Variables.robot
Resource    EITK3_General_Keywords.robot
Suite Teardown   Run Keywords
...              Run Keyword If All Tests Passed    Run    jama_report_results.EXE --testplanid ${testplanid} --testcaseid ${testcaseid} --passed True --user ${jamauser} --password ${jamapwd} --notes "Test passed"
...    AND       Run Keyword If Any Tests Failed    Run    jama_report_results.EXE --testplanid ${testplanid} --testcaseid ${testcaseid} --passed False --user ${jamauser} --password ${jamapwd} --notes "Test failed. Check logs for more information"

*** Variables ***
### VARIABLES TO REPORT IN JAMA ###
${testplanid}
${testcaseid}
${jamauser}
${jamapwd}
### TEST CASE VARIABLES ###
${TESTSERVER}=               SM5-DAC1    #Default values, can be changed during execution
### Task variables
${TaskName}                  Auto-Task-Clean-Up-Verification
### Settings variables
${TaskCleanupTime}                       #This variable would updated to the current time plus 5 minutes
${FileAge}                   1
${PayloadsStoredperTask}     100
${TaskHistoryAge}            1
${TaskRunRequestAge}         1

*** Test Cases ***
Change System Settings
    [Tags]    settings
## In the first part, we make sure there's at least one task that has run before clean up time ##
## Verify the task name is not occupied, if it is, then the task is deleted ##
    Create Session    Swagger                         ${Base_URL}
    Make Sure Task Does Not Exist                     ${TaskName}
### Create task details ###
    ${createAuditCopies}=    Set Variable             Never
    ${Hostname}=             Convert To Lower Case    ${TESTSERVER}  
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
    Open_Browser_And_Login_As_Admin        Chrome
    Select_EITK_Tool
    Navigate_To_System_Settings_Page
    EnterpriseITK_Settings_Task_Tab
    Verify_EITK_Settings_Page_Task_Tab
## Entering values ##
    ${Time}=               Get Current Date                  increment=00:05:00    result_format=%H:%M:%S    ## to set up the clean up time
    ${Current_Daytime}=    Get Current Date                  increment=00:05:00    exclude_millis=True       ## to check if clean up was ran the next day
    ${CleanUpCheckTime}=   Subtract Time From Date           ${Current_Daytime}    1 day
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
    Restart_Proccess_Using_Site_Monitor    ${TESTSERVER}            osii_eitkd
    Logout_User_And_Close_Browser
    ${Expected_Clean_Up_Time}=             Convert Date          ${CleanUpCheckTime}        result_format=epoch
    ${Expected_Clean_Up_Time}=             Convert To Integer    ${Expected_Clean_Up_Time}
    Run    echo ${Expected_Clean_Up_Time} >> time_setup.txt            ### save to verify the cleaner run successfully

Check the Clean Up ran as expected
    [Tags]   verify   
## We obtain expected clean up time from created file ##
    File Should Exist                                 time_setup.txt
    ${Clean_Up_Time}=     Get File                    time_setup.txt
    Remove File                                       time_setup.txt
##  Remove possible lingering white spaces ##
    ${Clean_Up_Time}=     Remove String               ${Clean_Up_Time}    ${SPACE}
    ${Clean_Up_Time}=     Remove String               ${Clean_Up_Time}    ${\n}
### Add miliseconds as we ignored them in the past test ###
    ${Miliseconds}=       Set Variable                000
    ${Clean_Up_Time}=     Set Variable                ${Clean_Up_Time}${Miliseconds}
##  Remove possible lingering white spaces ##
    ${Clean_Up_Time}=     Remove String               ${Clean_Up_Time}    \n
##  Create session to send API requests
    Create Session        Swagger                     ${Base_URL}
##  Filter for start time before the clean up date 
    ${filter}=            Set Variable                ["startTime","<","${Clean_Up_Time}"]
    ${params}=            Create Dictionary           filter=${filter}
##  Request for task history
    ${TaskHistory}=       GET-Task Run History        ${params}
    Status Should Be      200                         ${TaskHistory}
##  Verify it is empty
    ${Body}=              Convert To String           ${TaskHistory.content}
    Should Be Equal As Strings    ${Body}             [${SPACE}]
##  Request for task run requests
    ${RunRequests}=       GET-Task Run Requests       ${params}
    Status Should Be      200                         ${RunRequests}
##  Verify it is empty
    ${Body}=              Convert To String           ${RunRequests.content}
    Should Be Equal As Strings    ${Body}             [${SPACE}]
    Delete All Sessions

*** Keywords ***
Set_Value    [Arguments]             ${value}          ${xpath}
    Set Selenium Timeout             60s
    Click Element                    xpath=${xpath}
    Wait Until Element Is Enabled    xpath=${xpath}
    Input Text                       xpath=${xpath}    ${value}