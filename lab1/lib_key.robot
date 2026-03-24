*** Settings ***
Library           FakerLibrary
Documentation     Exercise for testing keywords and libraries 

*** Variables ***
${MESSAGE}        Varpu

*** Keywords ***
Get Random Names
    ${name}=    First Name
    Log         ${name}
    Should be equal  ${MESSAGE}   ${name}

*** Test Cases ***
Test 1
    Get Random Names
