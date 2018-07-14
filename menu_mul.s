;Made by jhim
global _start

extern printf
extern scanf

section .bss
	input resb 8
	menu resb 8

section .data
	string db "%d * %d = %d", 10, 0
	format db "%d", 0
	line db "============================", 10, 0
	condition db "which number do you select (1. 19Dan, 2. select guguDan 3. exit):", 0

section .text
	global _start

_start:
	mov rdi, condition
	call printf

	mov rdi, format
	mov rsi, menu
	call scanf
	mov r15, [menu]

	cmp r15, 3
	je _done

	cmp r15, 2
	je _Input
	
	cmp r15, 1
	mov r13, 1 ; r13 --> i
	mov r14, 1 ; r14 --> j
	je _JLoop

_JLoop:
	mov rax, r13
	cmp r14, 10
	je _ILoop
	mov rdi, string		; first value
	mov rsi, r13		; second value
	mul r14
	mov rdx, r14		; third value
	mov rcx, rax		; fourth value
	call printf
	inc r14
	jmp _JLoop

_ILoop:
	cmp r13, 20
	je _start
	mov r14, 1
	inc r13
	mov rdi, line
	call printf
	jmp _JLoop

_Input:
	mov rdi, format
	mov rsi, input
	mov r12, 1
	call scanf
	
_printMul:
	cmp r12, 10 ; If r12 become 10 then exit program
	mov rax, r12
	je _start
	mov rdi, string ; first value
	mov rsi, [input]  ; second value
	mul rsi		
	mov rdx, r12	; Third value (RDX) become 0, after multification. Reset RDX to r12
	mov rcx, rax     ; fourth value
	inc r12
	call printf
	jmp _printMul

_done:
	mov rax, 60
	mov rdi, 0
	syscall
