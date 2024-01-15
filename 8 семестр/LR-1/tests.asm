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

      JB Wq, TEST_V
      JMP TEST_X

TEST_V:
      JB Vq, SET_Q
      JMP TEST_X

TEST_X:
      JB Xq, TEST_Z
      JMP TEST_A

TEST_Z:
      JNB Zq, SET_Q
      JMP TEST_A

TEST_A:
      JB Aq, TEST_U
      JMP TEST_G

TEST_G:
      JB Gq, TEST_U
      JMP CLR_Q

TEST_U:
      JB Uq, SET_Q
      JMP TEST_B

TEST_B:
      JB Bq, SET_Q
      JMP CLR_Q

CLR_Q:
      SETB Q
      JMP START

SET_Q:
      CLR Q
      JMP START

END
