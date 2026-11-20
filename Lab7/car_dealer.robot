*** Settings ***
Documentation       Car dealer website test

Library             SeleniumLibrary
Library             Dialogs
Library             Process

Test Setup          Start Container
Test Teardown       Stop Container 

*** Variables ***
${LOGIN URL}      http://localhost:3000
${BROWSER}        Firefox 


*** Test Cases ***
Take Initial Screenshot And Open Browser
   Open Browser      ${LOGIN URL}   ${BROWSER}
   Capture Page Screenshot   
   # Pause execution to see what happens on browser


   Click Link        Add a car 
   Input Text        make-input     Volvo
   Input Text        model-input    Xc60
   Input Text        mileage-input  12500
   Input Text        year-input     2022
   Input Text        plate-input    ABC-123
   Click Button      Add a new car

   Click Link        Add a car 
   Input Text        make-input     Ford 
   Input Text        model-input    Transit
   Input Text        mileage-input  22500
   Input Text        year-input     2019
   Input Text        plate-input    DEF-456
   Click Button      Add a new car

   Click Link        Add a car 
   Input Text        make-input     Mercedes-Benz 
   Input Text        model-input    Vito
   Input Text        mileage-input  32500
   Input Text        year-input     2017
   Input Text        plate-input    GHI-789
   Click Button      Add a new car

   Capture Page Screenshot
   Close Browser

*** Keywords ***

Start Container
   Run Process       docker-compose    up    --detach

Stop Container
   Run Process       docker-compose    down
   Pause Execution
