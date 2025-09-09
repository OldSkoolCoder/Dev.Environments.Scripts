# nes-hello-world

<h1>"Hello World!"</h1>

Have you ever wanted to code for the NES, but you didn't know how? Do you want 8-bit programming knowledge, but instead you're stuck with 16 bits of fear? (That's trying to be a joke.) Want to write the next Super Mario Bros.? Your journey begins here! This is my version of "Hello, World" for the NES, and I offer the code to you as an opportunity to begin learning to program for the NES/ASM 6502.

<h2>ASM 6502? What's that?</h2>
ASM 6502 is the assembly language used to program on the NES. If you've never programmed in an assembly language before, it can be a bit difficult at first, but with a bit of time and patience you can learn it, just like any other language.

I've added a lot of comments to the code (most of the code is commented), so this should help you as far as understanding what's going on with each line of the program, but you will of course need to learn the ASM6502 language. To do that, you'll need some kind of reference. My recommendation at this point would be to use ChibiAkumas' great "cheat sheet", which is downloadable for free here: https://www.chibiakumas.com/book/CheatSheetCollection.pdf (I also recommend his book on learning ASM6502, and suggest you use it to learn the commands while you're away from the computer... you can find it here:
https://www.amazon.ca/gp/product/B0BKMS6752
It's a great book for study time away from the computer, too!)

<h1> How to Compile "helloworld.asm" </h1>
If you're looking to compile the code, you'll need to use the VASM compiler. You can get it here: http://www.compilers.de/vasm.html . It's a great compiler that can be used for a variety of systems, and it was made by Dr. Volker Barthelmann. Check it out! To compile simply use: <pre>
<code>vasm6502_oldstyle.exe DIR/helloworld.asm -chklabels -nocase -Fbin -o "DIR2/helloworld.nes"</code> </pre>
where DIR and DIR2 are the paths/directories for the source file and target file, respectively. (If you have the win32 version of vasm, you may need to use vasm_oldstyle_win32.exe instead). I have not compiled this in either linux or on a Mac, so there may be differences, but the documentation on VASM should be able to shed some light on any changes that might exist.

<h1>Differences in Compilers</h1>
A lot of NES programmers use a different compiler than VASM, ca65 (which is a companion assembler to the cc65 crosscompiler). As a consequence, their code will look a little different than what you see here; in particular, the layout of where all of the code is placed will be different. For the sake of learning the code from this tutorial, I would recommend you just focus on using VASM and following my code. Don't worry about anything to do with different compilers, or variations in code for the time being. At first I found the differences between the two a bit confusing, but I found that once I understood the basic code and its layout using the VASM compiler, reading code for the ca65 was nearly effortless. I'm confident the same will happen for you! For now just focus on learning with VASM and you can always make the switch later if necessary. 


<h1>How to Run "helloworld.nes"</h1>
Assuming you've successfully followed the steps to compile above, you should now have an .nes file, "helloworld.nes". This file can be run in any NES (Nintendo Entertainment System) emulator. I tend to use Nestopia, but other NES developers really seem to enjoy FCEUX, so use whichever emulator you'd like!

<h1>How to Use (and Learn From) "helloworld.asm"</h1>
"Hello World!" in Python is 1 line of code. <br/>
In C++, it's 4 or 5 lines. <br/>
In ASM 6502? <br/>
Well... including spaces and comments we're clocking in at around 250 lines of code. Yikes! 
But fear not! While there is much to learn, if you take it step by step, you'll see it's not so bad. I've taken great pains to comment just about every line of code in this sample program, so you should at least have an easier time figuring it out. Let me give you some other tips, too, to make learning ASM6502 programming easier.

<h2>General Layout of an NES Program</h2>
The general layout for NES code is as follows:
<ol>
  <li>Header</li>
  <li>Labels (e.g. someLabel equ $01)</li>
  <li>NMI, IrqHandler, Program Reset/Initialization</li>
  <li>Game Loop</li>
  <li>Data/Lookup Tables/Functions</li>
  <li>Footer</li>
  <li>Tile Data</li>
</ol>

Let's go over these sections in more detail.

<h2>The Header</h2>
These are all labeled pretty clearly in the program, and all are necessary for a functioning NES cartridge. The Header (the part with "db "NES",$1A", etc.) is included in every NES program, and while changes can be made to some parts of the header, in the beginning I would recommend leaving it as is. As with all parts of the code, you can learn the specifics of what each line does, and try modifying them later as you see fit.
<h2>Labels</h2>
In this particular program there are no labels... but if there were, they'd look something like this:<pre>
  <code>playerHealth equ $27  ; playerHealth can be used instead of writing $27</code>
</pre>
This can be handy when you plan on always storing the same information at the same address, because it's a lot easier to remember <i>playerHealth</i> than $27! Labels are a lot like variables, so you can think of them like that if you'd like, just keep in mind the following things: 
<ol>
  <li>1) #playerHealth gives you the number $27, but playerHealth gives you the value stored at $27. I often mix the two up... in fact, I'm tempted to go double-check right now, just to make sure I got it right... yep, we're good. (*Phew*) </li>
