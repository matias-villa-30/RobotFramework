*** Settings ***
Documentation       Lab 8 part 2

Library             SeleniumLibrary
Library             RandomLibrary.py 
Library             Dialogs
Library             Process
Library             Collections

Suite Setup          Start Container
Suite Teardown       Stop Container 

*** Variables ***
${LOGIN URL}      http://localhost:3000
${BROWSER}        Firefox 


*** Test Cases ***

Test Add Ten Random Cars
   Open Browser      ${LOGIN URL}   ${BROWSER}
   ${LIST}=    Create List
  
   FOR      ${i}     IN RANGE    10
         Click Link        Add a car 
         
         ${brand}=    Generate Test2 Brand
         Append To List   ${LIST}   ${brand}
         ${model}=    Generate Test2 Model
         ${mileage}=  Generate Mileage
         ${year}=     Generate Year
         ${plate}=    Generate Plate
         
         Input Text        make-input     ${brand}
         Input Text        model-input    ${model}
         Input Text        mileage-input  ${mileage}
         Input Text        year-input     ${year}
         Input Text        plate-input    ${plate}
         Click Button      Add a new car
   END
   Set Suite Variable    @{LIST}
   Capture Page Screenshot

*** Test Cases ***

Test Remove Skodas From List
    FOR    ${i}    IN RANGE    9    -1    -1
        ${brand}=    Get From List    ${LIST}    ${i}

        IF    'Skoda' in $brand
            Log    Removing Skoda at index ${i}

            Open Context Menu    xpath=(//td[contains(@class, 'car-brand')])[${i + 1}]
            Handle Alert    ACCEPT
        END
    END

    Capture Page Screenshot

*** Keywords ***

Start Container
   Run Process       docker-compose    up    --detach

Stop Container
   Run Process       docker-compose    down
   Pause Execution
