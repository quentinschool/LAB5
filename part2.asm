; quesmith@pdx.edu
; Quentin Smith

extern printf			; the C function, to be called
global main				; the standard gcc entry point

    %define NULL 0
    %define NL 10
    %define TAB 9
    %define EXIT_SUCCESS 0
    %define ARRAY_SIZE 15

	;%define DEBUG
    %ifdef DEBUG
        %macro CURR_LINE 1
            push %1
            push fmt_curr_line
            call printf
            add esp, 8
        %endmacro
    %else   ;DEBUG
        %macro CURR_LINE 1
        %endmacro
    %endif ;DEBUG
section .bss			; BSS, uninitialized identifiers
    array: resd ARRAY_SIZE
section .data			; Data section, initialized identifiers
    lesstenoutput: db "Array Index: %d  Value: %d", NL
    temp: dw 0	
section .rodata         ; Read-only section, immutable identifiers
        fmt_curr_line: db "DEBUG LINE: %d", NL, NULL

    array_output: db "Array Index: %d Value: %d", NL

    


section .text			; Code section.

main:					; the program label for the entry point
	; Don't change or remove the lines of code in here  |
	push ebp			; set up stack frame			|
	mov ebp, esp		;								|
	; Don't change or remove the lines of code in here	|


	; 
	; Your NASM code will go in here
	;
    CURR_LINE(__LINE__)

    mov esi, array
    CURR_LINE(__LINE__)
    mov ebx, 0
    mov edi, 1

    loop:
        add edi, 2
        CURR_LINE(__LINE__)
        mov [esi+ebx*4], edi
        inc ebx
        cmp ebx, ARRAY_SIZE
        jl loop
    
    mov ebx, 14
    mov edi, 0

    mov esi, array

    CURR_LINE(__LINE__)

    printloop:
        movzx eax, word [esi+ebx*4]
        push eax
        push ebx
        cmp ebx, 10
        jl less10
        push array_output
        jmp print

        less10:
            push lesstenoutput

        print:
            call printf
            add esp, 12
            sub ebx, 1
            cmp ebx, 0
            jge printloop
CURR_LINE(__LINE__)

    
	; Don't change or remove the lines of code in here  |
	mov	esp, ebp		; takedown stack frame			|
	pop	ebp				;								|
						;								|
	mov	eax, EXIT_SUCCESS			; no error return value			|
	ret					; return						|
	; Don't change or remove the lines of code in here  |
