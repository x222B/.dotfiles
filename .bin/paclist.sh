#!/bin/bash
# paclist - creates list of all installed packages
# reinstall with pacman -S $(cat pacman)

pacman -Qqet | grep -v "$(pacman -Qqg base)" | grep -v "$(pacman -Qqm)" > /$HOME/.pkglist/pacman

# A list of local packages (includes AUR and locally installed)
pacman -Qqm > /$HOME/.pkglist/aur
