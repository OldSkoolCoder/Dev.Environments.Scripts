// Hello World program for the BBC Micro
// Assembled with Kick Assembler
// Outputs "hello world" to the screen
//
// to assemble and run:
// 1) kickass HelloWorld.asm by pressing F1 or [ctrl]+p to open command pallet
// 2) Type "task run task" and click on "Run Task"
// 3) select the "ICK Build & Launch BBC Emulator"
// 4) enjoy :)

// to start your own project
// 1) copy this folder and rename it
// 2) open the new folder in VSCode
// 3) rename the "helloWorld.code-workspace" file to match your folder name
// 4) rename the HelloWorld.asm file to start your own code
// 5) Start coding :)


.encoding "ascii" 
 
.const OSASCI = $ffe3

* = $1900

Start:
        ldx #$00
    Loop:
            lda Hello,x
            beq Done
            jsr OSASCI     // print using CHAROUT equivelant
            inx
            jmp Loop
Done:            
        rts

Hello:
    .text "hello world"     // Text to print
    .byte $0d, $00          // End of text 