#!/bin/bash

#Setup script for dotfiles

echo -e "\u001b[33;1m Backing up existing files... \u001b[0m"
mv -iv ~/.Xresources ~/.Xresources.old
mv -iv ~/.bash_profile ~/.bash_profile.old
mv -iv ~/.bash_logout ~/.bash_logout.old
mv -iv ~/.bashrc ~/.bashrc.old
mv -iv ~/.dialogrc ~/.dialogrc.old
mv -iv ~/.dircolors ~/.dircolors.old
mv -iv ~/.gitconfig ~/.gitconfig.old
mv -iv ~/.gitignore ~/.gitignore.old 
mv -iv ~/.gitmodules ~/.gitmodules.old
mv -iv ~/.profile ~/.profile.old
mv -iv ~/.xinitrc ~/.xinitrc.oldc
mv -iv ~/.zprofile ~/.zprofile.old
mv -iv ~/.zshrc ~/.zshrc.old
mv -iv ~/.bin ~/.bin.old
mv -iv ~/.config ~/.config.old
mv -iv ~/.pkglist ~/.pkglist.old
mv -iv ~/.vim ~/.vim.old

echo -e "\u001b[36;1mAdding symlinks...\u001b[0m"
ln -sfnv $PWD/.Xresources ~/.Xresources
ln -sfnv $PWD/.bash_profile ~/.bash_profile
ln -sfnv $PWD/.bash_logout ~/.bash_logout
ln -sfnv $PWD/.bashrc ~/.bashrc
ln -sfnv $PWD/.dialogrc ~/.dialogrc
ln -sfnv $PWD/.dircolors ~/.dircolors
ln -sfnv $PWD/.gitconfig ~/.gitconfig
ln -sfnv $PWD/.gitignore ~/.gitignore
ln -sfnv $PWD/.gitmodules ~/.gitmodules
ln -sfnv $PWD/.profile ~/.profile
ln -sfnv $PWD/.xinitrc ~/.xinitrc
ln -sfnv $PWD/.zprofile ~/.zprofile
ln -sfnv $PWD/.zshrc ~/.zshrc
ln -sfnv $PWD/.bin ~/.bin
ln -sfnv $PWD/.config ~/.config
ln -sfnv $PWD/.pkglist ~/.pkglist
ln -sfnv $PWD/.vim ~/.vim

echo -e "\u001b[36;1m Remove backups with 'rm -ir ~/.*.old'. \u001b[0m"
echo -e "\u001b[32;1m Completed. \u001b[0m"
