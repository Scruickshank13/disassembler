*------------------------------------------------------------------------------
* Title      : NewLine
* Written by : Dillon Evans
* Date       : 5/6/23
* Description: Displays a new line (carriage return and line feed characters).
*------------------------------------------------------------------------------


*------------------------------------------------------------------------------
* Subroutine : NewLine
* Description: Displays a new line (carriage return and line feed characters).
* Parameters : None.
* Returns    : None.
*------------------------------------------------------------------------------
NewLine

.Registers  REG     D0/A1

    MOVEM.L .Registers,-(SP)    * Preserve D0 and A1
    LEA     CRLF,A1
    MOVE.B  #14,D0
    TRAP    #15                 * Display the new line characters
    MOVEM.L (SP)+,.Registers    * Restore D0 and A1
    RTS                         * Return


*------------------------------------------------------------------------------
* Constants
*------------------------------------------------------------------------------
CRLF    DC.B    $0D,$0A,0       * New line characters





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
