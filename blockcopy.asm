.const SRC_ADDR = $0400
.const DST_ADDR = $0500
.const PAGES = 2

BasicUpstart2(start)
    *=$1000 "Start"
start:          lda #<SRC_ADDR      // Store Source Address for 
                sta $fb             // block copy in ZP
                lda #>SRC_ADDR
                sta $fc
                lda #<DST_ADDR      // Store Destination Address
                sta $fd             // for block copy in ZP
                lda #>DST_ADDR
                sta $fe
                ldy #0
                ldx PAGES+1         // Load page count
                beq copyfragment    // Do we only have a fragment?
copypage:       lda ($fb),y         // Move one byte in page transfer
                sta ($fd),y
                iny                 // and repeat for the rest of the
                bne copypage        // page
                inc $fc             // Then increase the SRC and DST
                inc $fe             // addresses by a page
                dex                 // and repeat while there are more
                bne copypage        // pages to move
copyfragment:   cpy PAGES+0
                beq done
                lda ($fb),y
                sta ($fd),y
                iny
                bne copyfragment
done:           rts


// _movfwd	        ldy #0		;initialise the index
// 	            ldx len+1	;load the page count
// 	            beq _frag	;... do we only have a fragment?
// _page 	        lda (src),y	;move a byte in a page transfer
// 	            sta (dst),y
// 	            iny		;and repeat for the rest of the
// 	            bne _page	;... page
// 	inc src+1	;then bump the src and dst addresses
// 	inc dst+1	;... by a page
// 	dex		;and repeat while there are more
// 	bne _page	;... pages to move
// _frag	cpy len+0	;then while the index has not reached
// 	beq _done	;... the limit
// 	lda (src),y	;move a fragment byte
// 	sta (dst),y
// 	iny		;bump the index and repeat
// 	bne _frag\?
// _done 	equ *		;all done                