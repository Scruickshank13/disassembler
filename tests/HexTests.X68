*------------------------------------------------------------------------------
* Title      : HexTests
* Written by : Dillon Evans
* Date       : 5/20/23
* Description: Tests the HexToInt and IntToHex subroutines.
*------------------------------------------------------------------------------
    ORG     $1000


*------------------------------------------------------------------------------
* Includes
*------------------------------------------------------------------------------
    INCLUDE ../src/HexToInt.X68
    INCLUDE ../src/IntToHex.X68
    INCLUDE ../src/NewLine.X68


*------------------------------------------------------------------------------
* Start
*------------------------------------------------------------------------------
Start
    LEA     HexMsg,A1
    MOVE.B  #14,D0
    TRAP    #15             * Ask for the hex string

    LEA     UserInput,A1
    MOVE.B  #2,D0
    TRAP    #15             * Accept the hex string

    BSR     HexToInt        * Convert the hex string to an int
    CMPI.B  #0,D1           * If the conversion failed:
    BLT     Invalid         *   Ask for a different hex int
    MOVE.L  D0,D3           * Store the int for later

    LEA     LengthMsg,A1
    MOVE.B  #14,D0
    TRAP    #15             * Ask for the length of the hex string to display

    MOVE.B  #4,D0
    TRAP    #15             * Accept the length to display

    MOVE.B  D1,D2
    MOVE.L  D3,D1
    LEA     HexOutput,A1
    BSR     IntToHex        * Convert the int to a hex string

    LEA     HexMsg,A1
    MOVE.B  #14,D0
    TRAP    #15             * Prepare to display the hex string

    LEA     HexOutput,A1
    MOVE.B  #13,D0
    TRAP    #15             * Display the hex string

    BSR     NewLine
    BRA     Start           * Keep looping

Invalid
    LEA     InvalidMsg,A1
    MOVE.B  #13,D0
    TRAP    #15             * Display an error message
    BSR     NewLine
    BRA     Start


*------------------------------------------------------------------------------
* Variables
*------------------------------------------------------------------------------
UserInput   DS.B    81  * Allocate space for user input to be stored
HexOutput   DS.B    9   * Allocate space for hex output to be stored


*------------------------------------------------------------------------------
* Constants
*------------------------------------------------------------------------------
HexMsg      DC.B    'Hex = $',0
LengthMsg   DC.B    'Length = ',0
InvalidMsg  DC.B    'That is not a valid hexadecial number.',0


*------------------------------------------------------------------------------
* End
*------------------------------------------------------------------------------
    END     Start






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
