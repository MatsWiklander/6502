.const SCREEN_ADDR = $0400

BasicUpstart2(start)
    *=$1000 "Start"

start:          
                lda #<SCREEN_ADDR
                sta $fb
                lda #>SCREEN_ADDR
                sta $fc
                ldx #0
                ldy #0
column:         lda #81
                sta ($fb),y
                iny
                cpy #40
                bne column
                clc		
	            lda $fb
	            adc #40
	            sta $fb
                bcc ok
                inc $fc
                
ok:             ldy #0
                inx
                cpx #25
                bne column
done:           rts