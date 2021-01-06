#import "vic_ii.asm"

BasicUpstart2(start)
    *=$1000 "Start"

start:  lda #$03
        sta SPRITE_ENABLED
        lda #$c0
        sta $07f8
        lda #$c1
        sta $07f9
        lda #$01
        sta SPRITE_COLOR_0
        lda #$00
        sta SPRITE_COLOR_1
        lda #$20
        sta X_COORD_SPRITE_0
        sta Y_COORD_SPRITE_0
        lda #$38
        sta X_COORD_SPRITE_1
        lda #$20
        sta Y_COORD_SPRITE_1

wait:   lda RASTER_COUNTER
        cmp #$fb
        bne wait
        inc Y_COORD_SPRITE_0
        inc Y_COORD_SPRITE_1
        jmp wait
        rts

// sprite 0 / singlecolor / color: $01
*=$3000
sprite_0:
    .byte $00,$00,$00,$77,$00,$ee,$55,$00
    .byte $aa,$77,$00,$ee,$00,$00,$00,$70
    .byte $00,$0e,$50,$00,$0a,$70,$00,$0e
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$70
    .byte $00,$0e,$50,$00,$0a,$70,$00,$0e
    .byte $00,$00,$00,$77,$00,$ee,$55,$00
    .byte $aa,$77,$00,$ee,$00,$00,$00,$01
sprite_1:
    .byte $00,$00,$00,$77,$00,$ee,$55,$00
    .byte $aa,$77,$00,$ef,$00,$00,$00,$70
    .byte $00,$0e,$50,$00,$0a,$70,$00,$0e
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$70
    .byte $00,$0e,$50,$00,$0a,$70,$00,$0e
    .byte $00,$00,$00,$77,$00,$ee,$55,$00
    .byte $aa,$77,$00,$ee,$00,$00,$00,$01
