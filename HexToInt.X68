*------------------------------------------------------------------------------
* Title      : HexToInt
* Written by : Dillon Evans
* Date       : 5/5/23
* Description: Converts a hexadecimal string to an int.
*------------------------------------------------------------------------------


*------------------------------------------------------------------------------
* Subroutine : HexToInt
* Description: Converts a hexadecimal string to an int.
* Parameters : (A1) = The NULL-terminated hexadecimal string.
* Returns    : D0.L = The int.
*              D1.B = The number of characters converted.
* Notes:
*   The conversion will fail if the string is more than 8 characters long or
*   contains non-hexadecimal characters. If this occurs, then:
*     D1.B will be negative.
*     NOT D1.B will produce the number of characters successfully converted.
*     D0.L will store the value of the int immediately before failure.
*------------------------------------------------------------------------------
HexToInt

.Registers  REG     D2/D3/A2

    MOVEM.L .Registers,-(SP)    * Preserve D2, D3, and A2
    CLR.L   D2                  * D2 is the result
    CLR.B   D3                  * D3 is the number of chars converted
    MOVEA.L A1,A2               * A2 points to the next char
                                * D1 is the current char

.Loop
    MOVE.B  (A2)+,D1            * Read the next char into D1
    CMPI.B  #0,D1               * If the end of the string has been reached:
    BEQ     .Return             *   Conversion complete
    CMPI.B  #8,D3               * If the string is longer than 8 chars:
    BEQ     .Invalid            *   Conversion failure

    BSR     HexCharToInt        * Convert the current char to an int
    CMPI.B  #-1,D0              * If the char conversion failed:
    BEQ     .Invalid            *   String conversion failure

    ASL.L   #4,D2               * Add the value of the current char to the
    ADD.B   D0,D2               * result
    ADDQ.L  #1,D3               * Increment the char counter
    BRA     .Loop               * Keep looping

.Invalid
    NOT.B   D3                  * NOT the number of chars converted to indicate
                                * a failure while still saving how many chars
                                * were successfully converted.

.Return
    MOVE.L  D2,D0               * Move the result into D0
    MOVE.B  D3,D1               * Move the number of chars converted into D1
    MOVEM.L (SP)+,.Registers    * Restore D2, D3, and A2
    RTS                         * Return D0 and D1


*------------------------------------------------------------------------------
* Subroutine : HexCharToInt
* Description: Converts a hexadecimal character to an int.
* Parameters : D1.B = The hexadecimal character.
* Returns    : D0.B = The int. -1 if the character is not hexadecimal.
*------------------------------------------------------------------------------
HexCharToInt
    CMPI.B  #'0',D1         * If D1 < '0' or D1 > '9':
    BLT     .Uppercase      *   D1 is not a number
    CMPI.B  #'9',D1         *   Check if it's an uppercase letter
    BGT     .Uppercase

    MOVE.B  D1,D0           * Else:
    SUBI.B  #'0',D0         *   D1 is between '0' and '9'
    RTS                     *   Return D1 - '0'

.Uppercase
    CMPI.B  #'A',D1         * If D1 < 'A' or D1 > 'F':
    BLT     .Lowercase      *   D1 is not an uppercase letter
    CMPI.B  #'F',D1         *   Check if it's a lowercase letter
    BGT     .Lowercase

    MOVE.B  D1,D0           * Else:
    SUBI.B  #'A',D0         *   D1 is between 'A' and 'F'
    ADDI.B  #10,D0          *   Return D1 - 'A' + 10
    RTS

.Lowercase
    CMPI.B  #'a',D1         * If D1 < 'a' or D1 > 'f':
    BLT     .Invalid        *   D1 is not a valid hex character
    CMPI.B  #'f',D1         *   Return -1
    BGT     .Invalid

    MOVE.B  D1,D0           * Else:
    SUBI.B  #'a',D0         *   D1 is between 'a' and 'f'
    ADDI.B  #10,D0          *   Return D1 - 'a' + 10
    RTS

.Invalid
    MOVE.B  #-1,D0          * Return -1
    RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
