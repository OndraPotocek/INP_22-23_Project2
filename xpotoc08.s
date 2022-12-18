; Autor reseni: Ondřej Potoček xpotoc08

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; DATA SEGMENT
                .data
login:          .asciiz "xpotoc08"  ; sem doplnte vas login
cipher:         .space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize "funkce" print_string)
;-r27-r11-r7-r18-r0-r4
; CODE SEGMENT
                .text

                ; ZDE NAHRADTE KOD VASIM RESENIM
main:
                daddi r7, r0, 0
                daddi r27, r0, 122
                daddi r11, r0, 97

loop:   
                lb r18, login(r7)
                slti r4, r18 ,97
                bne r4, r0, end 
                addi r18 ,r18, 16
                slti r4 ,r18, 122
                beq r4, r0, overflow
                sb r18, cipher(r7)
                addi r7, r7, 1
second:
                lb r18, login(r7)
                slti r4 ,r18, 97
                bne r4, r0, end
                addi r18, r18, -15
                slti r4, r18, 97
                bne r4, r0, underflow
                sb r18, cipher(r7)
                addi r7, r7, 1

                j loop

overflow:
                sub r18, r18, r27
                addi r18, r18, 96
                sb r18, cipher(r7)
                addi r7, r7, 1
                j second

underflow:
                sub r18, r18, r11
                addi r18, r18, 123
                sb r18, cipher(r7)
                addi r7, r7, 1
                j loop

end:
                daddi r4, r0, cipher
                jal print_string

                syscall 0   ; halt

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
