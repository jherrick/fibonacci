TITLE Program Template     (template.asm)

; Author:  Joel Herrick
; Last Modified: 4/18/2018
; OSU email address: herricjo@oregonstate.edu
; Course number/section: 271-400
; Project Number: 2                Due Date: 4/22/18
; Description: calculates fibonacci numbers and validates user-input range

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

MAX = 80
UPPER = 46
LOWER = 1

intro_1       BYTE   "Fibonacci Numbers",0
intro_2       BYTE   "Programmed by Joel Herrick",0
prompt_1      BYTE   "What's your name? ",0
response_1    BYTE   "Hello, ",0
intro_3       BYTE   "Enter the number of Fibonacci terms to be displayed",0
intro_4       BYTE   "Give the number as an integer in the range [1 .. 46].",0
prompt_2      BYTE   "How many Fibonacci terms do you want? ",0
validate      BYTE   "Out of range. Enter a number in [1 .. 46].",0
outro_1       BYTE   "Results certified by Joel Herrick.",0
outro_2       BYTE   "Goodbye, ",0
outro_3		  BYTE   ". ",0
spaces	      BYTE   "     ",0
fibo          DWORD  ?

; (insert variable definitions here)

userName     BYTE    MAX+1 DUP (?)
userNumber   DWORD   ?

.code
main PROC

;Program introduction
	mov		edx, OFFSET intro_1     ;fibonacci numbers
	call	WriteString		
	call	CrLf
	mov		edx, Offset intro_2		;programmed by joel herrick
	call	WriteString
	call	CrLf

;Obtain user's name
	mov		edx, OFFSET prompt_1	;whats your name
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, MAX
	call	ReadString				;get username

;Greet user
	mov		edx, OFFSET response_1	;hello, username
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf
	mov		edx, OFFSET intro_3		;enter the # of fibo terms to be displayed
	call	WriteString
	call	CrLf
	mov		edx, OFFSET intro_4		;give the number as an integer in the range [...]
	call	WriteString
	call	CrLf
	call	CrLf

redo:

;Obtain number of fibo terms to display
	mov		edx, OFFSET prompt_2	;how many fibo #s do you want
	call	WriteString
	call	ReadInt					;get int from user
	mov		userNumber, eax

;Validate number of terms

	;validate upper bound
	cmp		eax, UPPER			;check upper bound
	jbe		upperOK				;if upper ok, check lower
	mov		edx, OFFSET validate
	call	WriteString			;out of range error printed
	call	CrLf
	jmp		redo				;jump and repromt for number

	;validate lower bound
upperOK:
	mov		eax, userNumber
	cmp		eax, LOWER			;check lowerbound
	jge		inputOK				;if lower okay continue
	mov		edx, OFFSET validate
	call	WriteString			;else out of range error printed
	call	CrLf
	jmp		redo				;jump and reprompt for number

	;validation completed
inputOK:
	
;Prepare to enter loop
	mov		ecx, userNumber		;set loop counter ecx to usernumber
	mov		fibo, 0
	mov		eax, 1
	mov		ebx, 0


;Enter loop 
Loop1:	
	
;Check remaining loops and jump if <= 5
	cmp		ecx, 5
	jle		Loop2

;Larger than 5, prepare 2nd loop
	mov		userNumber, ecx
	mov		ecx, 5
	
Loop2:
	add		eax, fibo		;add prev fibo term to eax (current fibo number)
	mov		fibo, ebx		;move pre fibo term to fibo
	call	WriteDec
	mov	    edx, OFFSET spaces
	call	WriteString
	mov		ebx, eax		;move cur fibo term to prev fibo term temp storage
	loop	Loop2			
	
;Check if done looping (less than 5 loops remaining before printing)
	cmp		userNumber, 5
	jle		goodBye

;Otherwise subtract 5 from remaining loops
	sub		userNumber, 5

;reset loop counter and reenter loop
	mov		ecx, userNumber		   ;restore original loop #
	inc		ecx                    ;accommodate for reentering loop1 to not drop a loop
	call	CrLf
	loop	Loop1

goodBye:

;Say goodbye
	call	CrLf
	call	CrLf
	mov		edx, OFFSET outro_1		;results validated by joel herrick
	call	WriteString
	call	CrLf
	mov		edx, OFFSET outro_2		;goodbye, username
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET outro_3		; .
	call	WriteString
	call	CrLf

; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
