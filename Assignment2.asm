TITLE Assignment 2    (Assignment2.asm)

; Author(s): James Beene, Savhanna Beene
; CS271           Date: 1/28/2025
; Description: Assignment 2 program

INCLUDE Irvine32.inc

; (insert constant definitions here)

UpperLimit EQU 1000											;Upper limit of inputs from user.
Intro BYTE "James Beene, Savhanna Beene, Assignment 2", 0   ;introduction of assignment

begin BYTE "This program will calculate the factors of each number "
             BYTE "within a range of numbers between 1 and 1,000 and indicates which numbers are prime. "
             BYTE "In order to do this, please follow the prompts given. "
             BYTE "To begin, please enter your name:", 0   ;begin instructions
enterlow BYTE "Now, please enter the lower value for the range: ",0 ;prompt for the lower value
enterupp BYTE "Next, the upper value for the range: ", 0    ; prompt for the upper value
errmsg BYTE "Invalid input, please try again. Remember, the value must be between 1 and 1000" ;error message after validation fail


.data
; (insert variable definitions here)

username BYTE 
a DWORD
b DWORD

.code

; (insert executable instructions here)

	exit	; exit to operating system

main ENDP

; (insert additional procedures here)

END main
