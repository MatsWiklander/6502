#import "registers.asm"
#import "variables.asm"
#import "macros.asm"
#import "instructions.asm"
#import "splash.asm"
#import "joystick.asm"

BasicUpstart2(start)
    *=$1000 "Start"

start:          jsr display_instructions
                // jsr display_splash
                ClearScreen(SCREEN_RAM)
                jsr game_loop
                rts

game_loop: {
loop:           jsr handle_input
                jsr game_logic
                jsr handle_output                
                jmp loop
}

handle_input: {
                jsr read_joystick_1
                jsr read_joystick_2
                rts
}

game_logic: {
                rts
}

handle_output: {
wait:           lda #$fb
                cmp RASTER_COUNTER
                bne wait
                DisplayJoystick1()
                DisplayJoystick2()
                rts
}