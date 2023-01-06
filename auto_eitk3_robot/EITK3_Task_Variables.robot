*** Variables ***


########################################################################################################################
########################################################################################################################

# Task Page Variables:
# Task Header and Functions near the Task Header:
${Tasks_Logo}  //*//mdc-icon[@id="header-icon" and text()[contains(.,'work')]]
${Header}  //*[@id="title-text"]
${Tasks_PageTitle}  //*//span[@id="title-text" and text()[contains(.,'Tasks')]]
${Tasks_TextDragColumn}  //*/div//div[text()[contains(.,'Drag a column header here to group by that column')]]
${Tasks_ColumnChooser_Icon}  //*//div[@aria-label='Column Chooser']/div//i[@class='dx-icon dx-icon-column-chooser']
${Tasks_ColumnChooser_PopupTitle}  //*//div[text()[contains(.,'Column Chooser')]]
${Tasks_ColumnChooser_PopupClose_Button}  //*//div[@class='dx-button-content']//i[@class='dx-icon dx-icon-close']
${Tasks_ColumnChooser_PopupText}  //*//div[@class='dx-empty-message' and text()[contains(.,'Drag a column here to hide it')]]
${Tasks_AddTask_Button}    //*[@title='Add Task']
# Task Page -> Name Column Variables:
${Tasks_Name_Column}  //*//td[@aria-label='Column Name']//div[text()[contains(.,'Name')]]
${Tasks_Name_Column_Search_Icon}  //*//td[@aria-label='Column Name, Filter cell']/div//div[@role='menubar']/div/ul/li/div[@role='menuitem']/div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-default']
${Tasks_Name_Column_Icon_Overlay}    (//*[@aria-label='Column Name']/../..//*[@role='menuitem']//*[@class='dx-item-content dx-menu-item-content'])[1]
${Tasks_Name_Column_Search_Textbox}    (//*[@aria-label='Column Name']/../..//*[@role='textbox'])[1]
${Tasks_Name_Column_SearchContainsIcon}  (//*//td[@aria-label='Filter cell']//div[@role='menubar']//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-contains'])[1]
${Tasks_Name_Column_SearchDoesNotContainIcon}  //*//td[@aria-label='Column Name, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-not-contains']
${Tasks_Name_Column_SearchStartsWithIcon}  //*//td[@aria-label='Column Name, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-starts-with']
${Tasks_Name_Column_SearchEndsWithIcon}  //*//td[@aria-label='Column Name, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-ends-with']
${Tasks_Name_Column_SearchEqualsIcon}  //*//td[@aria-label='Column Name, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-equals']
${Tasks_Name_Column_SearchDoesNotEqualIcon}  //*//td[@aria-label='Column Name, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-not-equals']

# Task Page -> Status Column Variables:
${Tasks_Status_Column}  //*//td[@aria-label='Column Status']//div[text()[contains(.,'Status')]]
${Tasks_Status_Column_Search_Icon}  //*//td[@aria-label='Column Status, Filter cell']/div//div[@role='menubar']/div/ul/li/div[@role='menuitem']/div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-default']
${Tasks_Status_Column_Icon_Overlay}  (//td[@aria-label='Filter cell']//div[@role='menubar']/div/ul/li/div[@role='menuitem']/div[@class='dx-item-content dx-menu-item-content'])[2]
${Tasks_Status_Column_Search_Textbox}  (//*//td[@aria-label='Filter cell']/div//*/div/div//*//input[@role='textbox'])[2]
${Tasks_Status_Column_SearchContainsIcon}  //*//td[@aria-label='Column Status, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-contains']
${Tasks_Status_Column_SearchDoesNotContainIcon}  //*//td[@aria-label='Column Status, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-not-contains']
${Tasks_Status_Column_SearchStartsWithIcon}  //*//td[@aria-label='Column Status, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-starts-with']
${Tasks_Status_Column_SearchEndsWithIcon}  //*//td[@aria-label='Column Status, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-ends-with']
${Tasks_Status_Column_SearchEqualsIcon}  //*//td[@aria-label='Column Status, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-equals']
${Tasks_Status_Column_SearchDoesNotEqualIcon}  //*//td[@aria-label='Column Status, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-not-equals']
# Task Page -> LastRunTime Column Variables:
${Tasks_LastRunTime_Column}  //*//td[@aria-label='Column Last Run Time']//div[text()[contains(.,'Last Run Time')]]
${Tasks_LastRunTime_Column_Search_Icon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li/div[@role='menuitem']/div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-default']
${Tasks_LastRunTime_Column_Icon_Overlay}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li/div[@role='menuitem']/div[@class='dx-item-content dx-menu-item-content']//span[@class='dx-menu-item-popout-container']
${Tasks_LastRunTime_Column_Search_Textbox}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//*/div/div//*//input[@role='combobox']
${Tasks_LastRunTime_Column_Calendar_Icon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div//div[contains(@class,'dx-datebox-datetime')]//div[@class='dx-dropdowneditor-input-wrapper']/div//div//div/div//div[@class='dx-dropdowneditor-icon']
${Tasks_LastRunTime_Column_SearchEqualsIcon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-equals']
${Tasks_LastRunTime_Column_SearchDoesNotEqualIcon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-not-equals']
${Tasks_LastRunTime_Column_SearchLessThanIcon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-less']
${Tasks_LastRunTime_Column_SearchGreaterThanIcon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-greater']
${Tasks_LastRunTime_Column_SearchLessThanOrEqualToIcon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-less-equal']
${Tasks_LastRunTime_Column_SearchGreaterThanOrEqualToIcon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-greater-equal']
${Tasks_LastRunTime_Column_SearchBetweenIcon}  //*//td[@aria-label='Column Last Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-between']
# Task Page -> NextScheduledRunTime Variables:
${Tasks_NextScheduledRunTime_Column}  //*//td[@aria-label='Column Next Scheduled Run Time']//div[text()[contains(.,'Next Scheduled Run Time')]]
${Tasks_NextScheduledRunTime_Column_Search_Icon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li/div[@role='menuitem']/div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-default']
${Tasks_NextScheduledRunTime_Column_Icon_Overlay}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li/div[@role='menuitem']/div[@class='dx-item-content dx-menu-item-content']//span[@class='dx-menu-item-popout-container']
${Tasks_NextScheduledRunTime_Column_Search_Textbox}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//*/div/div//*//input[@role='combobox']
${Tasks_NextScheduledRunTime_Column_Calendar_Icon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div//div[contains(@class,'dx-datebox-datetime')]//div[@class='dx-dropdowneditor-input-wrapper']/div//div//div/div//div[@class='dx-dropdowneditor-icon']
${Tasks_NextScheduledRunTime_Column_SearchEqualsIcon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-equals']
${Tasks_NextScheduledRunTime_Column_SearchDoesNotEqualIcon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-not-equals']
${Tasks_NextScheduledRunTime_Column_SearchLessThanIcon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-less']
${Tasks_NextScheduledRunTime_Column_SearchGreaterThanIcon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-greater']
${Tasks_NextScheduledRunTime_Column_SearchLessThanOrEqualToIcon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-less-equal']
${Tasks_NextScheduledRunTime_Column_SearchGreaterThanOrEqualToIcon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-greater-equal']
${Tasks_NextScheduledRunTime_Column_SearchBetweenIcon}  //*//td[@aria-label='Column Next Scheduled Run Time, Filter cell']/div//div[@role='menubar']/div/ul/li//div[@role='menuitem']//div[@class='dx-item-content dx-menu-item-content']//i[@class='dx-icon dx-icon-filter-operation-between']

########################################################################################################################

# Tasks Dropdown Variables (used to navigate back to Tasks Page):
${EITK_Tasks_Dropdown}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Tasks"]
${EITK_Tasks_Caret}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Tasks"]/i
${Tasks_Dropdown_Tasks}   //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Tasks']
${Tasks_Dropdown_TaskRunRequests}   //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Task Run Requests']
#${Tasks_Dropdown_TaskRunHistory}   //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Task Run History']

########################################################################################################################

# Results from searching for a certain Job Name Variables currently used:
${Tasks_Name_Search_First_Result}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Auto_Test_HR_02']
${Tasks_Name_Search_First_Result_01}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Auto_Test_HR']
${Tasks_Name_Search_First_Result_02}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Auto_Test_HR_02']
${Tasks_Name_Search_First_Result_03}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Auto_Test_HR_03']
${Tasks_Name_Search_First_Result_04}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Auto_Test_HR_04']
${Tasks_Name_Search_First_Result_SR}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Auto_Test_SR']
${Tasks_Name_Search_First_Result_DD}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Auto_Test_DD']
${Tasks_Name_Search_First_Result_Web_01}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Web_Steps_Test_HR']
${Tasks_Name_Search_First_Result_Web_01_Success}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//tr[@aria-rowindex='1']//*/div//span[text()[contains(.,'Success')]]
${Tasks_Name_Search_First_Result_Web_02}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Web_Steps_Test_HR_02']
${Tasks_Name_Search_First_Result_Web_02_Success}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//tr[@aria-rowindex='1']//*/div//span[text()[contains(.,'Success')]]
${Tasks_Name_Search_First_Result_Web_03}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='Web_Steps_Test_HR_03']
${Tasks_Name_Search_First_Result_Web_03_Success}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//tr[@aria-rowindex='1']//*/div//span[text()[contains(.,'Success')]]
${Tasks_Name_Search_First_Result_SuccessfulFileStep_TestCase}   //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='SuccessfulFileStep_TestCase']
${Tasks_Search_Loading}  //app-tasks/app-tasks-view/div/dx-data-grid/div/div[7]/div/div/div[text()='Loading...']
########################################################################################################################

# Variables used for deleting Tasks:
${Tasks_Delete_Button}  //mdc-icon[text()=' delete_forever ']
${Tasks_Delete_Button_Dialog_Message}  //*/div/div//div[@class="dx-popup-content dx-dialog-content"]//div[text()='Are you sure you want to delete this Task?']
${Tasks_Delete_Button_Option_Yes}  //*[@role="toolbar"]//*[@class="dx-toolbar-center"]//*[@class="dx-button-content"]//span[text()='Yes']
#${TaskDetails_Saved_Task_Message}  /html/body/div[3]/div/div
#${Tasks_Delete_Task_Message}  /html/body/div[3]/div/div

${Message}  //*[@class='dx-toast-message' and @role='alert']
${Message_Snackbar}    //div[contains(@class, 'mdl-js-snackbar mdl-snackbar mdl-snackbar--active')]
${Message_Snackbar_Text}    //div[contains(@class, 'mdl-snackbar__text')]
# Really difficult to catch when it disappears and isn't static ^^
${Tasks_Grid_After_Search_And_Delete}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*//span[text()="No Data"]

# Variable used to verify the search for this particular task either (aka whether this task exists or doesn't exist):
${Tasks_NameSearch_Result_EmailStep}  //app-tasks/app-tasks-view/div/dx-data-grid/div//*/div/div/div/div/table/tbody//*//td[text()='EmailStep_TestCase_HR']

################################################################################################################################################################################################################################################

# Admin Dropdown Variables
${EITK_Admin_Dropdown}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Admin"]
${EITK_Admin_Caret}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Admin"]/i
${Admin_Dropdown_System Settings}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='System Settings']

########################################################################################################################
# EITK Settings Page Tasks Tab Variables
${EITK_Settings_Page_Title}     //h3[text()='EnterpriseITK Settings']
${EITK_Tasks_Tab}    //h3[text()='Tasks']
${EITK_Allow_PV_Access_Checkbox_Unchecked}  //*[@id='taskstaskAllowPvAccessHelp']/..//label[@class='input-wrapper mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded']
${EITK_Settings_Save_Button}   //*[@id="saveBtn"]
${EITK_Settings_Cancel_Button}  //*[@id="cancelBtn"]
${EITK_Allow_PV_Access_Checkbox_Checked}  //*[@id='taskstaskAllowPvAccessHelp']/..//label[@class='input-wrapper mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-checked is-upgraded']
${EITK_Allow_PV_Access_Checkbox}    //*[@id='taskstaskAllowPvAccessHelp']/..//label[contains(@class,'input-wrapper mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events')]
${EITK_Allow_PV_Access_Checkbox_Label}    //span[text()='Allow PV Access']
${EITK_Allow_PV_Access_Help_Icon}     //*[@id="taskstaskAllowPvAccessHelp"]
#${EITK_Allow_PV_Access_Help_Icon_Information}      //div[contains(text(),"Allows Password Vault access in string fields using the ${pvuser:'')"]
${EITK_Log_Task_Header_Textbox}    //label[text()='Log Task Header']/../..//input[@id="taskstaskLogHeader"]
${EITK_Log_Task_Header_Help_Icon}     //*[@id="taskstaskLogHeaderHelp"]
${EITK_Log_Task_Header_Help_Icon_Information}   //div[contains(text(),'Will log the header value with every Task execution log if present')]
${EITK_Log_Task_Header_Textbox_Label}   //label[contains(text(),"Log Task Header")]
${EITK_Max_Payloads_Stored_Per_Task_Textbox}    //label[text()='Max Payloads Stored per Task']/../.. //input[@id="tasksgridFsMaxPayloadAmount"]
${EITK_Max_Payloads_Stored_Per_Task_Help_Icon}    //*[@id="tasksgridFsMaxPayloadAmountHelp"]
${EITK_Max_Payloads_Stored_Per_Task_Help_Icon_Information}  //div[contains(text(),'The maximum number of task payload files that can be stored at once for each Task')]
${EITK_Max_Payloads_Stored_Per_Task_Textbox_Label}  //label[contains(text(),"Max Payloads Stored per Task")]
${EITK_Max_Task_Run_Request_Age_Textbox}    //label[text()='Max Task Run Request Age']/../..//input[@id="taskstaskRunRequestsCleanUpAge"]
${EITK_Max_Task_Run_Request_Age_Help_Icon}    //*[@id="taskstaskRunRequestsCleanUpAgeHelp"]
${EITK_Max_Task_Run_Request_Age_Help_Icon_Information}  //div[contains(text(),"The maximum age (in days) of a task run request before it is cleaned up. If this value is updated, the EnterpriseITK prcoess must be restarted to make this change effective.")]
${EITK_Max_Task_Run_Request_Age_Textbox_Label}  //label[contains(text(),"Max Task Run Request Age")]
${EITK_Cleanup_Time_Textbox}    //label[text()='Cleanup Time']/../..//input[@id='taskstaskDailyAuditCleanupTime']
${EITK_Cleanup_Time_Help_Icon}    //*[@id="taskstaskDailyAuditCleanupTimeHelp"]
${EITK_Cleanup_Time_Help_Icon_Information}  //div[contains(text(),"The daily time (in HH:mm:ss. Uses military time, 0-23 hours, 0-59 minutes, 0-59 seconds) to clean the audit folders")]
${EITK_Cleanup_Time_Textbox_Label}  //label[contains(text(),"Cleanup Time")]
${EITK_Max_File_Age_Textbox}    //label[text()='Max File Age']/../..//input[@id='taskstaskCleanUpAge']
${EITK_Max_File_Age_Help_Icon}    //*[@id="taskstaskCleanUpAgeHelp"]
${EITK_Max_File_Age_Help_Icon_Information}  //div[contains(text(),"The maximum age (in days) of a file before it is cleaned up. If this value is updated, the EnterpriseITK prcoess must be restarted to make this change effective")]
${EITK_Max_File_Age_Textbox_Label}  //label[contains(text(),"Max File Age")]
${EITK_Task_History_Age_Textbox}    //label[text()='Max Task History Age']/../..//input[@id='taskstaskHistoryCleanUpAge']
${EITK_Task_History_Age_Help_Icon}    //*[@id="taskstaskHistoryCleanUpAgeHelp"]
${EITK_Task_History_Age_Help_Icon_Information}  //div[contains(text(),"The maximum age (in days) of a task history before it is cleaned up. If this value is updated, the EnterpriseITK prcoess must be restarted to make this change effective")]
${EITK_Task_History_Age_Textbox_Label}  //label[contains(text(),"Max Task History Age")]
${EITK_Schedule_OnAny_Site_Checkbox}    //*[@id='taskstaskScheduleOnAnySiteHelp']/..//label[contains(@class,'input-wrapper mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded')]
${EITK_Schedule_OnAny_Site_Checkbox_Label}    //span[text()='Schedule on any site']
${EITK_Schedule_OnAny_Site_Help_Icon}    //*[@id="taskstaskScheduleOnAnySiteHelp"]
${EITK_Schedule_OnAny_Site_Help_Icon_Information}   //div[contains(text(),"The Task scheduler will schedule Tasks to run on any site instead of just the online site")]
${EITK_Settings_Page_Message}   //*[@id="wp-snackbar"]/div