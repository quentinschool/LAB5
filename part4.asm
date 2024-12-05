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
    array1 resd 1
    array2 resd 1
    array3 resd 1
section .data			; Data section, initialized identifiers
    arraysize: dd NULL
    ; array:  dd 04
    getasize: db "Enter the number of elements in the array ", NULL
    array_number: db "     %d", NULL
    lessten: db "      %d", NULL
    dig3: db "    %d", NULL
    seed: dd NULL
    modulo: dd NULL
    x: dd NULL
    y: dd NULL
    
section .rodata         ; Read-only section, immutable identifiers
        fmt_curr_line: db "DEBUG LINE: %d", NL, NULL

        array_output: db "array1:", NULL
        array_output2: db "array2:", NULL
        array_output3: db "array3:", NULL
        getseed: db "Enter the seed to use for rand() ", NULL
        getvalue: dd "%d", NULL
        getmodulo: db "Enter the modulo to apply to the random numbers ", NULL
        modu: db "modulo %d", NL, NULL
        divi: db "dividend: %d", NL, NULL
        array_end: db NL, NULL
        backarray_end: db "  in reverse",NL, NULL
        array3_end: db "  array1 + array2", NL, NULL
        


    


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
        mov dword [arraysize], 15

    malloc1:
        mov eax, [arraysize]    ; the number of elements we want for the array
        imul eax, 4          ; we have to multiply by the size of element
        push eax             ; push that value onto the stack
        call malloc          ; call malloc()
        add esp, 4           ; clean up the stack
        mov [array1], eax
        mov ecx, [arraysize]    ; the number of elements in the array
    malloc2:
        mov eax, [arraysize]    ; the number of elements we want for the array
        imul eax, 4          ; we have to multiply by the size of element
        push eax             ; push that value onto the stack
        call malloc          ; call malloc()
        add esp, 4           ; clean up the stack
        mov [array2], eax
        mov ecx, [arraysize]    ; the number of elements in the array
    malloc3:
        mov eax, [arraysize]    ; the number of elements we want for the array
        imul eax, 4          ; we have to multiply by the size of element
        push eax             ; push that value onto the stack
        call malloc          ; call malloc()
        add esp, 4           ; clean up the stack
        mov [array3], eax
        mov ecx, [arraysize]    ; the number of elements in the array

    ; love_init:
    ;     mov dword [ array3 + ecx ], 0
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
            mov dword [seed], 17
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
            mov dword [modulo], 150
        moduloend:

    mov ebx, 0

    



    loop1:
        xor eax, eax
        call rand
        mov esi, [array1]
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
            mov esi, [array1]
            mov ecx, [arraysize]
            mov [esi+(ebx*4)], edx
            inc ebx
            cmp ebx, ecx
            jl loop1
    
    mov ebx, 0
    mov edi, 0
    mov eax, 0


    push array_output
    call printf
    add esp, 4

    CURR_LINE(__LINE__)

    printloop1:              
        mov eax, [esi+ebx*4]
        
        mov esi, [array1]

        cmp eax, 10
        push eax
        jl .less10
        cmp eax, 100
        jge .three
        push array_number
        jmp .print
        .three:
            push dig3
            jmp .print
        .less10:
            push lessten  
        .print:
            
            call printf
            add esp, 8
            inc ebx
            mov ecx, [arraysize]
            cmp ebx, ecx
            jl printloop1

    push array_end
    call printf
    add esp, 4
    mov ebx, 0

    loop2:
        mov eax, 0
        xor eax, eax
        call rand
        ; mov [x], eax
        mov esi, [array2]
        mov edx, 0
        ; mov edi, [modulo]
        ; mov eax, [x]
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
            mov esi, [array2]
            mov ecx, [arraysize]
            mov [esi+(ebx*4)], edx
            inc ebx
            cmp ebx, ecx
            jl loop2

    mov ebx, 0
    mov edi, 0
    mov eax, 0
    mov esi, [array2]


    push array_output2
    call printf
    add esp, 4

    printloop2:              
        mov eax, [esi+ebx*4]
        
        mov esi, [array2]

        cmp eax, 10
        push eax
        jl .less10
        cmp eax, 100
        jge .three
        push array_number
        jmp .print
        .three:
            push dig3
            jmp .print
        .less10:
            push lessten  
        .print:
            
            call printf
            add esp, 8
            inc ebx
            mov ecx, [arraysize]
            cmp ebx, ecx
            jl printloop2

    push array_end
    call printf
    add esp, 4

    push array_output2
    call printf
    add esp, 4

    mov ebx, [arraysize]
    dec ebx
    printloop2back:
            mov eax, [esi+ebx*4]
        
        mov esi, [array2]

        cmp eax, 10
        push eax
        jl .less10
        cmp eax, 100
        jge .three
        push array_number
        jmp .print
        .three:
            push dig3
            jmp .print
        .less10:
            push lessten  
        .print:
            
            call printf
            add esp, 8
            dec ebx
            mov ecx, [arraysize]
            cmp ebx, 0
            jge printloop2back

    push backarray_end
    call printf
    add esp, 4
        
    mov ecx, 0
    loop3:
        mov esi, [array1]
        mov eax, [esi+ecx*4]
        mov edi, [array2]
        add eax, [edi+ecx*4]
        mov esi, [array3]
        mov [esi+ecx*4], eax
        inc ecx
        cmp ecx, [arraysize]
        jl loop3

    mov ebx, 0
    mov edi, 0
    mov eax, 0

    push array_output3
    call printf
    add esp, 4

    mov ecx, 0
    printloop3:  
        mov esi, [array3]           
        mov eax, [esi+ebx*4]       
        cmp eax, 10
        push eax
        jl .less10
        cmp eax, 100
        jge .three
        push array_number
        jmp .print
        .three:
            push dig3
            jmp .print
        .less10:
            push lessten  
        .print:
            
            call printf
            add esp, 8
            inc ebx
            mov ecx, [arraysize]
            cmp ebx, ecx
            jl printloop3

    push array3_end
    call printf
    add esp, 4



    

    ;; free the memory we allocated
    mov ecx, [array1]
    call free
    mov ecx, [array2]
    call free
    mov ecx, [array3]
    call free
    ; mov ecx, array2
    ; call free
    ; add esp, 4


   
  
CURR_LINE(__LINE__)

    
	; Don't change or remove the lines of code in here  |
	mov	esp, ebp		; takedown stack frame			|
	pop	ebp				;								|
						;								|
	mov	eax, EXIT_SUCCESS			; no error return value			|
	ret					; return						|
	; Don't change or remove the lines of code in here  |
