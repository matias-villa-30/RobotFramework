*** Settings ***
Documentation       Lab 8

Library             SeleniumLibrary
Library             RandomLibrary.py 
Library             Dialogs
Library             Process

Suite Setup          Start Container
Suite Teardown       Stop Container 

*** Variables ***
${LOGIN URL}      http://localhost:3000
${BROWSER}        Firefox 


*** Test Cases ***
Test 1
   Open Browser      ${LOGIN URL}   ${BROWSER}

   FOR      ${i}     IN RANGE    3
         Click Link        Add a car 
         
         ${brand}=    Generate Car Brand
         ${model}=    Generate Car Model
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
         
   Click Link        Add a car 
         
   ${brand}=    Generate Car Brand
   ${model}=    Generate Car Model
   ${mileage}=  Generate Mileage
   ${year}=     Generate Year
   
   Input Text        make-input     ${brand}
   Input Text        model-input    ${model}
   Input Text        mileage-input  ${mileage}
   Input Text        year-input     ${year}
   Input Text        plate-input    ABC-123
   Click Button      Add a new car

   FOR      ${i}     IN RANGE    2
         Click Link        Add a car 
         
         ${brand}=    Generate Car Brand
         ${model}=    Generate Car Model
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

   Capture Page Screenshot   
   # BOTON DERECHO ELIMINA AUTOS
   Open Context Menu          (//div[contains(@class, 'car-specs') and contains(@class, 'car-plate')])[4]//span[contains(@class, 'field-value')]
   Handle Alert     ACCEPT 
   Capture Page Screenshot

*** Keywords ***

Start Container
   Run Process       docker-compose    up    --detach

Stop Container
   Run Process       docker-compose    down
   Pause Execution
