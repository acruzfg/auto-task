*** Variables ***

########################################################################################################################
########################################################################################################################

# General Variables Part 1 Variables:

########################################################################################################################

# General Variables Part 2 Variables:

# OSINavbar Variables:
${OSINavbar_EITKLogo}  //*[@id="wp-logo"]//a[@href='/eitk/page/auth/EnterpriseITK.html']//img[@src='/eitk/page/auth/images/enterprise-itk-white.svg']
${OSINavbar_Tasks}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Tasks"]
${OSINavbar_Tasks_Caret}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Tasks"]/i
${OSINavbar_Tasks_Tasks}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Tasks']
${OSINavbar_Tasks_TaskRunRequest}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Task Run Requests']
${OSINavbar_Tasks_TaskRunHistory}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Task Run History']
${OSINavbar_NamingService}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Naming Service"]
${OSINavbar_NamingService_Caret}  //*[@id="navbar"]//*[@role="menuitem"]//*[text()="Naming Service"]/i
${OSINavbar_NamingService_IDMaps}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='ID Maps']
${OSINavber_NamingService_Sources}  //*[@class="dx-submenu"]//*[@role="menuitem"]//*[text()='Sources']

########################################################################################################################

# Keeping Valid till I figure out the exact reference:
${Task_Monarch_Success}    //td[text()='Auto_Test_DD']/..//span[contains(text(),'Success')]
${Last_Run_Time}    //td[text()='Auto_Test_DD']/..//td[4]/div

########################################################################################################################
########################################################################################################################