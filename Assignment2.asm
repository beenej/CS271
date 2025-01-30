TITLE Assignment 2    (Assignment2.asm)

; -----------------------------------------------------------
; Author(s): James Beene, Savhanna Beene
; CS271           Date: 1/28/2025
; Description: Assignment 2 program
; -----------------------------------------------------------

INCLUDE Irvine32.inc

; (insert constant definitions here)

UpperLimit EQU 1000				;Upper limit of inputs from user.


.data
; (insert variable definitions here)

    ; introduce collaborator names and assignment
    Intro BYTE "James Beene, Savhanna Beene, Assignment 2", 0  

; --------------------------------------------------------------------------------------------------------

    ; prompts for user input

    Begin BYTE "This program will calculate the factors of each number "
          BYTE "within a range of numbers between 1 and 1,000 and indicates which numbers are prime. "
          BYTE "In order to do this, please follow the prompts given. "
          BYTE "To begin, please enter your name:", 0                 ;begin instructions
    lowBoundPrompt BYTE "Now, please enter the lower value for the range: ",0 ;prompt for the lower value
    uppBoundPrompt BYTE "Next, the upper value for the range: ", 0    ; prompt for the upper value
    continuePrompt BYTE "Enter 1 to do another calculation, or 0 to exit: ", 0

; --------------------------------------------------------------------------------------------------------

    ; messages to user

    inputErrMsg BYTE "Invalid input, please try again. Remember, the value must be between 1 and 1000" ;error message after validation fail
    listPrimeMsg BYTE " Prime Number", 0 ; number is a prime number
    listPerfectSquareMsg BYTE " Perfect Square", 0  ;number is a perfect square
    exitMsg BYTE "Thanks for using our program!", 0

; --------------------------------------------------------------------------------------------------------

    username BYTE 50 DUP(0)    ;username entered by user
    lowBound DWORD ?
    uppBound DWORD ?
    userSelection DWORD ?

; --------------------------------------------------------------------------------------------------------

.code
; (insert executable instructions here)

    ; Print Intro
    call clrscr
    mov edx, OFFSET Intro
    call writestring
    call crlf

    ; Prompt for user name
    mov edx, OFFSET Begin
    call writestring
    call crlf

    ; Store user name
    mov edx, OFFSET username
    mov ecx, 50
    call ReadString
    call Crlf

    ; Prompt for lower bound, loop until valid input
inputLower:
    mov edx, OFFSET lowBoundPrompt
    call writestring
    call readint
    mov lowBound, eax
    cmp eax, 1
    jl invalidInputs
    cmp eax, UpperLimit
    jg invalidInputs

    ; Prompt for upper bound, loop until valid input
inputUpper:
    mov edx, OFFSET uppBoundPrompt
    call WriteString
    call ReadInt
    mov uppbound, eax
    cmp eax, 1
    jl invalidInputs
    cmp eax, UpperLimit
    jg invalidInputs
    cmp eax, lowbound
    jl invalidInputs

    ; Loop through range of numbers
    mov ecx, lowBound
calculate:
    cmp ecx, uppBound   ;ensure lower bound is less than upper bound
    jg endFactor        ;if not, send error message to reprompt inputs
    
    call Crlf
    mov eax, ecx
    mov edx, OFFSET " : "
    call WriteString

    ; Calculate factors in range
    mov ebx, 1
getFactors:
    cmp ebx, ecx
    jg detPrime       ;if ebx is greater than ecx, determine if prime or not

    mov edx, 0
    mov eax, ecx
    div ebx           ;divide upper bound by 1 to get remainder

    cmp edx, 0
    jne notFactor     ;if remainder is not 0, not a factor
    
    ; if it's a factor, print the factor
    call WriteInt  ; Print factor
    mov edx, OFFSET ", "
    call WriteString

notFactor:
    inc ebx           ;increment ebx to check next factor
    jmp getFactors

    ;determine if number is prime or not
detPrime:
    mov eax, ecx
    cmp eax, 1
    jle notPrime

    mov ebx, 2
getPrime:
    cmp ebx, eax
    jge isPrime
    
    mov edx, 0
    div ebx          ;divide upper bound by 2 to get remainder

    cmp edx, 0
    je notPrime      ;if remainder is 0, it's not a prime number
    inc ebx          ;increment ebx to check next factor
    jmp getPrime     ;loop back to getPrime

isPrime:
    mov edx, OFFSET listPrimeMsg
    call WriteString
    jmp detPerfectSquare

notPrime:
    jmp detPerfectSquare

detPerfectSquare:
    mov eax, ecx
    mov ebx, 1

perfectSquare:
    mov edx, 0
    mul ebx               ; EAX = EBX * EBX (square EBX)
    cmp eax, ecx          ; Compare with the original number
    je isPerfectSquare    ; If they are equal, it's a perfect square
    ja notPerfectSquare   ; If EBX^2 > ECX, exit (not a square)
    inc ebx               ; Increment EBX (next number to square)
    jmp perfectSquare ; Repeat for the next number

isPerfectSquare:
    mov edx, OFFSET listPerfectSquareMsg
    call WriteString
    jmp endPerfectSquare    ; perfect square process is done

notPerfectSquare:
    jmp endLoopSteps

endLoopSteps:
    call Crlf
    inc ecx
    jmp calculate

endFactor:
    ; Prompt user to continue or exit
continueOrExit:
    mov edx, OFFSET continuePrompt
    call WriteString
    call ReadInt
    mov userSelection, eax
    cmp eax, 0
    je exitProgram
    cmp eax, 1
    je inputLower
    jmp continueOrExit

exitProgram:
    mov edx, OFFSET exitMsg     
    call WriteString

	exit	; exit to operating system

invalidInputs:
    MOV edx, OFFSET invalidInput
    CALL WriteString
    CALL Crlf
    JMP inputLower

main ENDP

; (insert additional procedures here)

END main
