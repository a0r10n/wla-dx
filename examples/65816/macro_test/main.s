
.memorymap
	slotsize $8000
	defaultslot 1
	slot 0 $0000
	slot 1 $8000
.endme                    

.lorom

.rombanksize $8000
.rombanks 3

.DEF prev_term $0000

.MACRO .term ARGS str
__\._\@:
        .WORD  prev_term
        .REDEF prev_term CADDR - 2
        .BYTE  str.length, str, 0
.ENDM

.DEF prev_test $0000
	
.MACRO .test ARGS str
__\._\@+1:
	.PRINT __\._\@+1, "\n"
        .WORD  prev_test
        .REDEF prev_test __\._\@+1
        .BYTE  str.length, str, 0
.ENDM

.MACRO .storager
        .DB \@, \@+1, 1+\@+1, \@-1
.ENDM
	
.bank 0 slot 1
.section "Bank0" force returnorg
main:
	.db "01>"
        .term "YES"
	.db "<01"

	.db "02>"
	.term "NO"
	.db "<02"
	
	.db "03>"
	.term "HELLO"
	.db "<03"

	.db "04>"
        .test "JA"
	.db "<04"

	.db "05>"
	.test "NEIN"
	.db "<05"
	
	.db "06>"
	.test "HALLO"
	.db "<06"

	.db "07>"
	.storager
	.db "<07"

MIDDLE1 = 1+2+3
MIDDLE2= 1+1+1
        MIDDLE3 = 1+2
MIDDLE4 =1+1-1
MIDDLE5=2+1+1
        MIDDLE6=1+1
        MIDDLE7= 1+1
        MIDDLE8 =1+1

	.db "08>"
	.db MIDDLE1+ 1, 1 + MIDDLE2 + 1, MIDDLE3+ 1, 2+ MIDDLE4 +1, 3+MIDDLE5+1
	.db 1+MIDDLE6+1, 2+ MIDDLE7+ 2, 3 +MIDDLE8 +3
	.db "<08"
.ends