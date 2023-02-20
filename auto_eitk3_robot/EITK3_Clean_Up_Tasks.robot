*** Settings ***
Library     SeleniumLibrary    run_on_failure=Nothing
Library     DateTime
Library     OperatingSystem
Resource    ../auto_common_robot/General_Variables.robot
Resource    ../auto_common_robot/General_Keywords.robot
Resource    ../auto_common_robot/${testsystem}_Variables.robot
Resource    Report_to_Jama.robot
Resource    EITK3_Task_Variables.robot
Resource    EITK3_General_Variables.robot
Resource    EITK3_General_Keywords.robot

*** Variables ***
${testsystem}=               SM-DAC1    #Default values, can be changed during execution
${testcycle}
${TaskCleanupTime}           1
${FileAge}                   1
${PayloadsStoredperTask}     100
${TaskHistoryAge}            1
${TaskRunRequestAge}         1

*** Test Cases ***
Change System Settings
    [Tags]    settings
## Navigate to EITK Setting Page Task Tab ##
    Open_Browser_And_Login_As_Admin    Chrome
    Select_EITK_Tool
    Navigate_To_System_Settings_Page
    EnterpriseITK_Settings_Task_Tab
    Verify_EITK_Settings_Page_Task_Tab
## Entering values ##
    ${Time}=               Get Current Date                  increment=00:05:00    result_format=%H:%M:%S
    ${Current_Daytime}=    Get Current Date                  increment=00:05:00    exclude_millis=True
    ${Daytime}=            Add Time To Date                  ${Current_Daytime}    1 day
    ${TaskCleanupTime}=    Set Variable                      ${Time}
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
    Logout_User_And_Close_Browser
    Run    echo ${Daytime} >> time_setup.txt


Restart EITK Instance
    [Tags]    restart
## Elements may be take a while to load, so we try with a high timeout ##
    Open_Browser_And_Login_As_Admin    Chrome
    Set Selenium Timeout               60s
## Navigate to Site Monitor Page ##
    Wait Until Element Is Visible      xpath=${Image_SM}
    Click Element                      xpath=${Image_SM}
    Wait Until Element Is Visible      xpath=${SM_System_Button}
    Element Text Should Be             xpath=${SM_System_Button}     ${testsystem}    ignore_case=True
    Click Element                      xpath=${SM_System_Button}
## Check the osii_eitkd process is visible ##
    Wait Until Element Is Visible      xpath=${EITK_process}
    Element Text Should Be             xpath=${EITK_process}    osii_eitkd
## Click on box to restart process ##
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
    Logout_User_And_Close_Browser

Check the Clean Up ran as expected
    [Tags]   verify
    Set Suite Variable    ${results}        0
    Open_Chrome_Browser_With_Modified_Download_Directory_And_Login_As_Admin
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
###   Report to JAMA test results ###  
    ${jama_id}=            Run                        python .\\auto_eitk3_endpoints\\TestCaseResults.py "Automated - Create, Modify & Delete EITK Table and Verify Table Elements via Endpoints" "${testcycle}" 
    Run Keyword If         ${results} == 1            Jama-Report Passed Test    run_id=${jama_id}
    ...  ELSE
    ...  Jama-Report Failed Test            run_id=${jama_id}


*** Keywords ***
Set_Value    [Arguments]             ${value}          ${xpath}
    Set Selenium Timeout             60s
    Click Element                    xpath=${xpath}
    Wait Until Element Is Enabled    xpath=${xpath}
    Input Text                       xpath=${xpath}    ${value}

Open_Chrome_Browser_With_Modified_Download_Directory_And_Login_As_Admin
    ${chrome options}=               Evaluate              sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # list of plugins to disable. disabling PDF Viewer is necessary so that PDFs are saved rather than displayed
    ${disabled}                       Create List          Chrome PDF Viewer
    ${prefs}                          Create Dictionary    download.default_directory=${OUTPUT_DIR}             plugins.plugins_disabled=${disabled}
    Call Method                       ${chrome options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver                  Chrome               chrome_options=${chrome options}
    Go To    ${URL}
    maximize browser window
    wait until element is visible     xpath=${OSI_Logo}
    wait until element is visible     xpath=${OSI_Username}
    input text                        id:username  admin
    wait until element is visible     xpath=${OSI_Password}
    input text                        id:password  admin21`
    wait until element is visible     xpath=${OSI_Login_Button}
    click element                     xpath=${OSI_Login_Button}  