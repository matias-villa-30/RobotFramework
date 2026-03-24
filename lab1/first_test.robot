*** Settings ***
Library     String 

*** Test Cases ***
Create a Random String
   Log To Console    Generating a random string.
   Generate Random String  10
   Log to Console    String created already!
