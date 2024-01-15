$NOMOD51
$INCLUDE (8051.MCU)

Q DATA P3 ; P3.2

Wq DATA P0 ; 22h.0 P0.0
Vq DATA P1 ; P1.3
Xq DATA P0 ; 28h.2 P0.2
Zq DATA P2 ; P2.5
Aq DATA P0 ; 28h.5 P0.5
Gq DATA P1 ; 25h.0 P1.0
Uq DATA P0 ; 20h.3 P0.3
Bq DATA P0 ; 21h.4 P0.4

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

START:
      ; Q = (W * V + X * /Z) + (A + G)*(U + B)

      MOV A, Wq
      ANL A, #00000001B ; W = P0.0
      JNZ TEST_V
      JMP TEST_X

TEST_V:
      MOV A, Vq
      ANL A, #00001000B ; V = P1.3
      JNZ SET_Q
      JMP TEST_X

TEST_X:
      MOV A, Xq
      ANL A, #00000100B ; X = P0.2
      JNZ TEST_Z
      JMP TEST_A

TEST_Z:
      MOV A, Zq
      ANL A, #00100000B; Z = P2.5
      JZ SET_Q
      JMP TEST_A

TEST_A:
      MOV A, Aq
      ANL A, #00100000B ; A = P0.5
      JNZ TEST_U
      JMP TEST_G

TEST_G:
      MOV A, Gq
      ANL A, #00000001B ; G = P1.0
      JNZ TEST_U
      JMP CLR_Q

TEST_U:
      MOV A, Uq
      ANL A, #00001000B ; U = P0.3
      JNZ SET_Q
      JMP TEST_B

TEST_B:
      MOV A, Bq
      ANL A, #00010000B ; B = P0.4
      JNZ SET_Q
      JMP CLR_Q

CLR_Q:
      SETB Q.2
      JMP START

SET_Q:
      CLR Q.2
      JMP START

END
