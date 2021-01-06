.const SCREEN_ADDR = $0400
.const COLUMNS = 40
.const ROWS = 25

BasicUpstart2(start)
    *=$1000 "Start"

start:
                lda #$ff            // Maximum frequency value
                sta $d40e           // Voice 3 frequency low byte
                sta $d40f           // Voice 3 frequency high byte
                lda #$80            // Noise waveform, gate bit off
                sta $d412           // Voice 3 control register
loop:           lda $d012           // Wait for raster line $ff
                cmp #$ff
                bne loop
                lda #<SCREEN_ADDR   // Load screen low-byte of 
                sta $fb             // screen address into ZP
                lda #>SCREEN_ADDR   // Load screen hi-byte of 
                sta $fc             // screen address into ZP
                ldx #0              // Screen row 0
                ldy #1              // Screen column 1
column:         lda ($fb),y         // Load character from source
                dey                 // "Jump" one back
                sta ($fb),y         // Store character to destination
                iny                 // "Jump" two forward
                iny
                cpy #COLUMNS
                bne column          // Lather, rince and repeat
                lda $d41b           // Load new character from LFSR
                lsr                 // Divide it by 4 to make it usable
                ldy #(COLUMNS-1)
                sta ($fb),y
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
                jmp start
done:           rts