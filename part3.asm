; quesmith@pdx.edu
; Quentin Smith

extern printf			; the C function, to be called
extern malloc
extern scanf
extern rand
extern srand
extern free

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
    array resd 1
section .data			; Data section, initialized identifiers
    arraysize: dd NULL
    ; array:  dd 04
    getasize: db "Enter the number of elements in the array ", NULL
    array_number: db "     %d", NULL
    lessten: db "      %d", NULL
    
    seed: dd NULL
    modulo: dd NULL
    x: dd NULL
    y: dd NULL
    
section .rodata         ; Read-only section, immutable identifiers
        fmt_curr_line: db "DEBUG LINE: %d", NL, NULL

        array_output: db "array1:", NULL
        getseed: db "Enter the seed to use for rand() ", NULL
        getvalue: dd "%d", NULL
        getmodulo: db "Enter the modulo to apply to the random numbers ", NULL
        modu: db "modulo %d", NL, NULL
        divi: db "dividend: %d", NL, NULL
        array_end: db NL
        


    


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
        mov eax, dword[arraysize]    ; the number of elements we want for the array
        imul eax, 4          ; we have to multiply by the size of element
        push eax             ; push that value onto the stack
        call malloc          ; call malloc()
               ; the return value from malloc() is in eax. save it in a memory location
        ;; should check for NULL return vale from malloc()
        add esp, 4           ; clean up the stack
        mov [array], eax
        mov esi,  array        ; move the pointer value in z into a register
        mov ecx, [arraysize]    ; the number of elements in the array
        ;dec ecx         ; we have to decrement. without a decrement, we'd go from 10-0 (one to many)

    ; love_init:
    ;     mov dword [ esi + ecx ], 0
    ;     ;; mov dword [ z + ecx], 0      ; does not work. this is the address of z, not address in z
    ;     ;; mov dword [ [ z ] + ecx ], 0 ; does not accept this syntax
    ;     loop love_init



    random:
        push getseed
        call printf
        add esp, 4

        push seed
        push getvalue
        call scanf
        add esp, 8
        cmp dword [seed], 0
        jle seed3
        jmp seedend
        seed3:
            mov dword [seed], 3
        seedend:
            push dword [seed]
            call srand
            add esp, 4

    getmod:
        push getmodulo
        call printf
        add esp, 4
        
        push modulo
        push getvalue
        call scanf
        add esp, 8

        cmp dword [modulo], 0
        jle modulo0
        jmp moduloend

        modulo0:
            mov dword [modulo], 100
        moduloend:

    mov esi, array
    mov ebx, 0
    mov edi, 1

    



    loop:
        xor eax, eax
        call rand
        mov esi, [array]
        mov edx, 0
        xor edx, edx
        cmp eax, 0
        je .zero
        cmp dword [modulo], 0
        je .zero
        idiv dword [modulo]
        jmp .finish
        .zero:
            mov dword[edx], 0
        .finish:
            mov esi, [array]
            mov ecx, [arraysize]
            mov [esi+(ebx*4)], edx
            inc ebx
            cmp ebx, ecx
            jl loop
    
    mov ebx, 0
    mov edi, 0
    mov eax, 0
    mov esi, [array]


    push array_output
    call printf
    add esp, 4

    CURR_LINE(__LINE__)

    printloop:              
        mov eax, [esi+ebx*4]
        
        mov esi, [array]

        cmp eax, 10
        push eax
        jl .less10
        push array_number
        jmp .print
        .less10:
            push lessten  
        .print:
            
            call printf
            add esp, 8
            inc ebx
            mov ecx, [arraysize]
            cmp ebx, ecx
            jl printloop

    push array_end
    call printf
    add esp, 4
    

    ;; free the memory we allocated
    mov ecx, array
    call free
    add esp, 4


   
  
CURR_LINE(__LINE__)

    
	; Don't change or remove the lines of code in here  |
	mov	esp, ebp		; takedown stack frame			|
	pop	ebp				;								|
						;								|
	mov	eax, EXIT_SUCCESS			; no error return value			|
	ret					; return						|
	; Don't change or remove the lines of code in here  |
