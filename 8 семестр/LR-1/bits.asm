$NOMOD51
$INCLUDE (8051.MCU)

Q BIT P3.2

Wq BIT P0.0 ; 22h.0 P0.0
Vq BIT P1.3
Xq BIT P0.2 ; 28h.2 P0.2
Zq BIT P2.5
Aq BIT P0.5 ; 28h.5 P0.5
Gq BIT P1.0 ; 25h.0 P1.0
Uq BIT P0.3 ; 20h.3 P0.3
Bq BIT P0.4 ; 21h.4 P0.4
F1 BIT 21h.5

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      org   0000h
      jmp   Start

;====================================================================
; CODE SEGMENT
;====================================================================

      org   0100h

Start:	
      ; Q = (W * V + X * /Z) + (A + G)*(U + B)

      MOV C, Wq
      ANL C, Vq
      MOV F0, C

      MOV C, Xq
      ANL C, /Zq
      ORL C, F0
      MOV F0, C

      MOV C, Aq
      ORL C, Gq
      MOV F1, C
      MOV C, Uq
      ORL C, Bq
      ANL C, F1
      ORL C, F0
      CPL C
      MOV Q, C
Loop:

      END
