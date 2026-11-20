*** Settings ***

Library        FlukeSerialCommand.py   ${SERIAL_PORT}
Library        OperatingSystem  
Library        String
Documentation  Lab 2

*** Variables ***
${SERIAL_PORT}    COM99_NON_EXISTENT

*** Test Cases ***
Test Connect To Fluke 
    # Connect to Fluke
    # REMEMBER TO ADD IGNORE COMMANDS FUNCTION TO GET RID OF JUNK CHARS
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
    Should Contain   ${sn}          6494021 
    Log To Console                  Serial Number: ${sn}
 
Test Set Simulator State

   # Switch to remote control mode 
   # Set temp = 36.5, set heart rate = 78 bpm, standard deviation = 0.05, ECG wave = on
   Send Command         REMOTE
   ${remote}=           Read Coming
   Should Not Contain   ${remote}   !03 Illegal parameter  
   Should Contain       ${remote}   RMAIN
   Log To Console       ${remote}
   
   Send Command         TEMP=36.5
   ${temp}=             Read Coming
   Should Not Contain   ${temp}   !03 Illegal parameter   
   Should Contain       ${temp}   *
   Log To Console       ${temp}

   Send Command         PULSE=80
   ${heart_rate}=       Read Coming
   # SHOULD NOT CONTAIN ILLEGAL PARAMETER AND SHOULD CONTAIN *, BOTH CONDITIONS GOTTA BE TRUE TO VALIDATE TEST
   Should Not Contain   ${heart_rate}   !03 Illegal parameter  
   Should Contain       ${heart_rate}  * 
   Log To Console       ${heart_rate}
   
   Send Command         STDEV=+0.05
   ${std_dev}=          Read Coming
   Should Not Contain   ${std_dev}   !03 Illegal parameter  
   Should Contain       ${std_dev}  * 
   Log To Console       ${std_dev}
   
   Send Command         ECGRUN=true
   ${ecg_on}=           Read Coming
   Should Not Contain   ${ecg_on}   !03 Illegal parameter  
   Should Contain       ${ecg_on}  *  
   Log To Console       ${ecg_on}
