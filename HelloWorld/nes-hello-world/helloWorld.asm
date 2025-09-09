	// Hello, World!
	// by Thomas Wesley Scott, 2023
	// Code starts at $C000.
	// org jump to $BFFO for header info

	* = $BFF0		// This command just tells
				// compiler to start at $BFF0
				// (where the header starts)

	// This is a run of the mill NES cartridge header.
	// Without this, your code won't work!
	// For now, always include this header exactly like
	// this.
	.text "NES"
	.byte $1a		// Default NES header info
	.byte $1			// Number of PRG-ROM pages
	.byte $1			// Number of CHR-ROM pages
	.byte %00000000		// Mapper and other info.
	.byte %00000000		// More mapper/other info.
	.byte 0			// Number of Ram pages
	.byte 0,0,0,0,0,0,0	// Unused 7 bytes

// The nmihandler is basically the code that runs
// every time the screen refreshes, which happens
// about 60 times a second.
nmihandler:
	lda #$02 	// Transfer sprite data from
	sta $4014	// from $0200 to DMA
	rti		// return from interrupt

// The irqhandler is the code that runs every
// time some NES hardware interrupts your code.
// I've used the "sei" command to disable every
// interrupt (except the screen/NMI above), so
// this can just be left mostly blank.
irqhandler:
	rti


// startgame is code that runs everytime the game 
// is turned on or reset. We're basically starting
// by "zeroing out" any data that lingered here
// after a reset. This also gives us some time 
// for the NES to load up properly before it 
// can accept/use graphics.

startgame:
	sei			// Disable interrupts
	cld			// Clear decimal mode

	ldx #$ff	
	txs			// Set-up stack
	inx			// x is now 0
	stx $2000		// Disable/reset graphic options 
	stx $2001		// Make sure screen is off
	stx $4015		// Disable sound
	stx $4010		// Disable DMC (sound samples)
	lda #$40
	sta $4017		// Disable sound IRQ
	lda #0	
waitvblank:
	bit $2002		// check PPU Status to see if
	bpl waitvblank		// vblank has occurred.
	lda #0
clearmemory:			// Clear all memory info
	sta $0000,x 		// from $0000-$07FF
	sta $0100,x
	sta $0300,x
	sta $0400,x
	sta $0500,x
	sta $0600,x
	sta $0700,x
	lda #$FF
	sta $0200,x		// Load $FF into $0200-$02FF 
	lda #$00		// to hide sprites 
	inx			// x goes to 1, 2... 255
	cpx #$00		// loop ends after 256 times,
	bne clearmemory 	// clearing all memory
		



waitvblank2:
	bit $2002		// Check PPU Status one more time
	bpl waitvblank2		// before we start loading in graphics

	lda $2002		// Read PPU status to reset high-low latch
	ldx #$3F		// Load high byte of $3F00 into $2006
	stx $2006
	ldx #$00		// Load low byte of $3F00 into $2006
	stx $2006
copypalloop:			// Start storing palette info
	lda initial_palette,x	
	sta $2007
	inx
	cpx #4			// loop 4 times
	beq copypalloop

	lda #$02		// Store sprite info 
	sta $4014		// into OAM DMA


// Loop to load sprites onto screen
	ldx #$00
spriteload:
	lda hello,x		// Loads one of four values into $0200,x:
	sta $0200,x 		// x-value, tile #, flip options, y-value
	inx
	cpx #$2C		// Loop 44 times (11 tiles with 4 attributes each)
	bne spriteload

	lda #%10010000		// Enable NMI on vblank, and use
	sta $2000		// $1000 as background tile address

	lda #%00011110		// Turn on sprites, background,
	sta $2001		// and clipping for both

// Necessary loop to keep program running
forever:
	jmp forever


// This is the only palette for this tutorial.
// Each byte is one colour.
initial_palette:
	.byte $1F,$21,$33,$30


// This is the data for our sprite placement.
// The first byte on each line is the y-coordinate.
// The second byte is the tile # in memory.
// The third byte is for flipping tiles.
// The fourth byte is the x-coordinate.

hello:
	.byte $6c, $00, $00, $3d // H
	.byte $6c, $01, $00, $46 // E
	.byte $6c, $02, $00, $4f // L
	.byte $6c, $02, $00, $58 // L
	.byte $6c, $03, $00, $61 // O

	.byte $75, $04, $00, $3d // W
	.byte $75, $03, $00, $46 // O
	.byte $75, $05, $00, $4f // R
	.byte $75, $02, $00, $58 // L
	.byte $75, $06, $00, $62 // D
	.byte $75, $07, $00, $6b // !

// This is the footer for our program.
// It is where we define (in order):
// - our nmihandler (what we do during vblank)
// - our reset (here it's called startgame)
// - our irqhandler (for handling interrupts)
// We have disabled our irqhandler, but all
// three are always included in our programs.
	* = $FFFA
	.word nmihandler
	.word startgame
	.word irqhandler

// After your footer, you include your
// tile data, which gets stored in CHR-ROM.
// You can include a file containing this
// data, so the code is a bit cleaner,
// but I've included it here so you can see
// the actual letters for yourself.

chr_rom_start:

	.byte %11000011	// H (00)
	.byte %11000011
	.byte %11000011
	.byte %11111111
	.byte %11111111
	.byte %11000011
	.byte %11000011
	.byte %11000011
	.byte $00, $00, $00, $00, $00, $00, $00, $00

	.byte %11111111	// E (01)
	.byte %11111111
	.byte %11000000
	.byte %11111100
	.byte %11111100
	.byte %11000000
	.byte %11111111
	.byte %11111111
	.byte $00, $00, $00, $00, $00, $00, $00, $00

	.byte %11000000	// L (02)
	.byte %11000000
	.byte %11000000
	.byte %11000000
	.byte %11000000
	.byte %11000000
	.byte %11111111
	.byte %11111111
	.byte $00, $00, $00, $00, $00, $00, $00, $00

	.byte %01111110	// O (03)
	.byte %11100111
	.byte %11000011
	.byte %11000011
	.byte %11000011
	.byte %11000011
	.byte %11100111
	.byte %01111110
	.byte $00, $00, $00, $00, $00, $00, $00, $00

	.byte %11000011	// W (04)
	.byte %11000011
	.byte %11000011
	.byte %11000011
	.byte %11011011
	.byte %11011011
	.byte %11100111
	.byte %01000010
	.byte $00, $00, $00, $00, $00, $00, $00, $00

	.byte %01111110	// R (05)
	.byte %11100111
	.byte %11000011
	.byte %11000011
	.byte %11111100
	.byte %11001100
	.byte %11000110
	.byte %11000011
	.byte $00, $00, $00, $00, $00, $00, $00, $00

	.byte %11110000	// D (06)
	.byte %11001110
	.byte %11000010
	.byte %11000011
	.byte %11000011
	.byte %11000010
	.byte %11001110
	.byte %11110000
	.byte $00, $00, $00, $00, $00, $00, $00, $00

	.byte %00011000	// ! (07)
	.byte %00011000
	.byte %00011000
	.byte %00011000
	.byte %00011000
	.byte %00000000
	.byte %00011000
	.byte %00011000
	.byte $00, $00, $00, $00, $00, $00, $00, $00



// Lastly, if we have less than 512 tiles
// we need to "pad" our rom to give it
// the correct file size.
// If you ever have issues with your .nes
// file, this might be it! (Best to leave
// this line of code in just to be safe,
// since it guarantees the correct size of
// ROM data.)

chr_rom_end:
	.fill 8192-(chr_rom_end -chr_rom_start),$00

