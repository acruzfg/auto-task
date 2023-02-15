*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing
Library    DateTime
Resource    ../auto_common_robot/General_Variables.robot
Resource    ../auto_common_robot/General_Keywords.robot
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Resource    EITK3_Task_Variables.robot
Resource    EITK3_General_Variables.robot
Resource    EITK3_General_Keywords.robot

*** Variables ***
${testsystem}=               SM5-DAC1    #Default values, can be changed during execution
${TaskCleanupTime}=          02:00:00    
${FileAge}=                  1    
${PayloadsStoredperTask}=    100
${TaskHistoryAge}=           60
${TaskRunRequestAge}=        30


*** Test Cases ***
Change System Settings
## Navigate to EITK Setting Page Task Tab ##
    Open_Browser_And_Login_As_Admin    Chrome
    Select_EITK_Tool
    Navigate_To_System_Settings_Page
    EnterpriseITK_Settings_Task_Tab
    Verify_EITK_Settings_Page_Task_Tab
## Entering values ##
    ${Daytime}=    Get Current Date    increment=00:05:00    result_format=%H:%M:%S
    ${TaskCleanupTime}=    Set Variable    ${Daytime}
    Set_Value    ${TaskCleanupTime}    ${EITK_Cleanup_Time_Textbox}
    Set_Value    ${FileAge}    ${EITK_Max_File_Age_Textbox}   
    Set_Value    ${PayloadsStoredperTask}    ${EITK_Max_Payloads_Stored_Per_Task_Textbox}
    Set_Value    ${TaskHistoryAge}    ${EITK_Task_History_Age_Textbox} 
    Set_Value    ${TaskRunRequestAge}    ${EITK_Max_Task_Run_Request_Age_Textbox}
## Save changes and verify correct pop up message ##
    Click Button    xpath=${EITK_Settings_Save_Button}
    Wait until element is visible  ${Message_Snackbar}
    ${Pop_Up_Message}=  Get text  ${Message_Snackbar_Text}
    Run Keyword If    "${Pop_Up_Message}" == "No changes made"
    ...    Log    The values entered are the same as before. No changes made.
    ...  ELSE
    ...    Should be equal  ${Pop_Up_Message}  Save successful
    Close All Browsers

Restart EITK Instance
## Navigate to EITK Setting Page Task Tab ##
    Open_Browser_And_Login_As_Admin    Chrome
    Set Selenium Speed    2s
    Wait Until Element Is Visible    xpath=${Image_SM}
    Click Element    xpath=${Image_SM}
    Wait Until Element Is Visible    xpath=//*[@id="global-page-content"]/div[2]/div[2]/div[1]/div/div
    Click Element    xpath=//*[@id="global-page-content"]/div[2]/div[2]/div[1]/div/div
    Sleep    10s

    Close All Browsers

*** Keywords ***
Set_Value    [Arguments]    ${value}    ${xpath}
    Set Selenium Timeout    60s
    Click Element    xpath=${xpath}
    Wait Until Element Is Enabled    xpath=${xpath}
    Input Text    xpath=${xpath}    ${value}