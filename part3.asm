; quesmith@pdx.edu
; Quentin Smith

extern printf			; the C function, to be called
extern malloc
extern scanf
global main				; the standard gcc entry point

    %define NULL 0
    %define NL 10
    %define TAB 9
    %define EXIT_SUCCESS 0

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
section .data			; Data section, initialized identifiers
    arraysize: dd 10
    array:  dd 0x0
    getasize: db "Enter the number of elements in the array ", NL, NULL
    getvalue: db "%d", NULL
    array_number: db TAB, "%d", NULL
    array_end: db NL
section .rodata         ; Read-only section, immutable identifiers
        fmt_curr_line: db "DEBUG LINE: %d", NL, NULL

        array_output: db "array1:"
        


    


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

    push getasize   ;Getting array size
    call printf
    add esp, 4
    push arraysize
    push getvalue
    call scanf
    add esp, 8
    cmp dword [arraysize], 0
    jle array10
    jmp malloc1

    array10:
        mov dword [arraysize], 10

    malloc1:
        mov eax, arraysize    ; the number of elements we want for the array
        imul eax, 4          ; we have to multiply by the size of element
        push eax             ; push that value onto the stack
        call malloc          ; call malloc()
        mov [ array ], eax       ; the return value from malloc() is in eax. save it in a memory location
        ;; should check for NULL return vale from malloc()
        add esp, 4           ; clean up the stack

    ; mov edi, [ array ]       ; move the pointer value in z into a register
        mov ecx, [arraysize]    ; the number of elements in the array
        ;dec ecx         ; we have to decrement. without a decrement, we'd go from 10-0 (one to many)


    mov esi, array
    CURR_LINE(__LINE__)
    mov ebx, 0
    mov edi, 1

    loop:
        add edi, 2
        CURR_LINE(__LINE__)
        mov [esi+ebx*4], edi
        inc ebx
        cmp ebx, ecx
        jl loop
    
    mov ebx, 0
    mov edi, 0

    mov esi, array

    CURR_LINE(__LINE__)

    push array_output
    call printf
    add esp, 4

    CURR_LINE(__LINE__)

    printloop:              
        movzx eax, word [esi+ebx*4]
        push eax
        push array_number


        call printf
        add esp, 8
        inc ebx
        mov ecx, [arraysize]
        cmp ebx, ecx
        jl printloop
    push array_end
    call printf
    add esp, 4
CURR_LINE(__LINE__)

    
	; Don't change or remove the lines of code in here  |
	mov	esp, ebp		; takedown stack frame			|
	pop	ebp				;								|
						;								|
	mov	eax, EXIT_SUCCESS			; no error return value			|
	ret					; return						|
	; Don't change or remove the lines of code in here  |
