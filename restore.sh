#!/bin/bash

#Remove created symlinks

find ~ -type l -exec unlink {} \;

#Restore old dotfiles

mv -iv ~/.Xresources.old ~/.Xresources
mv -iv ~/.bash_profile.old ~/.bash_profile
mv -iv ~/.bash_logout.old ~/.bash_logout
mv -iv ~/.bashrc.old ~/.bashrc
mv -iv ~/.dialogrc.old ~/.dialogrc
mv -iv ~/.dircolors.old ~/.dircolors
mv -iv ~/.gitconfig.old ~/.gitconfig
mv -iv ~/.gitignore.old ~/.gitignore
mv -iv ~/.gitmodules.old ~/.gitmodules
mv -iv ~/.profile.old ~/.profile
mv -iv ~/.xinitrc.old ~/.xinitrc
mv -iv ~/.zprofile.old ~/.zprofile
mv -iv ~/.zshrc.old ~/.zshrc
mv -iv ~/.bin.old ~/.bin
mv -iv ~/.config.old ~/.config
mv -iv ~/.pkglist.old ~/.pkglist
mv -iv ~/.vim.old ~/.vim

