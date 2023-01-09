*** Settings ***
Variables  Robot_Pass_Fail_Report_To_Jama.py
Library  Robot_Pass_Fail_Report_To_Jama.py


*** Keywords ***
########################################################################################################################

# General Keywords Used:

Verify_Application_Page
    # Verify Application Page
    wait until element is visible  xpath=${PageTitle_OSIWebApplications}
	wait until element is visible  xpath=${Image_EITK}
	wait until element is visible  xpath=${ImageText_EITK}

Select_EITK_Tool
	wait until element is visible  xpath=${Image_EITK}
	wait until element is visible  xpath=${ImageText_EITK}
	click element  xpath=${Image_EITK}
	wait until element is not visible  xpath=${Tasks_Search_Loading}

Verify_OSINavbar
    ${IsElementVisible}=    Run keyword and return status    wait until element is visible  xpath=${OSINavbar_Tasks}    2s
    IF  ${IsElementVisible} == ${False}
        FOR    ${i}    IN RANGE    2
            Click Element    xpath=//*[@id='navbar']/div/div/div[@role='button' and @aria-label="menu"]
            wait until element is visible    xpath=//*[@class="dx-treeview-node-container" and @role='group']
            click element    xpath=//*[@role="treeitem" and @aria-label="admin"]
            wait until element is visible    xpath=//*[@role="treeitem" and @aria-label="admin" and @aria-expanded="true"]
            wait until element is visible    xpath=//*[@data-item-id="18" and @role="treeitem"]
            click element    xpath=//*[@data-item-id="18" and @role="treeitem"]
        END 
    END       
    # Verify Tasks Dropdown:
    wait until element is visible  xpath=${OSINavbar_Tasks}
    wait until element is visible  xpath=${OSINavbar_Tasks_Caret}
    click element  xpath=${OSINavbar_Tasks_Caret}
    wait until element is visible  xpath=${OSINavbar_Tasks_Tasks}
    wait until element is visible  xpath=${OSINavbar_Tasks_TaskRunRequest}
    #wait until element is visible  xpath=${OSINavbar_Tasks_TaskRunHistory}
    #click element  xpath=${OSINavbar_Tasks_Caret}
    # Verify Naming Service Dropdown:
    wait until element is visible  xpath=${OSINavbar_NamingService}
    wait until element is visible  xpath=${OSINavbar_NamingService_Caret}
    click element  xpath=${OSINavbar_NamingService_Caret}
    wait until element is visible  xpath=${OSINavbar_NamingService_IDMaps}
    wait until element is visible  xpath=${OSINavber_NamingService_Sources}
    # Verify Admin Dropdown:
    wait until element is visible  xpath=${OSINavbar_Admin}
    wait until element is visible  xpath=${OSINavbar_AdminCaret}
    click element  xpath=${OSINavbar_AdminCaret}
    wait until element is visible  xpath=${OSINavbar_AdminDropdown_SystemSettings}
    # Verify Notifications Button:
    wait until element is visible  xpath=${OSINavbar_Button_Notifications}
    click element  xpath=${OSINavbar_Button_Notifications}
    wait until element is visible  xpath=${OSINavbar_NotificationsDropdown_ViewNotifications}
    wait until element is visible  xpath=${OSINavbar_NotificationsDropdown_ManageTopics}
    # Verify Apps Button:
    wait until element is visible  xpath=${OSINavbar_Button_Apps}
    # Verify admin Dropdown:
    wait until element is visible  xpath=${OSINavbar_adminL}
    wait until element is visible  xpath=${OSINavbar_adminCaretL}
    click element  xpath=${OSINavbar_adminCaretL}
    wait until element is visible  xpath=${OSINavbar_adminDropdown_Logout}
    wait until element is visible  xpath=${OSINavbar_adminDropdown_ChangePassword}
    wait until element is visible  xpath=${OSINavbar_adminDropdown_ChangeLandingPage}
    wait until element is visible  xpath=${OSINavbar_adminDropdown_SwitchToMobileView}
    #click element  xpath=${OSINavbar_adminCaretL}
    #wait until element is not visible  xpath=${OSINavbar_adminDropdown_Logout}

Tasks_Column_Visual_Verification
    # Verify Tasks page
    wait until element is visible  xpath=${Tasks_Name_Column}
    wait until element is visible  xpath=${Tasks_Status_Column}
    wait until element is visible  xpath=${Tasks_LastRunTime_Column}
    wait until element is visible  xpath=${Tasks_NextScheduledRunTime_Column}

