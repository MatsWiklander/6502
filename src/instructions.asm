#import "registers.asm"
#import "macros.asm"
#import "colors.asm"

#importonce

display_instructions: {
                lda #BLACK
                sta BORDER_COLOR
                sta BACKGROUND_COLOR_0

                CopyScreen(instructions, SCREEN_RAM)

                FillColorRam(COLOR_RAM, WHITE)
                
                WaitForAnyKey()

                rts
}

instructions: {
    .text "         ---=== the game ===---         "
    .text "                                        "
    .text "lorem ipsum dolor sit amet, consectetur "
    .text "adipiscing elit. nulla porttitor eros   "
    .text "non nisl ullamcorper pharetra.          "
    .text "                                        "
    .text "pellentesque felis ligula, pellentesque "
    .text "vitae congue ut, rhoncus ac mi. nunc    "
    .text "aliquet elit non lacus egestas, eu      "
    .text "placerat ipsum aliquet.                 "
    .text "                                        "
    .text "sed scelerisque lorem ut ipsum pretium, "
    .text "aliquet euismod dui rutrum. mauris      "
    .text "consequat augue nisi, sed facilisis     "
    .text "lorem suscipit ac. vivamus rhoncus      "
    .text "nibh ante, et tempus tellus luctus sit  "
    .text "amet.                                   "
    .text "                                        "
    .text "sed lacinia diam nisi, vel condimentum  "
    .text "ex tempus ac. nunc a leo.               "
    .text "                                        "
    .text "                                        "
    .text "                                        "
    .text "                                        "
    .text "               press any key to continue"
}