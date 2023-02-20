*** Settings ***
Variables  Robot_Pass_Fail_Report_To_Jama.py
Library  Robot_Pass_Fail_Report_To_Jama.py
Library    SeleniumLibrary
*** Keywords ***
##################################################################################################################################################################################
##################################################################################################################################################################################
# Keywords between multiple Robot Test Cases:
##################################################################################################################################################################################
# Browser Keywords:
Open_Browser_And_Login_As_Admin
    [Arguments]  ${Browser}
    # Open Browser Chrome and go to the specificied URL depending on the system
    open browser  ${URL}  ${Browser}
    maximize browser window
    # Execute javascript  document.body.style.zoom="70%"
    # Set Selenium Wait Time and Speed as per the browser that is being used
    set selenium timeout  60s
    Run keyword if  "${Browser}" == "ie"  set selenium speed  0.08s
    Run keyword if  "${Browser}" == "chrome"  set selenium speed  0.08s
    # Check to see if we are using the IE browser. If we are using the IE browser then check to see if there is a website certificate issue. If there is this will
    # get us past the warning and allow for us to continue on to our preferred website:
    Run keyword if  "${Browser}" == "ie"  Verify_IE_CertIssue_Exists
    # Sometimes when the website certificate has expired on a test system, the user may be prompted for certificate authentication. The below 3 lines is to cater to this.
    ${Cert_Authentication}=  run keyword and return status  wait until element is visible  xpath=//*[@id="details-button"]  5s
    Run keyword if  ${Cert_Authentication}  click element  xpath=//*[@id="details-button"]
    Run keyword if  ${Cert_Authentication}  click element  xpath=//*[@id="proceed-link"]
    # Log in as Admin
    wait until element is visible  xpath=${OSI_Logo}
    wait until element is visible  xpath=${OSI_Username}
    input text  id:username  admin
    wait until element is visible  xpath=${OSI_Password}
    input text  id:password  admin21`
    wait until element is visible  xpath=${OSI_Login_Button}
    click element  xpath=${OSI_Login_Button}

Verify_IE_CertIssue_Exists
    ${IsElementVisible}=  run keyword and return status  wait until element is visible  xpath=${IE_CertIssue_SiteNotSecure_Text}
    Run keyword if  ${IsElementVisible}  IE_CertIssue_ContinueToWebsite

IE_CertIssue_ContinueToWebsite
    wait until element is visible  xpath=${IE_CertIssue_Closethistab_Option}
    wait until element is visible  xpath=${IE_CertIssue_Moreinformation_Option}
    click element  xpath=${IE_CertIssue_Moreinformation_Option}
    wait until element is visible  xpath=${IE_CertIssue_Moreinformation_Goontothewebpage_Option}
    click element  xpath=${IE_CertIssue_Moreinformation_Goontothewebpage_Option}

Logout_User_And_Close_Browser
    # Logout User
    wait until element is visible  xpath=${User_Toolbar_User_Dropdown}
    wait until element is visible  xpath=${User_Toolbar_User_Caret}
    click element  xpath=${User_Toolbar_User_Caret}
    wait until element is visible  xpath=${User_Dropdown_Logout}
    element text should be  xpath=${User_Dropdown_Logout}  Logout
    click element  xpath=${User_Dropdown_Logout}
    # Close Browser
    close browser
##################################################################################################################################################################################
# General Search Techniques:
Check_Column_Search_Options_Text
    [Arguments]  ${Page_Title}  ${Column_Title}
    # Verify Search Options:
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Contains Search
    wait until element is visible  xpath=${Column_Any_Search_Contains}  2s
    click element  xpath=${Column_Any_Search_Contains}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchContainsIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Does Not Contain Search
    wait until element is visible  xpath=${Column_Any_Search_DoesNotContain}
    click element  xpath=${Column_Any_Search_DoesNotContain}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchContainsIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchDoesNotContainIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Starts With Search
    wait until element is visible  xpath=${Column_Any_Search_StartsWith}
    click element  xpath=${Column_Any_Search_StartsWith}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchDoesNotContainIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchStartsWithIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Ends With Search
    wait until element is visible  xpath=${Column_Any_Search_EndsWith}
    click element  xpath=${Column_Any_Search_EndsWith}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchStartsWithIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchEndsWithIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Equals Search
    wait until element is visible  xpath=${Column_Any_Search_Equals}
    click element  xpath=${Column_Any_Search_Equals}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchEndsWithIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchEqualsIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Does Not Equal Search
    wait until element is visible  xpath=${Column_Any_Search_DoesNotEqual}
    click element  xpath=${Column_Any_Search_DoesNotEqual}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchEqualsIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchDoesNotEqualIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Default/ Reset Search
    wait until element is visible  xpath=${Column_Any_Search_Reset}
    click element  xpath=${Column_Any_Search_Reset}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchDoesNotEqualIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}

Check_Column_Search_Options_Numerical
    [Arguments]  ${Page_Title}  ${Column_Title}
    # Verify Search Options:
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    sleep  2s
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Equal Search
    wait until element is visible  xpath=${Column_Any_Search_Equals}
    click element  xpath=${Column_Any_Search_Equals}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchEqualsIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Does Not Equal Search
    wait until element is visible  xpath=${Column_Any_Search_DoesNotEqual}
    click element  xpath=${Column_Any_Search_DoesNotEqual}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchEqualsIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchDoesNotEqualIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Less Than Search
    wait until element is visible  xpath=${Column_Any_Search_LessThan}
    click element  xpath=${Column_Any_Search_LessThan}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchDoesNotEqualIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchLessThanIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Greater Than Search
    wait until element is visible  xpath=${Column_Any_Search_GreaterThan}
    click element  xpath=${Column_Any_Search_GreaterThan}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchLessThanIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchGreaterThanIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Less Than Or Equal To Search
    wait until element is visible  xpath=${Column_Any_Search_LessThanOrEqualTo}
    click element  xpath=${Column_Any_Search_LessThanOrEqualTo}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchGreaterThanIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchLessThanOrEqualToIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Greater Than Or Equal To Search
    wait until element is visible  xpath=${Column_Any_Search_GreaterThanOrEqualTo}
    click element  xpath=${Column_Any_Search_GreaterThanOrEqualTo}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchLessThanOrEqualToIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchGreaterThanOrEqualToIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    # Verify Between Search
    wait until element is visible  xpath=${Column_Any_Search_Between}
    click element  xpath=${Column_Any_Search_Between}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchBetweenIcon}
    wait until element is visible  xpath=${Column_Any_Search_Between_Start_Text}
    wait until element is visible  xpath=${Column_Any_Search_Between_Start_Textbox}
    wait until element is visible  xpath=${Column_Any_Search_Between_End_Text}
    wait until element is visible  xpath=${Column_Any_Search_Between_End_Textbox}
    input text  xpath=${Column_Any_Search_Between_Start_Textbox}  0
    input text  xpath=${Column_Any_Search_Between_End_Textbox}  3
    # Clicking TAB key here to move away from the Search type "Between" This has been specifically used to make it work with IE browser.
    Press Keys  xpath=${Column_Any_Search_Between_End_Textbox}  \ue004
    wait until element is not visible  xpath=${Column_Any_Search_Between_End_Textbox}  timeout=2
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchGreaterThanOrEqualToIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchBetweenIcon}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Icon_Overlay}
    # Verify Default / Reset Search
    wait until element is visible  xpath=${Column_Any_Search_Reset}
    click element  xpath=${Column_Any_Search_Reset}
    wait until element is not visible  xpath=${${Page_Title}_${Column_Title}_Column_SearchBetweenIcon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Icon}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search_Textbox}

Check_Column_Search_Options_Boolean
    [Arguments]  ${Page_Title}  ${Column_Title}
    sleep  2s
    # Verify 'true' Option:
    Boolean_Options_And_Selection  ${Page_Title}  ${Column_Title}  true
    # Verify 'false' Option:
    Boolean_Options_And_Selection  ${Page_Title}  ${Column_Title}  false
    # Verify '(all)' Option:
    Boolean_Options_And_Selection  ${Page_Title}  ${Column_Title}  (all)

Boolean_Options_And_Selection
    [arguments]  ${Page_Title}  ${Column_Title}  ${Desired_Option}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Dropdowneditor}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_Dropdowneditor}
    # wait until element is not visible  xpath=${Tasks_Search_Loading}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_(all)_Option}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_true_Option}
    wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_false_Option}
    click element  xpath=${${Page_Title}_${Column_Title}_Column_${Desired_Option}_Option}
    ${DoubleCheckSelectedSearch}=  Run Keyword And Return Status  Elemenet Should Not Be Visible  ${${Page_Title}_${Column_Title}_Column_${Desired_Option}_Option_Selected}
    Run Keyword If  ${DoubleCheckSelectedSearch}  Boolean_Options_And_Selection  ${Page_Title}  ${Column_Title}  ${Desired_Option}

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
    #wait until element is visible  xpath=${${Page_Title}_${Column_Title}_Column_Search${Search_Type}Icon}
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
    
Filtering_Returns_Value
    # Filtering_Returns_Value verifies that the value in row 1 for the index selected either matches or mismatches the ${Expected_Outcome} of that selected area. Then this function will verify if that is the expected outcome of that match with ${Expected_OutCome_TF}. The TF part stands for True or False.
    [Arguments]  ${Expected_OutCome}  ${Expected_OutCome_TF}  ${Column_Index}
    ${sorted_task}    Get Text    xpath=//*[@class="dx-datagrid-content"]/table/tbody/tr[@aria-rowindex='1']/td[@aria-colindex='${Column_Index}']
    ${Result}=  run keyword and return status  Should Be Equal As Strings    ${sorted_task}    ${Expected_OutCome}
    Should Be Equal As Strings  ${Result}  ${Expected_OutCome_TF}
##################################################################################################################################################################################
# Generally Used (this makes sure that multiple screenshots aren't produced because we use keyword if commands):
Test Teardown
    Run Keyword If Test Failed    Selenium2Library.Capture Page Screenshot
########################################################################################################################
# Jama Report Keyword:
Jama_Report
    [Arguments]  ${TestCase_Name}  ${Status}  ${JamaPlan_ID}  ${JamaTestCase_ID}
    # This function is used to report (a) to the console output if the test case was successful (pass or fail),
    # (b) report to jama the results of test case that just was conducted (pass or fail), and (c) display to the console output if this jama function succeed or not (pass or fail).
    log to console  ${\n}
    log to console  ${TestCase_Name}  Status:
    log to console  ${Status}
    ${Jamma_Report_Status}  set variable  FAIL
    ReportingToJama  ${Status}  ${JamaPlan_ID}  ${JamaTestCase_ID}
    ${Jamma_Report_Status}  set variable  PASS
    log to console  Jama_Report Status:
    log to console  ${Jamma_Report_Status}
    log to console  The Overall Status:
    log to console  ${\n}
##################################################################################################################################################################################
# Keyword related to User group and Console group
Navigate_To_WP_Group
    [Arguments]  ${User/Console}
    wait until element is visible  xpath=${OSINavbar_Admin}
    wait until element is visible  xpath=${OSINavbar_AdminCaret}
    click element  xpath=${OSINavbar_AdminCaret}
    wait until element is visible  xpath=${${User/Console}_Groups_Option}
    click element  xpath=${${User/Console}_Groups_Option}
    wait until element is visible  xpath=${${User/Console}_Group_Page_Title}
    wait until element is visible  xpath=${Admin_${User/Console}_Group}

#Keyword to naviagte to Audits
Navigate_To_Audits_Page
    wait until element is visible  xpath=${OSINavbar_Admin}
    wait until element is visible  xpath=${OSINavbar_AdminCaret}
    click element  xpath=${OSINavbar_AdminCaret}
    Wait Until Element Is Visible    xpath=${Audits_Option}
    Click Element    xpath=//*[@href='/platform/page/admin/audits.html']
    
