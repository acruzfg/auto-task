*** Variables ***

########################################################################################################################
########################################################################################################################

# Variables used to get around invalid website certificates for the IE browser:
${IE_CertIssue_SiteNotSecure_Text}  //*//div[text()='This site is not secure']
${IE_CertIssue_Closethistab_Option}  //*//id[text()='Close this tab']
${IE_CertIssue_Moreinformation_Option}  //*//a[text()='More information']
${IE_CertIssue_Moreinformation_Goontothewebpage_Option}  //*[text()='Go on to the webpage (not recommended)']

########################################################################################################################

# General Variables Part 1 Variables:

# OSI Login Variables:
${OSI_Logo}  //*[@id="osilogo"]
${OSI_Username}  //*[@id="username"]
${OSI_Password}  //*[@id="password"]
${OSI_Login_Button}  //*[@id="submit"]

# Application Page Variables:
${PageTitle_OSIWebApplications}  //*//h1[text()[contains(.,'OSI Web Applications')]]
${Image_EITK}  //*[@href='/eitk/page/auth/EnterpriseITK.html']//*//img[@src='/eitk/page/auth/images/enterprise-itk.png']
${ImageText_EITK}  //*[@id="appsContainer"]//a[@href='/eitk/page/auth/EnterpriseITK.html']//div[text()[contains(.,'EnterpriseITK')]]
${Image_MC}  //*[@id="appsContainer"]//a[@href='/maintenance/page/auth/MaintenanceCenter.html']//*//img[@src='/maintenance/page/auth/images/maintenance-center-icon.svg']
${ImageText_MC}  //*[@id="appsContainer"]//a[@href='/maintenance/page/auth/MaintenanceCenter.html']//div[text()[contains(.,'Maintenance Center')]]
${Image_SM}  //*[@id="appsContainer"]//a[@href='/platform/page/auth/sitemonitor.html']//*//img[@src='/platform/page/auth/images/apps-system-monitor-sm.png']
${ImageText_SM}  //*[@id="appsContainer"]//a[@href='/platform/page/auth/sitemonitor.html']//div[text()[contains(.,'System Monitor')]]
${Image_MAP}    //*[@id="appsContainer"]//a[@href='/map/page/auth/MonarchAdminPortal.html']//*//img[@src='/map/page/auth/images/map-icon.svg']
${ImageText_MAP}    //*[@id="appsContainer"]//a[@href='/map/page/auth/MonarchAdminPortal.html']//div[text()[contains(.,'Monarch Admin Portal')]]
${Image_SM}  //*[@href='/eitk/page/auth/sitemonitor.html']//*//img[@src='/platform/page/auth/images/apps-system-monitor-sm.png']

# Bare-bones Logout Variables:
${User_Toolbar_User_Dropdown}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="admin"]
${User_Toolbar_User_Caret}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="admin"]/i
${User_Dropdown_Logout}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Logout']

# Variable to use site monitor
${Restart_Process_Button}                       //i[contains(text(),'refresh')]
${Confirm_Button}                               //button[contains(text(),'Confirm')]
${Cancel_Button}                                //button[contains(text(),'Cancel')]
${Message_Snackbar}    //div[contains(@class, 'mdl-js-snackbar mdl-snackbar mdl-snackbar--active')]
${Message_Snackbar_Text}    //div[contains(@class, 'mdl-snackbar__text')]

########################################################################################################################

