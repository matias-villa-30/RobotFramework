*** Settings ***
Library           FakerLibrary      locale=fi_FI
Library           OperatingSystem
Library           Dialogs
Library           Collections
Library           String
Documentation     Exercise for testing keywords and libraries 

*** Variables ***
${number_names}        5
${FILE_PATH}    ${CURDIR}/file.txt


*** Keywords ***
Get Random Names
   [Arguments]    ${num_names}
   ${LIST}=    Create List
   FOR    ${i}    IN RANGE    ${num_names}
        ${name}=    Name
        Append To List  ${LIST}   ${name}
   END
   RETURN   ${LIST}

Remove Existing Address File
   [Arguments]          ${file_name}
   ${file_exists} =    Run Keyword And Return Status    File Should Exist    ${file_name} 
   IF  ${file_exists}
      ${name_del}=  Set Variable  ${LIST[0]} 
      Log To Console    ${name_del}
      Remove From List    ${LIST}  0  
   ELSE 
      Pass Execution    File does not exist  
   END 

*** Test Cases ***
Test 1
   Log To Console       Generating random names from Faker Library                
   ${LIST}=        Get Random Names                 ${number_names}
   Remove File     ${FILE_PATH} 

Test 2
   ${LIST}=       Get Random Names     ${number_names}   
   ${selected}=   Get Selection From User    Choose a name    @{LIST}
   ${address}=    Address

   Log To Console     Found selected: ${selected}
   Append To File     ${FILE_PATH}    ${selected}\n
   Append To File     ${FILE_PATH}    ${address}\n

Test 3
    ${content}=    Get File    ${FILE_PATH}
    @{lines}=      Split To Lines    ${content}
    ${count}=      Get Length    ${lines}
    
    Log To Console    File has ${count} lines
    Should Be Equal As Integers   ${count}  3
