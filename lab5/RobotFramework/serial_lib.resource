*** Settings ***

Library           FlukeSerialCommand.py   ${SERIAL_PORT}
Library           OperatingSystem  
Library           String
Documentation     Resource file for lab 3

*** Variables ***
${SERIAL_PORT}    COM99_NON_EXISTENT

*** Keywords ***
Connect To Fluke 
    Send Command                    CR  
    Ignore Response
    # Get Firmware verison  
    Send Command                    IDENT

    ${firmware_raw}=                Read Coming
    Should Contain                  ${firmware_raw}    PROSIM8
    ${parts}=                       Split String    ${firmware_raw}    separator=,
    ${firmware}=                    Set Variable    ${parts[1]}
   
    Should Be Equal                 ${firmware}    2.09.04
    Log To Console                  Firmware Version: ${firmware}
   
# Get Serial Number
    Send Command                    SN
    ${sn}=                          Read Coming    
    Should Contain                  ${sn}          6494021 
    Log To Console                  Serial Number: ${sn}

Set To Local Mode
    [Documentation]    Sets the device to local mode and ignores 'already local' errors.
    Send Command    LOCAL
    ${resp}=        Read Coming
    Log To Console  \nDEBUG: Local Response was: ${resp}
    
    # WE DO NOT USE 'Should Contain' HERE. 
    # Just reading the buffer is enough. If it's local, it's local.
    
Set To Remote Mode
   # Switch to remote control mode 
   # Set temp = 36.5, set heart rate = 78 bpm, standard deviation = 0.05, ECG wave = on
   Send Command                     REMOTE
   ${remote}=                       Read Coming
   Should Not Contain               ${remote}   !02 Illegal command  
   Should Contain                   ${remote}   RMAIN
   Log To Console                   ${remote}

Set ECG Off 
   Send Command         ECGRUN=false
   ${ecg_on}=           Read Coming
   Should Not Contain   ${ecg_on}   !03 Illegal parameter  
   Should Contain       ${ecg_on}  *  
   Log To Console       ${ecg_on}
 
