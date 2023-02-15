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


*** Test Cases ***
Change System Settings
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

