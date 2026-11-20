#!/bin/bash 

echo "Flashing..."

openocd -f board/pico-debug.cfg -c "tcl_port disabled" -c "gdb_port disabled" -c "program atcmd/cmake-build-debug/atcmd.elf reset exit"

echo "Done!"
