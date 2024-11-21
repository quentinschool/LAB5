; quesmith@pdx.edu
; Quentin Smith

extern printf			; the C function, to be called
global main				; the standard gcc entry point

    %define NULL 0
    %define NL 10
    %define TAB 9
    %define EXIT_SUCCESS 100
    %define ARRAY_SIZE 20

	%define DEBUG
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
    array: resw ARRAY_SIZE
section .data			; Data section, initialized identifiers

section .rodata         ; Read-only section, immutable identifiers

    array_output: db TAB, "Array Index: %d  Value: %d", NL

section .text			; Code section.

main:					; the program label for the entry point
	; Don't change or remove the lines of code in here  |
	push ebp			; set up stack frame			|
	mov ebp, esp		;								|
	; Don't change or remove the lines of code in here	|


	; 
	; Your NASM code will go in here
	;

    mov esi, array

    loop:
        mov [esi+(ecx*4)], (2+(eci*2))
        inc ecx
        cmp ecx, ARRAY_SIZE
        jl loop
    
    mov ecx, 0
    printloop:
        push [esi+(ecx*4)] 
        push ecx
        call array_output
        call printf
        inc ecx
        jl printloop



	; Don't change or remove the lines of code in here  |
	mov	esp, ebp		; takedown stack frame			|
	pop	ebp				;								|
						;								|
	mov	eax, EXIT_SUCCESS			; no error return value			|
	ret					; return						|
	; Don't change or remove the lines of code in here  |