Navigate_To_Tasks_Page
    # Navigate to Tasks
    wait until element is visible  xpath=${EITK_Tasks_Dropdown}
    wait until element is visible  xpath=${EITK_Tasks_Caret}
    click element  xpath=${EITK_Tasks_Caret}
    wait until element is visible  xpath=${Tasks_Dropdown_Tasks}
    wait until element is visible  xpath=${Tasks_Dropdown_TaskRunRequests}
    #wait until element is visible  xpath=${Tasks_Dropdown_TaskRunHistory}
    click element  xpath=${Tasks_Dropdown_Tasks}

Verify_Task_Page
    log to console  Verify Task Page Starting
    # Verify that we are on the Tasks Page:
    wait until element is visible  xpath=${Tasks_Logo}
    wait until element is visible  xpath=${Tasks_PageTitle}
    wait until element is visible  xpath=${Tasks_TextDragColumn}
    wait until element is visible  xpath=${Tasks_ColumnChooser_Icon}
    click element  xpath=${Tasks_ColumnChooser_Icon}
    wait until element is visible  xpath=${Tasks_ColumnChooser_PopupTitle}
    wait until element is visible  xpath=${Tasks_ColumnChooser_PopupClose_Button}
    wait until element is visible  xpath=${Tasks_ColumnChooser_PopupText}
    click element  xpath=${Tasks_ColumnChooser_PopupClose_Button}
    wait until element is not visible  xpath=${Tasks_ColumnChooser_PopupTitle}
    Tasks_Column_Visual_Verification
    wait until element is visible  xpath=${Tasks_AddTask_Button}
    # Verify Name Column Search Capabilties:
    log to console  Step Name
    ${Page_Title}  set variable  Tasks
    ${Column_Title}  set variable  Name
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    ${IsElementVisible}=  run keyword and return status  element should be visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    run keyword if  ${IsElementVisible}  Check_Column_Search_Options_Text  ${Page_Title}  ${Column_Title}
    wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Status Column Search Capabilties:
    log to console  Step Status
    ${Column_Title}  set variable  Status
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    ${IsElementVisible}=  run keyword and return status  element should be visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    run keyword if  ${IsElementVisible}  Check_Column_Search_Options_Text  ${Page_Title}  ${Column_Title}
    wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Last Run Time Column Search Capabilties:
    log to console  Step LastRunTime
    ${Column_Title}  set variable  LastRunTime
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Calendar_Icon}
    ${IsElementVisible}=  run keyword and return status  element should be visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    run keyword if  ${IsElementVisible}  Check_Column_Search_Options_Numerical  ${Page_Title}  ${Column_Title}
    wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Next Scheduled Run Time Column Search Capabilties:
    log to console  Step NextScheduledRunTime
    ${Column_Title}  set variable  NextScheduledRunTime
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Calendar_Icon}
    ${IsElementVisible}=  run keyword and return status  element should be visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    run keyword if  ${IsElementVisible}  Check_Column_Search_Options_Numerical  ${Page_Title}  ${Column_Title}
    wait until element is not visible  xpath=${Tasks_Search_Loading}
    log to console  Verify Task Page Ended

Tasks_SearchName_Textbox
    # Verify that we are on the Task Page
    wait until element is visible  xpath=${Tasks_PageTitle}
    # Verify that the Task Page Name Search Textbox is visible/ exists
    wait until element is visible  xpath=${Tasks_Name_Column_Search_Textbox}

Delete_Task
    # Click on Task Delete Button
    wait until element is visible  xpath=${Tasks_Delete_Button}
    click element  xpath=${Tasks_Delete_Button}
    # Verify Delete Task Popup
    wait until element is visible  xpath=${Tasks_Delete_Button_Dialog_Message}
    element text should be  xpath=${Tasks_Delete_Button_Dialog_Message}  Are you sure you want to delete this Task?
    wait until element is visible  xpath=${Tasks_Delete_Button_Option_Yes}
    element text should be  xpath=${Tasks_Delete_Button_Option_Yes}  YES
    click element  xpath=${Tasks_Delete_Button_Option_Yes}
    # Verify this Task was deleted
    wait until element is not visible  xpath=${Tasks_Delete_Button_Dialog_Message}
    wait until element is visible  xpath=${Message}
    element text should be  xpath=${Message}  Task was successfully deleted
    wait until element is not visible  xpath=${Message}
    wait until element is visible  xpath=${Tasks_Grid_After_Search_And_Delete}
    element text should be  xpath=${Tasks_Grid_After_Search_And_Delete}  No Data

