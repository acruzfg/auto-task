*** Settings ***
Library     SeleniumLibrary    run_on_failure=Nothing
Library     DateTime
Library     OperatingSystem
Resource    ../auto_common_robot/General_Variables.robot
Resource    ../auto_common_robot/General_Keywords.robot
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Resource    EITK3_Task_Variables.robot
Resource    EITK3_General_Variables.robot
Resource    EITK3_General_Keywords.robot
Test Setup       Open_Browser_And_Login_As_Admin    Chrome
Test Teardown    Logout_User_And_Close_Browser

*** Variables ***
${testsystem}=               SM5-DAC1    #Default values, can be changed during execution
${TaskCleanupTime}  
${FileAge} 
${PayloadsStoredperTask}
${TaskHistoryAge}
${TaskRunRequestAge}

*** Test Cases ***
Change System Settings
    [Tags]    settings
## Navigate to EITK Setting Page Task Tab ##
    Select_EITK_Tool
    Navigate_To_System_Settings_Page
    EnterpriseITK_Settings_Task_Tab
    Verify_EITK_Settings_Page_Task_Tab
## Entering values ##
    ${Daytime}=            Get Current Date                  increment=00:10:00    result_format=%H:%M:%S
    ${TaskCleanupTime}=    Set Suite Variable                ${Daytime}
    Set_Value              ${TaskCleanupTime}                ${EITK_Cleanup_Time_Textbox}
    Set_Value              ${FileAge}                        ${EITK_Max_File_Age_Textbox}   
    Set_Value              ${PayloadsStoredperTask}          ${EITK_Max_Payloads_Stored_Per_Task_Textbox}
    Set_Value              ${TaskHistoryAge}                 ${EITK_Task_History_Age_Textbox} 
    Set_Value              ${TaskRunRequestAge}              ${EITK_Max_Task_Run_Request_Age_Textbox}
## Save changes and verify correct pop up message ##
    Click Button                   xpath=${EITK_Settings_Save_Button}
    Wait until element is visible  ${Message_Snackbar}
    ${Pop_Up_Message}=             Get text          ${Message_Snackbar_Text}
    Run Keyword If                 "${Pop_Up_Message}" == "No changes made"
    ...    Log                     The values entered are the same as before. No changes made.
    ...  ELSE
    ...    Should be equal         ${Pop_Up_Message}  Save successful


Restart EITK Instance
    [Tags]    restart
## Elements may be take a while to load, so we try with a high timeout ##
    Set Selenium Timeout               60s
## Navigate to Site Monitor Page ##
    Wait Until Element Is Visible      xpath=${Image_SM}
    Click Element                      xpath=${Image_SM}
    Wait Until Element Is Visible      xpath=${SM_System_Button}
    Element Text Should Be             xpath=${SM_System_Button}     sm5-dac1
    Click Element                      xpath=${SM_System_Button}
## Check the osii_eitkd process is visible ##
    Wait Until Element Is Visible      xpath=${EITK_process}
    Element Text Should Be             xpath=${EITK_process}    osii_eitkd
## Click on box to restar process ##
    Page Should Contain Element        xpath=${EITK_Restart_Checkbox}
    Click Element                      xpath=${EITK_Restart_Checkbox}
    Wait Until Element Is Enabled      xpath=${Restart_Process_Button}
    Click Element                      xpath=${Restart_Process_Button}
## Confirm on pop up window ##    
    Wait Until Element Is Visible      xpath=${Confirm_Button}
    Wait Until Element Is Enabled      xpath=${Confirm_Button}
    Click Element                      xpath=${Confirm_Button}
## Verify message confirms process was restarted ##
    Wait until element is visible      ${Message_Snackbar}
## Go back to App Page ##
    Click Element                      xpath=${OSINavbar_Button_Apps}
    Wait Until Element Is Visible      xpath=${OSINavbar_Button_Apps_ShowApps}
    Click Element                      xpath=${OSINavbar_Button_Apps_ShowApps}
## Wait for EITk to restart and appear again the in the Apps Page. This make take up to 2-3 minutes ##
    Set Selenium Timeout    180s
    Wait Until Element Is Not Visible  xpath=${Image_EITK}
    Wait Until Element Is Visible      xpath=${Image_EITK}



*** Keywords ***
Set_Value    [Arguments]             ${value}          ${xpath}
    Set Selenium Timeout             60s
    Click Element                    xpath=${xpath}
    Wait Until Element Is Enabled    xpath=${xpath}
    Input Text                       xpath=${xpath}    ${value}