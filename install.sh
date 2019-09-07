#!/bin/bash
#This scripts configures dotfiles, installs packages and and configures additional system settings

#include colorized echos
source .lib/echos.sh

################
#DOTFILES SETUP#
################

#Creates a backup of current dotfiles in ~/.dotfiles_backup/$now, removes existing symlinks and creates symlinks for new dotfiles
green "Dotfiles Setup"
read -r -p "symlink all dotfiles to ~/? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
  green "Creating symlinks for dotfiles..."
  now=$(date +"%Y.%m.%d.%H.%M.%S")

  for file in .*; do
    #skips . and ..  
    if [[ $file == "." || $file == ".." ]]; then
      continue
    fi
    running "~/$file"
    # if the file exists:
    if [[ -e ~/$file ]]; then
        mkdir -p ~/.dotfiles_backup/$now
        mv ~/$file ~/.dotfiles_backup/$now/$file
        echo "backup saved as ~/.dotfiles_backup/$now/$file"
    fi
    # symlink might still exist
    unlink ~/$file > /dev/null 2>&1
    # create the link
    ln -s ~/.dotfiles/$file ~/$file
    echo -en '\tlinked';ok
  done
fi

#################
#PACKAGE INSTALL#
#################

read -r -p "Do you want to install packages from .pkglist/pacman? [y/N]" response
if [[ $response =~ (y|yes|Y) ]]; then
	read -r -p "Do you want to edit the package list? (Installs all packages by default) [y/N]" response
	if [[ $response =~ (y|yes|Y) ]]; then
		nano ./.pkglist/pacman
	fi
	action "Installing packages from .pkglist/pacman"
	#Installs the packages without showing the prompt or progress
	echo
	while IFS= read -r line
	do
		echo -n "Installing $line"
		sudo pacman -S --needed --noconfirm $line >/dev/null 2>&1
		ok
	done < ".pkglist/pacman"
fi
	

#############
#MISC CONFIG#
#############

#replaces the /etc/hosts file with the one from https://someonewhicares.org/hosts/ 
read -r -p "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org?[y|N] " response
if [[ $response =~ (yes|y|Y) ]];then
	action "Creating a backup of /etc/hosts"
	sudo cp /etc/hosts /etc/hosts.backup
	ok
	action "Replacing /etc/hosts"
	sudo cp ./hosts /etc/hosts
	ok
	green "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
else
	ok "skipped";
fi


#Change shell to zsh
if [[ "$SHELL" != "/bin/zsh" ]]; then
  action "Setting zsh as your shell (password required)"
  chsh -s /bin/zsh
  ok
fi

#Change Keyboard layout
read -r -p "Enter Xorg keyboard layout:" response
sudo localectl --no-convert set-x11-keymap $response "" "" ""
read -r -p "Enter TTY keymap:" response
echo "KEYMAP="$response | sudo tee -a /etc/vconsole.conf > /dev/null
ok

#Disable PC speaker
action "Disabling PC speaker"
rmmod pcspkr
echo "blacklist pcspkr" | sudo tee -a /etc/modprobe.d/nobeep.conf > /dev/null

#The End
green "All done. Note that some of the changes require a logout/reboot to take effect."
