#import "registers.asm"
#import "macros.asm"
#import "colors.asm"

#importonce

display_splash: {
                InitMultiColorBitMap()

                ClearMultiColorBitMap(BITMAP_RAM, BLACK)
                
                WaitForAnyKey()

                rts
}