Count_Total_Amount_Of_Steps
    ${Web_Count}=  get element count  //*[@id="WEB"]
    ${File_Count}=  get element count  //*[@id="FILE"]
    ${Executable_Count}=  get element count  //*[@id="EXE"]
    ${Email_Count}=  get element count  //*[@id="EMAIL"]
    ${Translation_Count}=  get element count  //*[@id="TRANSLATION"]
    ${Payload_Storage_Count}=  get element count  //*[@id="PAYLOAD_STORAGE"]
    ${Total_Count}=  evaluate  ${Web_Count}+${File_Count}+${Executable_Count}+${Email_Count}+${Translation_Count}+${Payload_Storage_Count}
    set global variable  ${Total_Count}
    #log to console  ${Temp_Count}
    ${Verification_Count}=  catenate  Total Step Count: ${Total_Count}
    log to console  ${Verification_Count}

Current_Time_And_Date
    ${Date_And_Time_Last_RunTime_Current_Month}=    Get Current Date    result_format=%b
    ${Date_And_Time_Last_RunTime_Current_Day_Year}=  Get Current Date    result_format=%d, %Y
    ${Date_And_Time_Last_RunTime_Current_Day_Year}=  Replace String Using Regexp  ${Date_And_Time_Last_RunTime_Current_Day_Year}  ^0  ${EMPTY}
    ${Date_And_Time_Last_RunTime_Current_Time}=    Get Current Date    result_format=%I:%M
    ${Date_And_Time_Last_RunTime_Current_Time}=  Replace String Using Regexp  ${Date_And_Time_Last_RunTime_Current_Time}  ^0  ${EMPTY}
    ${Date_And_Time_Last_RunTime}=  catenate  ${Date_And_Time_Last_RunTime_Current_Month} ${Date_And_Time_Last_RunTime_Current_Day_Year}  ${Date_And_Time_Last_RunTime_Current_Time}
    set global variable  ${Date_And_Time_Last_RunTime}
    log to console  ${Date_And_Time_Last_RunTime}
    ${PM_OR_AM_Last_RunTime}=    Get Current Date    result_format=%p
    set global variable  ${PM_OR_AM_Last_RunTime}
    log to console  ${PM_OR_AM_Last_RunTime}


Tasks_Search_And_Remove
    [Arguments]  ${Task_Name}
    Tasks_SearchName_Textbox
    wait until element is visible  xpath=${Tasks_Name_Column_Icon_Overlay}
    click element  xpath=${Tasks_Name_Column_Icon_Overlay}
    wait until element is visible  xpath=${Column_Any_Search_Reset}
    click element  xpath=${Column_Any_Search_Reset}
    wait until element is not visible  xpath=${Tasks_Search_Loading}
    #wait until element is visible  xpath=${Tasks_Name_Column_SearchContainsIcon}
    wait until element is visible  xpath=${Tasks_Name_Column_Search_Textbox}
    input text  xpath=${Tasks_Name_Column_Search_Textbox}  ${Task_Name}
    ${IsElementVisible}=  run keyword and return status  wait until element is visible  xpath=${Tasks_Search_Loading}  5s
    run keyword if  ${IsElementVisible}  wait until element is not visible  xpath=${Tasks_Search_Loading}
    ${IsElementVisible}=  run keyword and return status  wait until element is visible  xpath=//app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='${Task_Name}']  10s
    run keyword if  ${IsElementVisible}  Delete_Task

Navigate_To_System_Settings_Page
    # Navigate to Admin
    wait until element is visible  xpath=${EITK_Admin_Dropdown}
    wait until element is visible  xpath=${EITK_Admin_Caret}
    click element  xpath=${EITK_Admin_Caret}
    wait until element is visible  xpath=${Admin_Dropdown_System Settings}
    click element  xpath=${Admin_Dropdown_System Settings}
    wait until element is visible   ${EITK_Settings_Page_Title}

EnterpriseITK_Settings_Task_Tab
     #Task Tab
     wait until element is visible  ${EITK_Tasks_Tab}
     click element  ${EITK_Tasks_Tab}

