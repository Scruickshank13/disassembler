*------------------------------------------------------------------------------
* Title      : IntToHex
* Written by : Dillon Evans
* Date       : 5/20/23
* Description: Converts an int to a hexadecimal string.
*------------------------------------------------------------------------------


*------------------------------------------------------------------------------
* Subroutine : IntToHex
* Description: Converts an int to a hexadecimal string.
* Parameters : D1.L = The int.
*              D2.B = The number of characters to convert.
*               A1  = The location to store the hexadecimal string at.
* Returns    : (A1) = The null-terminated hexadecimal string.
*------------------------------------------------------------------------------
IntToHex

.Registers  REG     D0-D2

    MOVEM.L .Registers,-(SP)    * Preserve D0, D1, and D2

    ADDA.L  D2,A1               * Move A1 to the last char (null terminator)
    CLR.B   (A1)                * Make the last char be the null terminator

.Loop
    SUBQ.L  #1,D2               * Decrement D2, and if D2 < 0:
    BLT     .Return             *   Conversion complete

    BSR     IntToHexChar        * Convert the least-significant 4 bits of D1
    MOVE.B  D0,-(A1)            * Prepend the char to the string
    LSR.L   #4,D1               * Shift D1 to the right by 4 bits
    BRA     .Loop               * Keep looping

.Return
    MOVEM.L (SP)+,.Registers    * Restore D0, D1, and D2
    RTS                         * Return (A1)


*------------------------------------------------------------------------------
* Subroutine : IntToHexChar
* Description: Converts an int to a hexadecimal character.
* Parameters : D1.B = The int.
* Returns    : D0.B = The character.
*------------------------------------------------------------------------------
IntToHexChar
    MOVE.B  D1,D0       * Copy the int to D0
    ANDI.B  #$0F,D0     * Mask out the upper half of the byte
    CMPI.B  #10,D0      * If D0 >= 10:
    BGE     .Letter     *   D0 is a letter (between 'A' and 'F')
    ADDI.B  #'0',D0     * Else:
    RTS                 *   Return D0 + '0'

.Letter
    SUBI.B  #10,D0
    ADDI.B  #'A',D0
    RTS                 * Return D0 - 10 + 'A'





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
