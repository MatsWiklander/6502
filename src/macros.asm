#import "registers.asm"
#import "variables.asm"
#import "common.asm"

#importonce
.macro WaitForAnyKey() {
                lda #$00
                sta $c6
wait:           lda $c6
                beq wait
}

.macro InitMultiColorBitMap() {
                lda CONTROL_REGISTER_1
                ora #$bf
                ora #$20
                sta CONTROL_REGISTER_1

                lda CONTROL_REGISTER_2
                ora #$10
                sta CONTROL_REGISTER_2
                
                lda #$18
                sta MEMORY_POINTERS
}

.macro ClearMultiColorBitMap(bitmap_ram, color) {
                FillColorRam(COLOR_RAM, color)
                lda #<bitmap_ram
                sta $fb
                lda #>bitmap_ram
                sta $fc
                ldx #$00
                ldy #$00
                lda #$ff

loop:           sta ($fb),y
                iny
                bne loop
                inc $fc
                inx
                cpx #$20
                bne loop
}

.macro ClearScreen(screen_ram) {
                lda #$20
                ldx #$fa
loop:           sta screen_ram, x
                sta screen_ram + 250, x
                sta screen_ram + 500, x
                sta screen_ram + 750, x
                dex
                bne loop
}

.macro CopyScreen(screen, screen_ram) {
                ldx #$fa
loop:           lda screen, x
                sta screen_ram, x
                lda screen + 250, x
                sta screen_ram + 250, x
                lda screen + 500, x
                sta screen_ram + 500, x
                lda screen + 750, x
                sta screen_ram + 750, x
                dex
                bne loop

                lda screen
                sta screen_ram
}

.macro FillColorRam(color_ram, color) {
                lda #color
                ldx #$fa      
loop:           sta color_ram, x
                sta color_ram + 250, x
                sta color_ram + 500, x
                sta color_ram + 750, x
                dex
                bne loop

                sta color_ram
}


.macro DisplayJoystick1() {
                lda joystick_1_dx 
                sta SCREEN_RAM
                lda joystick_1_dy
                sta SCREEN_RAM+1
                lda joystick_1_fire_button
                sta SCREEN_RAM+2
}

.macro DisplayJoystick2() {
                lda joystick_2_dx
                sta SCREEN_RAM+3
                lda joystick_2_dy
                sta SCREEN_RAM+4
                lda joystick_2_fire_button
                sta SCREEN_RAM+5
}

// Get input from port 1 only this routine reads and decodes the
// joystick/firebutton input data in the accumulator. this least significant 5
// bits contain the switch closure information. If a switch is closed then it
// produces a zero bit. If a switch is open then it produces a one bit. The
// joystick directions are right, left, forward, backward bit3=right, bit2=left,
// bit1=backward, bit0=forward and bit4=fire_button. At rts time dx and dy
// contain 2's compliment direction numbers i.e. $ff=-1, $00=0, $01=1. dx=1
// (move right), dx=-1 (move left), dx=0 (no x change). dy=-1 (move up screen),
// dy=0 (move down screen), dy=0 (no y change). The forward joystick position
// corresponds to move up the screen and the backward position to move down
// screen. At rts time the carry flag contains the fire_button state. If c=1
// then button not pressed. If c=0 then pressed.
.macro ReadJoystick(joystick, dx, dy, fire_button) {
                lda #0
                sta dx
                sta dy
                sta fire_button

djrr:           lda joystick      
djrrb:          ldy #0              
                ldx #0              
                lsr                 
                bcs djr0            
                dey                 
djr0:           lsr                 
                bcs djr1            
                iny                 
djr1:           lsr                 
                bcs djr2            
                dex                 
djr2:           lsr                 
                bcs djr3            
                inx                 
djr3:           lsr                 
                stx dx   
                sty dy   
                bcc fire
                rts     
fire:           lda #1
                sta fire_button
                rts
}