</ol>
<h2>NMI, IrqHandler, Program Reset/Initialization</h2>
... so we move on to NMI, IrqHandler, and Program Reset/Initialization. They're all marked and explained fairly clearly in the program, so there shouldn't be too much confusion. Everything in the "NMI" section is what happens when the screen refreshes (which happens about 50 or 60 times a second, depending on whether you have an NTSC(60) or PAL(50) NES). 

The IrqHandler section is what happens during a system hardware interrupt, but we've disabled all of that (except for the screen refresh, AKA the NMI - the <strong>Non-Maskable Interrupt</strong>).

Again, these are all essential parts of the program, and you must include them.

<h2>The Game Loop </h2>
This is an interesting part of the game's program. The game loop is necessary because, if there were no loop, the game code would run once and be done! (Which probably wouldn't make for a very fun game, in most cases.) So the question is, what code do we find here? In the case of this particular program, there's basically nothing but the loop itself. Why, you might ask? It's a simple enough program that only needs the loop to keep the game from ending/crashing.

Some game developers would apparently put most of their code in the NMI (I'm told Konami is one such company), whereas others would make use of the game loop to put their code. This is all a bit above the scope of this tutorial, but if you're interested in reading more, you can learn more about it here:
https://www.nesdev.org/wiki/NMI_thread, and 
https://www.nesdev.org/wiki/The_frame_and_NMIs

<h2>Data, Lookup Tables, and Functions</h2>
This is where we store data for things like the order of background tiles, or the placement of sprites (NOTE: not the tile "blueprints" i.e. the design for the tiles, that comes later!), or any useful information that we might to look up (hence the name "look up table" or LAT). You'll see here I've put my data for the sprites for hello world, here. In fact, each group of 4 pairs of hexidecimal numbers gives (in this order): the y-coordinate, the tile-number, special attributes (none in this case), and the x-coordinates of each tile. I think I've marked it clearly enough in the program, but this can be a fun part of the program to modify if you're just looking to get your feet wet, so to speak. Modify the first number in any row, and you'll find the letters are in a different row. Modify the last value, and their x-coordinate will change. The 2nd value modifies which tile it is (so you could spell something entirely different), and the third attribute... well, it's a little more complicated, so perhaps we'll leave it for now (or if you're curious, you can read about it on nesdev's wiki here:
https://www.nesdev.org/wiki/PPU_OAM

As for functions, well, technically you can include them anywhere - the order of your code mostly doesn't matter as long as the control flow of your program works. If you've got the appropriate jmps, jsrs and whatnot, you should be fine (if I'm being honest, looking over my code I can see some spots where maybe a little more organization might improve its readability!)

<h2>Footer</h2>
This is another one of those sections where the code is simply necessary, and you probably shouldn't change it. Here we choose our names for:
<ul>
<li>our NMI (non-maskable interrupt AKA the screen refresh),</li>
<li>our reset (the code that runs on loading/resetting the game),</li>
<li>and our IRQ (other interrupts)</li>  
</ul>
Make sure you give names to all of these sections, and that you actually have code in all of these sections (you'll note my "irqhandler" - the section for my irq - has only an "rti" command, which is all you really need if you disable interrupts.. in fact, you may not even need that... I've never tested it without!)

<h2>Tile Data</h2>
Here is where we have our tile data (obviously). We have two bitplanes for each tile (basically two 8x8 grids of 0s and 1s AKA binary)... which describe what colour to use for each tile. Any tile can have up to 3 colours (4 if you include the background). Here's how the colour number is determined:
<ul>
<li>A zero in both grids means it's colour 0 (background)</li>
<li>A 1 in bitplane 1 (and zero in bitplane2) gives us colour 1</li>
<li>A 1 in bitplane 2 gives us colour 2</li>
<li>A 1 in both bitplanes gives us colour 3</li>
</ul>   
(Also if you look really closely at my code, you should be able to make out the simpler tiles, such as the letters and numbers.)

An excellent (but not too difficult) exercise would be to change the tiles from "Hello World!" to something different, like "Hello [your name here]!" Can you see how you might do this?

<h2>Next Steps</h2>

Congratulations! If you've read this far, I'm hoping it's because you've succeeded in compiling this code, maybe even editing it to suit your own purposes. If there's still any confusion left, that's completely normal! I learn new things about ASM 6502 everyday, and with time your confidence with the language will grow as mine has. There's always more to learn!

If you feel you've really absorbed what you can from this program, take a look at my other sample programs. Each one teaches you something new about the NES, and then we put it all together to make a game called Birthday Blast! Here are the links:
<ul>
  <li>https://github.com/thomaslantern/nes-basic-graphics</li>
  <li>https://github.com/thomaslantern/nes-basic-sound</li>
  <li>https://github.com/thomaslantern/nes-basic-controls</li>
  <li>https://github.com/thomaslantern/nes-birthday-blast</li>
</ul>

<h1>License</h1>
Feel free to copy this code, modify it, and use it for either personal or commercial purposes. If you manage to sell a cartridge copy of "Hello, World!", let me know! I'd love to see it ;)
