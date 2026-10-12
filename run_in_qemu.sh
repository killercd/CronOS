#!/bin/bash
qemu-system-i386 -drive format=raw,file=boot.bin,if=floppy -boot a
