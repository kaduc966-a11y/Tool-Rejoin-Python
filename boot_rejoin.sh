#!/bin/bash
# Ka Rejoin Python - Termux:Boot Auto Start Script
# File nay duoc dat tai ~/.termux/boot/boot_rejoin.sh

su -c "export PATH=/data/data/com.termux/files/usr/bin:/system/bin:/system/xbin && export TERM=xterm-256color && cd /data/data/com.termux/files/home/rejoin-python && python main.py" &
