#!/bin/bash

# Disables the PC Speaker for current session
rmmod pcspkr

# Prevents the PC Speaker from loading on boot
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

# Changes the Xorg keyboard layout
sed -i '28iOption "XkbLayout" "ba"' /usr/share/X11/xorg.conf.d/40-libinput.conf

