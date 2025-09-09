To test instalation

open desired folder and double click the xxx.code-workspace file to open vscode


*********************
DO THIS
*********************
before trying to build
select the workspace file in vscode

look for any lines containing "C:\Users\xxxxxxxx\DeveloperTools........

change the xxxxxxxx part to "Your computers user profile name (can be found by opening file manager and clicking C: drive followed by Users folder. there will be a default and public folder and the one with your profile name)

**********************

back in vscode, open the helloworld.z80 or helloWorld.asm file

to assemble 
-Commodore
    press F6 to assemble
    press SHIFT F6 to run in debugger
    enjoy 

-Spectrum
    Press F1
    type "TASK RUN TASK"
    select PASMO Build and Run Z80
    enjoy

-BBC
    Press F1
    type "TASK RUN TASK"
    select Kick Build and launch beeb emulator
    enjoy

For building your own program
-All Systems
    Copy the Systems HelloWorld folder to suitable location
    Rename the Folder, the .code-Workspace and the helloworld .asm/z80 file to you programs name

    after renaming the 3 files/folder double click the new workspace file 
    open the .asm/Z80 file

    Everything after START: label delete and start your code
    This will keep the AutoStart basic loader code


    Happy Codeing
    