# Column Dropdown Text Variables: (Re-useable for all different types of Column Search Values)
# Re-usable Text Search Column Options:
${Column_Any_Search_Contains}  //*/ul//*/div/div//span[text()[contains(.,'Contains')]]
${Column_Any_Search_DoesNotContain}  //*/ul//*/div/div//span[text()[contains(.,'Does not contain')]]
${Column_Any_Search_StartsWith}  //*/ul//*/div/div//span[text()[contains(.,'Starts with')]]
${Column_Any_Search_EndsWith}  //*/ul//*/div/div//span[text()[contains(.,'Ends with')]]
${Column_Any_Search_Equals}  //*/ul//*/div/div//span[text()[contains(.,'Equals')]]
${Column_Any_Search_DoesNotEqual}  //*/ul//*/div/div//span[text()[contains(.,'Does not equal')]]
${Column_Any_Search_Reset}  //*/ul//*/div/div//span[text()[contains(.,'Reset')]]
# Re-usable Number Search Column Options:
${Column_Any_Search_LessThan}  //*/ul//*/div/div//span[text()[contains(.,'Less than')]]
${Column_Any_Search_GreaterThan}  //*/ul//*/div/div//span[text()[contains(.,'Greater than')]]
${Column_Any_Search_LessThanOrEqualTo}  //*/ul//*/div/div//span[text()[contains(.,'Less than or equal to')]]
${Column_Any_Search_GreaterThanOrEqualTo}  //*/ul//*/div/div//span[text()[contains(.,'Greater than or equal to')]]
${Column_Any_Search_Between}  //*/ul//*/div/div//span[text()[contains(.,'Between')]]
# Re-usable Between Start and Between End Search Column Options:
${Column_Any_Search_Between_Start_Textbox}  /html/body/div[3]/div//div[@class='dx-editor-container dx-datagrid-filter-range-start']/div/div//div[@class='dx-texteditor-input-container']/input
${Column_Any_Search_Between_Start_Text}  /html/body/div[3]/div//div[@class='dx-editor-container dx-datagrid-filter-range-start']/div/div/div//div[@class='dx-texteditor-input-container']//div[@data-dx_placeholder='Start']
${Column_Any_Search_Between_End_Textbox}  /html/body/div[3]/div//div[@class='dx-editor-container dx-datagrid-filter-range-end']/div/div//div[@class='dx-texteditor-input-container']/input
${Column_Any_Search_Between_End_Text}  /html/body/div[3]/div//div[@class='dx-editor-container dx-datagrid-filter-range-end']/div/div//div[@class='dx-texteditor-input-container']//div[@data-dx_placeholder='End']

########################################################################################################################

# OSINavbar Variables:

${OSINavbar_Admin}  //*[@id="navbar"]//*[@data-tag="adminMenu"]/*[@role="menuitem"]/*[text()="Admin"]
${OSINavbar_AdminCaret}  //*[@id="navbar"]//*[@data-tag="adminMenu"]/*[@role="menuitem"]/*[text()="Admin"]/i
${OSINavbar_AdminDropdown_SystemSettings}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='System Settings']
${OSINavbar_Button_Dashboard}  //*[@id="navbar-dashboard-dropdown"]//i[text()[contains(.,'dashboard')]]
${OSINavbar_DashboardDropdown_ManageDashboards}  //*[@id="menuOptManageDashboards"]
${OSINavbar_Button_Notifications}  //*[@id='navbarNotificationsIcon']//i[text()[contains(.,'notifications')]]
${OSINavbar_NotificationsDropdown_ViewNotifications}  //*[@id='viewNotificationsItem']//*[text()='View Notifications']
${OSINavbar_NotificationsDropdown_ManageTopics}  //*[@role="menuitem"]//*[text()="Manage Topics"]
${OSINavbar_Button_Apps}  //*[@id="navbar"]//*[@data-tag="appsIcon"]//*[text()="apps"]
${OSINavbar_adminL}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="admin"]
${OSINavbar_adminCaretL}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="admin"]/i
${OSINavbar_adminDropdown_Logout}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Logout']
${OSINavbar_adminDropdown_ChangePassword}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Change password']
${OSINavbar_adminDropdown_ChangeLocale}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Change locale']
${OSINavbar_adminDropdown_ChangeLandingPage}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Change landing page']
${OSINavbar_adminDropdown_SwitchToMobileView}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Switch to mobile view']
${OSINavbar_Button_Apps_ShowApps}  //*[@id="apps_popup"]//span[text()='Apps Page']

########################################################################################################################

