// Hello World program for the Vic 20
// Assembled with Kick Assembler
// Outputs "hello world" to the screen
//
// to assemble and run:
// 1) kickass HelloWorld.asm by pressing F1 or [ctrl]+p to open command pallet
// 2) Type "task run task" and click on "Run Task"
// 3) select the "KICK Build & Launch Emulator"
// 4) enjoy :)

// to start your own project
// 1) copy this folder and rename it
// 2) open the new folder in VSCode
// 3) rename the "helloWorld.code-workspace" file to match your folder name
// 4) rename the HelloWorld.asm file to start your own code
// 5) Start coding :)


.encoding "petscii_mixed"
        *= $1201 "Basic Upstart"
        BasicUpstart(start)    // 10 sys$04097

.const CHAROUT = $ffd2
*=$120d
start:
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
