#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting ELF File: /afs/ualberta.ca/home/d/k/dktrotti/AutoTiltMaze/niosII_microc_tiltmaze/software/TiltMazeController_Flash/TiltMazeController_Flash.elf to: "../flash/TiltMazeController_Flash_generic_tristate_controller_0.flash"
#
elf2flash --input="/afs/ualberta.ca/home/d/k/dktrotti/AutoTiltMaze/niosII_microc_tiltmaze/software/TiltMazeController_Flash/TiltMazeController_Flash.elf" --output="../flash/TiltMazeController_Flash_generic_tristate_controller_0.flash" --boot="$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec" --base=0x1000000 --end=0x1400000 --reset=0x1000000 --verbose 

#
# Programming File: "../flash/TiltMazeController_Flash_generic_tristate_controller_0.flash" To Device: generic_tristate_controller_0
#
nios2-flash-programmer "../flash/TiltMazeController_Flash_generic_tristate_controller_0.flash" --base=0x1000000 --sidp=0x150A060 --id=0x0 --timestamp=1488912593 --device=1 --instance=0 '--cable=USB-Blaster on localhost [2-1.6]' --program --verbose 

