       .module comparaciones
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    
;Premios por categoria
primer_5cifras: .asciz "Primer premio de 5 cifras equivale a 1000 puntos\n"
segundo_5cifras:.asciz "Segundo premio de 5 cifras equivale a 500 puntos\n"
tercero_5cifras:.asciz "Tercer premio de 5 cifras equivale a 200 puntos\n"
cuatro_cifras:  .asciz "Terminacion de 4 cifras equivale a 50 puntos\n"
tres_cifras:    .asciz "Terminacion de 3 cifras equivale a 10 puntos\n"
dos_cifras:     .asciz "Terminacion de 2 cifras equivale a 5 puntos\n"
una_cifra:     .asciz "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

;Declaraciones
puntuaje:     .word 0
                .globl  numeros.asm
                .globl  imprime_cadena
                .globl  comparacion_5cifras
                .globl  comparacion_4cifras
                .globl  comparacion_3cifras
                .globl  comparacion_2cifras
                .globl  comparacion_reintegro
                
                .globl  bucle_despazamiento4cifras
                .globl  bucle_despazamiento3cifras
                .globl  bucle_despazamiento2cifras
                .globl  bucle_despazamientoreintegros



comparacion_5cifras:
        pshs    a
        lda     puntuaje
        cmps    #primer.premio
        bne     else1
        adda    #1000
        ldx     #primer_5cifras
        jsr     imprime_cadena
        jsr     comparacion_4cifras

else1:
        cmps    #segundo.premio
        bne     else2
        adda    #500
        ldx     #segundo_5cifras
        jsr     imprime_cadena
        jsr     comparacion_4cifras

else2:
        cmps    #tercer.premio
        bne     else3
        adda    #200
        ldx     #tercer_5cifras
        jsr     imprime_cadena
        jsr     comparacion_4cifras

else3:
        jsr comparacion_4cifras


comparacion_4cifras:
        puls    a
        leay    1,a
        pshs    a
        

comparacion_3cifras:
        puls    a
        leay    a, 2
        pshs    a
        cmps    #tres.cifras
        bne                             ;no se si crear otra subrutina
        ldx     #tres_cifras
        jsr     imprime_cadena
        jsr     comparacion_2cifras

comparacion_2cifras:
        puls    a
        leay    a, 3
        pshs    a
        cmps    #dos.cifras
        bne     
        ldx     #dos_cifras
        jsr     imprime_cadena
        jsr     comparacion_2cifras

comparacion_reintegro:
        puls    a
        leay    a, 4
        pshs    a
        cmps    #reintegro
        bne     
        ldx     #una_cifra
        jsr     imprime_cadena

bucle_despazamiento4cifras: 
        ldb     #0         
        ldu     #cuatro.cifras
        ldu     ,b+
        cmpb    #1
        beq     comparacion_3cifras
        cmps    u
        bne     bucle_despazamiento4cifras
        adda    #50
        ldx     #cuatro_cifras
        jsr     imprime_cadena
        