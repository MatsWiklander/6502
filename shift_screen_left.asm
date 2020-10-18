.const SCREEN_ADDR = $0400
.const COLUMNS = 40
.const ROWS = 25

BasicUpstart2(start)
    *=$1000 "Start"

start:
                lda $d012
                bne start
                inc $d020
                lda #<SCREEN_ADDR
                sta $fb
                lda #>SCREEN_ADDR
                sta $fc
                ldx #0
                ldy #1
column:         lda ($fb),y
                dey
                sta ($fb),y
                iny
                iny
                cpy #COLUMNS
                bne column
                clc		
	            lda $fb
	            adc #COLUMNS
	            sta $fb
                bcc ok
                inc $fc      
ok:             ldy #1
                inx
                cpx #ROWS
                bne column
                dec $d020
                jmp start
done:           rts