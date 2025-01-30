TITLE Assignment 2    (Assignment2.asm)

; -----------------------------------------------------------
; Author(s): James Beene, Savhanna Beene
; CS271           Date: 1/28/2025
; Description: Assignment 2 program
; -----------------------------------------------------------

INCLUDE Irvine32.inc

; (insert constant definitions here)

UpperLimit EQU 1000  ; Upper limit of inputs from user.

.data
; (insert variable definitions here)

    ; introduce collaborator names and assignment
    Intro BYTE "James Beene, Savhanna Beene, Assignment 2", 0  

; --------------------------------------------------------------------------------------------------------

    ; prompts for user input

    Begin BYTE "This program will calculate the factors of each number "
          BYTE "within a range of numbers between 1 and 1,000 and indicates which numbers are prime. "
          BYTE "In order to do this, please follow the prompts given. "
          BYTE "To begin, please enter your name:", 0  ; begin instructions
    lowBoundPrompt BYTE "Now, please enter the lower value for the range: ", 0  ; prompt for the lower value
    uppBoundPrompt BYTE "Next, the upper value for the range: ", 0  ; prompt for the upper value
    continuePrompt BYTE "Enter 1 to do another calculation, or 0 to exit: ", 0

; --------------------------------------------------------------------------------------------------------

    ; messages to user

    inputErrMsg BYTE "Invalid input, please try again. Remember, the value must be between 1 and 1000", 0  ; error message after validation fail
    listPrimeMsg BYTE " Prime Number", 0  ; number is a prime number
    listPerfectSquareMsg BYTE " Perfect Square", 0  ; number is a perfect square
    exitMsg BYTE "Thanks for using our program!", 0

; --------------------------------------------------------------------------------------------------------

    username BYTE 50 DUP(0)  ; username entered by user
    lowBound DWORD ?
    uppBound DWORD ?
    userSelection DWORD ?

; --------------------------------------------------------------------------------------------------------

.code
main PROC

    ; Print Intro
    CALL Clrscr
    MOV edx, OFFSET Intro
    CALL WriteString
    CALL Crlf

    ; Prompt for user name
    MOV edx, OFFSET Begin
    CALL WriteString
    CALL Crlf

    ; Store user name
    MOV edx, OFFSET username
    MOV ecx, 50
    CALL ReadString
    CALL Crlf

    MOV BYTE PTR [edx+ecx], 0

    ; Prompt for lower bound, loop until valid input
inputLower:
    MOV edx, OFFSET lowBoundPrompt
    CALL WriteString
    CALL ReadInt
    MOV lowBound, eax
    CMP eax, 1
    JL invalidInputs
    CMP eax, UpperLimit
    JG invalidInputs

    ; Prompt for upper bound, loop until valid input
inputUpper:
    MOV edx, OFFSET uppBoundPrompt
    CALL WriteString
    CALL ReadInt
    MOV uppBound, eax
    CMP eax, 1
    JL invalidInputs
    CMP eax, UpperLimit
    JG invalidInputs
    CMP eax, lowBound
    JL invalidInputs

    ; Loop through range of numbers
    MOV ecx, lowBound
calculate:
    CMP ecx, uppBound  ; ensure lower bound is less than upper bound
    JG endFactor  ; if not, send error message to reprompt inputs

    CALL Crlf
    MOV eax, ecx
    MOV edx, OFFSET " : "
    CALL WriteString

    ; Calculate factors in range
    MOV ebx, 1
getFactors:
    CMP ebx, ecx
    JG detPrime  ; if ebx is greater than ecx, determine if prime or not

    MOV edx, 0
    MOV eax, ecx
    DIV ebx  ; divide upper bound by 1 to get remainder

    CMP edx, 0
    JNE notFactor  ; if remainder is not 0, not a factor

    ; if it's a factor, print the factor
    CALL WriteInt  ; Print factor
    MOV edx, OFFSET ", "
    CALL WriteString

notFactor:
    INC ebx  ; increment ebx to check next factor
    JMP getFactors

    ; determine if number is prime or not
detPrime:
    MOV eax, ecx
    CMP eax, 1
    JLE notPrime

    MOV ebx, 2
getPrime:
    CMP ebx, eax
    JGE isPrime

    MOV edx, 0
    DIV ebx  ; divide upper bound by 2 to get remainder

    CMP edx, 0
    JE notPrime  ; if remainder is 0, it's not a prime number
    INC ebx  ; increment ebx to check next factor
    JMP getPrime  ; loop back to getPrime

isPrime:
    MOV edx, OFFSET listPrimeMsg
    CALL WriteString
    JMP detPerfectSquare

notPrime:
    JMP detPerfectSquare

detPerfectSquare:
    MOV eax, ecx
    MOV ebx, 1

perfectSquare:
    MOV edx, 0
    MUL ebx  
    CMP eax, ecx  
    JE isPerfectSquare
    
    JA notPerfectSquare  
    INC ebx  
    JMP perfectSquare  

isPerfectSquare:
    MOV edx, OFFSET listPerfectSquareMsg
    CALL WriteString
    JMP endLoopSteps  ; perfect square process is done

notPerfectSquare:
    JMP endLoopSteps

endLoopSteps:
    CALL Crlf
    INC ecx
    JMP calculate

endFactor:
    ; Prompt user to continue or exit
continueOrExit:
    MOV edx, OFFSET continuePrompt
    CALL WriteString
    CALL ReadInt
    MOV userSelection, eax
    CMP eax, 0
    JE exitProgram

    CMP eax, 1
    JE inputLower
    JMP continueOrExit

exitProgram:
    MOV edx, OFFSET exitMsg
    CALL WriteString

    EXIT  ; exit to operating system

invalidInputs:
    MOV edx, OFFSET inputErrMsg
    CALL WriteString
    CALL Crlf
    JMP inputLower

main ENDP

END main
