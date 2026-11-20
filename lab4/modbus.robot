*** Settings ***

Library           ModbusASCII.py    

Documentation     Initial testing for lab 4

*** Test Cases ***
    
Unsupported Function Codes Report With Exception Code
   ${result}=        Write To Registers    9    5565    7
   Should Contain    ${result}      Exception

Supported Function Codes Work As Specified
   ${result}=        Write To Registers   10  1001  6
   Should Contain    ${result}            Success 

Reading From Input Register Works As Specified
   ${result}=              Read From Registers   1  1  4
   Should Not Contain      ${result}   Exception

Write To Invalid Register Number Reports An Error
   ${result}            Write To Registers   9    9041    6
   Should Contain       ${result}               Exception

Write Value Greater Than 16 Bits Reports An Error
   ${result}            Write To Registers   9    109041    6
   Should Contain       ${result}            Error   

Writing 16 Bit Values Succeeds
   ${result}            Write To Registers      9     63453    6
   Should Not Contain   ${result}               Error

Write Valid Value To Holding Register And Read Said Valid Value Back
   Write To Registers         12                      6543        6
   ${read}=                   Read From Registers     12    1     3
   Should Be Equal As Numbers    ${read}[0]                 6543

Write Valid Negative Value To Holding Register
   ${valid}=   Write Negative Values To Registers     13    -3654    6
   Should Not Contain   ${valid}    Error

Write Invalid Negative Value To Holding Register
   ${valid}=   Write Negative Values To Registers     13    -38454    6
   Should Contain   ${valid}    Error

Write Valid Negative Value And Read Back
   ${valid}=   Write Negative Values To Registers     14    -3654    6
   ${read}=                   Read Negative           14    3
   Should Be Equal As Numbers    -3654              ${read}

