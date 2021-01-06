#import "registers.asm"
#import "variables.asm"
#import "macros.asm"

#importonce

read_joystick_1: {
                ReadJoystick(JOYSTICK_1, joystick_1_dx, joystick_1_dy, joystick_1_fire_button)
}

read_joystick_2: {
                ReadJoystick(JOYSTICK_2, joystick_2_dx, joystick_2_dy, joystick_2_fire_button)
}