Verify_EITK_Settings_Page_Task_Tab
    wait until element is visible   xpath=${EITK_Allow_PV_Access_Checkbox}
    wait until element is visible   xpath=${EITK_Allow_PV_Access_Checkbox_Label}
    wait until element is visible   xpath=${EITK_Allow_PV_Access_Help_Icon}
    wait until element is visible   xpath=${EITK_Log_Task_Header_Textbox}
    wait until element is visible  xpath=${EITK_Log_Task_Header_Textbox_Label}
    wait until element is visible  xpath=${EITK_Log_Task_Header_Help_Icon}
    wait until element is visible   xpath=${EITK_Max_Payloads_Stored_Per_Task_Textbox}
    wait until element is visible  xpath=${EITK_Max_Payloads_Stored_Per_Task_Textbox_Label}
    wait until element is visible  xpath=${EITK_Max_Payloads_Stored_Per_Task_Help_Icon}
    wait until element is visible   xpath=${EITK_Max_Task_Run_Request_Age_Textbox}
    wait until element is visible  xpath=${EITK_Max_Task_Run_Request_Age_Textbox_Label}
    wait until element is visible  xpath=${EITK_Max_Task_Run_Request_Age_Help_Icon}
    wait until element is visible   xpath=${EITK_Cleanup_Time_Textbox}
    wait until element is visible  xpath=${EITK_Cleanup_Time_Textbox_Label}
    wait until element is visible  xpath=${EITK_Cleanup_Time_Help_Icon}
    wait until element is visible   xpath=${EITK_Max_File_Age_Textbox}
    wait until element is visible  xpath=${EITK_Max_File_Age_Textbox_Label}
    wait until element is visible  xpath=${EITK_Max_File_Age_Help_Icon}
    wait until element is visible   xpath=${EITK_Task_History_Age_Textbox}
    wait until element is visible  xpath=${EITK_Task_History_Age_Textbox_Label}
    wait until element is visible  xpath=${EITK_Task_History_Age_Help_Icon}
    wait until element is visible   xpath=${EITK_Schedule_OnAny_Site_Checkbox}
    wait until element is visible   xpath=${EITK_Schedule_OnAny_Site_Checkbox_Label}
    wait until element is visible  xpath=${EITK_Schedule_OnAny_Site_Help_Icon}
    wait until element is visible   xpath=${EITK_Settings_Save_Button}
    wait until element is visible   xpath=${EITK_Settings_Cancel_Button}

EITK3_Change_Display_View
    FOR    ${i}    IN RANGE    2
        Click Element    xpath=//*[@id='navbar']/div/div/div[@role='button' and @aria-label="menu"]
        wait until element is visible    xpath=//*[@class="dx-treeview-node-container" and @role='group']
        click element    xpath=//*[@data-item-id="13" and @role="treeitem" and @aria-label="admin"]
        wait until element is visible    xpath=//*[@data-item-id="13" and @role="treeitem" and @aria-label="admin" and @aria-expanded="true"]
        wait until element is visible    xpath=//*[@data-item-id="17" and @role="treeitem"]
        click element    xpath=//*[@data-item-id="17" and @role="treeitem"]
        Verify_OSINavbar
    END

Verify_Column_Search_Type_Text
    # This keyword can be used to verify all the available options of the filtering search for various pages and columns
    [Arguments]  ${Page_Title}  ${Column_Title}  ${Search_Type}  ${Search_Text}  ${Expected_OutCome}  ${Expected_OutCome_TF}  ${Column_Index}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    clear element text  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is visible  xpath=${Column_Any_Search_${Search_Type}}
    click element  xpath=${Column_Any_Search_${Search_Type}}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search${Search_Type}Icon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    input text  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}  ${Search_Text}
    ${IsElementVisible}=  run keyword and return status  wait until element is visible  xpath=${Tasks_Search_Loading}  5s
    run keyword if  ${IsElementVisible}  wait until element is not visible  xpath=${Tasks_Search_Loading}
    # We have included a sleep of 3s here due to us not able to verify the search is over because the value in row 1 is unknown to us.
    sleep  3s
    Filtering_Returns_Value  ${Expected_OutCome}  ${Expected_OutCome_TF}  ${Column_Index}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    clear element text  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    # This keyword is used within "Verify_Column_Search_Type_Text" keyword.
########################################################################################################################