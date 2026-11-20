*** Settings ***
Library           DataDriver              #tag_column=[Tags]     exclude=High 
Library           FlukeSerialCommand.py   ${SERIAL_PORT}    

Resource          serial_lib.resource

Test Template     Check health values

Suite Setup       Connect To Fluke 
Suite Teardown    Set To Local Mode
Test Setup        Set To Remote Mode
Test Teardown     Set ECG OFF

Documentation     Lab 3

*** Test Cases ***
Health Test for ${age_group} with Rate ${Hear_Rate} and Temperature ${body_temp} with Std deviation ${std_deviation} 

*** Keywords ***
Check health values
    [Arguments]          ${age_group}    ${Hear_Rate}    ${body_temp}   ${std_deviation}  
    Send Command         PULSE= ${Hear_Rate}  
    Send Command         TEMP= ${body_temp} 
    Send Command         STDEV= +${std_deviation}    
    Log Many             ${age_group}    ${Hear_Rate}    ${body_temp}   ${std_deviation}
    Sleep                1s  
