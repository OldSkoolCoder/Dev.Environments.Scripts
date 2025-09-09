// Hello World program for the C64
// Assembled with Kick Assembler
// Outputs "hello world" to the screen
//
// to assemble and run:
// 1) kickass HelloWorld.asm by pressing F6
// 4) enjoy :)

// to start your own project
// 1) copy this folder and rename it
// 2) open the new folder in VSCode
// 3) rename the "helloWorld.code-workspace" file to match your folder name
// 4) rename the HelloWorld.asm file to start your own code
// 5) Start coding :)


BasicUpstart2(Start)
.encoding "petscii_mixed"

.const CHAROUT = $ffd2
Start:
        ldx #$00
    Loop:
            lda Hello,x
            beq Done
            jsr CHAROUT     // print using CHAROUT
            inx
            jmp Loop
Done:            
        rts

Hello:
    .byte $93               // Clear screen
    .text "hello world"     // Text to print
    .byte $0d, $00          // End of text 
