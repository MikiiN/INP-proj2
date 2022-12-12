; Autor reseni: Michal Žatečka xzatec02

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; r1-r5-r24-r25-r0-r4
; DATA SEGMENT
                .data
login:          .asciiz "xzatec02"  ; sem doplnte vas login
z:             .byte 122
a:             .byte 97
cipher:         .space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize "funkce" print_string)

; CODE SEGMENT
                .text

                ; ZDE NAHRADTE KOD VASIM RESENIM
main:
    loop:
                        lb      r1, login(r5)
                        addi    r25, r1, -97
                        bgez    r25, skip_end1
                        b       end
        skip_end1:
                        lb	    r25, z(r0)
                        addi    r25, r25, -96
                        add     r1, r1, r25
                        addi    r25, r1, -122
                        bgez    r25, corection1 
        corection_back1:
                        sb      r1, cipher(r5)
                        b		second
        corection1:
                        addi r1, r1, -26
                        b corection_back1
        second:
                        addi	r5, r5, 1 
                        lb      r1, login(r5)
                        addi    r25, r1, -97
                        bgez    r25, skip_end2
                        b       end
        skip_end2:
                        lb      r25, a(r0)
                        addi    r25, r25, -98
                        add     r1, r1, r25
                        addi    r25, r1, -97
                        bgez    r25, corection_skip2 
                        addi    r1, r1, 26
        corection_skip2:
                        sb      r1, cipher(r5)
                        addi    r5, r5, 1              
                b loop
end:
                daddi   r4, r0, cipher   ; vozrovy vypis: adresa login: do r4
                jal     print_string    ; vypis pomoci print_string - viz nize


                syscall 0   ; halt

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
