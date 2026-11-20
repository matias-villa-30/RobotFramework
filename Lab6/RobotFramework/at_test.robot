*** Settings ***

Library        OperatingSystem
Library        AT_Lib.py      ${SERIAL_PORT}
Documentation  Lab 5

*** Variables ***
${SERIAL_PORT}    COM99_NON_EXISTENT

*** Keywords ***
Clean Buffer
   Send Cr           CR
   Ignore Response

*** Test Cases ***

# Start AT communication
Disable Local Echo
  
   Clean Buffer
   Disable Echo
   ${echo} =         Read Coming 
   Should Contain    ${echo}        OK

Start AT communication
   Send Plain At
   Sleep             1s
   ${response}=      Read Coming
   Should Contain    ${response}    OK 
   Log To Console    ${response}

# SHORT LENGTH TESTS
Send Short And Fast Message 
   Set Len Timeout         10    20
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "Arsenal!"
   ${response} =           Read Coming
   Log To Console          ${response}

Send Short And Medium Message 
   Set Len Timeout         10    100
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "Arsenal"
   ${response} =           Read Coming
   Log To Console          ${response}

Send Short And Slow Message 
   [Tags]                  Slow
   Set Len Timeout         10    500 
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "Arsenal"
   ${response} =           Read Coming
   Log To Console          ${response}
   Clean Buffer

# MEDIUM LENGTH TESTS
Send Medium And Fast Message 
   Set Len Timeout         20    20
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "Less than 20 chr"
   ${response} =           Read Coming
   Log To Console          ${response}
   Clean Buffer

Send Medium And Medium Message 
   Set Len Timeout         20    100
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "Less than 20 chr"
   ${response} =           Read Coming
   Log To Console          ${response}
   Clean Buffer

Send Medium And Slow Message 
   [Tags]                  Slow
   Set Len Timeout         20    500 
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "Less than 20 chr"
   ${response} =           Read Coming
   Log To Console          ${response}
   Clean Buffer

# LONG LENGTH TESTS

Send Long And Fast Message 
   Set Len Timeout         30    20
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "This string is about 30 char"
   ${response} =           Read Coming
   Log To Console          ${response}
   Clean Buffer

Send Long And Medium Message 
   Set Len Timeout         30    100
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "This string is about 30 char"
   ${response} =           Read Coming
   Log To Console          ${response}
   Clean Buffer

Send Long And Slow Message 
   [Tags]                  Slow
   Set Len Timeout         30    500 
   ${short_msg}=           Read Coming  
   Log To Console          ${short_msg}  
   Should Contain          ${short_msg}      OK
   Send Command            "This string is about 30 char"
   ${response} =           Read Coming
   Log To Console          ${response}