# Veriable for Setting permssion for Tasks IDMap and Source
${Audits_Option}    //a[contains(text(),'Audits')]
${User_Groups_Option}   //a[text()='User Groups']
${Console_Groups_Option}   //a[text()='Console Groups']
${User_Group_Page_Title}   //h3[text()='User Groups']
${Console_Group_Page_Title}   //h3[text()='Console Groups']
${Admin_User_Group}    //div[text()='Admin']
${Admin_Console_Group}    //div[text()='AdminConsole']
${Admin_User_Group_Edit_Icon}  //div[text()='Admin']/../..//i[text()='edit']
${Admin_Console_Group_Edit_Icon}  //div[text()='AdminConsole']/../..//i[text()='edit']
${Edit_Group_Popup_Title}    //h4[text()='Edit Group']
${Edit_Group_Popup_Main_Tab}   //a[text()='Main']
${Edit_Group_Popup_Permissions_Tab}    //a[text()='Permissions']
${Edit_Group_Popup_App_Permissions_Tab}    //a[text()='App Permissions']
${Edit_Group_Popup_Close_Button}   //h4[text()='Edit Group']/..//button[text()='Close']
${Edit_Group_Popup_Save_Button}   //h4[text()='Edit Group']/..//button[text()='Save']
${Edit_Group_Popup_EnterpriseITK_Tab}    //h4[text()='Edit Group']/..//a[text()='EnterpriseITK']
${EITK_Edit_Group_Popup_EnterpriseITK_Tasks_Toggle_Name}     //div[text()='Tasks']
${EITK_Edit_Group_Popup_EnterpriseITK_Source_Toggle_Name}     //div[text()='Sources']
${EITK_Edit_Group_Popup_EnterpriseITK_IDMap_Toggle_Name}     //div[text()='ID Maps']
${EITK_Edit_Group_Popup_EnterpriseITK_Tasks_Toggle}    //div[text()='Tasks']/..//span[@class='mdl-switch__ripple-container mdl-js-ripple-effect mdl-ripple--center']
${EITK_Edit_Group_Popup_EnterpriseITK_Source_Toggle}    //div[text()='Sources']/..//span[@class='mdl-switch__ripple-container mdl-js-ripple-effect mdl-ripple--center']
${EITK_Edit_Group_Popup_EnterpriseITK_IDMap_Toggle}     //div[text()='ID Maps']/..//span[@class='mdl-switch__ripple-container mdl-js-ripple-effect mdl-ripple--center']
${EITK_Edit_Group_Popup_EnterpriseITK_Tasks_Toggle_Set_To_False}     //div[@id='EnterpriseITK-tasks']//label[@class='mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded']
${EITK_Edit_Group_Popup_EnterpriseITK_Source_Toggle_Set_To_False}   //div[@id='EnterpriseITK-sources']//label[@class='mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded']
${EITK_Edit_Group_Popup_EnterpriseITK_IDMap_Toggle_Set_To_False}        //div[@id='EnterpriseITK-id_maps']//label[@class='mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded']
${EITK_Edit_Group_Popup_EnterpriseITK_Tasks_Toggle_Set_To_True}     //div[@id='EnterpriseITK-tasks']//label[@class='mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded is-checked']
${EITK_Edit_Group_Popup_EnterpriseITK_Source_Toggle_Set_To_True}    //div[@id='EnterpriseITK-sources']//label[@class='mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded is-checked']
${EITK_Edit_Group_Popup_EnterpriseITK_IDMap_Toggle_Set_To_True}     //div[@id='EnterpriseITK-id_maps']//label[contains(@class,'mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded is-checked')]
${Edit_Group_Popup_Message}  //div[@class='mdl-snackbar__text']

########################################################################################################################
# Variables declared for Maintenance Center WP permissions declaration
${Edit_Group_Popup_MaintenanceCenter_Tab}    //h4[text()='Edit Group']/..//a[text()='Maintenance Center']
${MCTab_Edit_Group_Popup_MC_JobAccess_Label}  //label[text()='Job Access']
${MCTab_Edit_Group_Popup_MC_JobAccess_Caret}  //*[@id="input-Maintenance Center-jobaccesspermission_container"]//*//i[text()='arrow_drop_down']
${MCTab_Edit_Group_Popup_MC_JobAccess_View}  //*[@id="input-Maintenance Center-jobaccesspermission_container"]//*//li[text()='View']
${MCTab_Edit_Group_Popup_MC_JobAccess_View/Edit}  //*[@id="input-Maintenance Center-jobaccesspermission_container"]//*//li[text()='View/Edit']
${MCTab_Edit_Group_Popup_MC_JobAccess_View/Edit/Deploy}  //*[@id="input-Maintenance Center-jobaccesspermission_container"]//*//li[text()='View/Edit/Deploy']
${MCTab_Edit_Group_Popup_MC_AllowEditModifications_Label}  //div[text()='Can edit modifications']
${MCTab_Edit_Group_Popup_MC_AllowEditModifications_Toggle}  //div[text()='Can edit modifications']/..//span[@class='mdl-switch__ripple-container mdl-js-ripple-effect mdl-ripple--center']
${MCTab_Edit_Group_Popup_MC_AllowEditModifications_Toggle_True}  //*[@id="Maintenance Center-editmodspermission"]//label[@class='mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded is-checked']
${MCTab_Edit_Group_Popup_MC_AllowEditModifications_Toggle_False}  //*[@id="Maintenance Center-editmodspermission"]//label[@class='mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded']
${MCTab_Edit_Group_Popup_MC_DomainGroups}  //div[text()='Domain Groups']

######################################################## #########################################################################################################################################################
# Variables for downloading audits file in the Audits 
${Download_Button}                //button[@id='download-btn']
${Download_All_Option}            //li[@id='download-all-btn']
${Download_Filtered_Option}       //li[@id='download-filtered-btn']