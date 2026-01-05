
Cursor_X equ $40	
Cursor_Y equ $41
	
	ifdef BuildA80		;Atari 800 settings
GTIA equ $D000			;GTIA address
ChrAddrH equ $E0    	;Font at $E000
	org     $A000       ;Start of cartridge area
	
	else				;Atari 5200 settings
GTIA equ $C000			;GTIA address
ChrAddrH equ $F8    	;Font at $F800	
	org     $4000       ;Start of cartridge area	
	endif
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	INIT

ProgramStart:        
	sei                 ;Disable interrupts

	
    ldx #$00
    txa
ClearLoop    
    sta $00,x           ;Clear zero page
    sta GTIA,x          ;Clear GTIA
    dex
    bne ClearLoop
		
	
	
	
	lda #<DisplayList
	sta $D402 			;DLISTL - Display list lo
	lda #>DisplayList
	sta $D403 			;DLISTH - Display list hi
	
	lda #ChrAddrH		
	sta $D409 			;CHBASE - Character set base
	
	lda #%00100010   	
	sta $D400 			;DMACTL - DMA Control (screen on)


	lda #$0F      	  	;Set color PF1 (foreground)
	sta GTIA+ $17 		;COLPF1 equ 
	
	lda #$00       	 	;Set color PF2 (background)
	sta GTIA+ $18		;COLPF2 

	lda #0
	sta Cursor_X
	sta Cursor_y
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Your Code Goes Here		
	
	;Load in the address of the Message into the zero page
	lda #>HelloWorld
	sta $21				;H Byte
	lda #<HelloWorld
	sta $20				;L Byte
		
	
	jsr PrintStr		;Show to the screen
	
	jmp *

HelloWorld:				;255 terminated string
	db "Hello World!",255

PrintChar:
	sta $24				;Character to show
	txa
	pha
		lda #0			;Zero High byte (Use A as Low)
		sta $23
		
		lda Cursor_Y	
		;Y* 40 = 		%00101000	(Y*8 + Y*32)
		asl				;00000001
		rol $23			;00000010	*2
		asl
		rol $23			;00000100	*4
		asl
		rol $23			;00001000	*8
		sta $22
		
		lda $23			;Back up Y*8 for later
		sta $25
		
		lda $22			;00001000
		asl
		rol $23			;00010000	*16
		asl
		rol $23			;00100000	*32
		
		clc
		adc Cursor_X	;Add Xpos
		adc $22
		sta $22
		
		lda $23			;Get Y*32
		adc $25			;Add Y*8... Result=Y*40
		
		ora #$18		;Screen Base at $1800
		sta $23
	
	
		lda $24			;Get back Character to show
		cmp #96			;Check if character >96
		bcs	PrintCharOK
		sec
		sbc #$20		;Fix Uppercase
PrintCharOK:	
		ldx #0
		sta ($22,x) 	;Store in video memory
		
		inc Cursor_X	;Inc Xpos
		lda Cursor_X
		
		cmp #40			;Screen is 40 chars wide
		bne PrintChar_NotNextLine
		jsr NewLine
PrintChar_NotNextLine:	
	pla
	tax
	rts
	
NewLine:
	lda #0
	sta Cursor_X		;Reset X
	inc Cursor_Y		;Inc Y
	rts

				

PrintStr:
	ldy #0				;Set Y to zero
PrintStr_again:
	lda ($20),y			;Load a character from addr in $20+Y 
	
	cmp #255			;If we got 255, we're done
	beq PrintStr_Done
	
	jsr PrintChar		;Print Character
	iny					;Inc Y and repeat
	jmp PrintStr_again
PrintStr_Done:
	rts	

	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Display List
  
    org $b000
	
Smode equ 2
DisplayList:				;Display list data
	db $70,$70,$70;$70 7= 8 blank lines 0= blank lines
	db $40+2				;$40+2
	
	dw $1800				;Screen starts at &1800
		
	db $02,$02,$02,$02,$02,$02 ;Screen mode (2) lines
	db $02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02
		
	db $41					;Loop
	dw DisplayList
		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Rom Header
        org $bffd
        db $FF         ;Disable Atari Logo
        dw ProgramStart;program Start
		
		
		